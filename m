Return-Path: <linux-wireless+bounces-18083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C42A210A6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508793A2A9A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286171DE4EA;
	Tue, 28 Jan 2025 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsurlDlm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB018C004;
	Tue, 28 Jan 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088318; cv=none; b=s0M3NsqlwZS69dLIprRlH3ybf+okN90ej2r7G/BqwVdmwkSd5OBtrwyFh5qG6iq8Kyg8tdk81Uog2e6bVz0+w07/lwTOvrefQxs1AHceGw3/c0bNFvBn0MeSUhModtMqmkRzq5MuI7YuQiusjvfKJDMONoHpUSDjMfFUZrtiRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088318; c=relaxed/simple;
	bh=rk0MZJ6NzbgfWYcohF1MDeZKZ/XoT2cU1Q5+Rgs82bk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=s32RTCoiKPi18jm4786qWg1UE99mXzlYj/7T7AjfJYZCpFciLVS3G5GhNFKYHKUbh7xXY66nOBXzW0TAO1iD73MeVPFrYqzAfzJvJLjPiLLn5l/iW7YsgDy5LjkXeACr/v+FEtDFNb2Uk2/wzc37S66o3sO1p+d+FKpfZCLB5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsurlDlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C5AC4CED3;
	Tue, 28 Jan 2025 18:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088317;
	bh=rk0MZJ6NzbgfWYcohF1MDeZKZ/XoT2cU1Q5+Rgs82bk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BsurlDlmnLDgDP1BlpbwyXu1HjJcSFwjoOVWfXae4yJMr/ywSXEw6eU7Ks8FDBYPZ
	 mJ1UAi2wXiAq1WXNVHd6G8K901Ro2RtLdht+5m7Dx9sRGFqDTCprOQg//7Hkg55O9n
	 TlTTcW+s+drhUCOL30cbxddtTeNUndN2JbeNIVs0PahMBBgv6DWsIRJDN2TlBAvxwE
	 3LEaP5ts2E/29pNs7ftjGBnR+a9MQ1tlYnkrNtY0cxrJjuJoUBvgcOXo/GIauuHbH+
	 5Ew9I2nvKn/QDFMoKkH+3iZ1gMcO7T1/yKY+B9U5XfbBULqrkbSo9FI16SrGh20Kol
	 mnlZ3cTGbPhoA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: use random seed flag for BCM4355 and
 BCM4364
 firmware
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
References: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Arend van Spriel
	<aspriel@gmail.com>, Hector Martin
	<marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "brcm80211@lists.linux.dev"
	<brcm80211@lists.linux.dev>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173808831366.1321818.12181240056808824268.kvalo@kernel.org>
Date: Tue, 28 Jan 2025 18:18:35 +0000 (UTC)

Aditya Garg <gargaditya08@live.com> wrote:

> From: Aditya Garg <gargaditya08@live.com>
> 
> Before 6.13, random seed to the firmware was given based on the logic
> whether the device had valid OTP or not, and such devices were found
> mainly on the T2 and Apple Silicon Macs. In 6.13, the logic was changed,
> and the device table was used for this purpose, so as to cover the special
> case of BCM43752 chip.
> 
> During the transition, the device table for BCM4364 and BCM4355 Wi-Fi chips
> which had valid OTP was not modified, thus breaking Wi-Fi on these devices.
> This patch adds does the necessary changes, similar to the ones done for
> other chips.
> 
> Fixes: ea11a89c3ac6 ("wifi: brcmfmac: add flag for random seed during firmware download")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>

Patch applied to wireless.git, thanks.

0e9724d0f89e wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/47E43F07-E11D-478C-86D4-23627154AC7C@live.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


