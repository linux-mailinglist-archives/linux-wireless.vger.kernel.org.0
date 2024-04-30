Return-Path: <linux-wireless+bounces-7017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA68B67BA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 03:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47F61F23916
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB66E211C;
	Tue, 30 Apr 2024 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VcGTwznZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3549A2107
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442164; cv=none; b=gX25O8f3c83jXnqShHTQT3mGWaH+AeHykvWEoyGooUtFTb+j4sJnAc5bHIEC4Q29FgM1QW+kmwf75PryJd4WbcWhmrGNpOn9uCNoVGzduirh293LVEGL1i3yDbng9khUsrQFqrV9joZKt2JiZSz/4eY+PQoEYG5wK+gnQXatmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442164; c=relaxed/simple;
	bh=ZpsjBwqvwKbrrby/ZAlyQFIhgTPCtstlLy+oDfsv+1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kSXYPZSian5SpgBAcYmRe6JuWpQQxQ5olix2BEuz64rNWiEATO91wioOurPOmFZNTl3OuguDhOntTWGlkQHv4NlByxYwKk44/PAkoh7rkZ+CODQ56foE6R3uNJNWuroaVzVt+acpO05L9NfWsSF8z3tKspUmKOQTKFn3qWKT1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VcGTwznZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TNjIMp026547;
	Tue, 30 Apr 2024 01:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OQz0jT858WbxozOFH647yHa4dxYo5PopzxQP2OLzJC4=; b=Vc
	GTwznZI5an5+VnSsx6N8vqBX27H7hpZr9pvGeXRrvvTaBxIStK3nve3ys0gwDzTD
	nyxlw0rqSa6gnRCxFILMNLAcgmOTxITD378riHqc5EjE7uz/dSEPM3nC16ik0vUM
	s85Y+R28VntP1nVB8nNXdjLGl8FgWrYDK+neyXmjzMW3uL9xCF2Bz08Y9g7QgtJJ
	RsMv6HdzTOAsZo5hWpPjN9AWAUyaxkxGM6h7KRiMKnncGt7GqtXocJ+VEovkfdHP
	cssouSMmCd9aj+Hm6OswlTwjlDofVEILqdaqpW5GNc/8UdTF4K3skdj9QlDoWw0p
	m2COmJ9BI7qtrTmnTGWQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvsb8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:55:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U1twjc010325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:55:58 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 18:55:57 -0700
Message-ID: <de3e77c6-53af-44c2-97dc-8b9b61eb86ae@quicinc.com>
Date: Mon, 29 Apr 2024 18:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: ath12k: remove invalid peer create logic
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429081525.983-1-quic_kangyang@quicinc.com>
 <20240429081525.983-6-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429081525.983-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BUGroUby09bo8Y94X7i-5dlKFNeZl7rv
X-Proofpoint-GUID: BUGroUby09bo8Y94X7i-5dlKFNeZl7rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=910 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300013

On 4/29/2024 1:15 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> In ath12k_mac_op_assign_vif_chanctx(), there is a logic to
> create peer using ar->mac_addr for a STA vdev. This is invalid
> because a STA vdev should have a peer created using AP's
> MAC address. Besides, if we run into that logic, it means a peer
> has already been created earlier, we should not create it again.
> So remove it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


