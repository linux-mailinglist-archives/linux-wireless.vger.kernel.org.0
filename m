Return-Path: <linux-wireless+bounces-18840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF81A324B1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 12:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5755165FA3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D811F2365;
	Wed, 12 Feb 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MSzLRe81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FE1B21AD
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359175; cv=none; b=WuZi84GTL3ulZeHEl5pEhHwBgcRbF8MlI2EzYIkj/DA56QqvZ0PI+JcfoQ97sh+I6963ApeneWdzim6NE8SjM7Sjl90MkGwCmqopM9VYssbP0jSYmMrPr2ilP+cBC8/Yr+sqB8adNz+KnglB8MwSo318zw/GUVi4ToGIXDgAtFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359175; c=relaxed/simple;
	bh=qm+JiC8dkF8hU/UNFfKCapfcove6PJcIWKVVG7kovJw=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:In-Reply-To:
	 Message-ID:Date; b=VH+yZCpgPJCoODItlAnJ9/DwXWdoJqr2DAAwts8rpziYuCqu8P8QGBSXnuVfZDWgw3tOqA86iFMDnEBapccQ6U+8uNxYZ+/GMppfF+ppAen/+OulW07E3nrRzttx12z0YEOx/QR7XtI9PSCSYwyO+1ZNubMCSJO7PIQVAAG1YAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MSzLRe81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C95PYa026413;
	Wed, 12 Feb 2025 11:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:subject:to; s=qcppdkim1; bh=UoR3IOvD4H/
	L0pB5U7reZrodqFkzHr3+pdOLxK7N4EA=; b=MSzLRe81pvP04mIVKx6u/Hn7PMe
	Tx5deO5eT6GxQnanIVYln5LQ20OUOqlNZRNVW+Zeq4pJ0pifDxSG7zu70W4CAjmm
	FBBzev4VurV/YQS+M0nv8FyCbyGZUKJ/Z8Bcmvk+Dvh5K84OhL3RFztymS4z5Fvz
	BDlSoPBBuQRNflwMnq9wRvMoVcW4imSmrUfbZEKV/HTCK/UDMG3haaYOggzemehx
	dw+T9PCovMzPxOwzb5oCLF1FlUs53cDMrOrHwVcoVZRBE+AXfWWezcSSEk7aYoPd
	ZC3XtcnuvOLEEhKj7I9w+GyttD+xx9S2UIpQ+dUAGw7HTRqUikaX4hycuHA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j5bhg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:19:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51CBJTJ0004318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:19:29 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Feb 2025 03:19:27 -0800
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
Subject: Re: [PATCH v10 3/4] wifi: ath12k: use correct WMI command to set country code for WCN7850
In-Reply-To: <20250212063200.1631-4-quic_kangyang@quicinc.com>
Message-ID: <051390c4-0da2-488b-82ae-61fca543b4ee@nalasex01c.na.qualcomm.com>
Date: Wed, 12 Feb 2025 03:19:27 -0800
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _XAK54e0QmXoLhr62m20Wzlfn3ioSqnF
X-Proofpoint-GUID: _XAK54e0QmXoLhr62m20Wzlfn3ioSqnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=514 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120087

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

