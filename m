Return-Path: <linux-wireless+bounces-5284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C131B88C6C3
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4345FB2434B
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D713C816;
	Tue, 26 Mar 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAYgmjVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9313C813
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466622; cv=none; b=XfDa9wPgTxzXUrF8AtYA9tHtgc++jq3je933AS6jjzXsstZq2VmcxlswBCOzmbBJEGMRvu8VbLs88INTbbtWTR+scxvLTQSVhCcDjO/7Zdyz+lKGNrenmc8Z7wzHV/Bo5PW8dI5ZpqxXBOq8OhKcxeBPBg5A4tnFYAOfkoUK9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466622; c=relaxed/simple;
	bh=jJ5LuUqxRDXzEXygSR0WOYP+R7OkXRBkvw9wvksroVI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o8Ecxb73dUpxu+q4xuCOLJ3uMTd8XKxWbcf5sTv1EpFkB5ZgOI0y9wF7GSpjp1i0et0i2PndA2wt47REE60/6de1K2ym15bDS65FLjQk5jm868p4/qEYCoMC0dlwLhRDXWhnl7LJ7wAsBpqYDY6b8UFzHOFe2TiIsQIV/DIS0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAYgmjVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC08C433C7;
	Tue, 26 Mar 2024 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711466622;
	bh=jJ5LuUqxRDXzEXygSR0WOYP+R7OkXRBkvw9wvksroVI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vAYgmjVNO+gUeYSYjGdeAgM9tawDdXYtxyzKZOkcCXybAi3UE0K71vjyGMkWp7t8N
	 6BnxJ31jnb/qAfL7lQegMBaxqlkdIrsTEK8H0jvcZvG6H9oXokg8a250N24O5hBdlI
	 xEdf7k7NMi18zMACxhyX+O05717Irloh1pn3PcKn9m07wVVkU8XFStLQBFWskUuVgb
	 WOAL2kw3Q87UOsDMXxvDZbSb03GfR89vdudLcRlfSLXOD7HlROY7hPcGVYicZRj0kl
	 1FOnaF0HT1eVNHSi8MIS2q7HIV3xmfk3EIFQK8TRFS8F6jkuL11uDAhrDesKZVzilY
	 cUR5uftjdI0ww==
From: Kalle Valo <kvalo@kernel.org>
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/6] bug fixes and enhancements to 6 GHz band support
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
Date: Tue, 26 Mar 2024 17:23:39 +0200
In-Reply-To: <20240325212304.28241-1-quic_pradeepc@quicinc.com> (Pradeep Kumar
	Chitrapu's message of "Mon, 25 Mar 2024 14:22:58 -0700")
Message-ID: <877chp81ac.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:

> In 6 GHz band, add support for
> 1. channel 2.
> 2. Fix packet drop issues.
> 3. AMPDU aggregation
> 4. SMPS configuration
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Baochen already commented on patch 6 but in general I don't see any
analysis how this patches affects (or works) with WCN7850. I should not
be asking about this for every patch, the analysis should be in the
commit message by default.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

