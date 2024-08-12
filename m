Return-Path: <linux-wireless+bounces-11326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF694F980
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 00:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5941F230CF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B218953F;
	Mon, 12 Aug 2024 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K+8cdcE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B2198A03
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501057; cv=none; b=iRb49kTbV/i2tUg5i5Bo6fE5XUESlgalFoH7QhMAJ/95raMS1G42+DtIDUKd/a0dEahARE2/v9sxHODcUrke9TSODJu5P3vKINxzGsrkCpvygicHF2wCCvk8aS0FvwzXH7UroBTWc3QQKmVdzmku21YvrUyIC5LA/7v34tcxCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501057; c=relaxed/simple;
	bh=vLy1R2A6sN+r2Yub5aN8807w25cQ6gCAbwICFB31Tns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B08MrSaveQijyaSi5vUAyYF1gyoj/1Hei5X5ELGRfyFfz3SwK5QaKRFixlwpOC/PPwXCSjroJ+YgNMbXVih+PGsfe0qpI1RAlEvtcSGNNvTzPyi/LrjYfmNb3SHvrp7s27WLZFAxj9LX1O+IMlokFJUXZNefIWJvZvKIQLfP98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K+8cdcE+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSWHl015866;
	Mon, 12 Aug 2024 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2tIQ0JAED2gtRsBzo8WoYCk+yYNckei+8xlTHO9Pxcs=; b=K+8cdcE+91CXFkbR
	DYdWxal7EmA1//77MUQ2jDgyLZqEgThI2TIMWEeZRkcS4Yj4fKiph9kZ4YZ+JMBw
	6AJgJz7yqDzfaZEqHd7X2psoFXEdUY149/NklanRzObUpQoSuoh33VwZ/Q3bdzfX
	PYSqyJU5uv0Jhew4XDus0JhR/RROF7RUPBUbCPyUw3Ro1CjkYsGuiuVbxag47khv
	z7rUpgULN0jNu8PMYmIgu5ctZgsjZZkW7A9Wg3A5jyq7/fCSc/y8Hae6iD3PKGpN
	i4H8f8Fv56PIBkNcK9nWCd9q8vWNiet4W8y7SGHdz51aQNAYY5zQCVl14SZXhMwI
	+pbzpA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x1chnfx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 22:17:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47CMHU6k030478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 22:17:30 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 15:17:30 -0700
Message-ID: <a8b3e9ed-20ef-4536-b56d-f8ae89dd53d0@quicinc.com>
Date: Mon, 12 Aug 2024 15:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix the stack frame size warning in
 ath12k_mac_op_hw_scan
To: Miaoqing Pan <quic_miaoqing@quicinc.com>, <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240809015841.2671448-1-quic_miaoqing@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240809015841.2671448-1-quic_miaoqing@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5sNwWYuWvzQCy_jH0_mf33T8VKzeqFmp
X-Proofpoint-ORIG-GUID: 5sNwWYuWvzQCy_jH0_mf33T8VKzeqFmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=654 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120163

On 8/8/2024 6:58 PM, Miaoqing Pan wrote:
> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath12k/mac.c: In function ‘ath12k_mac_op_hw_scan’:
> drivers/net/wireless/ath/ath12k/mac.c:3806:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



