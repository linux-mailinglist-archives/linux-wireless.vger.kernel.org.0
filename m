Return-Path: <linux-wireless+bounces-15472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E1E9D1B39
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 23:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230E82817BE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761961A08BC;
	Mon, 18 Nov 2024 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gSlju5GQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E0183CD1
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970184; cv=none; b=dhnnp56Pvt/Qc2knxAOE1PI5kRwEgwgC44nPw+ALypHGsRvyHaEosMT8IWzxSIZpVQyhepYDEiEgrC/Bh2s0ildwCjHYLLr3bmSJErzvi9a+ADN3jdxuyLnzI33yYu3OalclhD3/UaEm66w4F4qYgFZsRc2x/rnKncgyYZFw5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970184; c=relaxed/simple;
	bh=zEYW655Guy9k3UUTtxx8BSvtfgUDndONSVag7xyfAR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UzWz/5katwz5jZWttJtKB09YLuHncHFwf2jUkpyxSP6nXIrRAsh20izcQ+1r10v+m1lCFvvxdyzLK/JjvTXRAiIRPHkU7hgQGASmJI+ykF6BdaU/XtxZsfSIHZBuuE48xKRpP28aw3HiLPLNN7ifbYUp7rYfsT3SIkgX9su+9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gSlju5GQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGinN004780;
	Mon, 18 Nov 2024 22:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sJMEJFrVhvtck7GI/grlsvt4PO+tm6wa9v8BN/+20uI=; b=gSlju5GQ+1BGK0iE
	JFFyypq4pRLtcqlGa3qsWh7/cw4/pc+8sDRR8ks9iJXLiPNR11J0PoExeYucb/FA
	WiMizzsIEfFoUtTfcT3sttn38zxBtSRm+3RRM2YxxFSUtlEHBQLSxLZUysJ7BM/o
	/DPNWqzlav20f01ZqIzqnLOacdVRjZ3eQks4fkxzyITJVRmoaCiFVffKBFThS/G1
	rRqqdwyHoY4n6SQBGuTI9RYDaJg9exsml2H2dgb0lerRnk1jpT5dW7lCwmV9EdZW
	Xhs2/7vjGiKLPu08m2LCXwQ6L+3aV1mgUFFSu4T05K0gC/n6VSvD2K5AAjchptRD
	2B1w9g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7rs40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 22:49:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AIMnaLH017282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 22:49:36 GMT
Received: from [10.111.176.82] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 14:49:36 -0800
Message-ID: <f254a769-efba-450e-8dde-1768b99be50f@quicinc.com>
Date: Mon, 18 Nov 2024 14:49:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix inappropriate use of
 print_array_to_buf_index()
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241118035722.1755373-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241118035722.1755373-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TJVXLF8kXvWEM4XMWX4N6wBfuuGdjLFV
X-Proofpoint-ORIG-GUID: TJVXLF8kXvWEM4XMWX4N6wBfuuGdjLFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=799 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180187

On 11/17/2024 7:57 PM, Roopni Devanathan wrote:
> Currently in ath12k_htt_print_tx_pdev_mumimo_grp_stats_tlv() the
> htt_stats_buf->ul_mumimo_grp_best_usrs array is printed using
> print_array_to_buf_index() with a stats_index of 1. This is meant
> to convey the semantic that first entry in ul_mumimo_grp_best_usrs
> is associated with user 1. However, unlike some of the other "usr"
> arrays which have that semantic, ul_mumimo_grp_best_usrs does not
> have that semantic. Instead the first entry corresponds to user 0.
> 
> Fix the issue by calling the API - print_array_to_buf(), instead of
> print_array_to_buf_index().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


