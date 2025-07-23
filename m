Return-Path: <linux-wireless+bounces-25929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF1B0EEF5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8F8962A75
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59DB288C24;
	Wed, 23 Jul 2025 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="XHnHYFjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865DF288C92
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264648; cv=none; b=p7Gvm68qnLP4x3Vu9yYLu1SqZF+38lle1BAJHEGGSoAeqJdFDFbH3VLfTEjbxK08j1z2F/QOkUbcjgncT1cKWLWLcAzCVGmATCY0BNCNgwFTPp9RrJpWQRrQX/Pg+YbfUECmhTG4Aaq4nkdhw/wdKTcouzUhK74z09qKroT/Ads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264648; c=relaxed/simple;
	bh=+XqUM7z2kOiFz565x/x4/InS3B8vZfnorSxqVKSI00I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myWdIIuXlK66BWQoe2fKsiB5CEBhkDvKNhjV/TqxWJzXJg9CD085MFKIBipIaCnU8VlCq4K0vnE11Qbz11IYOs89/OMkm/42YqZ8y26E6CoRJ7v7SE/XGCeOq5vMBuETYQ5G9lc2JKpi2MMtd/SR667G9edEUdM5fM8g7MX0ABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=XHnHYFjK; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1753264646; x=1784800646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XqUM7z2kOiFz565x/x4/InS3B8vZfnorSxqVKSI00I=;
  b=XHnHYFjK/RfnfussELf327pwBrHodaezUvwvwvyrdBgXVqck2Owlw2qd
   nObCuOhOP+NPETsR+tHS2I9WRvyMjeJ2G4VYZn/4Sr3cSfYg9FjaFj/k0
   FX34t30zgDed5gA9xall+P0bc+UOFjExTlMR+c83nazmObFGMIo8cJKsM
   Y=;
X-CSE-ConnectionGUID: s8cr5nGGTSmkRtu2ED9dNQ==
X-CSE-MsgGUID: 1gyYJeG0SG6jeBntkrncJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="92425419"
X-IronPort-AV: E=Sophos;i="6.16,333,1744063200"; 
   d="scan'208";a="92425419"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:57:18 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 11:57:17 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Jul 2025 11:57:15 +0200
Date: Wed, 23 Jul 2025 15:27:08 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, Gokul Sivakumar
	<gokulkumar.sivakumar@infineon.com>
Subject: Re: [PATCH wireless-next v3] wifi: brcmfmac: fix EXTSAE WPA3
 connection failure due to AUTH TX failure
Message-ID: <aICx9J5MOf2GNp6e@ISCN5CG14747PP.infineon.com>
References: <20250709120454.5332-1-gokulkumar.sivakumar@infineon.com>
 <faa64fa7-beaa-458a-9fc9-e6b33533f534@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <faa64fa7-beaa-458a-9fc9-e6b33533f534@broadcom.com>
X-ClientProxiedBy: MUCSE816.infineon.com (172.23.29.42) To
 MUCSE827.infineon.com (172.23.29.20)

