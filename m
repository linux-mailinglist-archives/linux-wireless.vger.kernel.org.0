Return-Path: <linux-wireless+bounces-14833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38F9B95D8
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E41F23F2B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF231CA81;
	Fri,  1 Nov 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L92IHH/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F61CB513
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479666; cv=none; b=nnaQLz7Gs4AqGG4zE4N/K7Dj3IS2qreQv7xCbVm8v2fpfUbDORN/UdRzjCp6qR/KJx0SyLsd2QsHKXtqEgEmqfKwQu3ZDZObU6ebXyhekp0GG4IVSZioNfX7x0mKQHul5EwcrdghWsPxWshj795+AXt4uTC5ITzxApbiUvHZcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479666; c=relaxed/simple;
	bh=2TKJsYc3rs5nFxoSVbumIeoobiO6pE0ynaY06VAfZBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I7OQmOpP5/qPCDTFQybZKk/Ima7EMXJKIEUTIHKkBTJQUa6HBOQi3+DbozGOIA6+pX/ET5S5ccjJjk7dW8M7bcKuV1OxD56DxZRT65ydNG4TgbN3m/hTdyr3zCoM20+JJmpg9XMHluzwy/bBZ+xoWcGgC8dJO6pAQy/p8aqjSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L92IHH/I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1D3QBB002324;
	Fri, 1 Nov 2024 16:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZH0w1JaygqaPO6EvdliOSCFmwhlIJoRNgJ+WLQBLWY=; b=L92IHH/IDT+ZhqTX
	am3TNl0AeSvudl/8M02ipScIJsxbG7YeC7796LS9RY6gj/QeAdXyjQrgyt9B/LDq
	Lfi2NTIc0KiCSV3QMh/euj4JpSP4KtH5DlDX39rI43WSUcvAjoBD8Q8MZI9nyyqa
	Xg4MFAriqRF7zvccKv8pfg7u9IJet5f1TsnkkrcRoJsWMdxhnxX6O4ib2QW8G5pD
	KGlfSyv7ijsQ1Omy0ykomOK7a3GIFNDm615ydXvKquHymc+iVz4RFamQWGSHr59M
	ihFpzaQ3eOGqKm3AGVCJl6NyeAj/cLCHapDJ6a1H9Lp4jDuX8mOr4mIaKHPD6j6K
	NnpzpQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmn5fyaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 16:47:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1GlbZO003714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 16:47:37 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 1 Nov 2024
 09:47:36 -0700
Message-ID: <e988d32c-f1b0-407e-b04e-84a6ef4d0b30@quicinc.com>
Date: Fri, 1 Nov 2024 09:47:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] wifi: ath12k: add helper to find multi-link
 station
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
 <20241101151705.165987-8-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241101151705.165987-8-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oVVI8c7CFoXIyMkROjXw-Cg9cyA1xk-l
X-Proofpoint-GUID: oVVI8c7CFoXIyMkROjXw-Cg9cyA1xk-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=827
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010121

On 11/1/2024 8:17 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Multi-link stations are identified in driver using the multi-link
> peer id and they have ATH12K_PEER_ML_ID_VALID bit set in the id. Add a helper
> to find multi-link station using the multi-link peer id.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


