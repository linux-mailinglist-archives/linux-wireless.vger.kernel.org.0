Return-Path: <linux-wireless+bounces-2809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7833842543
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 13:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0762B1C212E0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29084C66;
	Tue, 30 Jan 2024 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGXD0BKj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57767749
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618871; cv=none; b=ZaEi8KFUnRUz+cg3YQVnIuv9ruFSWjHHP0VZV7eWuCljeCnb0JKR61B6DYJXQV9SzMerMhlUGtVYKNRpKZGX0w0y9XtCF2OD99RWnvr0cTNYpFG+C7MCWaqfMCVQiPg8UEisYApFsk7USIkK1w1UVqv+TIm9Whknad0DFFBI08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618871; c=relaxed/simple;
	bh=MhQT7o+Al/h0IoQPXBL/bPL4C/jTbRMt3l/rAwvfqDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=bBTfMjeiErEMDPpn8ytsLpPoh0P+ClfjQSmY4xhm1XqkqbW4MOdpFEHA5z3cucp/7d83Pi3aP0Ao1aSm1NwFzE9LtRScGnikNkTSuPnhzuKUSiyapm35DIlEj27VDeNeTu3p3jCxOCeCmcaATWK+9q2hqWz3WENhrqSOgCXSxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGXD0BKj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddce722576so1853673b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706618869; x=1707223669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1A7lAno5x9C29tGnNasR6WfLx0tGgZFi6+7h8bi5BQ=;
        b=QGXD0BKjHvhWqIYdycs6jBs3Neq4ZiJXbNiiPVsABLi9lkZcoWv7bXj/8wI0Z4yVDi
         PqLt4niSEn0ShyvS1kco+7myeny2J8BOivSyMmrKPRdLUztBVUOKBU8xd2/7rMqlLFJ0
         V9YEzJVHYhaXC6L9J9ZpgLLLyTTxW71z7wiWusWP+KcJ6jlq3At38PbLCLI/MFF7pYds
         cDQFKo2BBwgNb3yIEtq3EKi3T5E0QEJpBSJplIae88FXsndoLxdqH9GXPgiebHcHF6Ux
         zSMuWPRC/+Ci6yFDnF5gVkbWqTmKOJg3VUY1L47TTQ+tJ66BSW7wqaAwlPxgpHu35rQJ
         C72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618869; x=1707223669;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1A7lAno5x9C29tGnNasR6WfLx0tGgZFi6+7h8bi5BQ=;
        b=qnr5nIJ617QOi7f1xmJpWFwvGOu+WP82IOXZdMVpRsiBKDHwjv+mrPB5i1IJizklHj
         GwH5+mjDh0zTZVBGgncHbw1U1qqXPrlG/cR5ckDb2nZMB/yMrtAb4jgkH0PwP5v+KA8V
         OX126JOx4U2TlSuvfmu1BcrJAzOmhT2mDobX5M4I9c+hJES6vuBoyt/syZpnwuXyZTXR
         PoqXQEIrekdtMNvpaDgxM2Lio9dzBlhf+RCZJTPEg72pefnpFcE0MhW4z2/cUgg0ce87
         aila5HARXKr2hWuJzyPn6hyJMAlIRjYnQkLdgjzFVSgi2P09sC6M7KcgDgNvQLOu57N2
         H9vg==
X-Gm-Message-State: AOJu0Yy8a8Tf7H5ZGYTGIpJw9pVyCBD2aa3N3T1TWLOT5OSshhE8D3Rd
	Akou/21pnFHSaeY4V28aNuqkgBwgqjjQEXlYeMItzMcvzkuGKv6S
X-Google-Smtp-Source: AGHT+IGjmtBVR3GPrHrPAln3egIkNUUaeyzoNHquZBybeWZzhsqy5DN4P34ArZ3nEEbv+mORdz0ciQ==
X-Received: by 2002:a05:6a20:4f1e:b0:19b:e91c:1a42 with SMTP id gi30-20020a056a204f1e00b0019be91c1a42mr4463748pzb.55.1706618869413;
        Tue, 30 Jan 2024 04:47:49 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090a31cc00b002868abc0e6dsm11374081pjf.11.2024.01.30.04.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:47:48 -0800 (PST)
