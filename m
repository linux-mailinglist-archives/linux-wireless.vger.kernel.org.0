Return-Path: <linux-wireless+bounces-11017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27468949590
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF451F21485
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE422071;
	Tue,  6 Aug 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK/ImSN1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D52C182
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961811; cv=none; b=R+Z42nn6EYGykpsK+hdJWn+jVt7Lw9UGU9QK1vzoydKaq/D9MFzWStwZ0nPomc18wCbuvxKnPTr+q6UhWTRzyGR6IhXrBRRn1kSfRWhny3JJCI0iig1u8GW4yVuts9K3htlTjd7RD771w/mKZcYdKrEpNwVptckNNum5KTmz3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961811; c=relaxed/simple;
	bh=aF9r4LJodNFC1kG2f/0NqjaJjRGspVZwkUtVoJX09tE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aJ28cB2wFkskCalG3aGBPDd3A9U0e3+H1FZ5FfhL6pmF2rQVTRWaCtuXBvos+FZS/JeYA/MNU6SQsgS1MON/h0ySGgrU7PLEQ41j8ko+ZBAjeyiUzJyWjjihq97JCOHsvM0xKyg3CDHo/4Cey+3IQT3b/ywxFo43/QRbTbCjvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK/ImSN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6391EC32786;
	Tue,  6 Aug 2024 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722961811;
	bh=aF9r4LJodNFC1kG2f/0NqjaJjRGspVZwkUtVoJX09tE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XK/ImSN1cy0D88BKeXNOIjxXmQkiE4a86PPEetIQiMBlY+bzG7t5er7S+CetzPewM
	 XkzJVFPdU/jRMsRpNmxH0f0pi0vAx6MaoN52g0dEKF9ilb4VPe3v2gaCGsjl+BeHnc
	 eRxzUkYSLJNHYVj2UDEp3in0gF68MTWKk2MMBYbLqzU7riA509zqCaRbHD+wfoZAYf
	 RJXJSBuhfMsjzBm0ECA8tw9xlgVuZGyghXoVle2oaj3s3pGimZU9pTTzYtUOHDEdJk
	 x5ZadEQF/IYB/QEOC6YXB1GuI+khiJyvgxZ5XuDVSD/n28bWfeo6pov9bCi1/XFNfM
	 4zH8/JaoLwU/g==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192du: Initialise value32 in
 _rtl92du_init_queue_reserved_page
References: <2a808244-93d0-492c-b304-ae1974df5df9@gmail.com>
Date: Tue, 06 Aug 2024 19:30:08 +0300
In-Reply-To: <2a808244-93d0-492c-b304-ae1974df5df9@gmail.com> (Bitterblue
	Smith's message of "Tue, 6 Aug 2024 19:20:11 +0300")
Message-ID: <87a5hp62cv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> GCC complains:
>
>    In file included from include/linux/ieee80211.h:21,
>                     from include/net/mac80211.h:20,
>                     from drivers/net/wireless/realtek/rtlwifi/rtl8192du/../wifi.h:14,
>                     from drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:4:
>    In function 'u32p_replace_bits',
>        inlined from '_rtl92du_init_queue_reserved_page.isra' at drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c:225:2:
>>> include/linux/bitfield.h:189:18: warning: 'value32' is used uninitialized [-Wuninitialized]
>
> Part of the variable is indeed left uninitialised.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408062100.DWhN0CYH-lkp@intel.com/
> Fixes: e769c67105d3 ("wifi: rtlwifi: Add rtl8192du/hw.{c,h}")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> Kalle and Ping-Ke,
>
> Kernel 6.11 will be the first one to include this driver.
> Should this patch go to the wireless tree?

Yes, compiler warning fixes should be always sent to Linus ASAP. Ping,
if you agree please assign the patch to me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

