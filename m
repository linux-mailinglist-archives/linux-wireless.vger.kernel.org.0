Return-Path: <linux-wireless+bounces-20500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EEA67833
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4400A3B16C5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54F20FABC;
	Tue, 18 Mar 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YhVTOffV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8B20F098
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312694; cv=none; b=H1y3EdKSzBoWJukb6+skYgp+66lgK1Z+oPcynTn9XYS9AlZoERqh3yXa9lPry6/gpI5wvN+WY3UXQRtX1hLtpdqeJkQv4xs9UNMeqNh+c0q4+DFAvx1OPo/0mRyj4ff3okIy2Nloolr8rncYy0r69z4pWs2aMQVD3Ts8DsY/QJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312694; c=relaxed/simple;
	bh=ZyrAsfG49DpGrkR8H0kzvP1bytvhZGZoDf14miCEpnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTpryDZ6StEo1cksLEo4ANbPQEAz0uayfrc0HRGl1pZdNUxk2LNTSLDxwkwxR57d6Vqj1OP5E1AlD3OXcgtqSxlQ4jIIoHxC8v0e6+HC6re/GxLob+kmL4i3JCZ51gplfxvfDEZMNEdtecoaFYYPgBzX3/6s8P2+aJRcQjFYiE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YhVTOffV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9KiaB019952
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 15:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SAVIkA2nJaCLd5wAcdILg01ybenTh1RV6XjKZhSWOTk=; b=YhVTOffV+TQlTTy5
	Idt5nfGNUPYHSpbS9a7570JwGHmhOBtWPl6B+rk6g8I5J10SoNk2BAhLZeaSAqlq
	D8Y4h7pXldifp2MFhgA2TzHVY/XAKvtso8M484z9VMrDyjRnjLAbR+/p1svnRkXN
	LXzAozz4gpQC0w1OsKCEx0LW8wHbwDUu8m1aY58ot9WYmXlqhUrZR8HnSBuEOTH8
	oQwaspgm5GinYXF0swQbYHfj9V54d31BZI31SPQgWGAqFAKjxqgIzwHmsO3wLkqi
	OPkad7QCOl39wBuh0ELSwhJsqSSARI5+ShtBR7F9kPd2OE4bNmfR2woKdMEf9Bm/
	Ypt56w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1tx8qd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 15:44:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224191d9228so115845625ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 08:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312684; x=1742917484;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVIkA2nJaCLd5wAcdILg01ybenTh1RV6XjKZhSWOTk=;
        b=s1q6E/g5md1GiVaFuE4dam6yBuaQ1Nlaavh3zfpUdS2vPAZLsTT+Fbw+AQwtMpekaa
         1SBwR6zH3UxLCea68eE/jERuqN7Ai3GdyAIVCTRvqXA2CFTGYm2hmi5IbU4k/HLFGoQ1
         nPydDfsdzTS9tiR2JFIvWQUDNpv+LDRIprJ1lG3yIpCirtqD2HsHm3YcsR7HFoQ4r5Gb
         W97Yh13iMCQ/7ayUm3oqObs3ERLYDL6yJlOjQn4NzfFeObOYBuqjD18f8/gCgGlqwylr
         aeNRTIaMKMzPVo+zw4BtsJLLtnOV5AOvew+TZKg1BqClEMf4wuUxHa+zdr8FOInmY5an
         qVjw==
X-Forwarded-Encrypted: i=1; AJvYcCVAp97l6hZZDz7s6llwmIKIC3UCaQpvF8ux576UrjsBzsekPyemzxFWa41980ydiY/cjKdisyXaQyt/Rj7PAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwreFG7IHUMq9f2sUcWg2fKqAikY5Mf2vQv8YZSWsFvHeb3QzO0
	I5TLMDpWSUb3BQLqlirMGMMFdC7cA3L7UzXJmArWKSAT35ITyiMySHdebmNqi06Bt1ie3xrdkF1
	83sjComxDKblykAa+6Tpn8J6hUjPMH+5qCZQUNz55xxf2x+1EzsRs9mpovLZU23DFWQ==
X-Gm-Gg: ASbGncvCjNdsxBX9i96TgM93fnvU6zd9gz6WJE15Ne6kW6XBww3qcAs0sH0flx8nXgX
	n4fBjff0lZ9asn4bMq37f81Nlx4OhyFWK8IOmCI2yrAHfxHWeGqt4SjVx6s1fyBj9guF2NSq+GI
	whM4mRjTLH/94K1IJ8qO18lIPt7MfXTFAJH7e0xGIVJLvWsoMYRgAWlf+0wQbp6XUBsDdKxD7Ar
	BlaSZl5MSPuiuRBqDSvPR8vfVONW75oFpCa+K1IHs3GiqyDbbYXSSbPkFWvi9YZkOElBcZfokUg
	4TLXc3u/jEsDgTEikzGY5ijbwowiZ4GWBwf52B6dMcJQ7FeMj0bMkO3S0dRpFzEbuEdWmwU=
X-Received: by 2002:a17:902:ce0b:b0:223:668d:eba9 with SMTP id d9443c01a7336-225e0a15945mr234859925ad.10.1742312684404;
        Tue, 18 Mar 2025 08:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4lLp5t7+ZMhTjiUg/ojVkZKcM7/NIU48U90wLJENACatjgBlOPc+VKldix4F3T50fec8NNA==
X-Received: by 2002:a17:902:ce0b:b0:223:668d:eba9 with SMTP id d9443c01a7336-225e0a15945mr234859595ad.10.1742312684072;
        Tue, 18 Mar 2025 08:44:44 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116af372sm9716397b3a.160.2025.03.18.08.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 08:44:43 -0700 (PDT)
Message-ID: <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 08:44:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W/I4VQWk c=1 sm=1 tr=0 ts=67d994ed cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=E5dAun_1JQ9YDljNTxIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: mBavLk55ek_lgyCotvtU14U92MHPJydj
X-Proofpoint-ORIG-GUID: mBavLk55ek_lgyCotvtU14U92MHPJydj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180116

On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);

kernel test robot warns:
cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'

looks like others have fixed this by first casting to (uintptr_t)
a few examples:

tsa->version = (enum tsa_version)(uintptr_t)of_device_get_match_data(&pdev->dev);
model = (enum ep93xx_soc_model)(uintptr_t)device_get_match_data(dev);
priv->cks = (u8)(uintptr_t) of_device_get_match_data(dev);
rt5677->type = (enum rt5677_type)(uintptr_t)device_get_match_data(dev);

not sure if there is a "better" way

/jeff

