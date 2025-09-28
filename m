Return-Path: <linux-wireless+bounces-27686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADCBBA762D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5B63A43F7
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Sep 2025 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E28212548;
	Sun, 28 Sep 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MShMd1cC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D70149E17
	for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759084282; cv=none; b=ndus+2UrVZrIKGcstBufGXvTBY7udgfMq6o6Uhryu8aaLZegbX1uN33zjPKeCIcXPBMUrzLOa6ODuKeMTTtWCrFkmqxBgBRs1GEDLuSmTha8TSu8BUIgCA2ZvY4irNgLrVmy0UYOOGs57pBl3VOfoeCcdhhMnd0WN96qT1YJMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759084282; c=relaxed/simple;
	bh=PYZUlpfvT2ZcrsZ7U+uilDVUWowRz36UUNqZO4fBgkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EV/OG7u+Qi8cwHppjcwTKvN4X0TguR8S0hkIrWiygwtyymiTAYz0PDNN7mUbNUzSRu4VUJCmnTEFVOI2fC9pl7zWYnuZWOXedSH0P5NwT1IC0T3oXFXRshX1SJhz04EBYOUyqXBowS88W4JsxwkSp3gFxmrn/kXGcAS8WTkgNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MShMd1cC; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-633c1b740c5so2693553d50.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 11:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759084280; x=1759689080;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FaVTHQxepHhWY00ilV5GmDuf2+vdGOeUTtGtx6/KsM=;
        b=NIgAmKw7paV0jMLmH7C/qJCgYMNgAMiifYWsD7/v/0gdWBwbK1SxuSvyrHBlPeHiGr
         UGc5IlVqCtz7ghMGn93VPKF71yql5O39cMroMGDxC2/tYcN6lHgpS3BPbsvyKXcImBIC
         ywgEMC6IK69lhOiGDAsL9uqlIXX7yLKT6YMhpqmtEzkzc60xpl2EijGFKtc1xo5dxRS2
         QWbdM6e17X238D3sZ+fJnrND2dnGO4U/WrC6TI3ZQVKtrdQJlf81XQBqgyihncgCLzfg
         Nw0WJrGZ9FS8bfvEU//uu9akCr2mpvMXU26X3TX3YZqo3ENIJ2o+Q3Wx68cYUTM2+CYz
         TebQ==
X-Gm-Message-State: AOJu0YwbMEiriojZQ6cIuiJwpwK1esYtEaK150fHSlIaBmwD9ViJoWIX
	jqjEfoANcrTOtMkqVw1bdedspwI28SiO1olSdP5ZtLjniQ25tbaLK4W3ijqRc8vBDVrxxOpqF2+
	ZvnSp6N+RD1DlRYcR9OmR1XBNA9pppEfRrXSyHKYmI3SHHBlzDjcTftOsHXU+a0kdvG56cpx0Qh
	1vflE1MHNOBGpAt9nH4beqIZ3gSK12s/Y7pcUF4HN8pXDZzDXfvGTiBwXxYMZQoK4r195VkWu8u
	L4aXDQBNlVA17ZUP/5OleqjdR0H
X-Gm-Gg: ASbGncvtzFC/CbOQtXnQLijkfJHv68o2r92BhL1tljvqrzScYIjxpgND0mo3rpR56+W
	IgMdtYNPD5KRyIZtlIFUTC59pqqFw0ejRXJiwDaXS32KhanZCN/RcvWz8YRuh9Nd9DmFmflRpMW
	9AhXc/C9V39f4erGmxYAfBpe3KYJTJgfwdcgH5VThbWQoQ1xKKrrAM9/YdQRiWFUClEloo+tJhk
	yx7zClIPD/z2Cz/IJ/Fqu7knw9uOmdPkNSfRWhK9x5O3kqWfuDmwZMM2dDx4e5uGTK/oGx/ZJ6z
	wx//Bi6abr960IoG7/Q/lJslfVDvvAE/dvmq1EL5IwwyTFG+VpoEp48KTCQHCEl4+EySBjOYG/o
	7+wGy+0WeWSO3wP73zDyC6NuqfeZf6j4CzE/drcGZbL7RDQqZTTGjfxQR152Ec9A25FpKLeBxR3
	+ze5A+zw==
X-Google-Smtp-Source: AGHT+IHWedOuzPL/NvRSgPs58Bs8LojwAykn/YZnB/UV3sX4AlpQJCIVcIiQbJFz8dpoYPdoZe/DlekuAcC8
X-Received: by 2002:a53:b4d0:0:b0:636:1ee5:7745 with SMTP id 956f58d0204a3-6361ee579b5mr11771067d50.0.1759084279749;
        Sun, 28 Sep 2025 11:31:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-eb38396eb2csm566395276.18.2025.09.28.11.31.19
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2025 11:31:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3bc13c24d6so113592066b.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Sep 2025 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759084278; x=1759689078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7FaVTHQxepHhWY00ilV5GmDuf2+vdGOeUTtGtx6/KsM=;
        b=MShMd1cCXHAzhlnlyeKC00892LmjrfGRrGxeuKMu0gSi40S8z8ASnsXjpIWOShovZj
         FYWBuY9C1Jxi9HNl1lM0NOzJ/C8EMF1ovb64RNEYAYx5L/YE2pD7H+MdDgLUryksKwUJ
         f1d+hydjIWZKmfD4Jvfew5WfoFqXuuncM287A=
