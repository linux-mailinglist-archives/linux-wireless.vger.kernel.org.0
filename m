Return-Path: <linux-wireless+bounces-21032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649DA781F9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 20:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3433A5CFF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0481DAC95;
	Tue,  1 Apr 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bt6Asskl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4979FE
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531238; cv=none; b=TYHyuUSpXF0NyE+etCfBner0eqNI+oqQGse3dtqk84pUTzetStUYVgBCgKcj0AwakooGP5/J3n5FqbF6bVfSp1jyPZPtyTrf/Zx282n1G1Cbp4v/AhndPMXGdDExDdqA2c5S59pfzoYnUBiliFE+bOc8VwflFVdFL7XSY6+yUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531238; c=relaxed/simple;
	bh=91GFk+NyTgzygmVrc4JDV4vJfVaacAqtj4s0VxybaSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VP4AnuYQg5/nwfZxeOhJvmJLG4Emz8vDi5inaG/iLN3l5EYQcE//OC/iz5mZHV9mrEgeXwwj5q9ai2AEPsUS+Puo+/JcJHcrjtkBPt7/pZycwD12XmxDL1Np21ypoykZsiWiZBbl0IzFNhKdAI+kLcR5h+M5x3Df5xNrXq7eIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bt6Asskl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531BUaSl000396
	for <linux-wireless@vger.kernel.org>; Tue, 1 Apr 2025 18:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G00aK+ClWe/yj83sy8/Bag12dpu5J8Bv0Gl0h4BMGcw=; b=bt6Asskl7fMFPQGU
	ciLqDV0Q9m/ywzBX9Wp61yoi0VAYgBN+4gZzAt684/XYXRpadEgD7xSEOh2Dnogl
	YVZgOMjWqzoGo59AyUq9pdKh4JcjUSw20iVf3yrClAJBhmCk5xLbdpLLTpr1jNfR
	2zKbgOfjywVoKguuKsd2YwpHDZQmFJUuVuL7f+LjQ0ovNROG0h2tiAbwtLdTruAl
	FG+0wcM2qsnvpvuqwnw1OyZaky7J4FtPDT8gZvSco4829pjYMbV4O3jP/gjAl9fS
	d0gxLzXCcjaCDkyQCglNrZzBjNvquCDLz7Aum+CZivS7Dd/Gf0NOryD9Zh5YdkUN
	7qBKxg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qh722-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 18:13:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225107fbdc7so105616805ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 11:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531234; x=1744136034;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G00aK+ClWe/yj83sy8/Bag12dpu5J8Bv0Gl0h4BMGcw=;
        b=KH8mKgTyS5u9ZeXWXi/l2uNJLb27WJiDkgvNX+JrLQfkiaLAON+N3zYsRXO0SZsHL6
         18yBFeUfkL+6FymMYmUkh6Q/EvGBx9tAwiKSHHFtdzbBR3K8ao+u6Vss2Qa32Y2tBlVo
         C7qXqvVPQbzNIedGqceN2HcvdnmyYNsj5FFgTII0AihL4Nl66F9qNSGCWVtyLPW+OcGU
         w3VsjJWGn5WiJ1sTp0U/LV4AJlO6E4Q6LrtpE4AKbSC8TVXjTEOU3hEjMEbJQX6Lq7Ew
         gM/GjgdsqK9iv1qTObRedINQlsN6ZQThZM+UhBuVWElGjp9m46zYR/+OzkAWXRQDjdGE
         wWhg==
X-Gm-Message-State: AOJu0Yz/GzarOMO+qKexO8pSNVaYKq0VteCwajM/Qtis6W21YN4HSA2T
	OjCuju38yEpWD1J2XeWjfU5rB7ROLcIZZSTtV4fSSyhG1h6Z997P930FeHAl4CicTrI88uRXVRF
	/6y+rwrVS6zeWmS7KJBamRoJw5AnypTZMaKd41X8DEccWf/IJZRQUEqcv5Z1Rsyr2VA==
X-Gm-Gg: ASbGnctRZd9VFa8f+4Srl4MyFVOT7woyVape2WtfBq9AHgH6bZTirRgAQBt7itDbySD
	5WY9EKZMVYIjbG6clsefWUo9Hbhe+S4JmVK/HPCJD/4wyC/NfXbLl1NKXsxgeqom/UEq+K8oKqF
	aXIudHiqPa3TLrLvh+heYVfll8AIWJdyMqmCZjK68nt8flXhz5NAXog2TQI8r8YQLXMI/rkJNbU
	05ECv+FCTUM/QDrUAWT6szSXSWtkvBk37nKDH4LQkc67FmR6vAiW2aEJduc35SDed6XyGuPL8Xe
	g/g0AhnL1eDbO/YWtZIqIOuh4BwjDs9WGbK1y1Q2LTrrxP8zCT9vaYWDdIiqy+UAr2XApAA=
X-Received: by 2002:a17:902:d48c:b0:224:122d:d2de with SMTP id d9443c01a7336-2292f95d9famr182967455ad.16.1743531233662;
        Tue, 01 Apr 2025 11:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf0TOnaa38iCspexZAAqOhLvd4SAu4lpbYLtBPjsUOIAqDdZYqJDWnhjqOZC3GMU2Iu1/3Qw==
X-Received: by 2002:a17:902:d48c:b0:224:122d:d2de with SMTP id d9443c01a7336-2292f95d9famr182967205ad.16.1743531233203;
        Tue, 01 Apr 2025 11:13:53 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1e9b46sm91994755ad.211.2025.04.01.11.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 11:13:52 -0700 (PDT)
Message-ID: <addca47d-041d-4d2b-acd1-ba457f4a1b1c@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 11:13:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: divide by zero in ath9k_htc_choose_bslot()
To: rtm@csail.mit.edu,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org
References: <87261.1743430651@localhost>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87261.1743430651@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67ec2ce3 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=N70VXZDXIPEuKPa3oYEA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: lF7G9T15B89lqqFt1dSGyNSCPoXrFSxU
X-Proofpoint-GUID: lF7G9T15B89lqqFt1dSGyNSCPoXrFSxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_07,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=977 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010112

On 3/31/2025 7:17 AM, rtm@csail.mit.edu wrote:
> Toke,
> 
> Yes, your fix makes the problem go away for me, and does seem
> like the better approach.
> 
> Robert
> 
>> diff --git i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
>> index 547634f82183..81fa7cbad892 100644
>> --- i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
>> +++ w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
>> @@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
>>         struct ath_common *common = ath9k_hw_common(priv->ah);
>>         int slot;
>>  
>> +       if (!priv->cur_beacon_conf.enable_beacon)
>> +               return;
>> +
>>         if (swba->beacon_pending != 0) {
>>                 priv->beacon.bmisscnt++;
>>                 if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {
> 

Toke, care to submit a patch I can apply?

Thanks,
/jeff


