Return-Path: <linux-wireless+bounces-30824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E058D20399
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 17:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2FB33002D30
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF872798E5;
	Wed, 14 Jan 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nodSYOXG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btREn/XW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598B23A0E9F
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408505; cv=none; b=r6PClHCjt6I8FUbgttQkYcPz9mtFREPfRvpfU3iiL2UuHSrXa5aydUFiE0iQwq5UDtAEasaEHfspwvJKch5eznYtmA+QXrO/0GOlTku6uobVXjwDPZP1ICkHXlYEMSe3pZf01LrcQC0UVl1Sd53jicX/0lnpGIwSjxZoz6YY8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408505; c=relaxed/simple;
	bh=M4DvEfC2Hx5xpGlpvfilykmSJXBQrkbTNTRAkPyUkiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI0I/F6tZzfdDmYJx5Ajs/oUTLpesJ1VMPAJLBw5qcKhDYWH5Q4ErbJY7jkIaN/0xszg74vbVwRFmEfbVCBMNvaYrYBuC9dWIZxbzG6G99gN9oVo2RZUPJ16B8CW0kfPDvzFepEpbUTVP3sK0RDmmXtTGzC+tg7Hn6fEgZw9pQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nodSYOXG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=btREn/XW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EChVex3925427
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 16:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zhlm7w5XQ5aGbGz4HNY8lWvxOeoJHGqdxG/3+1jCylU=; b=nodSYOXGr4AMOq2j
	XvP9bAXpMpWJszXB1NYC/kFjc1P/75P/1dPmrJNIv+P4T3wyJDllkYOW7fVliGOC
	6BeCsnmqTuFtA/gBAWDXdbSA2vbW6qIa/OHcoL9YGZkigyb05ncz371tBz1sVnyD
	g6xER8l1DsvoHZy/7bhWDbPYgJ4KcyyEatq6/FVbveZSkdu6rzXeQqse0H47HX9V
	S4+TQS6Rgk+wC4U4ZVwtAseBZnZxVSo2sow3cmaLl4e31tq3chkUifkQXJr5eTF5
	fxwPtBclagT+a34tDOZq5ygeqGjsDMcebOQ08d1PZE17UCq0eys7HTbM+lT6WDvI
	cbfpRQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpbdbrs5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 16:35:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1233b81a92dso371193c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768408502; x=1769013302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhlm7w5XQ5aGbGz4HNY8lWvxOeoJHGqdxG/3+1jCylU=;
        b=btREn/XWL6GxtdQYf3ZXy3+6eJS3QoDYctCA1oG7Hp2HzsDln+htwpm+T1t+bhbPme
         4smEHCjItxitsOc5LcwC2pbCKJJQq3NZkkwqyLJOI5Znb1Gv+XRiA19z+CzBYDf9pShI
         6iPkEX2JkPmqUPOPhpBa4jk/sP7IxHiiEU2vytZ7NPocPqyY4Ed2Hkeg15+5CdZVK1Ad
         Mfd8EjWia22kdQpYnb52itFzQJ/4Mop8iF85umCTPA8A0ZBlLMaiU3D40tkV+JJg281B
         TF83LI0Uc3HsvEyWj3B/MQGNzqXIq73AvQPKY6d0l/OBlsCFEc3nw8lR0oXfM48OLs5X
         ycLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768408502; x=1769013302;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhlm7w5XQ5aGbGz4HNY8lWvxOeoJHGqdxG/3+1jCylU=;
        b=bR2Ls0hLAeCgWyhkO4O4lOn79cCUZ9n4wM3Y/zrdo3wnlFpuvqjYCsfgx9z8fb9keK
         qBYAQ6z7QxToWs4KkLJXRsh1l56M7XowbqknOQH2hci6ijEPYrJ5rp3xxHkkSq+ILp9d
         KjymEZbq0I3yzYY+EkqCGwrH050n2Hn9eM53S4vVdYl2BfiqSg6bIArpkg2JE2L6hnj2
         vVVR0iRQI+cMKDsRpAlQE0GYHS5YX5Z11f8pgMMQzZ8x+s1tEs8iIJa9aVjDrp9ImFdZ
         ORoh6y3d38kW/Svzk1VHzbjwo7VtN8ssckNINPrJZPiXpBbdRJxaBJsDWddO3KrPet5M
         Z5Ug==
X-Gm-Message-State: AOJu0YxauYvVFoTB4g5UlYOKROo7RCDqxylP+LGtTSXK5kQ/d4EknErm
	g8I+44zD/R8ixMp1VTTD2oIzsmTX2+aqVAiWhJQxOy+zc+ME1YwYAegN4B7GpH9XSRDb0I5LWhv
	mNYAGk9UgWo6q7kTXQiFfzDJ0FY69Kf33K4VVRu9zlO218qz8gsYD310cUjD5R5UVgSZbM5M4RU
	CaIA==
