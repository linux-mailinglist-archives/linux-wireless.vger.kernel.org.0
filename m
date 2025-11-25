Return-Path: <linux-wireless+bounces-29324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDFBC83B41
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960443AC8F4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9384284894;
	Tue, 25 Nov 2025 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BnnV+Nvt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MUFk7Hd5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078913AA2D
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055522; cv=none; b=SIQBYUoiti9YQ/YcxWKJkHY6DUifX+eq1Ji7h/EWmlYiRLrBNUeHXMblDIQQz221kgjXJzN7aAZI0UPsm+ZlQu2SQZBD91MwnXDrJ12JsnEhPziYqXt/JSfjawkntOqlLmB2jXtrdN0cdxVKCfAmaOX+jCzdswPL+CXZQaLLVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055522; c=relaxed/simple;
	bh=9GS+vQuSJAh/NMSHmdyhx8Sb1FGCOL4M7RDkSpFxfYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hw32gez1lN8B/i0e3ZEzJ0snaMraEWdxcM0vkoSBoOCMwn6UGifEWtqpl4JfkYWCJjToi2we6/aeSsKnbjz03Q/aczDPFRWEZHgTc7+4iM7hQgnghvyqOheuVzJA17znhno9FDKxNLzz8KQiyXIPzYm8AvnGXhXdVsBd8lMWbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BnnV+Nvt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MUFk7Hd5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP2gde21939497
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EkIjKxwbsVJk6t/Dmt3+QSVkHkWAqBjVCeXDIT0n3BE=; b=BnnV+Nvt41vYDB4i
	bIQVSVYpkcJWV8F20JVi80MW/68sr5z2iCM/PE8M8s+pmlLaHnecXjODusJhIv8K
	qGmhVZyT8rRTyrd/aqAZpEHKqwR2CcE8UUvHD+zb/sNKVVMdewyGm15XLwNMmabh
	0fAmsLeo6Vl6r7QJ08vE3l7aoMSlIKHJ2wQLGJTvantpo0qC/fe/tJKvlHBv1c7H
	2yXlRrqDGi8aN0DNdlAGH+sX7MSnf7mljKJ+2T5lSwxJ+3kW5xnIFsvqV9y0jDIp
	pZ2LyGnTT+0KQQnWn6yExCmnlRe7ylxmJBYtk9r4caTWOOahg297gehlsdL03+ZZ
	PvdBXw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amsst2efg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:25:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297ddb3c707so43095005ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 23:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764055518; x=1764660318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkIjKxwbsVJk6t/Dmt3+QSVkHkWAqBjVCeXDIT0n3BE=;
        b=MUFk7Hd5qE9D2DMGb2HQ6ex2pIOfXPPuAldbsOoN0eTdrqeAbN/V4nk8YU1RHwEKDN
         4XoOH12Wt0MG3oDqvqsQQ6wvZmSICmvM6u1rlih0xUY2imUnoMfmY7LycTiU+KvRs5Sx
         ZhLn+LkCEONQKF+8zXJKi+R+GTXJIH4IpCflCooa4+OGMrJCcdIi5rpzrsum7VRa0Nbw
         2o5y7rTCXU/V8nqape7Mt0KYcEovWL62WkAxWPV3oWt4OWO2n0w5tFojnuiDmQsWCO7Q
         auKxlbaGtHLATX8CLF1s7mRUsNE0WQrlPAAJU0OOhu+n9JL5uyQFhcC4AGfNmiDIdfgW
         p0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764055518; x=1764660318;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkIjKxwbsVJk6t/Dmt3+QSVkHkWAqBjVCeXDIT0n3BE=;
        b=M+GgiMkfmLGaZv92TKdFWYmfW28mMQN2VYHERE6jCnMptdq6A6WXDwqsS7qqSegZ1B
         JckBRz2i4S2D3+EAGWsqPdLP+qXy96tf8Zz/UWcS0uSNqjDO3XwDvzM7435GIcgeUcZe
         VSEtsd5z2gX7AMSndhaRDOI7DK8l2sS/m2tB9oreeLzIcjLWwJpm6hWvVMm87WRJt2nT
         drho2RkEQxk05CcdyESt7MjVA/ElWsGbov8jVQZJ2EaVbO5PjkQh6PmrQ/SM5vH8D+Ko
         KpmmI7Wdy55Njcc27Kbg4PqjxkH2dYmdpNAlRfwc3jxGiFB6hRCIBQh/yoAMGqHkFDkz
         mXJw==
