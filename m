Return-Path: <linux-wireless+bounces-2580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B38683E816
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 01:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB4B225CC
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 00:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15258F49;
	Sat, 27 Jan 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PK52Ew4+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E758F40
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314432; cv=none; b=PnAAErigD2N7jB7pQuaelMOMvEePsmSwogJ/btf/iTSRHrD51kBrXdZ/bXzYPTY1tM+yQEq4RggxxwRxTEjb719sNZbOuLNmAcZdb7J+fV27T2Ga7KfEWiusoSSyOVqmqlYiO8grLsi9ZygVDIBsgTghNRuIOUwJ/6PM5sPMfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314432; c=relaxed/simple;
	bh=v8CgIiRZy2eAlrQJjFOjy1N5767mndd0AmaZvrdEKD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KCpQvY2hCoyixOmDN9QyCOBxsaQFfGXg2VVA+HWetMrhhQZNOGpT2SUxj5AX56zFjSJFEys4KOVpoSyE3mSQUPFw05pB5UOMdG3SM7CYiy7j2FywXRABBX9E3rr6r+Tx8yLxrjf3v1e9eDdbhmZTcCgtKnCk7WiFqjDadv8SdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PK52Ew4+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMnErl004573;
	Sat, 27 Jan 2024 00:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EXK6VAxvSzZjxQyP65qzd7Sn16kufk2hYumVjnbPGG4=; b=PK
	52Ew4+7pJRWEkDDOgB1f0e9y3zSg0+6BioJXIF/dRAwHXHliwzdA1qBVxMIG7MtN
	EEkPlGiW8rlP1A3cUijBJIRd/+AJBBdS8sc3apx7C19ll8UVssrXEAVcRSmapYFd
	DuRx88e1Lj7VzGai40CSL28MARZ7rXSN8BQF2cahjWrf/NmIkQJDbGlfKfTajk7z
	1gT64zmkw96XKm0jalZXN26s+d1dvFScUnU+ashURYSYO4AUhHT1/9wqRsiJGwjk
	jjOCSlgyWMc/zjYUT8xT5Qx2rSZ8HYMfM9y47VxCuaaxLk3tujX/+HxAWnb8znUS
	R5mcj1YJZZGt7tQFH+FQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvhxyrk36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:13:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R0DkEo030532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 00:13:46 GMT
Received: from [10.110.0.209] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 16:13:46 -0800
Message-ID: <a9a1625e-cc14-4ef0-b0a4-d849120d9906@quicinc.com>
Date: Fri, 26 Jan 2024 16:13:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] wifi: ath12k: change interface combination for
 P2P mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240126115231.356658-1-quic_kangyang@quicinc.com>
 <20240126115231.356658-2-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240126115231.356658-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Myx16hgmdh2wWztkw855PbK9W59XyxL
X-Proofpoint-ORIG-GUID: 0Myx16hgmdh2wWztkw855PbK9W59XyxL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=716 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270000

On 1/26/2024 3:52 AM, Kang Yang wrote:
> Current interface combination doesn't support P2P mode. Change the
> combination for P2P mode.
> 
> Also, there is a bug that when mesh is enabled but ap is not enabled.
> In this situation, the mesh's max_interface of interface combination
> won't be set.
> 
> So assign the max_interfaces for mesh directly.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


