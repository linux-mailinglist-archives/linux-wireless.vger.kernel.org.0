Return-Path: <linux-wireless+bounces-26372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DEEB2531A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 20:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D92D1892DE0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC9291864;
	Wed, 13 Aug 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dr0jQA3K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EC1EDA2A
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110153; cv=none; b=DaJWjpmGglnxEr5uaps/XD5HsmZkTTwt1nS35y2rIulEkkha+wrwUX/wb0v/aWzi3UFxt4mo+Y43N9wKLR0G4pR2A6lIkbVvULsep18CL1uOnntVDYI12MeR4py+uKJqMEhOWPs0F94LV5sxeKAloKSTH/gmWNGtbRoZTnfV6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110153; c=relaxed/simple;
	bh=wWXPp/VoIpOlxQn9W42IZpMx37h+gOsfYPmWHxPLUIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eioKa4aYBADt+jAY2FuIhVBX0j5nBLlZPKYnMDwbSt/7Buk6eRpZZAkaXdr0mT/+0AFehS/CJXKu1iiWWRbbsUhCeBDYYhNPe4fLbyWcCLhWaNa/gj/fx1dQ4ZJ4wssqE/lxgYR5dMwWueX1G65qyfOlDqXOMuj8qRvxHIguJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dr0jQA3K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLfSa020594
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 18:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fkNO27715pGp3IKWDp2ZwDniztJ6nhHWNoF4xZvKIKE=; b=Dr0jQA3K5bNnbnSS
	hegMYVOM5H3CkRxthHZNtPNr+8aTgENW2hH2rhDyLAiBIUGzniNQT4TADkTV5OWb
	6RuICAc0PwJ4CPuUDvktFzAYzjlo3CmDEbVoxHeaxMWNIp7jRSgjXs+4dkK6lGgR
	ab6dttbTXEIr5n0pkzKjVoY6bAX6CB3hfdzJ8qYHoFT4R8c6MQasHD3NrGFbn7gs
	4jy3jZLo9d5x+HMjPV5A3seLq0wRtJVE1V06P19ri7UxnMigSwS9wcWSCkyHwYnf
	gGdVr0rh+GwZmYoORGxQjIo7x7fsRIw8+gzW8qJSBsN1wvlRySBmL7zookEjl8Wr
	9pVPpw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmcu6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 18:35:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b47173a00e8so38854a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110150; x=1755714950;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkNO27715pGp3IKWDp2ZwDniztJ6nhHWNoF4xZvKIKE=;
        b=Ar2E74LRpuOBBwYxWJeJkyrljjCCZ3oMZgINSRR3gFM0/txib8/PSadhbxRpwAe9eQ
         eoyQtTDd/Zx9CLcPWVWulkQaN+gPXp68JOfza7M4lwKzMaoOqUWixbrpleAAkfehvetd
         Hxkx4nk028G/aNwEiHheoyT5+5gCJ783fL+Qg70Up6A+o32g5d5qWmqh69/hHbBXMBb/
         dNZgnoRIPSoZO5HJp8qCvXSxa5jglnfMw66KcqEelH8l6DOxzt86xgDqLlbXrcDlamfP
         eCG93+pPADU/Eno4vgrFw+aSJjBcQpwt8nMKfKAiEAxJHIIrFgGsBBqrKhYUzOBgHzJI
         DTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTrXwi0hs5efzmY6T13y8SgHLmu78Zoxt+N74QVIayiUqhWxH3X5cmtqG7D/ZZqlRjSRfz/cBemKLtzVpDrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2rf6oD9fgFaUt/3wHGahD2jTdGrCtJi0J6Xk6XB9dqNoKITH
	jABbExZhhl38gkzsx6PmKdpIss/F4Tz+CBNcSISw0TKzRC6UF3v8ddm2fhVWhRVcB5W9htJuQOK
	8tNI7O5ySWf14d1U1z4GFdFxVCVMWj2d8pMG2Koejg3I6K2upBYypT6Pux9X2lBqKxiv3Qw==
