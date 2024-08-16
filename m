Return-Path: <linux-wireless+bounces-11551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0D95487D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69FE1F2170B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704E2156F34;
	Fri, 16 Aug 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwAG2W2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5716F262
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809899; cv=none; b=WKhT8dKHeRTsGD+afg/lXLDxDIh8OR1JPZndj5OFkaFC/4mkMytN6/JeVs8oyhe4ygjxRSLkTARpSqaxIK4D3NPic7ni8Vb0jtVqW7tGPOZQt71aN2btJnNNGaeg1Th9tLg6MfKDnD2shkgoyg4X90f+wGGL8sQiRp6gzk/EEvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809899; c=relaxed/simple;
	bh=JDejKgVCbxXhHRpgDbe3BWZSZA/QTVuczNbgpBrRqDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sFtA6uXiN40RVBRjejEzL3qU7hkySQ6LAK63Od+0I5Vr5MC8aGFW+ZE+94tKAMnsyi5K/IlepdNIcPImUV2zCaf29mPTaup4vlqmq3oBudbieLDp8IqjChryELkzaJQLRF0Re+Y5/zYoR52RunVqs9tEF3dfGWS86U9VX38UVUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwAG2W2h; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70cb1b959a6so32937a34.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723809897; x=1724414697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bAGCjXrxKhbef6CK8M/Tk8DVVHCkXA7g8LfrMUTUsek=;
        b=cwAG2W2hmPVQ0cgEwov9JWVlWpGxAs4v5mPPGzrvSAQLapjdhuNFDVVR+LicmDzQyT
         nN7KOz1GF8s4c68P4MF7EDVRiMzzeFTbD8VWBQR/4HamSN6/7SSXXIujywpDvtaLbzCF
         bHxGx3r40++1tyGksKaTTqvrFzjELe2+RPg7MM94IJDu3SQKHoY+Bn+mbH9JmyS696F1
         ixKg4krmzENAr+0qM0ps7yBnsCv2hrgxKsbZnGlOl1fPb6Hnk/WVSEQP1OMua+SY4GzS
         aJJg2dIbka12FhJav92Kz52+K0by/9QTotSq8MbSHVcu0LXtNH0RcXlip8+FM4JcIY4U
         UsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809897; x=1724414697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAGCjXrxKhbef6CK8M/Tk8DVVHCkXA7g8LfrMUTUsek=;
        b=tIfyCdomUQBwzNrktuYA/5RCATgxFfXR4/+Ljcs/NdAI0cjDCg89m7MO30MJydAz9+
         XzPvOSCnZYZzHPhvB+ze0DSgpH6ZDQTBmN42bnwfH01E7juwzYz2M/dVoi0hN/kxZcF2
         D5rG7Lixj41DO9qAxYWG54SQMmzXy8ypBtj75J8Q8wQN0tzxPCztImM+2Xja1JtX/C9T
         2ObwltYAxub1eX7GHJzhvOngsuPxXEy1LuKzowmkKKzSCPUhYVa2yXsRJuBl/Vmgi/t1
         p9c0+LwnMUiHnQ7D4KWGoT4ajNKXu780vzO9zBEMitdyGQJFV2BJ6YwpcD8RU29TkJQC
         5UJA==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZfJU2McLNpNjrGqSXN/oSUSSFh5NsL61MK2CwBCP4ZzzIsh9sa9mTmrpmd477BGvxqFpYA/uuUTg1rkMVF1FhPmUKgXbUH0aekh5XOQ=
X-Gm-Message-State: AOJu0Yxc2WphiT+w2Ps9ZayRaq71okzuyK3reEKSHHh2+/jZ+xAnt/V2
	D+VGTbo2oNzlCa/SanwZgOgaA8JU7NkyyBIEOpUNTXSCUE8KmKldSwcaWQ==
X-Google-Smtp-Source: AGHT+IHhh8P1PbO/OvVABQjxu4tqdd+RBPI10sxBvOVgamQfTXG9ys/lB6tA3b0mEI2uyOdBSN/t7Q==
X-Received: by 2002:a05:6830:6f42:b0:709:4065:63e6 with SMTP id 46e09a7af769-70cac850081mr2881650a34.12.1723809896624;
        Fri, 16 Aug 2024 05:04:56 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd9e39sm15676331cf.2.2024.08.16.05.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 05:04:56 -0700 (PDT)
Message-ID: <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
Date: Fri, 16 Aug 2024 05:04:54 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 8/16/24 3:19 AM, Baochen Qiang wrote:
>
> On 7/12/2024 9:11 PM, James Prestwood wrote:
>> Hi,
>>
>> I've seen this error mentioned on random forum posts, but its always associated with a kernel crash/warning or some very obvious negative behavior. I've noticed this occasionally and at one location very frequently during FT roaming, specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any negative behavior apart from a 3 second delay in sending the re-association frame since the kernel waits for this timeout. But we have some networks our clients run on that we do not own (different vendor), and we are seeing association timeouts after this error occurs and in some cases the AP is sending a deauthentication with reason code 8 instead of replying with a reassociation reply and an error status, which is quite odd.
>>
>> We are chasing down this with the vendor of these APs as well, but the behavior always happens after we see this key removal failure/timeout on the client side. So it would appear there is potentially a problem on both the client and AP. My guess is _something_ about the re-association frame changes when this error is encountered, but I cannot see how that would be the case. We are working to get PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>
>>  From the kernel code this error would appear innocuous, the old key is failing to be removed but it gets immediately replaced by the new key. And we don't see that addition failing. Am I understanding that logic correctly? I.e. this logic:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503
>>
>> Below are a few kernel logs of the issue happening, some with the deauth being sent by the AP, some with just timeouts:
>>
>> --- No deauth frame sent, just association timeouts after the error ---
>>
>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>> Jul 11 00:05:36 kernel: wlan0: authenticated
>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=16)
>> Jul 11 00:05:36 kernel: wlan0: associated
>>
>> --- Deauth frame sent amidst the association timeouts ---
>>
>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>> Jul 11 00:43:24 kernel: wlan0: authenticated
>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=101)
>> Jul 11 00:43:24 kernel: wlan0: associated
>>
> Hi James, this is QCA6174, right? could you also share firmware version?

Yep, using:

qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp 
crc32 bf907c7c

I did try in one instance the latest firmware, 309, and still saw the 
same behavior but 288 is what all our devices are running.

Thanks,

James


