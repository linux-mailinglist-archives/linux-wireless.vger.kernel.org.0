Return-Path: <linux-wireless+bounces-27864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E08BC1EF6
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B42619A1C3B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FD3595C;
	Tue,  7 Oct 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="FNSINSS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F807136E37
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851141; cv=none; b=OBr4sQFCn0trosp0iSrM3BRODMhIMwfISK3Ei+orXSao3rlSnrHZaNHjYZu3ddzdcLdtIpCmhUNKD0Rh/sdUxbQSM1HIf4C49FSIaNB3UDxToiaUW1FVEPLoLqz/jlewN1XZXQMkarNtYCiLxnTqnSuge7dmS6tWAINz5R7yims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851141; c=relaxed/simple;
	bh=VPRIaf1C07J42ykT1UemnFqv+BJKP4Di4tmuQJ89Keg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu9ycpM5welO7Cnowym4qt9sK6MEqSxmAZrYcO8vVVLUUICYKa8c0CNwgdOtNDSGcd5Z9SPey8bi3+qr7OZ8Hmf2/WAE4C5kL9/dGy+y703EjUOHeG4W73+Hs9fuAfPCtJsncmE34YtH7UcPHHUeM2qEJIzxo9YPVgApVjQXdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=FNSINSS6; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1759851139; x=1791387139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPRIaf1C07J42ykT1UemnFqv+BJKP4Di4tmuQJ89Keg=;
  b=FNSINSS6CvRthD/aweLwVXpkegViI7yEiuCuBHidGqYe9uR325FtX9G4
   hl9JHx1BNisHExyGTGJyuZsPOpxFujWptP7O94aqW5B9Nnb/VAjsnmf7m
   WC/PGO35HEhrHb1qFYl1Is4uo18qmS4tqQ50tyr16EQChaxTJaHVUZuJU
   8=;
X-CSE-ConnectionGUID: fc7q5blKSHqKkG9oT4Z6tg==
X-CSE-MsgGUID: mgZJRRfcTTKAAF1xT9ndiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="101797761"
X-IronPort-AV: E=Sophos;i="6.18,321,1751234400"; 
   d="scan'208";a="101797761"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 17:31:08 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Oct
 2025 17:31:07 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Oct 2025 17:31:05 +0200
Date: Tue, 7 Oct 2025 21:00:53 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Richard Reigh <richard@govivid.ai>
CC: <linux-wireless@vger.kernel.org>, <wahrenst@gmx.net>,
	<arend.vanspriel@broadcom.com>, <brcm80211-dev-list.pdl@broadcom.com>,
	<brcm80211@lists.linux.dev>, <chris@streetlogic.pro>, <s311332@gmail.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH v2] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
Message-ID: <aOUyLfSuIkby_8TZ@ISCN5CG14747PP.infineon.com>
References: <9811a46c-70ab-4bf6-9e20-7882fe1d0c55@gmx.net>
 <20251006231306.131967-1-richard@govivid.ai>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006231306.131967-1-richard@govivid.ai>
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

On 10/06, Richard Reigh wrote:
> When iPhones query network information via the WiFi settings "i" button,
> the brcmfmac driver crashes with a NULL pointer dereference. This occurs
> because the P2P device vif is not initialized when handling certain action
> frames.
> 
> Added an early check in brcmf_cfg80211_mgmt_tx() to verify P2P device vif
> availability before attepting to send action frames. Also added a defensive
> check in brcmf_p2p_tx_action_frame() as a safety net.
> 
> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
> 
> Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx")
> Signed-off-by: Richard Reigh <richard@govivid.ai>
> 
> ---
> Changes in v2:
> - Added early check in cfg80211.c before calling P2P functions (suggested by
>   Stefan Wahren)
> - Changed error message to debug level in p2p.c (suggested by Stefan Wahren)
> - Added fixes tag
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 +++++++++++++
>  .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c  |  6 ++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index ea8409e0e..9983136a7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5137,6 +5137,19 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
> 
>         vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
> 
> +       /* check if P2P device vif is available before attempting */
> +       /* action frames */
> +       if (ieee80211_is_action(mgmt->frame_control)) {

The action frame type specific operations are done already below in the
else if (ieee80211_is_action()) block. So ideally, it is better to do
all action frame type specific operations in the existing else if{} block,
instead of introducing a new if{} block, until unless it is really needed.

> +               struct brcmf_p2p_info *p2p = &cfg->p2p;
> +
> +               if (!p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif) {
> +                       brcmf_dbg(TRACE, "P2P device vif not available\n");
> +                       cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, false,
> +                                               GFP_KERNEL);
> +                       return 0;
> +               }
> +       }
> +

IMHO, bailing out here without responding to the ANQP Request, may not be
a viable solution for the crash. Need to have a way for the AP to respond
with the ANQP Response Public Action frame without crashing the driver.

Have a solution in mind, will send the patch for review after testing it.

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index 10d9d9c63..e62135cd4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
>         else
>                 vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> 
> +       /* add NULL check */
> +       if (!vif) {
> +               brcmf_dbg(TRACE, "vif is NULL, cannot send action frame\n");
> +               return -ENODEV;
> +       }
> +
>         err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
>                                         sizeof(*af_params));
>         if (err) {
> --
> 2.34.1
> 
> 

