Return-Path: <linux-wireless+bounces-16379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA79F0CC3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BC31889C65
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279C1DCB09;
	Fri, 13 Dec 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHLNT6Iq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3141CF7A2
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094576; cv=none; b=py+u1VfsnUzoGfnQYCnEOMVjpii0atnK31UFSzXjX6oRttwovXHKdCg9WzT2C7tEiA/4nzDnryuBIv4j7+IEkdnuWBin8F2M3ZpA+cNYH71c2NI78hbFfEJo5AWMpdItaOZEJC354cP7+KTOU6UPKzwDBHKYMY7Iv8Yu6eIzBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094576; c=relaxed/simple;
	bh=PSTBUC+qP6SJQSTHFmimlkjfMc56b5VjU4E3lqHLmpc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ChTjAVto+kO6xuAzuiPnQJcoer10v9U8bh1B1WROoHapNB6q42LVLaZATbOv8dkDkLcm9NDst4o7LYaPf1T1jmPnZX1NjVkSzXt8Rus3bsFec1GYtK9DkVAE4IDxURbveKbPkNQzQ6l/OU/rG6oO0gwQSGccRn9YyX0vCNaBB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHLNT6Iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD42C4CED0;
	Fri, 13 Dec 2024 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094575;
	bh=PSTBUC+qP6SJQSTHFmimlkjfMc56b5VjU4E3lqHLmpc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hHLNT6Iqthm2x/gtPPTRkoOL7KF/lu+7VCLOA7t8MsTGAE6TsJqhU4xkziu9V0hxS
	 rd/48h+cyLjZokaAyWyaB3h4T5uAyLZc6VU1mVWAD37ulOwInPwtEdv3DXE+3jG6Zw
	 6SArOnryow+SYPc9+aeJKKB/l1PwxDsicrrBuhESPgjtjWOqn4OnRE1CGPiF1vHNFh
	 dpXuR2LjxXXJgoCKkjSZryilBQjp1m1SVqd1covNfpAztiiN3THwcbiguBf621LZme
	 DLTSMy612y7JM0Z7/mjbQHrG6FnRN5qpdh9Lhji/hSRxosLerWm7mb1xi0asrlMcO4
	 ShlnQno89FLPQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: brcmfmac: add missing header include for brcmf_dbg
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241211133618.2014083-1-marcel.hamer@windriver.com>
References: <20241211133618.2014083-1-marcel.hamer@windriver.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, Marcel Hamer <marcel.hamer@windriver.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173409457271.1115965.15103388740268579716.kvalo@kernel.org>
Date: Fri, 13 Dec 2024 12:56:14 +0000 (UTC)

Marcel Hamer <marcel.hamer@windriver.com> wrote:

> Including the fwil.h header file can lead to a build error:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h: \
> 	In function ‘brcmf_fil_cmd_int_set’:
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h:90:9: error: implicit \
> 	declaration of function ‘brcmf_dbg’ [-Werror=implicit-function-declaration]
>    90 |         brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, data);
>       |         ^~~~~~~~~
> 
> The error is often avoided because the debug.h header file is included
> before the fwil.h header file.
> 
> This makes sure the header include order is irrelevant by explicitly adding the
> debug.h header.
> 
> Fixes: 31343230abb1 ("wifi: brcmfmac: export firmware interface functions")
> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

b05d30c2b6df wifi: brcmfmac: add missing header include for brcmf_dbg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241211133618.2014083-1-marcel.hamer@windriver.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


