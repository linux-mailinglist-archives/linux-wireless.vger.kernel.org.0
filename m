Return-Path: <linux-wireless+bounces-15140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA949C1BD5
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 12:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16B11C2128D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1E1E25F3;
	Fri,  8 Nov 2024 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kfQ64EK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DE47F69
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063948; cv=none; b=n8G7XQ7DjcfkGe9ON60ODbbHGBPLE7/ew7w8WpzPKBdSTEAuZUQm3QKgRNNOdkbRbQbr60QYbuRDVRek4qrTUGnNcKdTnGic2KFy96e5W+XAliYwUWvNiumC56I79nJBwfAiNAfppuV4uPp/tQgMyZJ300BpFUVEVIJGs8ksIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063948; c=relaxed/simple;
	bh=V+wBePRhTLSLEL8B4KmKK2BtQuEFMyLrj3eb8IZoAbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7gDhWSCe63au186iVR5G/4eK2ryPC+zkn2XPjpcD5qiQmrcKLQisp7x+UMIXrGM272XcKWAPquKzMbZXMVPwtnr3khCy4AasNLT8KNtJHLMnEEqxL6LUJaM3d2NL++6Kkh1ShCN3Yl1T1DuH6HeRbJg6PhXcTRx6n07WvnaJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kfQ64EK0; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lX+6b5xbo3iXYPGOoSLXSg5c+OKNgPgJxPKzzncIL9I=; b=kfQ64EK0GHdd/SumERR0+agH3A
	OUBQj4AMLIeMmeAc/lzGfn+N2C393vkA4a5dkQBwI4DgUnQfowWbwlngCPHFKijg5HgqGsO+6ZNxh
	mBv6tmqvOdDcPNBSNoa4ihL4WSLmeRRzUug3vBusk9O9CVFp3Xb1MisrApYghAKeDVgo0qIMR/nLu
	v7w9GWnvGgEtK5ALxtf974zwUdCBKUuMTs9+rjVxrMXqk/IMdZzPCf0+GUpO9r1saolx+FTUOPpBt
	/6g3Q3vN7nrHoqM3mg3NhTO3cktKK022r+WpmyFeoa2aQRSjqwjV1HhLCr0O8L8e5D7sNK7N0PkRb
	+ihx6iMw==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t9MoB-0040EJ-8A; Fri, 08 Nov 2024 12:05:43 +0100
Date: Fri, 8 Nov 2024 08:05:38 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH net 3/5] wifi: rtlwifi: wait for firmware loading before
 releasing memory
Message-ID: <Zy3wgtAEgZyg34R4@quatroqueijos.cascardo.eti.br>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-4-cascardo@igalia.com>
 <fe600a9588e045658ef4415e1ceb4983@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe600a9588e045658ef4415e1ceb4983@realtek.com>

On Fri, Nov 08, 2024 at 02:12:24AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > At probe error path, the firmware loading work may have already been
> > queued. In such a case, it will try to access memory allocated by the probe
> > function, which is about to be released. In such paths, wait for the
> > firmware worker to finish before releasing memory.
> > 
> > Fixes: a7f7c15e945a ("rtlwifi: rtl8192cu: Free ieee80211_hw if probing fails")
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  drivers/net/wireless/realtek/rtlwifi/usb.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > index c3aa0cd9ff21..c27b116ccdff 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > @@ -1028,13 +1028,15 @@ int rtl_usb_probe(struct usb_interface *intf,
> >         err = ieee80211_register_hw(hw);
> >         if (err) {
> >                 pr_err("Can't register mac80211 hw.\n");
> > -               goto error_out;
> > +               goto error_init_vars;
> >         }
> >         rtlpriv->mac80211.mac80211_registered = 1;
> > 
> >         set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
> >         return 0;
> > 
> > +error_init_vars:
> > +       wait_for_completion(&rtlpriv->firmware_loading_complete);
> 
> The firmware request is trigged by rtlpriv->cfg->ops->init_sw_vars(hw), and
> here is wait for filling rtlpriv->rtlhal.pfirmware and
> rtlpriv->rtlhal.wowlan_firmware.
>  
> The rtlpriv->cfg->ops->deinit_sw_vars(hw) is to free firmware. Shouldn't we
> call it here? Also shouldn't PCI need this?
> 

About PCI, as I was testing with a USB emulator, I couldn't test it, though
I found a few fixes that it would need as well. I can send a patchset for
the PCI fixes, though I won't be able to test them.

As for merging the following patch with this one, it would make sense. But
I found out the memory leak after coming up with this fix. And instead of
explaining two bugs (one UAF and one memory leak) in the same commit, I
thought it more simple to have two commits. Besides, given the Fixes line I
came up with for each one of them, they would apply to different trees.

Cascardo.

> >  error_out:
> >         rtl_deinit_core(hw);
> >  error_out2:
> > --
> > 2.34.1
> 

