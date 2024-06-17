Return-Path: <linux-wireless+bounces-9126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FF90B9C8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 20:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B991B284A9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0B61662FC;
	Mon, 17 Jun 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QP1btKqI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B718FC96
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647684; cv=none; b=XH/cafnWfOuL7AXbIE+dDN4n9qUFBbraIpEBE4/MeesTBReSFHU3LfokJWHW2BJpZcOQeyRBM50RghGc/EqvXtrb97shmM5MxotAcQcOpGqX1ND6MmgXjN+EtMqtN5w3MZHS1wpoyGZQ5W5Al7lnrGWN0WKbr+nT4KxB2ZVOWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647684; c=relaxed/simple;
	bh=aVGz6ZuT0T+m827NMXDLS9VnYZvBWKx32a2x27sQ4uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=StyNl1gKpMQrJ3CwTpJaNWMihOxVtDtJ4u6TuBNZNrAAiGpPknxysImn1tLK440WMK6sFbQlit2wwTDiTd2XW8emG+Rt4g43HcBBRtU+O3+UuMXb3/2VwZVdCjfH3a9cUS9XjDy52a7If5Uc2EVygThnkd/0ZdCLzl739Bvve9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QP1btKqI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEhuO1030652;
	Mon, 17 Jun 2024 18:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vVPPhwzFhSjzBWrLr0/VoLhH7Ttj1NrzFNv+6VmtY2M=; b=QP1btKqIZNP2/s6z
	srIvj9fOHlVb5kkdcYj2zMgWKLthBnqZPxR0ADz2XgaItuuSHID3O/3snO1HboyG
	L4adwA0xIK0CFqZanPqFbdEuWP4b0D+QRzuJzzn4/8Ibs9mBJUl3KG/OhP1wKqiv
	42iLzLFGlzv+DOZF5XdPq/Od/w4dMEheWmdxY5jHQ/Xy26yFRyxL8PHvv+8YHsXQ
	LptDIjSJTbKsifSagFKtd4EdUNVXKfBiqKxy0PpFj7HVA1txb0aQiEBcrk9Y822Q
	MvxJGEjvTtOE68bjoBMmr4+9ImWbjZzOpQmUWJGqxkNynrA83MH5Gp8J+NCYVKwN
	G6xxMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytfut1ke2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:07:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HI7sx3005366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 18:07:55 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 11:07:54 -0700
Message-ID: <a4f466a3-9839-4591-868d-fabd668030b7@quicinc.com>
Date: Mon, 17 Jun 2024 11:07:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix mbssid max interface advertisement
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240613153813.3509837-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240613153813.3509837-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x6OCStTPxMSNrhoJ3jY5aasbYYNEVG0-
X-Proofpoint-GUID: x6OCStTPxMSNrhoJ3jY5aasbYYNEVG0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=657
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170141

On 6/13/2024 8:38 AM, Karthikeyan Periyasamy wrote:
> The Current method for advertising the maximum MBSSID interface count
> assumes single radio per wiphy (multi wiphy model). However, this
> assumption is incorrect for multi radio per wiphy (single wiphy model).
> Therefore, populate the parameter for each radio present in the MAC
> abstraction layer (ah). This approach ensure scalability for both single
> wiphy and multi wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 519a545cfee7 ("wifi: ath12k: advertise driver capabilities for MBSSID and EMA")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


