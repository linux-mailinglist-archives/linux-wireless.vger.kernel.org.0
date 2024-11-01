Return-Path: <linux-wireless+bounces-14831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F949B959F
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC495281C59
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032801386BF;
	Fri,  1 Nov 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FilEEs1E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C5145FE0
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479195; cv=none; b=ZG2C1dBCtocUiUdvm7dVsyVkx4CV1cJYSP6BhAdoKPzaCQ6AEFSC6X6TABuDs3pCyskk2V71eGM/5NUllbDCUO75GnOmJgLozYvW1nh3UroR7bpAnHqw0XNU/aOhFAlS6PuwuPqPngPfPMwmOlpAGufbYOCAfteAoEjc1/MjhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479195; c=relaxed/simple;
	bh=spDgPyX5RBQAjjhlZJz7NORZmMn5Mj8pfVMG48MBc3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M0WT6J1ugPCD8QA0rHyi6vhA5xBuDAyFfAB1XWpnt/Vfc6xhYecK5dGup6sVhwMMyI2WLM5DDUJkRJZfAP6RHbp83C9IFhSPV3cNelv0dz2YgpTXjgnkeKyalTD+3NetrQE7GyYWX0kJTdKQrTZdXUrAITJZpGqCe3RfaAjWW/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FilEEs1E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1GFONG031375;
	Fri, 1 Nov 2024 16:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kNnlK8GEryd/58oOokBErJFsiUzSHPBZ3TbnG8tXiZI=; b=FilEEs1EsmBQJyoM
	86M0SwSoe0sIBvCLN57B2tUE6uMoDHopYQADflTel0oPVW0uUnyd6jlKhLd56PZN
	ndMOukOjtGyDfi5BmsaTpHNUjtlz1sugARTb9MP3lymcsJ7EiqFSe/AdGwQtBhMk
	n5nCCo+JREtVIiu6WkD6Iu3XsRFAJQrok8U2Wg+aCzpIOJmx2VzhS40Kt+yw4MPN
	nL/TSiZhl1yX3DB56mgzwxciK3r0S7e+VgzEJkZxcAvkthvA415ci+m1Qz7sBiMk
	VTW9+nhJrIlOlhNmJh+0/qYG5uw7vuqf6wZZjYJpZKbapT7dZGLnZMglH0ot6+z7
	YEbVHA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42mtxw1msn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 16:39:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1GdnMe000606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 16:39:49 GMT
Received: from [10.48.242.225] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 1 Nov 2024
 09:39:49 -0700
Message-ID: <84824b6f-5429-4ddc-9037-a320325ec653@quicinc.com>
Date: Fri, 1 Nov 2024 09:39:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] wifi: ath12k: Add helpers for multi link peer
 creation and deletion
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241101151705.165987-1-kvalo@kernel.org>
 <20241101151705.165987-6-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241101151705.165987-6-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AkDRmpBYXK-i7_qcvfORLkFaWLRlqwxn
X-Proofpoint-ORIG-GUID: AkDRmpBYXK-i7_qcvfORLkFaWLRlqwxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=649 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411010121

On 11/1/2024 8:17 AM, Kalle Valo wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> Add helper functions for multi link peer addition and deletion. And add address
> validation to ensure we are not creating link peers (belonging to different
> clients) with same MLD address. To aid in this validation for faster lookup,
> add a new list of ML peers to struct ath12k_hw::ml_peers and use the same for
> parsing for the above address validation use cases.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


