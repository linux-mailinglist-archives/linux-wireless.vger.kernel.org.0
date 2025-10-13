Return-Path: <linux-wireless+bounces-27956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E79BD2CAD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 13:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D62189B93C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Oct 2025 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE822459E7;
	Mon, 13 Oct 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X4d3VjM8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27EA13D891
	for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355236; cv=none; b=CE8XD622hJO86QvC0cQVckDud+gnAgSbuyjRtBdAToNar96azX7SDt7m+/iwdK85GjibbpbjhPPVqL+fIKlLeD9K3iVrK6kG1BjUWYP2cFUbehb3ScGd/u3kXE8XZvOEsxt32Q4HG0sPk/brsWMG96YrIM+3wGWBBMikkPrKb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355236; c=relaxed/simple;
	bh=/OvjI94dc8ZRU0Lt7OAWyHcYfEotIbmlebyKuelkavo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrsPPRpYXXfHiMLWFCLpC+HbqfaeccXttNsmsaUDySJKHZZpBVoH5fcpDZclIVTSSh0iD73Xup7mEwt4Y/htS7ifvBwHSueKiwSI0p9tfPyGS5p3T/fL/7+PtMzhIzO4DovrUBzAh6vKNWY4z269paaZGeuTyvrmWw0fLNj/hUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X4d3VjM8; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso74615396d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 04:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760355233; x=1760960033;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzZNrEoavuEwRdR40sndCnNWJejOOVpgDVKtB+Z0zf0=;
        b=jXeb3VK1MJHkN23ZmOZ0RG1dhsPW29J418kQbc9+999hgbclfDHmQuhJa4iyxcQQ1N
         yZlXN3v1sp8vdLYFQf2Oc503LckzVJVZ2q8uRuY5WsIlvEvIeFWr6L/nIQCb6d/kgLBj
         2GjwALsKXKOqfqZAVI6D6B/xaAU9Aul+6cyVl6MHATpX0SQmnpwEmqNccfhFEeWkFyA8
         OB9Ri9XJIniZdcwuBrxUnmVPB9/6yQ+dsBZprVQpFBzc5Svoxbw5Mp9GgkSLCu1mPaVC
         /wsbrkKeKvPrE8Qp2FifvUc5fybGGVThUxU28FOMP6Eq55oGJeSvazdLYOpBsPGisqMu
         IoJg==
X-Forwarded-Encrypted: i=1; AJvYcCXO+QfDkPaMRsk3hvtivxWzQoAtA2IUvFtUaUt0ATDrENbxredbAKlkopKtPgGZk+zlb4l386yDhEsgtNMs+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDI5ee5qFw/86yz2nzEGwP0vfY8fEx13pCCD+OQdThvFYM+CQ
	8h0x8XUN2b9OJSx/5BivP3/Yj38Gww+fP1NzMU2M7tX0zsgRf6mxn9J3rCoUDJYrzpK07cE5bSB
	k5IIW+VpmT2UdT2E5LgU0rRhGcWzqRx4PrvYwpPDUAfR4AwwMHXYbb/bB0EDv6fQwSwsioqKt3O
	kEfCP4ZyzKePS9biMF/ncCEITuiXPsS+NMm589+SBDRgMs+XvYJZ/sThpSOwWb39bunwP3J2k+/
	Ce+XAojFeiZhrkAKUcbVxmLVN9Z
X-Gm-Gg: ASbGncsEIlbz3bnXi3aRRuNFDRCuI9OpS0jOIsMFee0lPrPnySqSVoVtk9nEKuXfOsn
	+Mrk/za0ZMf1bVwgrfnRgfPEPpnuizQV+wbnmr0cb+iXG+ZUHmm7xOBwEdy0b7syH+mjJi6QGTh
	+SD+9guVdrQwj31os8PC0VPqY8i+bUdmLN693jtmQ6G+u3KfgffK6XZxQH+0DiCu4GZ3UKaG78U
	M83BHdV9s7wguR4x6OZfHsSLsMJLVw0Yu0xD7tZw3vLR+qRQ6gzux9ZeDoH2GLrLCpuJbT/PJzd
	JCj12Lcv4gxmR2RbctPG05NDUPfuL1eBNxOfxXUmhI35DnzOVSJh0rmq745245Cpsq+jil1om9E
	nhVG9cMUf8uAjHDA6pXRS3RXzgn8b6WSvdp44g4NTu0cmHSIuLsTzp1xdGqEKFoGdoDGYJ+OxCM
	21i+M=
