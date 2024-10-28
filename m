Return-Path: <linux-wireless+bounces-14605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE19B3267
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 15:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBCF282452
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB041DD0C8;
	Mon, 28 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLZTdCt/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C01DB95F
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124151; cv=none; b=jSJohUfXU5ZBzbX1Q/hIsPxqkAeW5TDOq2lc63UrCd/87mJ/WcQoYsXYymlLk2V4m5kqHXpGJkzvpHXHGMAqj98VqBIRJmtmsxGafb/7rg7AmtXFW/2mLL+IzIVWjPDK73rL3eHC8w5jps6h2RNUddxdHSFqSuGHm6MstWYkhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124151; c=relaxed/simple;
	bh=/sTP+2WN1c6C61ayQbhYvOxsF1O045VWiiHAmCmxdRg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oD2s1NfSbfpy4rYW+hmu9WK4QwdYi4U0NE5EYIup/iOzOVodIg50KmVP7tsYRxcUQStrRByf1D0OnobMFELdmPy+pNL/4DmteKjeXEecbkaURpPfgCqL9i7aeg81VRNKBx3vmxa2b3nMMZg/zcEAT5QiUTtAdbAUt1Z1BT/ebiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLZTdCt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84F8C4CECD;
	Mon, 28 Oct 2024 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730124150;
	bh=/sTP+2WN1c6C61ayQbhYvOxsF1O045VWiiHAmCmxdRg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vLZTdCt/SmyMqGbyieps+jmn3HmTfqbkIvQWC5aAXlIVh9Cc0Ac2lM8rAozGLiPMn
	 y6bH6K+N6XGReOyXKlQMmklXUjQTF8JVksK/6LOSGjC9gtgfXbHjLYSTDLVA+YcaAC
	 Wnx3Q1mLQB+j/gw51jia2B12CfA+/mc7cB7d5DyDgjnVgIw5SPM2XRIuXTXY/iJcJs
	 xEBsi1r8nqx0BigafejlIYsL9jHygbnvOMPXTCZSFmVm0UQjYkC2vyUmyIqRQRWpRC
	 pVL3xqe2AObh7h4gSdj3JRstxen20AOMnq5k4Z7uoe1kkY7MAItN/jfVNPQPb0ARVi
	 S6W5dJvsLnXaw==
From: Kalle Valo <kvalo@kernel.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>,  Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2] ath11k: remove error checking for debugfs_create_file()
References: <20241025064235.382-1-thunder.leizhen@huawei.com>
Date: Mon, 28 Oct 2024 16:02:27 +0200
In-Reply-To: <20241025064235.382-1-thunder.leizhen@huawei.com> (Zhen Lei's
	message of "Fri, 25 Oct 2024 14:42:35 +0800")
Message-ID: <87v7xcgwb0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhen Lei <thunder.leizhen@huawei.com> writes:

> Driver ath11k can work fine even if the debugfs files fail to be created.
> Therefore, the return value check of debugfs_create_file() should be
> ignored, as it says.
>
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Are you just guessing or did you confirm on a real device that ath11k
spectral really works without debugfs?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

