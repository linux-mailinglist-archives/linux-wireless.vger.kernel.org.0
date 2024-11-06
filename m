Return-Path: <linux-wireless+bounces-14972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4F9BE38C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 11:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E946286EFE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 10:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C91DD537;
	Wed,  6 Nov 2024 10:06:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FA1DD0E7
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887567; cv=none; b=JwBsy0HdENb8dS+y10We8djE08OLNgL2FTvMfq2TkScofAOPqJ4yLNY4cSPOxmMv/Fb6JIrYLiu+skIIHPxTshuNzbt+oVowRLRHglHuiIerv/NWufzZUnGNFO9tLPhJ5CkaVaHEcAN32BNiu3FeDAsRRefI2fMFQU/MWy2e7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887567; c=relaxed/simple;
	bh=eMoLB4nLnV0rGC4CN+YUY0L8H8kqGFp9UgJ5rSxg7PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZXZmOjGHU4ITZZfSuSIxBAa5byjNiXd6x1BURKCDzGq4AXPQcdSSiES4kBs5LRKvFOyXMXs2oUvEqomyjb8vfRdgxzZ172G9V5Hp/Ik9NvC4hua+2kzN08lCiAN8LpmU6r3TgvnoxSlHH/kA7EGh3mbt+myKv6IZ5YrzN6EC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300C5970b92E00000000000000c00.dip0.t-ipconnect.de [IPv6:2003:c5:970b:92e0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 36AF2FA132;
	Wed,  6 Nov 2024 11:06:04 +0100 (CET)
From: Sven Eckelmann <se@simonwunderlich.de>
To: ih@simonwunderlich.de, Issam Hamdi <ih@simonwunderlich.de>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 mathias.kretschmer@fit.fraunhofer.de, simon.wunderlich@open-mesh.com,
 sw@simonwunderlich.de
Subject:
 Re: [PATCH v2 1/2] wifi: ath9k: work around AR_CFG 0xdeadbeef chip hang
Date: Wed, 06 Nov 2024 11:06:03 +0100
Message-ID: <5516036.Sb9uPGUboI@ripper>
In-Reply-To: <20241106090439.3487958-1-ih@simonwunderlich.de>
References:
 <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241106090439.3487958-1-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 6 November 2024 10:04:38 CET Issam Hamdi wrote:
> +static bool ath_hw_hang_deadbeef(struct ath_softc *sc)
> +{
> +       struct ath_common *common = ath9k_hw_common(sc->sc_ah);
> +       u32 reg;
> +
> +       /* check for stucked MAC */
> +       ath9k_ps_wakeup(sc);
> +       reg = REG_READ(sc->sc_ah, AR_CFG);
> +       ath9k_ps_restore(sc);
> +
> +       if (reg != 0xdeadbeef)
> +               return false;
> +
> +       ath_dbg(common, RESET,
> +               "0xdeadbeef hang is detected. Schedule chip reset\n");
> +       ath9k_queue_reset(sc, RESET_TYPE_DEADBEEF);
> +
> +       return true;
> +}

I don't really get why this was proposed again. Can you please explain why the 
reworked version of this patch [1] (by Felix) is not good enough?

If there are any deficits with Felix's version then it would be nice to know 
get informed about it (in the commit message) and then work on the deficits. 
Having two different checks at the same time for the same thing in upstream 
Linux doesn't seem to be helpful.

I have more problems with the submission style - see next mail.

Kind regards,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a34d0a0da1abae46a5f6ebd06fb0ec484ca099d9