Message-ID: <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
Date: Tue, 30 Jan 2024 04:47:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
Cc: James Prestwood <prestwoj@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 1/29/24 11:00 PM, Baochen Qiang wrote:
>
>
> On 1/27/2024 3:18 AM, James Prestwood wrote:
>> On 1/24/24 5:06 AM, James Prestwood wrote:
>>
>>> Hi,
>>>
>>> I recently added support to ath10k, for the QCA6174, to receive 
>>> multicast action frames in order to support DPP. I'm trying to do 
>>> this for the ath11k QCNFA765/WCN6855. I took the same approach as 
>>> ath10k which was actually quite simple but I'm unable to see any 
>>> multicast frames coming over even when I enable RX/DATA debugging.
>>>
>>> What I've done so far is:
>>>
>>>  - Add FIF_MCAST_ACTION to the supported filters list
>>>
>>>  - Created/started a monitor vdev from within 
>>> ath11k_mac_op_configure_filter()
>>>
>>>     ath11k_mac_monitor_vdev_create(ar);
>>>
>>>     ath11k_mac_monitor_start(ar);
>>>
>>> - Also tried adding
>>>
>>>     ath11k_mac_config_mon_status_default(ar, true);
>>>
>>> I can successfully create/start the monitor vdev. I see now as I'm 
>>> writing this email that my specific hardware does not support 
>>> monitor mode outright... Is this a dead end or is there hope with 
>>> purely driver changes? or is it some filtering at the firmware level 
>>> preventing this?
>>
>> I was able to finally see my broadcast frame after some additional 
>> testing. It seems the driver/firmware/something gets a bit hung up 
>> when I attempt to put it in monitor mode. It will start printing 
>> these messages for about a minute:
>>
>> [   51.093034] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>> a1a2 != status ppdu_id a1a1 dest_mon_not_reaped = 650 dest_mon_stuck 
>> = 12
>> [   51.094461] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>> a1a3 != status ppdu_id a1a2 dest_mon_not_reaped = 651 dest_mon_stuck 
>> = 12
>> [   51.096281] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>> a1a5 != status ppdu_id a1a3 dest_mon_not_reaped = 652 dest_mon_stuck 
>> = 12
>>
>> In most cases these ppdu ID's are a one-off from the expected ID 
>> which seemed weird to me. But if I let it sit long enough I all of a 
>> sudden get a ton of "data rx" messages, which is what I would expect 
>> if I enabled a monitor vdev. Once this flurry starts I see the action 
>> frame from my other client, sometimes at least. The firmware 
>> generally crashes after a while so I've still got a ways to go but it 
>> seems within the realm of possibility that this device could receive 
>> broadcast action frames?
>>
>> Hoping for some breadcrumbs to follow here...
>>
> Hi James, as you already mentioned, ath11k/WCN6855 doesn't support 
> monitor mode yet. I don't know why you are testing multicast action 
> frame with monitor mode. So if monitor mode is not a must, could you 
> test this with STATION mode? We would look into this if any issue found.

As you may have guessed I don't _really_ know what I'm doing. When I got 
this working with ath10k I saw monitor device was being used in order to 
receive probes, and did the same for multicast action frames and it 
"just worked". The frames themselves were still being received on the 
station device. I attempted to mimic the changes with ath11k.

The end goal here is just that, be able to receive multicast action 
frames on the station device which currently does not work. I'm only 
seeing unicast frames when i enable RX debugging. The driver support for 
multicast action RX in the kernel for this is basically zero. An 
extended feature flag was added by Jouni when he added support to ath9k, 
I added limited ath10k support for a variant I tested, and I'd like to 
do the same for ath11k as we are transitioning to the WCN6855.

And help is much appreciated, and I'm happy to put in the work its just 
a steep learning curve coupled with the fact that any FW level 
communication is proprietary. I really just need a nudge in the right 
direction.

Thanks,

James

>
>> Thanks,
>>
>> James
>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>>
>