X-Gm-Gg: ASbGncupunAYk0VWUMlc0YY9SpiwSHKZxczZ3NsCUNhNXcQfO614UmbwbD2bnC0sSfH
	2CyVV0OCTsToBa7rJsAhQ+4EY6yckCfSJf0Zx33F3NVTZdMoNFC7wJQnvoeVLY+U6cLX9NLqVtd
	63PS042bJYuPaCDkTMxPXgxfLM0v8nhSHaBF/4TkYdLAZjypYswr+4A+PjBNEKqumjJFfdMhpif
	1o07lreCz0fHblK6zx3vgt5Kl1M/mgHqVSmYfc14zhHaZAT4uSql6C6itt4qWqLido5TrL2HrkO
	zZg17qZ1D/5k2EVf11OoFiBt1eMNCBfgtAG3RS+hRywXyq7ADXZhvTjBB3IvvPpWpHE16scg22F
	ZIx9g8DOksJigmVXHt3I=
X-Received: by 2002:a05:6a20:7d86:b0:240:101c:4428 with SMTP id adf61e73a8af0-240a8a81c69mr7107198637.10.1755110149679;
        Wed, 13 Aug 2025 11:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2kZks/JwlgHPvtxxNusaLWMXIXq4ksdEbDXAarmtpaoFOhFsAvVFA+ghd2uwcpPJ3en0w6Q==
X-Received: by 2002:a05:6a20:7d86:b0:240:101c:4428 with SMTP id adf61e73a8af0-240a8a81c69mr7107150637.10.1755110149159;
        Wed, 13 Aug 2025 11:35:49 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f5035sm26305118a12.39.2025.08.13.11.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 11:35:48 -0700 (PDT)
Message-ID: <272c9a0f-1e95-4c7c-9b84-a6b564d9e2bd@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 11:35:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: mwifiex: use vmalloc_array() to simplify code
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Johannes Berg <johannes.berg@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>,
        "open list:MARVELL MWIFIEX WIRELESS DRIVER"
 <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-6-rongqianfeng@vivo.com>
 <aJtGSxkRztAsy92h@stanley.mountain>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aJtGSxkRztAsy92h@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX2aTazgL9dUpM
 L5r/xmo+p8ZVft1zEvxBeb30YvrGhbb7cVkG33BrKrDpDgu77iRQqU5IOkQhs/yTGR2ELP/tSDW
 QTUiEoPT7oWSNvqTCldl/Pkj69+zPpnHtFhB32PZiEXRRznVlbU87GAKonAACLv00waQvDWZh8E
 RwS4N91ICBv5oUQ4vty2UsmEbNYc7ygkhdgcIeY01pd6bSL7oSAsF2erzPPXuocuEilch11tlSK
 pmtI/EZ/8mT1f66oUrHJIST3qZ4sMWVWoi2Y33++aj4JAOFU6XelePQoA/hdTQGVuQOKJFQxyTe
 FOJ3+9T+uSnC0FI9NOsO9axa7D5SoAbYdyx/YgqLh00xB1ORCTD6ZI70GxY1dr1Eddlfm49arFW
 N8KsJHw7
X-Proofpoint-GUID: Hk08WavNWjmlZmfLyk2Z4Vu-OPSgllJM
X-Proofpoint-ORIG-GUID: Hk08WavNWjmlZmfLyk2Z4Vu-OPSgllJM
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689cdb06 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=hCa7pYApQyHEYYEsZyIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

On 8/12/2025 6:48 AM, Dan Carpenter wrote:
> On Tue, Aug 12, 2025 at 09:32:18PM +0800, Qianfeng Rong wrote:
>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>> simplify the code.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>> index 3498743d5ec0..fb4183ff02a9 100644
>> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
>> @@ -4673,8 +4673,8 @@ int mwifiex_init_channel_scan_gap(struct mwifiex_adapter *adapter)
>>  	 * additional active scan request for hidden SSIDs on passive channels.
>>  	 */
>>  	adapter->num_in_chan_stats = 2 * (n_channels_bg + n_channels_a);
>> -	adapter->chan_stats = vmalloc(array_size(sizeof(*adapter->chan_stats),
>> -						 adapter->num_in_chan_stats));
>> +	adapter->chan_stats = vmalloc_array(adapter->num_in_chan_stats,
>> +					    sizeof(*adapter->chan_stats));
> 
> n_channels_bg is 14
> n_channels_a is either 0 or 31 depending on if we're using BAND_A.
> sizeof(*adapter->chan_stats) is 10.
> 
> So we're either allocating 280 or 900 bytes, which is quite small.  We
> should just use kmalloc_array() instead of vmalloc_array().

Should transition from v*() to k*() be separate from transition from *malloc()
to *malloc_array()?

/jeff

