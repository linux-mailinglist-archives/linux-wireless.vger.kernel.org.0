Return-Path: <linux-wireless+bounces-27712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C4BAA480
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 20:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3889D3C7ED1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D902367CF;
	Mon, 29 Sep 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aHyld3c+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E578236A73
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170213; cv=none; b=Q7sW/fajdkmdFC8etpXAUgFxEE+/ceqkeME38t1V+PfxxjQ48ZkxJIrMTfqzmrnji3via3fEfY4TUhxOXCnaHBl4HKpEdpzenlFs1F3b3krQGo9lzASfymAl2s7m2UsmOwuHogGnDPi7xYAnPExFJA228XHCytOhjp+szmZCnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170213; c=relaxed/simple;
	bh=QJFtZVXeI6V/F7PauM5ALE2r/fz4phzD29nTCt36V1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEDZ4VfT/nHJB1Dhc9obqDlbYPAALsb+zQ+kXOK1k1T3oIdZ1WPrh2IHAsbhCQTQsBVESDOPCq9typK+2Ho270viCEyzyB0Oi0rNwYd75X6WQISk27SpY/xAnwI03zuB0Imv/d9zz+MF9bnD+EmhHZPfIXRXYF5GN99FLiZsfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aHyld3c+; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-90926724bceso309666939f.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 11:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759170211; x=1759775011;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8820Bco2QKTOhDzV/dKofCVg3cLeM7g3fa83BzQ1oeE=;
        b=Y88dUaW6pUNs89pzz5lfs52t8owVcc6iK//0gsp4+scheLoor8tbF6Tk8fge2EkTZH
         PXhSvCdqmPwI7oLHR6dKVPbn6Vy5fOkfKEB+5GWSZ85jFqXpgE27lEZlyDlSA9uRug3i
         2tOYwwedxM9SSL9yF6WUOkDpfRY1RyMu6LslrrYtmH7WNrkl8p5GxqMMJBm18Fd4js5y
         2rN66BFyHOK9h7jeZ09wNh95p1kJvGxE3YlaKpioh29L30iICQzvJ8jkr7TgD1tvv5Fe
         Y7ecwZMnTTpxZVzbk/knaxzLd5gr3/+DtJtv5/D6KW52Q9+GXmkKLAZLkuSQumeHaN7K
         KF7A==
X-Gm-Message-State: AOJu0YwX3Dg5Ds053fCbZLm3x5ejQXu0FlWA71DU5E/34E70e6Mqi8ee
	dId6uzxeTrU2yQkomH+bQMFpWxWcy2usPTCk8CdVyHT13nNePsW28K3Kb6dk9W3bW1DPMXb7VTT
	E8cVOdK2gs60uTNuQn0J7Zv0akxQ+MNzLbQklI8XROarCBIcbhhzi5KbSsdgr3Jmq8I23k/Nw4C
	HoF9oYo66oaAaLGzUwuq17vrePrf0Ek62mRD4vJLm+kn6a4E/e3f30oWuhGe87yFL8w28NupHTq
	9HLA7Jlvg7Sf77xM6L7KEwVcERa
X-Gm-Gg: ASbGnctv+5nDnjjMZ2VDyh/NG1eCnnPKEg9tBO1YsVLYYIqzgFuquDmORNv7tFupZF6
	y3mwX/ksqS6O57REfmBWbUN/oAmU6flaHtKZxiC/RHiCDLfTg3ows9Lv83m0RFOylV7LdIv67WH
	Qfq3j6DeCY+ZQ7RhvscoI7KJPXFOfC0wUMcfxV92opyx8qny25uYIBE5uYD5ZfwtVhGCVJ8qEg5
	vehvp3KebTuBSzr5XqrhWCHEHgiGVBfLK9Hr8hBcZ/AeMiVkhlY/ZkiUcBnjA2i18K34H7btCTp
	O6PkkbpHaHJUaOhqIv/2Ct02ibAsuRhekVeKDcq5tY6FaUda2fZoMLEbRxzfvUNJFJi5XO0muPV
	5j7Wh5pciUxl4d2TxQ1dKH1l2iHXkiiBO7sm0rqITBoutyEuqvB4/Yvbf74gheDR6lfnrHZmc+/
	/+6ZkuBQ==
