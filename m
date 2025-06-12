Return-Path: <linux-wireless+bounces-24021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB5AD6521
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978091899B4D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B487DA7F;
	Thu, 12 Jun 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mus47qp7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926C502BE;
	Thu, 12 Jun 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691931; cv=none; b=Ieud0pOl8UwGgOzBPfRhXghQf1w790kBx0UVeMIW96vZp8M23N3KxHK77HmJI6Njbpm+wWBqkijlXeYzWbDrhCx1mvRhikHYFKR9yQIdAIo0iwkjcn7H0o0B5NItBJzG4usSJcIwYqTgIitxVJoEoBMWxYFo920Y8Ix/2i8Ck0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691931; c=relaxed/simple;
	bh=25BHAme0V0/6fwV8v7wf0NFqSAC6drcFzk8SkFALOuA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=L5uDOdPS1uZ43F/SrSZ+xVboQft5bgNSxfh55h68jtovZ+M3MI85rqnwXyC6SUIy315blFFO3JJcZ7yypQrr2iI4to8aCRVh5sW+HwWLIz5wMm1fApiSoNX5vZXfJEpCpsGBj6ehtIed+00F9MIqFe1JSvZgp21M4KYyRHXsIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mus47qp7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BJ0tYL027235;
	Thu, 12 Jun 2025 01:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2Ti9jWP13gHxXgYiLxvPYY
	X73Cvo+ynbHIVu9ujckXQ=; b=Mus47qp7abMP+BhBVit+nZniqHgqj3MvBT8iYb
	IVyqct93Xcj9howebVQDajQGhVog+f9gDfdKVBWz/wCgWTiq28GXA5B+ahZEG7nN
	KTdQH7ylnYPys5200l4Pq0aexuWPVjZ7+NJ0MLEIcPoKq0Sg74m/E1BNE1Min++O
	Bw+mpR5qxAvwuvxlRJBJKVspiWOe9eTk2AWXYvzHfkJeBdf93MNHELKlrhflKJWo
	Ti9gCce6EiI6plftcOeHIEfRtVIqWRY8aEho/ZZI3ZhFP/RzJllNDmsYmoxZTHqQ
	hqcPoGDoONahwudpI8GNsVAyeA4riZIVafj4OU55XRdr1pHg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476jrhdtc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C1W1H7016131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:01 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 18:31:59 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-current 0/4] wifi: ath12k: fixes to firmware stats
Date: Thu, 12 Jun 2025 09:31:48 +0800
Message-ID: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQuSmgC/4WPy07DMBBFfyXymqlsJ5k8hFD/A7Fw0gmxIA71O
 AFU5d9x3C7KArEZaV733HsRTN4Siza7CE+rZTu72KiHTPSjca8E9hR7oaUuJSoFJoxKv8HwCYP
 9IoaamirHSioslYhfH57SIj49i3gM/eI9uSBerktP5yVSwu1iImaTKG32eIXI5g7CwQSG0+wIV
 gUKdJejLrBEbKrjzHw4L+a9n6fpEMvTbqAzTLBPbGizOwNwU6+Tk9FymP13yr2qZOXPiBEswdR
 505RDgQPiMUboret3ZlJb9T8KOiooGrArsKpLKX8rbNv2A0F7rmGJAQAA
X-Change-ID: 20250611-ath12k-fw-fixes-8e9736701651
To: Jeff Johnson <jjohnson@kernel.org>,
        Ramya Gnanasekar
	<ramya.gnanasekar@oss.qualcomm.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>, g
	<gregoire.s93@live.fr>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EovSrTcA c=1 sm=1 tr=0 ts=684a2e12 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WBYhJntNMX0R2oXoKHEA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: g-ebaOzTeTPWBEfcLr4SfgQAm7Idwn3_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAxMCBTYWx0ZWRfX1vpGH1aTzm56
 arIPKGN0H6TBTOG+NwDGKR9v38EzX/bxip/GMEEc4YrpVQkhpmEdyzmaQR859xAlAMBuWzQTMOa
 RSdcqT+HohrHSXyH78JMQEtE/TCrZmAsK4uX+QcXPEuq0QglA0YtmtBc5zEFi/Nk/dZxfhrqScV
 dcWeniFxXTecIjm3pm+BI8IFxRA0VxMsWKi6v/GZLW+iN7gDgidMwMIgbAPoCvEdEP/hex3QVOC
 kPXkjjucDODz8mYvC4nZ3ofUbMhJ2dL/l8bZ+IWfdOwg0S5fqUNwHDsoR8Sy6CMWtWjMDmYiLlE
 6FsRTtGx4d+kwpVHMH2A+i10o9SwAoFjkK1F5qXkHFBkpan81xxhL4XZp/wf/5EAKmRUpOVgCMG
 F0R4a72ZGspn6wHr1GJTKPDljoQDhlRNiYDv7/PWcQUtGQHCI7FmCIqfSzxOMEorii8da/n4
X-Proofpoint-GUID: g-ebaOzTeTPWBEfcLr4SfgQAm7Idwn3_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=532
 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120010

We get report [1] that CPU is running in hot loop while requesting
firmware stats, fix it in patch [2/4]. While at it, fix documentation
on back-to-back firmware stats events in patch [1/4], and fix potential
failures due to static variables in patch [3/4]. patch [4/4] fix the
failure when there is no vdev started.

[1] https://lore.kernel.org/ath12k/AS8P190MB120575BBB25FCE697CD7D4988763A@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM/

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
Baochen Qiang (4):
      wifi: ath12k: fix documentation on firmware stats
      wifi: ath12k: avoid burning CPU while waiting for firmware stats
      wifi: ath12k: don't use static variables in ath12k_wmi_fw_stats_process()
      wifi: ath12k: don't wait when there is no vdev started

 drivers/net/wireless/ath/ath12k/core.c |  4 +++-
 drivers/net/wireless/ath/ath12k/core.h |  4 +++-
 drivers/net/wireless/ath/ath12k/mac.c  | 30 +++++++++---------------------
 drivers/net/wireless/ath/ath12k/wmi.c  | 27 ++++++++++++++-------------
 4 files changed, 29 insertions(+), 36 deletions(-)
---
base-commit: 4e89e05afa9fff6e68ec25ba1f21e711d91dcfeb
change-id: 20250611-ath12k-fw-fixes-8e9736701651
prerequisite-message-id: <20250609-ath12k-fw-stats-done-v1-1-2b3624656697@oss.qualcomm.com>
prerequisite-patch-id: 4b16b879aa24110d163279b32576789fa7383913

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


