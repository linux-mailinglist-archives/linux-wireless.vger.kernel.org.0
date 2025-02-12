Return-Path: <linux-wireless+bounces-18839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA74DA324B0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 12:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604743A15F6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FD51F2365;
	Wed, 12 Feb 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irJfFyST"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D31B21AD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359170; cv=none; b=sz7BmTdVECspDaea9/MhpUL8P8IUFXM6H+2D8tGaExtSgH4zd7MaQ74+zwI0S7hXc++45I/KwZYpYSdwAAs1upM/IccbCuaj3N0Kub8Owot0I027l4tjpSP/t9aror1wDYmNxrTzF93cwEgwFRlMCVcuq4h5N3PlPjIc5mjqm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359170; c=relaxed/simple;
	bh=qm+JiC8dkF8hU/UNFfKCapfcove6PJcIWKVVG7kovJw=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:In-Reply-To:
	 Message-ID:Date; b=C5E+saHO0Kt7QA6hPOqPuMN0GvQXr2fy5DexE9FQKe5azaITU5VAji61AypRcmKDZ/Fx+hD0sVMJvX100dt5eUayY7M9RFkKUdTLii7Be2PLIWtOMbU0wTacDHzGJd0vGXruPefkuEW9Iz2rHhIJNKitorxu5o9zTwvgeXJmbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irJfFyST; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CAmi2P011665;
	Wed, 12 Feb 2025 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:subject:to; s=qcppdkim1; bh=UoR3IOvD4H/
	L0pB5U7reZrodqFkzHr3+pdOLxK7N4EA=; b=irJfFySTkM+Zs5aqiaA7ly4DYkh
	qh2cp5xVRYklvE/H9PDbhgA2ooEQBIcYp7WlP7KPlyQZNsA7Zsav7GodrHEoF6AK
	LXK5Vot0nyUlQF/q2HsTBoFmIspeZJ1AKzsoJsY1dxu4u7csi1F//n12+TCcThH+
	pIlvsNjx0H/Dd/cG5FAj/5NNudBKVFDYzvkZUutO50xYLiqOHwL69Gb25dY2e5aa
	gKs7rSKh2i00xTw4K9XEn83ixQdKF8CVxeu+KoDxYmOwRwdgOX26RtOSjeSKI0lg
	Zc+vFecUBd0Yt2dL0tw6hI9E77ubKbNjC4otODYw4V6umirlMXo5GDZAaPw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxv3vpkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:19:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51CBJP0g004255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:19:25 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 03:19:23 -0800
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: <ath_bot_tesseract@quicinc.com>
To: <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v10 2/4] wifi: ath12k: add 11d scan offload support
In-Reply-To: <20250212063200.1631-3-quic_kangyang@quicinc.com>
Message-ID: <821ed7c9-c814-4109-9b07-41b77b2bb275@nalasex01c.na.qualcomm.com>
Date: Wed, 12 Feb 2025 03:19:23 -0800
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kR6ihQ00HJKxqOmB0xS-9Q6mqvAWDeyC
X-Proofpoint-ORIG-GUID: kR6ihQ00HJKxqOmB0xS-9Q6mqvAWDeyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=547
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120086

Hi Kang Yang,

A total of 1 issue(s) found in this patch. Please see below report -

Error 0: INADVISABLE_WORD_USAGE
Prefer 'firmware' over 'fw'.


- Tesseract
-- 
Deet-doot-dot, I'm a bot.

This report is generated by a bot. It may contain errors. User discretion advised.
Powered by KITE.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
http://go/ath10k
http://go/ath11k
http://go/ath12k