X-Gm-Gg: AY/fxX404kiB5GfsNyiGCfUI+q146WGHkDyB1QSDOJ0Y1a+8PQ40I4yBOKXbpalD4aP
	3uaryQf5Kf0SAUDNkkAFpu/m9ZR9EnYfKZlUkl+eizlrhlSyD2Ra3fXSPepTY3XCHTDPVOHO7It
	8r95l6N0ADzaPbg8Vdsk2Fb/p1u5VBCNk0Ok3Vx5csQWl+8oi4DZX+ZOltnJPklTzaRyujl8K2a
	Ci7NfCVkVmtHeLURvkIXnKsHM2wEKFOEtALjr61Xqj6brQ5kHsJjMutrbtwAPEjfkw+gtbbUUWa
	z1nnOsKxHEQPKezQPx5wyaIs8RmejfAAW+4u+PWT5RpIdEWAf+x9vh7QGAYY6O3mWqBVEW8mtkC
	vMFzrWPKd3mUpbsuqDdnkZWQJpDHQpEUiiyDS2r81zdfuteV4zvUa8mvTeLFh+DfdgmQwwg==
X-Received: by 2002:a05:7022:6182:b0:119:e569:f86a with SMTP id a92af1059eb24-1233cfed5f2mr39387c88.7.1768408500311;
        Wed, 14 Jan 2026 08:35:00 -0800 (PST)
X-Received: by 2002:a05:7022:6182:b0:119:e569:f86a with SMTP id a92af1059eb24-1233cfed5f2mr39333c88.7.1768408499655;
        Wed, 14 Jan 2026 08:34:59 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12316f2db84sm12303009c88.14.2026.01.14.08.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 08:34:59 -0800 (PST)
Message-ID: <a47cfe9f-01eb-4cdd-ac97-421f3c8a3451@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 08:34:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath: fix comment typo in monitor mode handling
To: Chien Wong <m@xv97.com>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Cc: linux-wireless@vger.kernel.org
References: <20251030143041.12027-1-m@xv97.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030143041.12027-1-m@xv97.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NvncssdJ c=1 sm=1 tr=0 ts=6967c5b7 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1_aVZONaAAAA:8 a=Ps-XcboYn3Tz16R_CMgA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=AoRcCS2iqqjlCIbQeai0:22
X-Proofpoint-ORIG-GUID: P2j5OPa-tyHo9uSZSjUrA6vsKhgGAH-q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzOCBTYWx0ZWRfX1ShPHi2tDPwn
 NmVtBrtGO6/LKVjA/RYr1iPZDxEC2JvDUp/Gk4w4zYLN28V77mLo6iNq8lEqbOKAJx0qguoQFSh
 KyP6+eEU81Ez6sTYA8AvePzL/Xabsuky96MbkNeN9dCE9AXz45ycb4LV06oXQTKz2F6QrztH0aN
 sgtV6oRTIgMwBO10Oo4vH8jr0GYNtHLazgjahJnrCb8C/0PttQ/BYioyl8LPYHoG+tO/G2FHSLw
 B/nck2U/GTNVtTahKQnEXac6xhOnof2+Z9+hIROdvKskV2ckDZfesXdjERjssz2+EMR0B2nrl4P
 6QXYCMs+mBM1J0inqcpSGSsHuce5VCJAFbCInDems3C9V9joSoimigMPSbY/WqUsSUVFaESN3cP
 Owvup9KYo2xGY+/R1mFviea7i548ocDRKaSe4GYHD0ANIEYCTNnavICm8d0RZtG4Wj0CLLrIStn
 VJnt3+14QOt2ejRhOPw==
X-Proofpoint-GUID: P2j5OPa-tyHo9uSZSjUrA6vsKhgGAH-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140138

On 10/30/2025 7:30 AM, Chien Wong wrote:

Subject should have use "ath11k:"
I'll fix this in my pending branch

And I've removed the ath12k list and added the ath11k list

> Correct a typo in the monitor mode comment where "it make" was mistakenly
> used instead of "it doesn't make". The comment explains that the brief
> period where monitor mode appears enabled before being removed is harmless
> in practice.
> Also, use more common phrase "in practice" instead of "in practise".
> 
> Fixes: 3f6e6c3291ed ("ath11k: disable monitor mode on QCA6390")
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

And I'll drop the Fixes tags since there is no code change and hence no need
to backport this change to stable kernels.

> Signed-off-by: Chien Wong <m@xv97.com>

