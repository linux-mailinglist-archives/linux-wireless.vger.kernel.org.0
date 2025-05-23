Return-Path: <linux-wireless+bounces-23370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE0AC2833
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 19:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54A89E7E33
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F02236F8;
	Fri, 23 May 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VIsc9/ha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48D29713B
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020088; cv=none; b=ieBwn3IGsmGpD5WOtlhoeFxo/xkNDnOl5k1NDadJ3dbHdGM6e+Bh55AbSf2s3lY6tpUZKSmEI1J6UfKNea9JgPu7H+lxTEMy2oRNoEG0GP74WPaL/9yOEUp+gMbK8YzvZm3hgfOfQrI8w8tjA5WJobgFDbkHq0UOrA9gq6eBZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020088; c=relaxed/simple;
	bh=t7vrTX7zMhssdBuywFp745ssjNHRzAdube8ZFTf8T7Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=WrRu3xBnCfD6OQCMp9Ynsf7Smag4etUTJiRre+TK4BqFPIB2lw7leOuI46JupAWVqtnRxWjWf1a0Qifyf7W5qofCL/vbs89n0xwpaqDwVXW5KbblGF2YG8zHn0UO3gOl27K2BwA1uiUwH/mVl3OH0nGx+1QNe6T5j8r2qyqyVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VIsc9/ha; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NEZ2Lc000836
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 17:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tZUadBFHdEtu6nVasWJSp0
	TAppzK35LzVtrVbC8Wug8=; b=VIsc9/hahModkP8X3PA1B8iC7GVr0M99R3IrGE
	aXOMtHoA+grJu4k3WXH+JuWtnc7F9fefFanwa6ufBzaL+31aP6GpUT4eTozFo5DS
	+uP/sPxDGnjFpdOhZajBfhanvUa1jy6YDpHtixdCXg0YASFpmfyLd9GhoWHqS4Ps
	9dIAJmh+pAOitJfq6Ga0yKPJHbo6QjdRxaVjLt6yKvymZXiolw382/psU+TPAEbD
	7ObJeHHx24IO0UAmz7b6jQDX+AL18ucjLChTa5ja+5XwGW+SkFCmVcaktjKh/ouo
	ggtOOWkfZxkyf2HAI2he2QxssLXXfZbxf2xizW+CGaf2hA4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf72hya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 17:08:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742cc20e11eso104895b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 10:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020084; x=1748624884;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZUadBFHdEtu6nVasWJSp0TAppzK35LzVtrVbC8Wug8=;
        b=EQNAjaAsL1sEtwN/e83yNP20y4fFYCn4BuyTxFpsBLJDWVFW7MmnR6ch0uPCJGGpaj
         5/r+aZwtRqPKFRtGcuLX9ZzErkU3uWFgdIS9tkRfKwE38c0ZvbQwzT7dqa4PLWCEY8rr
         HC6GNhIL46mg7Q+h424yGhUVZxhrrhLDlKAlckG0jmBMBZYyzUYS+cogwGEGHD6OYPcX
         rm04Jik1aZOM5hvuLT97Gw0aSU7qioxYDmxa1wi70OKA3ccyQxq0m3SIKB7fTIUeOK4g
         pBoirFwRUIyojbJPhqxKZiJ7hhKfzXg7kebDbdjY1ZoB+diQBBeXiK0eO8Qutk6gwXCy
         QlxQ==
X-Gm-Message-State: AOJu0Yw60+ECfq0wE/sZ6U8+PonK7uFanJkzusjKnSNuxoO27HJNKPjO
	8Ga3S//o9JBMMKWW8eOnplgv//x9uTEZDl/MshxP73Q0YSiGKLAKy7v1OsIjhx0bGpMQYX4IT6j
	nYNczDMR+2fjV4C2UPINh+AO7nt2UruZcVuaADydLJ5NztVDJ2BUeBTHWVUnyGGDHIgnpLQ==
X-Gm-Gg: ASbGncus0TU6QOMmlu+VY4EM3LZ4AYrXt9s+H8QiuBEf+c6uA1ee4hLDsDxbi3FXcQS
	1wJFrOUoB/tF9CU/C6QnLzroBfi61ioiqqsrQFhD1HhheN2Zohiz2aSf0Mvi9LJFj1n2UG0k0p1
	qSNmv2zUQW5+V3iCKzxxqdKoKF2Mz2CNKBXn79IgE89bGC6Xr3NnHYyf04tVJyKdVsesQPUR7Og
	F9aFpqMIoP84RXBcr66TCGY/JNlOVWwN/5UaSB9e9S7ZNI/3wzrYfiGIl0JX9D33uj8OlHI8urF
	N/IZbVQYP+Ocr7LWc24jiE+rZSrtrbwqL8ZD7b959BAMYbs0
X-Received: by 2002:a05:6a00:10d2:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-745fe03c2damr380014b3a.20.1748020083908;
        Fri, 23 May 2025 10:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5x+zjlejQD7iUhgZen4iAhbFV5wkG6YLj4vbg91n7MooaF52e912rywgPZgF74Hdf6hPSIA==
X-Received: by 2002:a05:6a00:10d2:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-745fe03c2damr379983b3a.20.1748020083500;
        Fri, 23 May 2025 10:08:03 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829c37sm13084080b3a.117.2025.05.23.10.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:08:03 -0700 (PDT)
Message-ID: <fcfa4e63-e421-42d1-b6da-11d2d7d2dd95@oss.qualcomm.com>
Date: Fri, 23 May 2025 10:07:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20250523
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MqePLXr4eVoN2pMeTERYj7nbafK1k8aW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE1NiBTYWx0ZWRfX4A6qXVU768OG
 vnlpTgGrvgeJCuSzpK8slRsXsWhKiihGPtawtYrey15AGlP1VicDLCOUHHxCb0Ye56sIM2aiYzR
 aNb9LQV5dKvm7lEB+OHY51/wXw/xi9xv2JnZHVk3o/pX+K5FvllCKX3IWw+URAEWD6XBSs8FCmV
 HgoDn8+xaJcPpsx8BvsOMrsfV4h1FU/DpVYDrAoLTumg9tpWPFusZj9Coya2eYnFEe6C90zF3X9
 uoS0eOtgF7GkBJc1eM/v2QJA1CRgDNBICPBUk9d3OV/IHI1SCRbKnc9E50jUGiLANhwjfzwxxEe
 gM12xRosOfBjqG+pvwSbM6sNs9VrGscMQn3z1OJIyFgYopxhneMJQGAfXFQQjSOu0O+vF5e1331
 ogsnVR8uDPsLDEPCmtsAX9pD/gjif5WfQp/NeDGbcxxusyCQ06wUi6SCW/9Y91bJMgrJ6ZGr
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=6830ab75 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=w00LdxtAzVfKRbiaHPIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: MqePLXr4eVoN2pMeTERYj7nbafK1k8aW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=831
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230156

The following changes since commit 3fbaee2775a4a6d44021aa035823a7388b0874fa:

  Merge branch 'robot/pr-0-1747839277' into 'main' (2025-05-21 15:05:37 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20250523

for you to fetch changes up to 2e91d8c3c4bd34a27177180a38f62d3ba3c96031:

  ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 (2025-05-23 09:50:02 -0700)

----------------------------------------------------------------

This is an update to the WCN7850 firmware that fixes the widely reported
failures due to the prior version in ath-20250424.

----------------------------------------------------------------
Jeff Johnson (1):
      ath12k: WCN7850 hw2.0: update to WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

 WHENCE                        |   2 +-
 ath12k/WCN7850/hw2.0/amss.bin | Bin 6082624 -> 6078528 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

