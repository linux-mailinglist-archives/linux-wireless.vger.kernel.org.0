Return-Path: <linux-wireless+bounces-4046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4329886882D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 05:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB701C21CF5
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 04:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A6D4D10A;
	Tue, 27 Feb 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rz8oz4Uv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95294CDE5
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007800; cv=none; b=EbWb6WGnZGdmYEFAvc8p2evH90nNA7t+cbnWAqmI8+qgrbpa++cpkcwp+1pcRw3ub9t1P6N5Ka1tKPmoyDEv+YOzdYp4tYxwMehnHmyEr/2xSRy+nMvW3Gcv7QXmIOBFPUNGC6C5pVEijrEv03w/O4bg1evD4QiBN3bq0cVtzys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007800; c=relaxed/simple;
	bh=v4/dbbx2UoF9w1miImwfMk7kOPPzDbj33T8wb1cKwPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/U61+Zj929IO7+IxaPQDRh1VfceKG0+hPQ/h2oKkAL1v/Ov7VIJOCmcFv6hXrQ1KHuUFgVNRHNXldpvybrr3vTgUwQ15jevBHxuNpvmIH8ie/tXxpRJVNXdpkqYEWfeS3hR89MwMocZGTV2wSGJEfMVLMtF3TdWZrSUzJfzebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rz8oz4Uv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R3w0K4022880;
	Tue, 27 Feb 2024 04:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Wg9W9HT
	TwBEheZHyJO48ibUZlzHTx9kzKaLvTneW4cE=; b=Rz8oz4UvO1DnFoatcBxWTyr
	5i1sZI/AZ7QAQ90ZEIYpMhpMj8Gu3C3DkjhgFim83YWwcgEytPbDX5XLQ/k8IFc8
	JrMyFdzaydd0neFjbRgYAPeFTF2LUUj6LjdgUw7DpUHsqqNtU9dWpmkoTaluzfCj
	yOXzyAb1AELdPtY8YF6ZL7bNib/PGXk1o9DWq1e7MhB/hXUjOvqGfCdBSby0rXHn
	5obdJftZakFxYUUX5/Morb6OFuu7AlzQdXgmKIfTI31rBBwSUfsREWEDV4eDQIJf
	7tIg22jdP6/XmlDniyNYL4RianjsOf+D2V1jbIAqz15r00HeegrNlM1y9ELHVKw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh89t01te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:23:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R4NB76010937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 04:23:11 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 20:23:09 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: keys and netif indication fixes for MLD AP
Date: Tue, 27 Feb 2024 09:52:49 +0530
Message-ID: <20240227042251.1511122-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xVV9sqABDPMJU_-RiLxxPrnEsIu6aWVw
X-Proofpoint-GUID: xVV9sqABDPMJU_-RiLxxPrnEsIu6aWVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=628
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270033

ieee80211_start_ap() function and ieee80211_stop_ap() function are
handling keys and netif indication at interface level. With MLO there is
requirement to handle it at link level. Add the required changes.

Aditya Kumar Singh (1):
  wifi: mac80211: handle netif carrier up/down with link AP during MLO

Rameshkumar Sundaram (1):
  wifi: mac80211: remove only link keys during stopping link AP
---
 net/mac80211/cfg.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)


base-commit: a4634aa71fee11f5e3e13bf7d80ee1480a64ce70
-- 
2.25.1


