Return-Path: <linux-wireless+bounces-21328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A089A829B7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6334A2AEC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCF26E169;
	Wed,  9 Apr 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WDR7QX+P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02926B97E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211044; cv=none; b=FAPkEmTqJkAhzwjQTwYG94/ueeqd9Bfl5aDo1eN53IXW7N/1U4BuZn+YdXCwvPOjRjXIJ87vwPVdEbtbqUXAoyWNeHNJA5Y4h/YoHP+qpIY4ZVcPFyswpzigg3wMrV8nkbZhRlCrE7fxCbPZSor/UtuQN3rGXSNV710OrQoUP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211044; c=relaxed/simple;
	bh=A70GfRt6rS7q055BdUvnvblK20cYmxXB3ubM9CYqwaE=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bR4NKNm1gpO5IX+M8Bwd1fH1BteFBPZL54Gjjl3OBb4LXN7cI4RyLO3Hw8GKMCQrJo3P+Pv6Lu6TdCi+n+GuLOXcWtHr7u5sIjp5kdqNKbUOgouLOjFCqlKT0mwNu1nvmIPWb/qa5JWM13xfSjBzAT7NfMZEaAzGovRCi0T3JPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WDR7QX+P; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf3d64849dso1174282766b.3
        for <linux-wireless@vger.kernel.org>; Wed, 09 Apr 2025 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744211041; x=1744815841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdQ6uVYA6aRCHZvQyDMxVKHgqhU7FXpMW3GkKnr+FVY=;
        b=WDR7QX+Py5LOlnsKZjgHFenGgdqNgR44gD9SeNFV/hPGgSAO/MD1sRAy+6fSgem+2b
         BC9Ud1L9LzOn5iT4aF3gssabFKZ2P1n72tRU6XeSF4fFhjbjMeP221A8OMRF43Kq9U7c
         oPZ49n3UF9f/AMC/kgPQ5hGDKJ7cniL0o5uq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744211041; x=1744815841;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdQ6uVYA6aRCHZvQyDMxVKHgqhU7FXpMW3GkKnr+FVY=;
        b=YG5Kj+55w1cSPjK6krivA/TWTJ9lFOg4XKMh/fiQbPMf9wHeMiIl/kmFB6A/Y6R/9i
         yxWXIhfc/L3499+KfNlv8t/cScXuetc5E+hxhtD/7SqRZg/fCJR1LbLObqPMyzxF+vMd
         YjiEZzesUoCigWq/FOa+U7smf/u/4x7VH/KsOeHm1BToP9ItH76sLXzyr8dyJHp0AA/2
         Ub3Fs9CglRClo/eJHQ6aY3dSTSttQimoc3tQlhDXI53O69hmyqJx7IkyDiEncevYwQKl
         IlUOtOfWMutfkC27q0Zmtwu/ITFpJbgVM8zuTwOVDK7l0cTNlc9VEqovdbypPl1DOOyn
         EjbA==
X-Forwarded-Encrypted: i=1; AJvYcCU6+7SyvsuyQ3hXxABUwBuCxasuA2cBoIeE5a8MOCQltsKuUXaq150PEl6gEIgw0ihZo2kQiSn8isiLmd5hig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFi4o74ua9e41y0K+vlMdQa59z2xp89jtmwSflO5/3q0Em1Lhz
	Ms6zUbejwPMcIcDH6Fjtu0vea+d7pLMkccWYPZFSgyIRysbVp4M3Vh8aHhf3Uw==
