Return-Path: <linux-wireless+bounces-25676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06AB0B02B
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 15:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5FC1AA3EC3
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33A15278E;
	Sat, 19 Jul 2025 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gfoPIPyt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B6DDC1
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752930615; cv=none; b=Ij+YLDA3RLYyhb9+V1MDnZpozoIVXo6EGQAeFi6JPhEe+oo36FvPZylPg7bqYfWOZnbcjohkQZOHEGpPahzdzV98g4k8h6uHg/9tGXVUMDp03PXxUZZ7TpYjkUpy9f2XMzJyF/0FQ27SmPMUPVgvRlJklf2UHvX2e9nseWfXjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752930615; c=relaxed/simple;
	bh=8SGl7r65wEVgyZ3SjxUwL8eWFzfmZy4H+rf6w0b/N8o=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kWQVWiNdIxRC7WU5yHTV1kj0ys6DJ9+xvcB5s83MH7JZ7zWKZ68M1fjTZJjgZJ6/z/aUKE8a5ODqEmM24IucCSmZR7w+dYGT2qzW4mUckpdA2oVBMFvAXqxLk7JKrw4NdV+G8LlgzpbY4Ru+Jp7DV0KWk3uLwbQ7I++9gTEtlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gfoPIPyt; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so5257143a12.1
        for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752930612; x=1753535412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJDpncAmbJKu1kr3LNcv6DPuOBIpHS6OJlJ+9JXb1xY=;
        b=gfoPIPytCUYUvByxfAdzyOrPEOKX6S+rexeLpxhk7cGhL49Xwam/zdiADe09k5Sadj
         QPdwkn09sL3cflZjF28fdYDDiVzJbiEnqpOnpJLd/UXNaz3TGwkxH8DyYT81b94iQAPm
         emQocXlQ39QrPt5QIFGIHds6T8s4ER+IOGAE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752930612; x=1753535412;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJDpncAmbJKu1kr3LNcv6DPuOBIpHS6OJlJ+9JXb1xY=;
        b=Q9klD9JHseAw0rpk6Lu0RhVKap1wCrJ2AhVOiw4znVlxKih0SyLhhEYaL+E4fH/nwD
         9Sf/yIP1knvoKAHLF4Big4OtXrfPGMe3H9kaxmihDSIw61IKDvgLqOTAVHlm5ohrs11o
         j8Cs1SRAjSk79W7tQ2EOVuIGZrpLioBgH+2bGS50cFETsQcjTykZI9rsrODnxMYfD9Ot
         IM0h1R2fCBylZBuHJFrV7mh64C60v7qmn/0udj1Ax4jFSOlSKW/E5sibiP7aLYj2/2la
         nuoWY1WijNnqaLX44OA2qXqw4BC53LRUnWdBPL9pDdGnmqMIyBEMLbUWpwa43KuTR3OO
         PNGw==
X-Gm-Message-State: AOJu0YytwjKD45s3YnfxPJCJth4Lslz9RDzhop2hAcyTDK1Gjnk6//Lg
	tHPAuZ2sLm3f3HRnyg0vqAGEUK7ZxzplIQgbeo4kNgp4SvDSKe91Co0DJbSOIEo6ww==
X-Gm-Gg: ASbGncutYWN+LHjrUSao/dbzYqGJmC0M/4KzPDwY3tBlRrvLZ0x+OqGCfQtqodUSMyb
	Oi0J2fXx3G86OCGoNxDulSaT7dLj3OUg3idnVKXT+RcTwns+rWnONLgSiobuKwgAK6g9G/BsLT3
	QOsjihI+YO+YVM4oT52r0x+3qeiCYw87moluWEG8Zuvp6yTRWS+zbMStOgTMh9CA4f9WNuspn2V
	9XqFhqW22DRh1tt0KJFrp0msPS2rH4LgyigqnwsuR8teXskBKfXtDUggpemsM5mb8zdYQrKThC2
	4RDsec6iDCxhVtWhVwOpaf6IeaeMRdmtVRz9pzCkpLGH0Jajg6lQA6ANrZ1MwT1slrd+czdwi7O
	Z9Ug/+Qih79T5RkTKLN9gvdnCVJ57L7OwNAWoADkhnXFGisTfpNkRHCiaByb51L0dgOCjV/0=
X-Google-Smtp-Source: AGHT+IHvTuWbAwAWdDAC+dFHxC6tFVTmU1n2PXejwG8LX6Dyq9sGIapdMJ7mFFZ8/uR6gvPbc9KCyg==
X-Received: by 2002:a05:6402:520c:b0:608:a7a0:48 with SMTP id 4fb4d7f45d1cf-6128262b18dmr13395215a12.28.1752930611917;
        Sat, 19 Jul 2025 06:10:11 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8dea633sm2519414a12.0.2025.07.19.06.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 06:10:11 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, Johannes Berg <johannes.berg@intel.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <wlan-kernel-dev-list@infineon.com>
Date: Sat, 19 Jul 2025 15:10:09 +0200
Message-ID: <19822ce6768.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250626050706.7271-1-gokulkumar.sivakumar@infineon.com>
References: <20250626050706.7271-1-gokulkumar.sivakumar@infineon.com>
User-Agent: AquaMail/1.55.2 (build: 105502562)
Subject: Re: [PATCH wireless-next RESEND] wifi: brcmfmac: fix P2P discovery failure in P2P peer due to missing P2P IE
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 26, 2025 7:07:23 AM Gokul Sivakumar 
<gokulkumar.sivakumar@infineon.com> wrote:

> After commit bd99a3013bdc ("brcmfmac: move configuration of probe request
> IEs"), the probe request MGMT IE addition operation brcmf_vif_set_mgmt_ie()
> got moved from the brcmf_p2p_scan_prep() to the brcmf_cfg80211_scan().
>
> Because of this, as part of the scan request handler for the P2P Discovery,
> vif struct used for adding the Probe Request P2P IE in firmware got changed
> from the P2PAPI_BSSCFG_DEVICE vif to P2PAPI_BSSCFG_PRIMARY vif incorrectly.
> So the firmware stopped adding P2P IE to the outgoing P2P Discovery probe
> requests frames and the other P2P peers were unable to discover this device
> causing a regression on the P2P feature.
>
> To fix this, while setting the P2P IE in firmware, properly use the vif of
> the P2P discovery wdev on which the driver received the P2P scan request.
> This is done by not changing the vif pointer, until brcmf_vif_set_mgmt_ie()
> is completed.
>
> Fixes: bd99a3013bdc ("brcmfmac: move configuration of probe request IEs")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
> .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 4b70845e1a26..075b99478e65 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -1545,10 +1545,6 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct 
> cfg80211_scan_request *request)
>  return -EAGAIN;
>  }
>
> - /* If scan req comes for p2p0, send it over primary I/F */
> - if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
> - vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> -
>  brcmf_dbg(SCAN, "START ESCAN\n");
>
>  cfg->scan_request = request;
> @@ -1564,6 +1560,10 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct 
> cfg80211_scan_request *request)
>  if (err)
>  goto scan_out;
>
> + /* If scan req comes for p2p0, send it over primary I/F */
> + if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
> + vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> +
>  err = brcmf_do_escan(vif->ifp, request);
>  if (err)
>  goto scan_out;
> --
> 2.43.0




