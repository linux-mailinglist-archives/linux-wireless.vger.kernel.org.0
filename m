Return-Path: <linux-wireless+bounces-1840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9382C55F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047CB1C21476
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1925611;
	Fri, 12 Jan 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BzFZo3V3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F82560A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CEErfc019655;
	Fri, 12 Jan 2024 18:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=auwGExs+0U24zSa+udYYtgByYLcZ8u/TzQieruqRB1U=; b=Bz
	FZo3V3tijg85FO0eoTD8hmtH7SN+3iYoREqiMOw71nNHgrghGCM4YAX5vqOTOU61
	AL1BeMw8d/oej+9+SS+N57R2Q3T4po8ezkG0jDWHd1niEJ2fS8GDjS+aq8Ztymhp
	f92EqWzO9z4nq4zweLePAR3LOVP7ukO0Lso9O5nWWbgxE7CSHmMMKTp0xckH+OIx
	dUYckmdwaMnNpHN0kUSn4pXeDSK1sEa52T32J4uEZQ0I5HzZEzKeRZX5q++oGbUQ
	g2ORuHiyOiSHf6RtLM6SHDQfPBdxooNRlCZhgVoZMSXXB3KPWtV920YuwFR/lFDw
	vn6GsU6mdqjqsdVuijPw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk6ee8mch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 18:26:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CIQF5T015920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 18:26:15 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 10:26:15 -0800
Message-ID: <f5c25f3f-a56b-49a9-ab47-db481ba9309e@quicinc.com>
Date: Fri, 12 Jan 2024 10:26:15 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] wifi: ath12k: Modify rts threshold mac op for
 single wiphy
Content-Language: en-US
To: Sriram R <quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-12-quic_srirrama@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111045045.28377-12-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dCSclbN3XhMReHmVTpwUNFxKg1ZMaunS
X-Proofpoint-GUID: dCSclbN3XhMReHmVTpwUNFxKg1ZMaunS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=514 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120144

On 1/10/2024 8:50 PM, Sriram R wrote:
> Since multiple radios are abstracted under a single wiphy,
> apply the rts threshold value to all the vdevs of the radios
> combined under single wiphy.
> 
> This also implies that vif specific rts threshold support
> needs to be added in future from cfg80211/mac80211.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


