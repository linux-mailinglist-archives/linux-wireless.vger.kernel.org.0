Return-Path: <linux-wireless+bounces-19626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC335A4A8AB
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 06:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CEC189BBE1
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 05:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687B1B0F20;
	Sat,  1 Mar 2025 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Df4PKkmh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69810FD
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740805710; cv=none; b=kDssXm1Unr6s635+oQ0RsTzMiooWBtbzsQJrjvxQG7hexZPoAr2F0qRpDUrv92nj3yQ1Bgt+V3aANG7O7sqL59WAionu4lveueNcgAw7ixGPgfmowQ5y/lU7BJ2G4d46e1omjMqi7TJEmnI00sPJhrhkmo1ZWgA0Ym8VHHz8DXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740805710; c=relaxed/simple;
	bh=3g1Z9XkpxZIWT/oLVM0iYETNp9tKwRufwHU5xLa34vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBrPLON5A8HNTDeiK+zCy+pQB9FRWTrzNosuDDKYv+58COrPxyhuT2VnA97gBbLExlkYNjDxAhZSfMdQCWEg6QeDPnS1yoWm3UiUAdpY8cUtYprunUMh+cavbhDFoMKbohQI+FtRx7KaXoHnUcJN5rOW5umAnnh4yc3MKRbp224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Df4PKkmh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213Z2gu031426
	for <linux-wireless@vger.kernel.org>; Sat, 1 Mar 2025 05:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mvzvijPldS6tDkdWHeMF7h3d8VZDqRT0m/lKGfdkkcg=; b=Df4PKkmhl+VutdiZ
	9YKingve/0nZ5w08LZeTlCUvSzVyVRXVtJw3AJP0yuZtITFEryqdx3X+qBv7Z80Z
	c6AjBsIV7fMjluOBSWBp96Fv/bY+P2+QYE+xkxtAFbxGnI2tUrHCoRFtGhte/AIH
	pngjogcsfiH0GnKwuautbRQUd5oy/26X78SRpBFH9LMTn0/rqtv3N9EO+6COj0ud
	Qgk5P9eInbjMqenzJjyjT49VyW6CuINoikcCJ2ZaJElSU+p6szNIHyTzGPv+iY1W
	PHc3YSTJrAG4wwOzQSe+EO13t4Ou+PFRoyxpeTClbjWQKhEktnA11aTVzs10vAWE
	tAyedA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453tf0g4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 01 Mar 2025 05:08:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2feda4729e9so831506a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 21:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740805707; x=1741410507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvzvijPldS6tDkdWHeMF7h3d8VZDqRT0m/lKGfdkkcg=;
        b=rjmQ+9Vm8ULEM+Fg7caWoo61far6oFg7JLHQaHTz85PIShekqKXfULuHVjclQGXPWP
         Oh7GA4Q42G4fRzz/jhpzqjqinPQDnLyob0nCbDNVWzA6+m4XgC/L4u5Yu17wRTU1Kt5c
         tl2MQfHf0MpPAuz+ef/p3k5xlxWDAqw1YjXG/IeRWqiICrxQ9hvx39nYvCsDSURCswgY
         wCjyat/P/axvBC0kCfclAsA21GdKzMFiPfT5yAQ4HNa+umlDlEK4b12BDQ/jQxTo8rxv
         nITy1DAdq5wQKhE58aX2Le+zrQNhFOf1ZyXHXq1sCU9pKpqBI45khArRDp/Ve2oqtsNe
         BimA==
X-Forwarded-Encrypted: i=1; AJvYcCX3iwnCwLadtlJAM58A8yubjoI4Kr8ejNre0w27tdXCB4/JdXAlQ2TjgwVL3yE5ZKHNNsKqUx0uD2rvAWaDTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkV6MIz9oqqlbH0sKqkUjdj4PQk7qvaR8CdPJu1LftA+89LadS
	SwMPCNP01Eia2q1LEgVMHwoXpewR4f6KxOzAb+tvQQfSFx763RxNbDgjSqdQaYCApAAqIg+EpYX
	SII2OFtVmxOvr/BGoXbLMIkHbQmdmQ9Xu/HnoX1jsYLOxMWWYHGukAh2jL9YEHucYLQ==
X-Gm-Gg: ASbGnctaqifJAWZCEY504czBr/LK7UPOCib1fzgoh2xXkr/XG68ITG5uOSvJ2IHbDkp
	D1WC94SiC5E+NYMLsxXBRmKk7l6/fRAiSyojJwfVO2md8cPzk7SA7B6F5UdrjMCY0OEBDF68egS
	9F7RgSoh9K1KwdK9uwyfidpwAgKyPbr4gWSl1WW1wcRPrUvjBCRbXjoMghcc+A2LyQBks2l9fL9
	MM2htuPGOHyK6OE4uNON0drHD84QGpZYjCZYI1GIYVnq/mda7zKWgDeBV8nknt8uJpqrsBe4EBi
	Nrn+5nM9vGVMGu0CRL0rL/j9bq36YKeG60t7mDvxfnAwC5s+jqF73Te4IEAv1lE=
X-Received: by 2002:a17:90b:528f:b0:2fe:baa3:b8bc with SMTP id 98e67ed59e1d1-2febabedbe1mr7655073a91.23.1740805706980;
        Fri, 28 Feb 2025 21:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/vPlqpHEUgI+a+2o/62cPS5Ifg2K1lLIxhz7aBhhW1sVlPf4mx/UX0l+6C4tO6IiJQGxbqQ==
X-Received: by 2002:a17:90b:528f:b0:2fe:baa3:b8bc with SMTP id 98e67ed59e1d1-2febabedbe1mr7655047a91.23.1740805706639;
        Fri, 28 Feb 2025 21:08:26 -0800 (PST)
Received: from [192.168.225.142] ([157.51.160.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98e7sm6858235a91.4.2025.02.28.21.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 21:08:26 -0800 (PST)
Message-ID: <64b6d4f9-429f-c415-4b4f-bec02f520671@oss.qualcomm.com>
Date: Sat, 1 Mar 2025 10:38:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 03/13] wifi: ath12k: refactor ath12k_hw_regs structure
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        P Praneesh <quic_ppranees@quicinc.com>,
        Balamurugan S <quic_bselvara@quicinc.com>
References: <20250228184214.337119-1-quic_rajkbhag@quicinc.com>
 <20250228184214.337119-4-quic_rajkbhag@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250228184214.337119-4-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: U6cW1xQ9NFyDj1vAlUN2Q-L4U0hBGa1l
X-Proofpoint-ORIG-GUID: U6cW1xQ9NFyDj1vAlUN2Q-L4U0hBGa1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=635
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010037



On 3/1/2025 12:12 AM, Raj Kumar Bhagat wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> IPQ5332 device have different register address values for the below
> registers:
> 
> HAL_TCL1_RING_BASE_LSB
> HAL_TCL1_RING_BASE_MSB
> HAL_TCL2_RING_BASE_LSB
> 
> HAL_SEQ_WCSS_UMAC_CE0_SRC_REG
> HAL_SEQ_WCSS_UMAC_CE0_DST_REG
> HAL_SEQ_WCSS_UMAC_CE1_SRC_REG
> HAL_SEQ_WCSS_UMAC_CE1_DST_REG
> 
> Hence, refactor ath12k_hw_regs structure to accommodate these changes
> in IPQ5332.
> 
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.3.1-00130-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Co-developed-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

