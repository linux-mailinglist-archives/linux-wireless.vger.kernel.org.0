Return-Path: <linux-wireless+bounces-6683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F328AD386
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF2286B28
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE3152197;
	Mon, 22 Apr 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RQ0INPJb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96190154427
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808315; cv=none; b=Cmm+zzwdCBjWxl/1msrOFZwWZ5rSw2PdK8zenkP7516P3YODL/nhzWUD31rSIyfWL7zNPpg8/Vnei0H1eo3eLBO0uLV8MSaXk7Y4rqJd7ErTb8zl90oNNc6mj3gzzEWVNHDg6ebE2nHcWaCFhADHKlGyzgAo+5LvHYP+gLpiNWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808315; c=relaxed/simple;
	bh=s3YoHtcbD9ufe7/WYndISw6UIipvD+OSlfQ9aErGsW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e3LkZwwS6ITTpcG9UC85uxutmgBVoRlpMPd+A2GNNa+0jXMiLpyOAeY6EiNOwpVmsLwuU4r00V30HiItT8qaJEd9+W866vJ3DqpOuk/AC5jFYrcXtoofWiDAYyKDXS2CrUJG/wp/7jbMHCCZ6wwKrgFSuGOEMTl8O6i1W2wMJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RQ0INPJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MDfMEB024401;
	Mon, 22 Apr 2024 17:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PkSYpnfgXd74FfwLXA9VkOCH5tkB//12GChwCN3/pNE=; b=RQ
	0INPJbOgDiUc4qzGCWBUMNPWWKCEj1mgJnCTlof9kBUStrMBknSDzN5vS0R/511v
	k4nR5fQ/JXt/ttUvazcnP3NaX5QCIOn8FyDI27pRKnlm2N43FbD0m3sBGNLaljr1
	XjWVBKGlUKCWyIUZAh1dvurEmeP5mca8ieEuasD623K0UH5E8Ptzeram84Em2h0G
	qN6HCK7F+DIBVWSFy8U8oLdVwN2QLSeRw4c11ZoNUNh1yMbMIz+DMs3nKOukyGSK
	vrDi6Zi5PW4uJ9FQ4P6pChX8dIxBfWvTeJNFF8AAJsUVzVMtzY4e33PRDlgfC1Wr
	mQfXvziU0vVEBemU9V1g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5sx56u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:51:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHpnPA011900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:51:49 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:51:49 -0700
Message-ID: <6e4940c8-4962-428d-ba46-a341ce208502@quicinc.com>
Date: Mon, 22 Apr 2024 10:51:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] wifi: ath12k: do not dump SRNG statistics during
 resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sfdy5egdbuKB3SFCODME87bscgA6xJwt
X-Proofpoint-GUID: sfdy5egdbuKB3SFCODME87bscgA6xJwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=678 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> Both the firmware reset feature and the power management
> suspend/resume feature share common power-down and power-up
> functionality. One aspect of the power-up functionality is
> the handling of the ATH12K_QMI_EVENT_FW_INIT_DONE event.
> When this event is received, a call is made to
> ath12k_hal_dump_srng_stats(), with the purpose to collect
> information that may be useful in debugging the cause of a
> firmware reset.
> 
> Unfortunately, since this functionality is shared between
> both the firmware reset path and the power management
> resume path, the kernel log is flooded with messages during
> resume. Since these messages are not useful during resume,
> and in fact can be confusing and can increase the time it
> takes to resume, update the logic to only call
> ath12k_hal_dump_srng_stats() during firmware reset.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