X-Gm-Gg: ASbGncsg41vwCZ4kFFg8WvqiaRe+4kRgGUtX7fTNMk+EZECxqKTDog4YUaayM1Vm675
	Q+cmUissxu/8Od4nhwefw0DuP8r0OODKZbGOJon48g/xe6XeKj2oYOdD853xeImJswvLFbA7MXw
	TyYJ4y6jITF4uvGqiMHDmaYq6Zv5EHJySIFr+Us+qnBBhvSuXs5TNE7ziyYBrvrc/G7MSbQzvna
	XiZf6IcSPoU+QOYP+CtDi881ThjXEWjE5flOWR+SLS4PuJoKF91Oqbozl5I4dSoqHXc8NE+nKz6
	Mk1yo1YdQBZZ8Gly9EDjnlm2vfuMH3ZNhzXq2AdwW9k9n/j4DFpCSJOLqh2oBvAujC7WNEjry9Q
	75S4=
X-Google-Smtp-Source: AGHT+IH8rvSNSI9ZT7sJJpxIkBiqflzFJXcmfoY4w8kr3Fxm/euzzgm+d6qqs73HjSj0q7bCQs8BSw==
X-Received: by 2002:a17:907:97d4:b0:ac3:121e:f2cb with SMTP id a640c23a62f3a-aca9d5dd4femr248936966b.1.1744211040164;
        Wed, 09 Apr 2025 08:04:00 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce7042sm106602666b.165.2025.04.09.08.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:03:59 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Wentao Liang <vulab@iscas.ac.cn>, <kvalo@kernel.org>
CC: <christophe.jaillet@wanadoo.fr>, <megi@xff.cz>, <saikrishnag@marvell.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Wed, 09 Apr 2025 17:03:58 +0200
Message-ID: <1961b144f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <d791185d-6a23-4c6f-8a93-d5464409939a@broadcom.com>
References: <20250406081930.2909-1-vulab@iscas.ac.cn>
 <d791185d-6a23-4c6f-8a93-d5464409939a@broadcom.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] brcm80211: fmac: Add error check for brcmf_usb_dlneeded()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 9, 2025 2:11:08 PM Arend van Spriel <arend.vanspriel@broadcom.com> 
wrote:

> On 4/6/2025 10:19 AM, Wentao Liang wrote:
>> The function brcmf_usb_dlneeded() calls the function brcmf_usb_dl_cmd()
>> but dose not check its return value. The 'id.chiprev' is uninitialized if
>> the function brcmf_usb_dl_cmd() fails, and may propagate to
>> 'devinfo->bus_pub.chiprev'.
>>
>> Add error handling for brcmf_usb_dl_cmd() to return the function if the
>> 'id.chiprev' is uninitialized.
>
> Thanks for the patch, but NAK. Let me explain why below...
>
>> Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 
>> chipsets")
>> Cc: stable@vger.kernel.org # v3.4+
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 7 ++++++-
>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
>> index 2821c27f317e..50dddac8a2ab 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
>> @@ -790,6 +790,7 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
>> {
>> struct bootrom_id_le id;
>> u32 chipid, chiprev;
>> + int err;
>>
>> brcmf_dbg(USB, "Enter\n");
>>
>> @@ -798,7 +799,11 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
>>
>> /* Check if firmware downloaded already by querying runtime ID */
>> id.chip = cpu_to_le32(0xDEAD);
>> - brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
>> + err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
>> + if (err) {
>> + brcmf_err("DL_GETID Failed\n");
>> + return false;
>
> The boolean return value does not indicate pass or fail. It answers the
> question implied by the function name brcmf_usb_dlneeded(), ie. is the
> USB device running firmware (false) or do we need to download firmware
> (true). So returning false here is not going to help us.
>
> The id.chip is initialized to 0xDEAD so upon a failure that value is
> being passed to brcmf_usb_prepare_fw_request() which will consequently
> return NULL, because we do not support a 0xDEAD chip. So there is no
> need to bail out here. Just print the failure message is enough although
> I would suggest to include the err value:
>
> - brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> + err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> + if (err)
> + brcmf_err("DL_GETVER failed: err=%d\n", err);

Maybe an error message in brcmf_usb_dl_cmd() would suffice printing the 
command id and error value. That way every invocation of the function logs 
a message upon failure.

Regards,
Arend
>



