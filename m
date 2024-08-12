Return-Path: <linux-wireless+bounces-11321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F5394F75B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 21:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E978D1F22A69
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A4418C920;
	Mon, 12 Aug 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kgTnvvAG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36637C156
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490043; cv=none; b=PBiCm9rIKJyoZbUSIIP8Oeoz/BSGwvFMfuAFeCPNmc31tCuPYoEOyuHtDU2rQ6lj2uHEpmKkLafFK0wsUk7RYuU551xl/8IVc/FyMzyeoEIKvJIC7HxCNb5KCL1l6Guo5PEz56WHPWI4rE4z7eW+D+SHKBzOXQJtRr01LFlO1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490043; c=relaxed/simple;
	bh=HjnxBLNvYbDQaSVNyJDvra1SA4hOtMuVeW4fYioRKQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KDesifibDvufi4wG8jv6WSLz6qDFkFreWG1qx/jUBHib8M30A9zmycw5wS289WkwkXUkI+psODamW5Bczfkb4i5bctRd8/xaFChJiE3in/p9KKLkxZUt9XqGBVKeAVX9PEAsXSTeUP7oSBEH+lq8CflmU7y4MrmEY4QpYrMEQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kgTnvvAG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSUMP021408;
	Mon, 12 Aug 2024 19:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6hzaPWQwxCqQP16WI8joKzRnT3Lpc8ce20Tdr9ekV4g=; b=kgTnvvAGc6xPPZLW
	9P6ILpkoIGR7b4RzTnNMjLk2yhR1XBrQqQeTuDJNRIcSXWWHS3rYdPf3mnK3CfTO
	4WMLaR50PQjTOzCAfetV/RnUhkSRoBPHdpRNi+Pj34iI58vgdHi4pYfrBEMvPzJz
	BP2gEC1Pb1a0K+BGuuZRyG4ifEn+Xtbrmj95zW1Jdc8XpNmVqMS9ob77EdYEN7d1
	E5mHySCdvJrASy12vABfQsfuyps4a/xjxLEo1mSmvtlh9WGjTh5k0/Knac8ZBUHI
	hHpBivflxp0xDrAfaZBWvqEChdy9SUxPZtd70qlXL+AnYomAIeqaL3xyMrqskUQN
	b77w7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1g7w8vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 19:13:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47CJDvX4016618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 19:13:57 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 12:13:56 -0700
Message-ID: <1ac890d9-7efc-4eda-ac5d-c03483b3c2ef@quicinc.com>
Date: Mon, 12 Aug 2024 12:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] wifi: ath11k: use union for vaddr and iaddr in
 target_mem_chunk
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240731014104.798028-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240731014104.798028-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6OHqUqm7SHm5eibcu6Uzr4V_X31HulKs
X-Proofpoint-ORIG-GUID: 6OHqUqm7SHm5eibcu6Uzr4V_X31HulKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=720 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120142

On 7/30/2024 6:41 PM, Miaoqing Pan wrote:
> The value of 'ab->hw_params.fixed_mem_region' determines that
> only one variable 'vaddr' or 'iaddr' is used in target_mem_chunk.
> So use an anonymous union instead, easy to check whether the
> memory is set or not.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



