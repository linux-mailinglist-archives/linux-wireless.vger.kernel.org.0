Return-Path: <linux-wireless+bounces-17196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6FA05F6A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B361888F4F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017716CD33;
	Wed,  8 Jan 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkU16KFB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002C1FC7D9
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348230; cv=none; b=XYHAfq1n6/Ke0h1ljXtu1CUQxpHszhKlOzdOHwo+I8E4wioeSdZjuI1G3DFGdzm4KbHVfeJJSWWTR3euKngAe7XvbeIAWSK2bgk33hxph2nucbdNvTu+Egyb//DnpCjzUjdnwzWssKdPgbzxDY7UgmgHba+lomOpuhN6TDM2HMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348230; c=relaxed/simple;
	bh=kwo/UmlE+C0omSv+5bK9BtV5or0AnIQAUjUDJRCfLI8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IUM9mtukidQfXeM88Dx1H0+s56GBz72ST/1l6sAO43wk6aHxpE8OhOYdtqtamz5QGWKXEaIWfau/UBjJbqCwFw6eFVV0jlBpQMfrplx/WdXAB4SHx2QinS+z+dq1lZ5ud2vRXQkR49s4kS+QgyH2ylVeAit7z/9EhLwb78Z1J4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkU16KFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B7AC4CEDD;
	Wed,  8 Jan 2025 14:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348229;
	bh=kwo/UmlE+C0omSv+5bK9BtV5or0AnIQAUjUDJRCfLI8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mkU16KFBiyycZ58xhcMya2mZ3kRKnuzgEKHbpbXvWpYwtoWZtV6WdCN9bMH4lG+3y
	 KwTB67j70L3BoLk0nCPSwEunVK98Z170pR69hkuXciOoRq9zfzV/Tkva/LbsVaK9sP
	 hpspXgzQR8TMoumqwhMPBzzigFTR8gMhIOrrjYxLsxYcGkuyTCCzP4LNbTi3L3qqYG
	 BfeN22kKpgG/QsBc0/kwxukmURTn5oGhzwMw3uTqMZJDJ3Afb5ZB+S5xhksaL5Ahpw
	 wJp73Kp8/hMPfGzWl4s+Toc/dwK0vOnUnFa2X0C6MxbNxGbs1tLnUJMGri0CHSxGOk
	 ikCNrX96P1iaw==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Anjaneyulu
 <pagadala.yesu.anjaneyulu@intel.com>
Subject: Re: [PATCH 15/15] wifi: iwlwifi: mvm: add UHB canada support in
 GET_TAS_STATUS cmd resp
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
	<20241226174257.dfd6b8893322.I196393dc3c9c28882f90b43a821a2d76a5c9a046@changeid>
Date: Wed, 08 Jan 2025 16:57:07 +0200
In-Reply-To: <20241226174257.dfd6b8893322.I196393dc3c9c28882f90b43a821a2d76a5c9a046@changeid>
	(Miri Korenblit's message of "Thu, 26 Dec 2024 17:44:56 +0200")
Message-ID: <87zfk1pd4s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>
> dump UHB canada is enabled or not based on firmware capability.
>
> Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Like in patch 14, wondering if the name is correct.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

