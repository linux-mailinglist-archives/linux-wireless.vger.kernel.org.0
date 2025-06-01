Return-Path: <linux-wireless+bounces-23523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA6AC9E9F
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jun 2025 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248F11891D3A
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jun 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB534317D;
	Sun,  1 Jun 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HzqhfffB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD9E552
	for <linux-wireless@vger.kernel.org>; Sun,  1 Jun 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748784265; cv=none; b=fJzBCU5vSlSxryz8zaLFroVQ9GUvY/LRp6Q8grkyRmIf6nBiZ1/0l6/P+Powl79/MsoSSxLUfPpx+mgvR4C8m350suCLKK3P45FIowhMvh/6Fw9UxFgrFxI5p784kPiyCy+V5HbcZbydeSEv27gvLxIJNTPEF4CWeDBUcdgYDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748784265; c=relaxed/simple;
	bh=Efa8JbAU8wTJfYphhIcixUQvOkk1j7yQKwtzJAHr0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRyW1MX9aM2ukiLyAapoYKTbJrQkOodZ1fZevOi6dL+NLIUFtm0fOVh60ndDx5un1SfLTPbMbt2aIDnCJGlG+tUZ5fCs+tkxbaxnt21ZjnaL9ttUIC2GwGVbi48xUhGdNlBBbKtpA96cC0uHipJeqZlWRpkWkY/sFQ4Xloy/o9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HzqhfffB; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 28C4F14C2D3;
	Sun,  1 Jun 2025 15:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1748784245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kw6rlWlte6OQhXk5hyB4d9Fe/CSfb590KM5qTfWcEiQ=;
	b=HzqhfffBBz275qtubpomdxlFyjz9GQjwBLnM6lJXopgls01vQnkKmjRhw7UjJQuzvtouo8
	1esOpf81e03IMPFHL/5nn0PI0lGMIDxRbmF6ajQVF6gIP0WLYyP+4N/W8eIKc3kaiP0ZVe
	gXnCBo+2evYFa8js7oagBPcjgel4XDVbTMUHRF41WXifjVHYzF57NbF2EBSejztaJPQdPX
	e8WiTHSo+wLS6QVvSFGVCzZq1PYLOmNWaQTO+sy5zH6aDovGEcpKiAKC6+dvdq73zcIPtu
	I40kH9PP5dwCai+VwZnECV2Vr5L68fY2raJj+kC2MigOpWr/+I/q4jCXaxU7ow==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id b7801609;
	Sun, 1 Jun 2025 13:24:03 +0000 (UTC)
Date: Sun, 1 Jun 2025 22:23:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: rtw89: array-index-out-of-bounds in rtw89_pci_release_rpp()
Message-ID: <aDxUZMSxOdLQ_-30@codewreck.org>
References: <aDcgcjNp3fRT9PZf@codewreck.org>
 <931eb77003ff469a835848cd462dae35@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <931eb77003ff469a835848cd462dae35@realtek.com>

Thanks for the quick reply

Ping-Ke Shih wrote on Thu, May 29, 2025 at 01:32:44AM +0000:
> My suggestions are:
> 
> (1) The latest firmware of RTL8852BTE is 0.29.122.0. Please try it.

I'm apparently already on that:

rtw89_8852bte 0000:03:00.0: Firmware version 0.29.122.0 (5659197d), cmd version 0, type 5

> (2) To disable PCI ASPM is also worth to try:
> 
>    /etc/modprobe.d/70-rtw89.conf 
>    options rtw89_pci disable_aspm_l1ss=y disable_aspm_l1=y disable_clkreq=y
>    options rtw89_core disable_ps_mode=y
> 
>    After setup these options, you need to cold reboot your machine to
>    make sure ASPM isn't enabled. Also, please check the setting via
>    /sys/module/rtw89_pci/parameters/ after rebooting. 
> 
> (3) Another is to disable power save mode via
>    sudo iw wlan0 set power_save off
> 
>    If this can work to you, you can add option to configuration file of
>    network manager to disable it. 

Thank you.
I'm not too interested in workarounds as I don't really need to use the
card; if you want me to try a kernel fix for the kernel crash I'll be
happy to re-enable the card a few weeks to check but there's little
point in testing these in my opinion unless it would help you fix the
firmware.


> > The line in question would be this line:
> > >        txwd = &wd_ring->pages[seq];
> > (which matches as pages is an array of 512 rtw89_pci_tx_wd structs)
> > 
> > 
> > Checking seq < RTW89_PCI_TXWD_NUM_MAX is trivial and I could send a
> > patch, but if that data is really bogus I assume any local check could
> > be fooled e.g. the data could be < 512 and still incorrect.
> 
> You're right. 

Right, I also checked the earlier "Cannot map qsel to dma" message but
it's also from the same value obtained from the card, so failing at that
point is not enough (even if it can probably still be better than a hard
crash...)


I'm not sure the crash happens in the same call of
rtw89_pci_interrupt_threadfn() but I think so given the end of the dump
and the map qsel error are 8 nsec appart (if I read this netconsole
format right)
In that case perhaps it'd make sense from the call to mark the card as
no longer running (and perhaps bail out) in case of error?

Something like this:
```
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c2fe5a898dc7..793e4a4cf5a2 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -896,8 +896,12 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	if (unlikely(isrs.isrs[0] & gen_def->isr_rdu))
 		rtw89_pci_isr_rxd_unavail(rtwdev, rtwpci);
 
-	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_halt_c2h))
+	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_halt_c2h)) {
 		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
+		// maybe?
+		rtwpci->running = false;
+		return IRQ_HANDLED;
+	}
 
 	if (unlikely(isrs.halt_c2h_isrs & gen_def->isr_wdt_timeout))
 		rtw89_ser_notify(rtwdev, MAC_AX_ERR_L2_ERR_WDT_TIMEOUT_INT);
```

Or is that flag also supposed to set itself?

Anyway, as said above this is mostly curiosity for me, please deal with
it as you see fit and let me know if you want me to test something.

Thanks,
-- 
Dominique Martinet | Asmadeus