On 07/23, Arend van Spriel wrote:
> On 7/9/2025 2:04 PM, Gokul Sivakumar wrote:
> > From: Ting-Ying Li <tingying.li@cypress.com>
> > 
> > For WPA3-SAE Connection in EXTSAE mode, the userspace daemon is allowed to
> > generate the SAE Auth frames. The driver uses the "mgmt_frame" FW IOVAR to
> > transmit this MGMT frame.
> > 
> > Before sending the IOVAR, the Driver is incorrectly treating the channel
> > number read from the FW as a frequency value and again attempts to convert
> > this into a channel number using ieee80211_frequency_to_channel().
> > 
> > This added an invalid channel number as part of the IOVAR request to the FW
> > And some FW which strictly expects a valid channel would return BAD_CHAN
> > error, while failing to transmit the driver requested SAE Auth MGMT frame.
> > 
> > Fix this in the CYW vendor specific MGMT TX cfg80211 ops handler, by not
> > treating the channel number read from the FW as frequency value and skip
> > the attempt to convert it again into a channel number.
> > 
> > Also fix this in the generic MGMT TX cfg80211 ops handler.
> > 
> > Fixes: c2ff8cad6423 ("brcm80211: make mgmt_tx in brcmfmac accept a NULL channel")
> > Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> > Signed-off-by: Ting-Ying Li <tingying.li@cypress.com>
> > Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> > ---
> > 
> > v3:
> >    * Fixed the "warning: incorrect type in assignment (different base types)"
> >      properly now, after kernel test robot reported it again.
> > 
> >    * Used brcmf_fil_cmd_data_get() instead of brcmf_fil_cmd_int_get() util
> >      for reading the channel number from the firmware as __le32 / __le16
> >      type instead of s32 type.
> > 
> > v2:
> >    * Fixed wifibot "warning: incorrect type in assignment (different base types)"
> >      in cyw/core.c file.
> > 
> >    * Fixed >80 line length checkpatch warning by reducing variable name len
> >      in cfg80211.c file.
> > 
> >    * Handled the return value of the BRCMF_C_GET_CHANNEL IOCTL Read operation
> >      in cfg80211.c & cyw/core.c files.
> > 
> >   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 33 ++++++++++++-------
> >   .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 29 ++++++++++------
> >   2 files changed, 41 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > index 40a9a8177de6..54b1f0c8117e 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> 
> [...]
> 
> > @@ -5606,25 +5606,36 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
> >               /* Add the channel. Use the one specified as parameter if any or
> >                * the current one (got from the firmware) otherwise
> >                */
> > -             if (chan)
> > -                     freq = chan->center_freq;
> > -             else
> > -                     brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
> > -                                           &freq);
> > -             chan_nr = ieee80211_frequency_to_channel(freq);
> > -             af_params->channel = cpu_to_le32(chan_nr);
> > +             if (chan) {
> > +                     ch = ieee80211_frequency_to_channel(chan->center_freq);
> > +                     af_params->channel = cpu_to_le32(ch);
> 
> When we have the chan instance we can simply do following instead:
> 
>                        af_params->channel = cpu_to_le32(chan->hw_value);
> 
> > +             } else {
> > +                     err = brcmf_fil_cmd_data_get(vif->ifp,
> > +                                                  BRCMF_C_GET_CHANNEL,
> > +                                                  &hw_ch, sizeof(hw_ch));
> 
> I understand the motivation to use brcmf_fil_cmd_data_get() here, but it
> may confuse people reading the code. So how about this incorporating the
> previous comment:
> 
>                if (chan) {
>                        hw_ch = cpu_to_le32(chan->hw_value);
>                } else {
>                        err = brcmf_fil_cmd_data_get(vif->ifp,
>                                                     BRCMF_C_GET_CHANNEL,
>                                                     &hw_ch, sizeof(hw_ch));

yeah, this suggestion looks clean. Also the local variable "hw_ch" can replaced
directly with "af_params->channel".

> > +                     if (err) {
> > +                             bphy_err(drvr,
> > +                                      "unable to get current hw channel\n");
> > +                             goto free;
> > +                     }
> > +             }
>                af_params->channel = hw_ch;

So that the above line can be removed. Will update and send a v4 patch.

> >               af_params->dwell_time = cpu_to_le32(params->wait);
> >               memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
> >                      le16_to_cpu(action_frame->len));
> 
> [...]
> 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > index c9537fb597ce..2cbb4a809ca7 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c

[...]

> > +     if (chan) {
> > +             ch = ieee80211_frequency_to_channel(chan->center_freq);
> > +             mf_params->channel = cpu_to_le16(ch);
> > +     } else {
> > +             err = brcmf_fil_cmd_data_get(vif->ifp, BRCMF_C_GET_CHANNEL,
> > +                                          &hw_ch, sizeof(hw_ch));
> > +             if (err) {
> > +                     bphy_err(drvr, "unable to get current hw channel\n");
> > +                     goto free;
> > +             } else {
> > +                     mf_params->channel = hw_ch;
> > +             }
> > +     }
> > +
> 
> proposing similar construct here.

Will update here as well in v4 patch.

Gokul

