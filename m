Return-Path: <linux-wireless+bounces-19631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2FA4A8B9
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCF16C71D
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0E1C0DED;
	Sat,  1 Mar 2025 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SC4nHPiE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25D199FBA
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740806082; cv=none; b=X9DYMJr063PvoaB41mpg3iCcmP8UDQxQC5xWgrMMSi9HfPFyy/HV9b+TjRuD9m2wKmSWb4tlXF61mX28lIoS7jJzmbPKpuVM8q2Z1OASNorhTAoczrjYT6Trl1BbXiPGjy5JV0nA/uq9sQ7m3XViTcHJ/7ftB2ApcjOYvpU0mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740806082; c=relaxed/simple;
	bh=+M9asrz6Ulkh9VCT3n8mjVH6dI5QBl5eTCf5yiu6Tg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B13GLFiohMiD/BcZbIv7fwEzlDBy8HEKrADR4DivmYpOsVXf6M1g0QHvYotxZzr58gfpU59QjyUA12PI+OzkxhRYZPt2k7zAelDRmQt18ZFDArs7ZgfjbtC9iusye5GUXiI/mgHZohgTO2Uje0HWWZyjM89TI22KIoXdKlHtzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SC4nHPiE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213k9QB028041
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wqXyh11i/d9FgoI4iEyq9N7G01Ko6UG1G0l515btXXk=; b=SC4nHPiEAHXYKM07
	f6fxwC2X9zfCYQtE355d6fxXDZ0ptEwChXOYsLqwegKWwQbdaN3UPR80D6za1ZhM
	M0m3eTYYjbBve5YskyldufHvbGddZjHFa8iRfqQuSq/2OSlkjBqqSrnAMR9jQzqT
	5K3roeofgVJ0PvqtK/AE3Fx9tI+dS1YbXHFk7EVOZQwuyjxoHxuGCL1k70Xo3RYj
	42Ysdzc+r31P9xhFLCVw7kxVP7WuVQg7LwGeuykh21EQxoqInN4K489txgsiRjk+
	HRLy/5TWS51kwK1JkgeqJBhCpQPr2GE28YDGVs8euKpNaNbN2EUNCDOlglJNk+d0
	Pt1StA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tm5g45h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:14:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22328fb6cbfso51296735ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740806078; x=1741410878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqXyh11i/d9FgoI4iEyq9N7G01Ko6UG1G0l515btXXk=;
        b=aE8fge1woxYLc7xjol0g1ilSzwBb5w8ojCPfbqfokQrJQPi6IYVHTi/YQAqU2zPgFX
         RYvbYGpVFlIxeFVBgNNjHrwplNSNtCzNXqu/p73XX9JywJWvJWNoljkOfKt2mhuP5Lsd
         dISPdTacWYkKliz3B8t3VQZHY85niB+zpAFuyS/iQVQDxd8XB7er3s2JtbGPD/ZG+3uu
         Iqp+Bw8EFZMsavRBu5fTAkYrp3x9YXw4RfPev+AK7vVLiDJaryRXvELhWnyKymzK0Hkh
         eh3WiqpGBn1wlsjUa7q4FhjCzLgpPYMuqgDq7e+eO6Pe4dPcX7f1anqyOaFUy5R7F9Sp
         Aa5A==
X-Forwarded-Encrypted: i=1; AJvYcCXfQ0BWKA3evwONMjMMC9zWYeByfHzXNRfFyTVHbgBGwoucuP43MYbKoudrR0mclFf+qlwy5k1zpwMoEM4ocQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtzz1LUTvTS97dMEIQyTFTca175EKZxXCJFBfMsyjxPP9YF0VW
	EwoWNK0tdn9n8yhjvB3u0JOW0+3nSTZj55+9uXCXA3XqZ0XZAD4xYLsL6pnwLzYAs14l9+FDlMe
	wvklqYkNSjNwTUf7DJiaCz+Fve0Nj+4VPtvAVGPps4IvrhgStSfgqDHgkaW6OokFFGQ==
X-Gm-Gg: ASbGnct1jcQh1mvVVvADjWEeGAkk0ZsAbUeDMM2UGpcV1CtIY1qqzvxq0qNUe3SLjQt
	msaexeaI1wKATlGHLsDZUgFfzTX4cOl4ttgSzjSAB9fpxAmypnGgPGhlMYqoGZl2G/rGAoG0W2k
	1KtrfBQkdZPaMEZNmW/LVpjiJxen+G/QdlumccxVKX6p2L9p0ui6b/iDw3XPOz67S2diEeSv+dk
	W1Rdd/bpM6Y7caa2GWXv7qeps6GK5JiokYHX/Ns9ZHp7/h+wllBjB8xBV0I+m360dhTSB636p1o
	z3WX313TbrwThKXMjnnMhvjUPscXF7bXgPQv/0iA/MgrADraf3wLsMJC9XpSkPI=
X-Received: by 2002:a17:903:f85:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22368f92419mr88630395ad.17.1740806078035;
        Fri, 28 Feb 2025 21:14:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoz2h4kdT11XEn1qc7/HfnBptJ7ipR5xoJL1yX7WyyTVEQlp/c5aBmXGyfWjaj6RZK1gN6ww==
X-Received: by 2002:a17:903:f85:b0:21c:fb6:7c3c with SMTP id d9443c01a7336-22368f92419mr88630165ad.17.1740806077696;
        Fri, 28 Feb 2025 21:14:37 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c15sm41660315ad.149.2025.02.28.21.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:14:37 -0800 (PST)
Message-ID: <332227ef-2036-c2e7-3ea4-1b37f8afd65b@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:44:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/13] wifi: ath12k: add AHB driver support for IPQ5332
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-9-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-9-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -QAHGf4Y4fek9kPgN1f-Wq1zBUDxq0nr
X-Proofpoint-GUID: -QAHGf4Y4fek9kPgN1f-Wq1zBUDxq0nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=729 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Add Initial Ath12k AHB driver support for IPQ5332. IPQ5332 is AHB
> based IEEE802.11be 2 GHz 2x2 WiFi device.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