X-Google-Smtp-Source: AGHT+IHdLY1kwdSpqhc8sDnd2yNFso70wecSAX/EasWbfXbm1j9aplb9RSmpQ2PAp6xWP21TwS2lBRESH/Rt
X-Received: by 2002:a92:dd11:0:b0:41f:5e50:23f1 with SMTP id e9e14a558f8ab-4259564927bmr208641255ab.25.1759170210536;
        Mon, 29 Sep 2025 11:23:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-425bf6d4f14sm8373065ab.23.2025.09.29.11.23.30
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 11:23:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f42b54d159so3829733f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759170209; x=1759775009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8820Bco2QKTOhDzV/dKofCVg3cLeM7g3fa83BzQ1oeE=;
        b=aHyld3c+/SEaDAHzQwytg1guZ9pxHzSCfLwqm33610R+dZ+BZ4MCrZ0ZsX5vR8z4dQ
         MGVMIHxHRRXEPGflmwRvyGlaSdxXUO3PkwY2arKWvQW/Kfda9jyLwwr3/Tnqm41dTADh
         WT070k71mqHuDeLzXs9N/n6Zep8GDZX5Iyj1A=
X-Received: by 2002:adf:ee44:0:b0:3ec:1b42:1f93 with SMTP id ffacd0b85a97d-413591d7997mr9616576f8f.37.1759170208798;
        Mon, 29 Sep 2025 11:23:28 -0700 (PDT)
X-Received: by 2002:adf:ee44:0:b0:3ec:1b42:1f93 with SMTP id ffacd0b85a97d-413591d7997mr9616558f8f.37.1759170208302;
        Mon, 29 Sep 2025 11:23:28 -0700 (PDT)
Received: from [10.229.41.112] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc6921b7dsm18996937f8f.42.2025.09.29.11.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 11:23:27 -0700 (PDT)
Message-ID: <b2e0bf04-f149-4a23-aba5-cad55a8923c1@broadcom.com>
Date: Mon, 29 Sep 2025 20:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS
To: Stefan Wahren <wahrenst@gmx.net>, Hsien Chou <s311332@gmail.com>,
 Chris Spargo <chris@streetlogic.pro>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>
References: <fd88175f-497b-4fec-9094-58709ddfd1bf@gmx.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <fd88175f-497b-4fec-9094-58709ddfd1bf@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/29/2025 7:06 PM, Stefan Wahren wrote:
> Hi,
> regarding reproducibility, I would assume Arend is using the mainline 
> kernel and Hsien just tested the Raspberry Pi vendor kernel. The 
> brcmfmac driver has some modifications downstream.

Actually, I tried to build the downstream RPi vendor kernel. However, 
there are some variables in play. The config Hsien Chou sent was 6.6.28, 
but the log is 6.12.34. So I have taken the provided config and built 
from the rpi-6.6.y branch:

commit bba53a117a4a5c29da892962332ff1605990e17a (HEAD, rpi/rpi-6.6.y)
Author: Phil Elwell <phil@raspberrypi.com>
Date:   Wed Mar 26 11:28:28 2025 +0000

     dts: rp1: Don't use DMA with UARTs

     DMA has been enabled on RP1's UART0, but with mixed success. Transmits
     seem to work, but the DMA interface is not well suited to receiving
     arbitrary amounts of data. In particular, the PL011 driver is slow to
     pass on the received data, batching it into large blocks.

     On balance, it's better to just disable the DMA support. As with the
     other UARTs, the required runes are left in the DTS as comments.

     Signed-off-by: Phil Elwell <phil@raspberrypi.com>

Probably should have tried withthe rpui-6.12.y branch instead. Let me 
try that although...:

$ git diff rpi/rpi-6.6.y rpi/rpi-6.12.y -- 
drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c 
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 7376f9f37d07..7949f78c61e1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2339,7 +2339,7 @@ struct wireless_dev *brcmf_p2p_add_vif(struct 
wiphy *wiphy, const char *name,
                 goto fail;
         }

-       strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
+       strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
         ifp->ndev->name_assign_type = name_assign_type;
         err = brcmf_net_attach(ifp, true);
         if (err) {

Gr. AvS

> @Hsien or @Chris,
> are you able to reproduce it with a mainline/torvalds kernel?
> You only need to replace Kernel, Modules and Device tree.
> 
> Best regards
>