X-Forwarded-Encrypted: i=1; AJvYcCVfI1UUK3f/HZzg2Iv0KWqQPnLlh2AYPLmWKD5ZCAdlhDD+OU0vEBoT3sKWLKvoOKpq7YwVZ0EJxMObEO88tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywkdYlCqZ+Hfjj8GimShi5YxtOzDvFF1083OGtEJJMghSC6nX1
	X1lnFYNGr24XsQsyb7znfLBLi/LwH5pdddxOJS9TxWZjsUDCgR/2Uhk+Bslv3ReBKor5gNx6Vg1
	AcNTCgZT02RNXGO93LfjI54tt3kdmpTSFZRQUO6gCoZ1065yKo/H0h3Hp60bROvYWfiFXuA==
X-Gm-Gg: ASbGncudLqd0cGG/dnnidmVA9A9p8JlWKDQkuZADdMnPPMVBIn9oPvom8l4aRTO/628
	bZquPGYXpoTgbCuG607LYzwrs1FNs8IXB6nzhyPKLNuy9aD3cMbPsXpHhQ6u8samVJBebCc/aik
	PVfTh2rqrD6fZFQ/KsgvJKv7QgILnUVARICPKkmeWbka/1Xc4R1VC4egdJkicHQj8ABGzzAaq8x
	uvWFi/LzXrGJXMkV4zVRfYHBFv2aaqa96lUsxaETzYjfiDNzYR94QeCbau36gbJVzu6PehIHsKG
	nDJtRYcK2ISry1VrZpXMAIS1Ae0yWFUZpYbs93v7HQ6gWDnSeatpfySKkh1y0pEJrLK1cxriPST
	0slncQmRZ5fD9RSoYn6oY/44d+h6IXa09AFaS2raf2b4P1QKR9qtM9qB55UU0ogD8WWo4k7Ui+g
	bk0x24BF8=
X-Received: by 2002:a17:903:3845:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-29bab1dc6camr21453755ad.56.1764055518282;
        Mon, 24 Nov 2025 23:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYKBdW0BRo1oZmJRQAGHiDy9+aQcDP1TIzmEFOLv755ABGBGKcFzUGz7W6kZdsHG9paxyp/w==
X-Received: by 2002:a17:903:3845:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-29bab1dc6camr21453365ad.56.1764055517825;
        Mon, 24 Nov 2025 23:25:17 -0800 (PST)
Received: from [10.133.33.245] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25df75sm158788545ad.65.2025.11.24.23.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 23:25:17 -0800 (PST)
Message-ID: <277cfe97-3024-4e65-8766-7b96646c5120@oss.qualcomm.com>
Date: Tue, 25 Nov 2025 15:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20251124134713.5819-1-tiwai@suse.de>
 <2faa8f4e-cb30-4e91-87d2-853c90458b01@oss.qualcomm.com>
 <87ecpmppkt.wl-tiwai@suse.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87ecpmppkt.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bM0b4f+Z c=1 sm=1 tr=0 ts=692559df cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=hraEoygzTrBnBSVDgbQA:9 a=QEXdDO2ut3YA:10 a=QxBQvo9kKf0A:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: O5Q67prL1BTE_AMARfUuS-UBb4-egpk3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA2MCBTYWx0ZWRfXxK+BYJ4QRfAB
 QsFCHMqCjXVXBRgHb80hPRGMtYsqFbmAAWvl92v24ieK91+9KJc0WLg5VHIX9z8RHX/kRaw/kSl
 4W0I7rqVXl9JmWPK/jZZU1b2NyIyBwGC0Ney97AVBC/mMIpmhVQ8xZhW4vuI0ES+vzsSsa/yzlU
 FGcIU/QVAGzSll+NiPSzlXzDN+LkcugUmyq3WbwCZC/nIUKAWBAt1VABngrnmWAm88/z4oLAWm+
 8H45rKD4cbtip4eN4CaHmsyKiYam7xw3IAv/Ij0J+1+D85mbzCj/xtpsZd7B4VnZXbLtPiRmcRU
 DIjX+VbLRnVsWNtRv8uwLtxiAeoA4ddOEWBOqPVKyWR3jHo4KWAmcOzQ2OC6AAMEFJnmjqcFLdY
 xbKEMYGGJ/m7zJuKArmhATurEy7Qdg==