X-Received: by 2002:a17:907:1c16:b0:b35:3073:28ac with SMTP id a640c23a62f3a-b3544101c80mr1706227366b.0.1759084278065;
        Sun, 28 Sep 2025 11:31:18 -0700 (PDT)
X-Received: by 2002:a17:907:1c16:b0:b35:3073:28ac with SMTP id a640c23a62f3a-b3544101c80mr1706224266b.0.1759084277527;
        Sun, 28 Sep 2025 11:31:17 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f3995adsm776347466b.35.2025.09.28.11.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 11:31:17 -0700 (PDT)
Message-ID: <1a187bdb-abd6-4e2c-bc29-94f9ab944023@broadcom.com>
Date: Sun, 28 Sep 2025 20:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: driver crash with iOS 18.6.1, potential DoS
To: Hsien Chou <s311332@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, Chris Spargo <chris@streetlogic.pro>
References: <CAE3HL_yv8t1Rkd+jLfQMkc3YrNONQp0pRFESV+v92ECf_+7Xjw@mail.gmail.com>
 <02ff0c6e-f2e5-450e-9666-3ce8b8404f86@broadcom.com>
 <CAE3HL_zPi2szh-_kPSvBcwHnYrSSYa51hwK_Kb4DqZbKAQct_w@mail.gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <CAE3HL_zPi2szh-_kPSvBcwHnYrSSYa51hwK_Kb4DqZbKAQct_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/26/2025 3:36 AM, Hsien Chou wrote:
> Hi Arend,
> 
> Attachement is the kernel .config file. Thanks for the quick response!

Thanks. That helps and using gdb I can determine the location in which 
the null deref happened:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:
1561		if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
    0x0000000000016d18 <+560>:	ldr	x0, [sp, #112]

1562			vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
    0x0000000000016d1c <+564>:	add	x1, x20, #0x48

1563		else
1564			vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
1565	
1566		err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
    0x0000000000016d20 <+568>:	mov	w3, #0x724                 	// #1828

1561		if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
    0x0000000000016d24 <+572>:	ldrb	w2, [x0, #5]                 <==

1562			vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
    0x0000000000016d28 <+576>:	add	x0, x20, #0x38
    0x0000000000016d2c <+580>:	cmp	w2, #0x2

x0 is indeed 0 so p2p_af is NULL. Offset of subtype field is indeed #5:

/* offset    |  size */  type = struct brcmf_p2p_action_frame {
/*    0      |     1 */    u8 category;
/*    1      |     3 */    u8 oui[3];
/*    4      |     1 */    u8 type;
/*    5      |     1 */    u8 subtype;
/*    6      |     1 */    u8 dialog_token;
/*    7      |     0 */    u8 elts[];

                            /* total size (bytes):    7 */
                          }

What does not make sense to me is that the logs says:

Sep 02 17:24:32 raspi kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000000000000000

Given the instruction in brcmf_p2p_send_action_frame+0x23c (+572) I 
would expect the kernel to complain about virtual address 0000000000000005.

Also not clear how p2p_af can be NULL.

	p2p_af = (struct brcmf_p2p_action_frame *)af_params->action_frame.data;

struct brcmf_fil_action_frame_le {
	u8	da[ETH_ALEN];
	__le16	len;
	__le32	packet_id;
	u8	data[BRCMF_FIL_ACTION_FRAME_SIZE];
};

struct brcmf_fil_af_params_le {
	__le32					channel;
	__le32					dwell_time;
	u8					bssid[ETH_ALEN];
	u8					pad[2];
	struct brcmf_fil_action_frame_le	action_frame;
};

so the data field in action_frame is a sized array element so it is not 
possible that it has NULL address.

So it seems I could not reproduce the build reliably. I used GCC13 iso 
GCC12 as given in the .config, but I don't expect that could explain the 
difference.

Regards,
Arend

> Regards,
> 
> --
> Ken Chou
> 
> Arend van Spriel <arend.vanspriel@broadcom.com> 於 2025年9月26日 週五 上午2:31寫道：
>>
>> On 9/24/2025 4:53 AM, Hsien Chou wrote:
>>> Hi Arend and everyone on the mailing lists,
>>>
>>> I'm reporting a driver crash in brcmfmac that can be triggered by an
>>> iPhone with iOS 18.6.1 or newer. This issue *allows a remote,
>>> unauthenticated device* to crash the Wi-Fi driver, leading to a denial
>>> of service.
>>>
>>> The full details, including complete crash logs and a step-by-step
>>> reproduction guide, are available on the GitHub issue page:
>>> https://github.com/raspberrypi/linux/issues/7033 <https://github.com/
>>> raspberrypi/linux/issues/7033>
>>>
>>> For a quick reference, here are the key details:
>>> * *Affected devices:* A Raspberry Pi running as a Wi-Fi access point.
>>> * *Trigger:* An iPhone with iOS > 18.6.1 attempts to view the properties
>>> of the Wi-Fi network.
>>> * *Root cause (based on preliminary analysis):* The driver panics,
>>> possibly due to a malformed or unexpected frame.
>>>
>>> Please let me know if you need any additional information to debug this
>>> issue.
>>
>> Having the kernel .config file from the Raspberry Pi would be helpful
>> reproducing the driver build. Can you provide that?
>>
>> Regards,
>> Arend



