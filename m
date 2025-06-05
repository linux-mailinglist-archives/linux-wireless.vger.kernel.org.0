Return-Path: <linux-wireless+bounces-23729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2FACE952
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 07:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F01174A48
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 05:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D471DD0D4;
	Thu,  5 Jun 2025 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C6f4wtlm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54101DC98C;
	Thu,  5 Jun 2025 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749101336; cv=none; b=f8iZrDbEtW6gn85p3hpVHcR7QWE0d1HtSGHtounMad8hMJFjI8t3jyVu0hI3c5lYik984wh0n0v1oBsfk/qLokAqksL1oB1y6V9J0BM5Xl32D0uc+Khnq3x3CCH5StO/5xEhZt2Z78WdwuDJA1sch/pYj2eigVFSjt1KtjRdrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749101336; c=relaxed/simple;
	bh=8T+KiH+TRmyHZbNkGgihRrs6KzyojxmRHnHiGTLDKWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F8+UnpfOmbSrzLhSi1gy6+EuUT24Q3FCozNnyEHviQ3ozn+ZsoRVkb7hBP4KvXB34e6g8Qf199lfwSkvj9gFDGRSV06wvTUMeSdS9Y/uEz5rqPsRNm2kjpjALs3CUebHMzQsNEmkqXBNgMtubsNFdF2QhtQOIMzabhimQmGuT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C6f4wtlm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554HJJK1027554;
	Thu, 5 Jun 2025 05:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c2nhgPnAlNxy8+rgUUUdvD4NqC/lP6n/L4BAZPK/zdo=; b=C6f4wtlmDrYbgTEt
	der0z0jFOw8tHXyZPIapDsbWmGPdhRUeRuMYJ1WPcHy7aKVeI2c2idNiEcUWleGn
	deHBwSmNyFu/SdGG6oyDRTXjKS9EL5S39le5DJS0d02/RQEc7cwmWOWqxbJqzH6E
	Zmv9AXOfV36TTYVh3Ki8nNkJW72WUyebr0lqOLioHBTSrNF3PvntlLXIRSc2aHyJ
	Vo3M118phas4c4J8oo6Xc/08VbDSArzVfegHBsLh9R0zKDuGE48XO8HxQMgke0ab
	NBtmXMVXbzLGN+pnkY0UEzGzGM8arTGOB3uSosIRk4MJwu28weNqDGcMDq+yblkO
	D9RlCg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t85su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 05:28:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5555SaxU024457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 05:28:36 GMT
Received: from [10.216.44.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 22:28:32 -0700
Message-ID: <fb4763e4-0106-94da-548c-6c585ab8ff2f@quicinc.com>
Date: Thu, 5 Jun 2025 10:58:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST
 definition for WCN7850
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Bhagavathi Perumal S
	<quic_bperumal@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
CC: Sriram R <quic_srirrama@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Parth Panchoil
	<parth105105@gmail.com>
References: <20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250523-ath12k-wrong-global-reset-addr-v1-1-3b06eb556196@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=68412b0e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=17ir-Gtp1zVAAPY-F3MA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jm_FZWIanXm3UkUXi9rD9HpK5lQoSJYT
X-Proofpoint-GUID: jm_FZWIanXm3UkUXi9rD9HpK5lQoSJYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA0NiBTYWx0ZWRfX08ybtEULpqSU
 TyKqO8j9oAB38jqmnSuBptOv9o+ILvYDefh1zgwESy+1dIUn5vQ8Lgylah24zorBgIwKs7E8fYr
 FH7n86tJYuErw+xLn4wZFA2HGuJEzyvFVNPxk8d2l6T+DKRAwnFLZCV7EmKBVNQIqQ9GE2wrYsG
 LAUJao5jmgIF0n0ULlk3PJtHQdx00mas96qS6WSwX15F3liGqgPVI45U+T1UKEHSZFy8NYyyAP/
 nwnNOCUUowPioO7vPthn7cBMOJg3g8NzHK0opX/XPYD91COIuB6KrhUHJUFyIIsUpAFUWoq23/D
 jazW+LgsHHJteIZwKtCsOBVUh1zoq+pkVdQCSpmaQn0L/WOQ9RPjZruDkMSKodz7Ug3s0ec86z9
 Qo+PEKyVwwnUy4HYZEIoXgHFT5Gf34e9HhZZFu2zqzZJULu1y8nDliSmcjwrJDNtVbK6e6kZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=503 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050046



On 5/23/2025 7:53 AM, Baochen Qiang wrote:
> GCC_GCC_PCIE_HOT_RST is wrongly defined for WCN7850, causing kernel crash
> on some specific platforms.
> 
> Since this register is divergent for WCN7850 and QCN9274, move it to
> register table to allow different definitions. Then correct the register
> address for WCN7850 to fix this issue.
> 
> Note IPQ5332 is not affected as it is not PCIe based device.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Reported-by: Parth Panchoil <parth105105@gmail.com>
> Closes: https://lore.kernel.org/all/86899b2235a59c9134603beebe08f2bb0b244ea0.camel@gmail.com
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