X-Google-Smtp-Source: AGHT+IFhLTwY1EosSoa9vWtv/420MtW1Z15jLq18ZbKmTd99E1BOFaDhJKgRVEBoHYgA8WI9PprM6dNc1Jq9
X-Received: by 2002:ac8:5712:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4e6ead147abmr296596491cf.27.1760355233381;
        Mon, 13 Oct 2025 04:33:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87bc32f08bbsm7904766d6.0.2025.10.13.04.33.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 04:33:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-854bec86266so1808794885a.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Oct 2025 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760355232; x=1760960032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dzZNrEoavuEwRdR40sndCnNWJejOOVpgDVKtB+Z0zf0=;
        b=X4d3VjM8Oj2GWwP6MC7UXmvuZlQvPvo7BF9Wqg1bik5qZxpf4jteN9U/gNLQRSCNln
         HfieBbOMQ+KjetdDuWTpSapysJKiohQBG/HIPd2yK4+0cAQzbbUBraY3BP5z4CXxwM35
         5j+Q74xCtWOOgP+fdBLFX2l1fz3PPdhZ2iDHY=
X-Forwarded-Encrypted: i=1; AJvYcCV7yWTDx1P56826b4dbFSWy9jSu7nz2LtG83GmSwx9WN7Konym3Coezh8cb/BV5ImyLzm5khrKl+P8jFLr/vA==@vger.kernel.org
X-Received: by 2002:a05:620a:a515:b0:886:ea5d:9270 with SMTP id af79cd13be357-886ea5d939fmr1176259085a.72.1760355231727;
        Mon, 13 Oct 2025 04:33:51 -0700 (PDT)
X-Received: by 2002:a05:620a:a515:b0:886:ea5d:9270 with SMTP id af79cd13be357-886ea5d939fmr1176256285a.72.1760355231289;
        Mon, 13 Oct 2025 04:33:51 -0700 (PDT)
Received: from [10.176.5.85] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849fe858a4sm960780385a.26.2025.10.13.04.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 04:33:50 -0700 (PDT)
Message-ID: <08f5a413-7bd3-477b-a78b-e9798bb42208@broadcom.com>
Date: Mon, 13 Oct 2025 13:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: brcmfmac: fix crash while sending
 Action Frames in standalone AP Mode
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 chris@streetlogic.pro, johannes@sipsolutions.net,
 linux-wireless@vger.kernel.org, richard@govivid.ai, s311332@gmail.com,
 wahrenst@gmx.net, wlan-kernel-dev-list@infineon.com
References: <4d24f3ed-0b7d-45cb-9dfc-b8b5e0b37fd2@broadcom.com>
 <20251013102819.9727-1-gokulkumar.sivakumar@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20251013102819.9727-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/2025 12:28 PM, Gokul Sivakumar wrote:
> Currently, whenever there is a need to transmit an Action frame,
> the brcmfmac driver always uses the P2P vif to send the "actframe" IOVAR to
> firmware. The P2P interfaces were available when wpa_supplicant is managing
> the wlan interface.
> 
> However, the P2P interfaces are not created/initialized when only hostapd
> is managing the wlan interface. And if hostapd receives an ANQP Query REQ
> Action frame even from an un-associated STA, the brcmfmac driver tries
> to use an uninitialized P2P vif pointer for sending the IOVAR to firmware.
> This NULL pointer dereferencing triggers a driver crash.
> 
>   [ 1417.074538] Unable to handle kernel NULL pointer dereference at virtual
>   address 0000000000000000

[...]

> 
> Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx")

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
> ---
> 
> v2:
> - Retain the reinit_completion() for "senf_af_done" in existing function
>    brcmf_p2p_tx_action_frame(). And move the init_completion() from
>    brcmf_p2p_create_p2pdev() to the brcmf_p2p_attach() function.
> 
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  3 +-
>   .../broadcom/brcm80211/brcmfmac/p2p.c         | 28 +++++++------------
>   .../broadcom/brcm80211/brcmfmac/p2p.h         |  3 +-
>   3 files changed, 12 insertions(+), 22 deletions(-)