X-Proofpoint-ORIG-GUID: O5Q67prL1BTE_AMARfUuS-UBb4-egpk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250060



On 11/25/2025 2:57 PM, Takashi Iwai wrote:
> On Tue, 25 Nov 2025 03:28:22 +0100,
> Baochen Qiang wrote:
>>
>>
>>
>> On 11/24/2025 9:47 PM, Takashi Iwai wrote:
>>> The recent kernels showed a regression wrt suspend/resume on Lenovo
>>> Thinkpad T14s Gen 3 AMD model; it fails to reconnect on resume after a
>>> long time sleep.  The only workaround was to unload/reload the driver
>>
>> how long? and with a short suspend you don't see the issue?
> 
> I can't say exactly, but usually after some hours.  I see it happening
> when the machine is resumed in the morning after an overnight sleep.
> Short suspends can resume mostly, as far as I tested.
> 
>>> (or reboot).
>>>
>>> It seems that this model also requires the similar quirk with
>>> ATH11K_PM_WOW which has been done for other Thinkpad models.
>>
>> the quirk is to workaround the unexpected wakeup issue, which seems not the same with
>> yours. Hence not sure if this is the right fix.
> 
> Yes, I wonder that, too.  The whole suspend/resume procedure look
> fairly different with PM WoW quirk, so some of them might matter.
> 
>>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1254181
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>
>>> I'm not sure whether this model has another DMI entry, so put Mark to
>>> Cc.
>>>
>>> Also, I wonder which Thinkpad models are rather the ones that should
>>> *not* take the quirk.  Since mine is Gen 3 and I already see Gen 2
>>> entries, which else remaining...?
>>>
>>>
>>>  drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>> index 812686173ac8..3aa78a39394b 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -924,6 +924,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
>>>  		},
>>>  	},
>>> +	{
>>> +		.driver_data = (void *)ATH11K_PM_WOW,
>>> +		.matches = { /* T14s G3 AMD */
>>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
>>> +		},
>>> +	},
>>
>> so with the change, the issue is not seen after a __long__ suspend?
> 
> Right, the connection gets resumed properly.
> 
>>>  	{
>>>  		.driver_data = (void *)ATH11K_PM_WOW,
>>>  		.matches = { /* T14 G4 AMD #1 */
>>
>> Hmm, I am feeling that we need to dig more to root cause this issue. Can you please help
>> to collect verbose wpa_supplicant/iwd log and kernel log?
>>
>> wpa_supplicant:
>> 	cd /lib/systemd/system
>> 	diff --git a/wpa_supplicant.service b/wpa_supplicant.service
>> 	index d5c7ef8..69693d0 100644
>> 	--- a/wpa_supplicant.service
>> 	+++ b/wpa_supplicant.service
>> 	@@ -5,7 +5,8 @@ Before=network.target
>> 	 [Service]
>> 	 Type=dbus
>> 	 BusName=fi.epitest.hostap.WPASupplicant
>> 	-ExecStart=/sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
>> 	+ExecStart=/sbin/wpa_supplicant -u -s -t -f/var/log/wpa_supplicant.log -dd -O
>> /run/wpa_supplicant
>>
>>
>> IWD:
>> simply add '-d' option when starting it. You may directly add it to the systemd service
>> entry if you like. See
>>
>> https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html
> 
> OK, I'll try to get the log (in tomorrow morning :)
> 
> Meanwhile, the PM WoW quirk looks fine for this Thinkpad model, I see
> no other regression with the quirk.  As a stop gap, would it be
> acceptable?  If yes, I'll resubmit with the entry of another Gen 3
> model Mark suggested.

I would suggest you waiting before we root cause, or at least before logs are collected
and investigated. Then let's see what we do next.

> 
> 
> thanks,
> 
> Takashi

