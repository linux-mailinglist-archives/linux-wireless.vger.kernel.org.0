Return-Path: <linux-wireless+bounces-19628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFADA4A8B1
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEDE188D75E
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D571BD9D8;
	Sat,  1 Mar 2025 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ov5ckv+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5871ADC86
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740805817; cv=none; b=Nve4S23UPlY2ekZaQCeaumbxspM6e5HUb9C2FztIEQwkMzTnoskY7boob1m6wo7ZI4+qAUreaoYZf1CRvCGz+EOQ6mKoKM7/3BxCdOKLptzfFaIPTsmF8RPvuobcc1LemiEqalmTSgITUITqGbBm4n0lwWd9FVVPP0GDlybX/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740805817; c=relaxed/simple;
	bh=7QETPNCf6V33FwpP2/eapAsWY3oM4Bh1FsTYCCOMHa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIzF6CSyy0xZVzr8LarX52Vw4fm6n6LazfW3g8QhF4yp+gTDRQlQmP5JS5aSpejHRgGPi17HL4Tf+uw+GZTzgfe8mbu/3mLCJKZUjjb85+jLVa9Yz74M4G4rNGbccMcYYCXuaHxOzjzD9Vw3DXnA948ulnDCKEGoVULpLtu1Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ov5ckv+7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Yk9O030342
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B/nGUNL5/MAVNh5LohVX5xo6ka5DWHkfH/+vaZgEPUo=; b=ov5ckv+7oUao89+W
	YefWowuuliMnzs8vTuO6ZbhAZ0NFfiHc7IpcwUuqBOP1nLOE+pTfmId6Y56YvXzb
	VEZgG6mW+cIbjnS2jAu9BRnYqBfxNdRSHwq4HmPXn7agqj3HwSHhF0fUuj3O/lo3
	Xg9cC7orVZPswoNgfUQz/7mBVPAmWDsbqvpuqFNHpvOmgy3B2vZd/fJx9thv908J
	nnGFWisS9xc0sy3tfTEGuZqLozeO7io5MI3jO90XMp2aH3j57DaPTGG5nbmIjXfd
	LpX9STTcQRxP6S+XplDybeok/ZqzkM7GBSASLd1ST/Ug+DuJ/5CNbus0zEDKQXjd
	hEmp6w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0g4gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:10:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22367f4e9b9so30038825ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740805814; x=1741410614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/nGUNL5/MAVNh5LohVX5xo6ka5DWHkfH/+vaZgEPUo=;
        b=G21oR5Kb/Lvdfzl4YqC8jUgGC6Gll0eXloBkAKBeMPPgv3e82pIYZvS3eVq4FV6scT
         NLCLDfQ2Fpx/uqUXEiGpoMl/wnni12EFujgCF8WsHT+PketTJG8m+NnvKuhvkLuxCH3C
         MQhogCQERutII0NScewyNwEwjMhok/cJxhHppHvTM8th7P74CUHFkSBUQTF4u7v1nSu6
         1Ag1xcmm/FPnBu6yfbfYcdu8XnWsrkovw8nlJG6blygxa8uJaCnwrEb5+sH8FTQ+0ccH
         JsP0shOZtqvaDsbBMbzlc9n8anyFPlJohPq9kMLowv0pVGuUvJF1glruR1cvHEoKJKcp
         UrZw==
X-Forwarded-Encrypted: i=1; AJvYcCXtDStxEct29AEndTk07IjA6oqHoRHa0BDVScM+AX1JZSx+Rwpr+TCtzhUUPqAgBO9Ovbx3D3uOdV8Fla3spw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzcGl7ewMQlVmi6DXb9rDRFw9ZdthmyP2dYu/bdyaGPNIZmfl
	wACoRF4vWQ3V044TNNwoWRzX0Ly0qd4vXg6C3My2myZk8bQyCn4l2a47DPW86nH62jTkLQMXvIU
	OehJWJVnSQ4aXcjr3kqu5fMx3VPABWTBUWd/OK/vQrbhK47AmqTFulCcjtvaRlaNE8A==
X-Gm-Gg: ASbGncuB7O5dcXQOqxPv2j4niB7d8+hDZOruKXdzbHilFRQgF2dzJwrA9eBRTaG6CWh
	/FVOlAR/dVhr6xou3RcHcWKwWEPiTgMOLy1P5yC5gterpIBeZIxv7iP9eP8hznbYt4Ew9nRVcmf
	Nn2IwlNkPiWEPQ/67GG9HF1qw6tkaJOcOmQ2PjKvoUlydGYpvsxhInDaew+mx8r7TCJHgw4bhWf
	LOBLY5saAGyU1Gf9tCWhKyXsEmbnozl6C+dISS3FgV0/yQnVFRZ2Chx1MsNGPzY8VcoSNbxoEE4
	2WU9iUhjsV+LVstHJhKa5Y5FViHdXyfgz47947fq37NO0jyVEwmIzobeuwrGEjw=
X-Received: by 2002:a17:903:1663:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-22368fa8746mr103580595ad.21.1740805813938;
        Fri, 28 Feb 2025 21:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEK3Hzs8YMaX+ebCf82T6SbKihl8RzxL2usQf8Gyh24s4uG9dkfZ+FAPIt7h/dWk7RXW4j7w==
X-Received: by 2002:a17:903:1663:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-22368fa8746mr103580385ad.21.1740805813586;
        Fri, 28 Feb 2025 21:10:13 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825b7b10sm6742150a91.11.2025.02.28.21.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:10:13 -0800 (PST)
Message-ID: <7d7e8e07-ccd9-da10-c84b-90cfc5a5b1e0@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:40:08 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 05/13] wifi: ath12k: avoid m3 firmware download in AHB
 device IPQ5332
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
 <20250228184214.337119-6-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-6-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pZVyrsgW3ZWy43pm4kzBXmNLfNZYCBYW
X-Proofpoint-ORIG-GUID: pZVyrsgW3ZWy43pm4kzBXmNLfNZYCBYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=986
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: Balamurugan S <quic_bselvara@quicinc.com>
> 
> Current ath12k devices, QCN9274 and WCN7850, supports m3.bin firmware
> download through ath12k driver. The new ath12k AHB based device
> IPQ5332 supports m3 firmware download through remoteproc driver.
> 
> Hence, add new parameter (fw.m3_loader) in ath12k_hw_params to avoid
> m3 firmware download in IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

