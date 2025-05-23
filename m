Return-Path: <linux-wireless+bounces-23335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FCDAC1ACA
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 05:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB78016BAE4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 03:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8B22257B;
	Fri, 23 May 2025 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J+8sT9vX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954971EFFAC;
	Fri, 23 May 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972168; cv=none; b=ZKbzhiR3Job0XtDT4ChHKthbCuE01NXp8Xi3c64r+FYzrLSg7G9Zt0o7xsqQLNtg6Mu6Zps1eZdSEWXrFwtwDuiayuRrI2kSYzPXE2Iv4GuSP2Ntb45uuYv//qTSP/HMxFF3lT8NstZ7FoutzDs261yzqpBWpn0lGRSbharcea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972168; c=relaxed/simple;
	bh=gEhL2PFoGAbPbUD4GLQo2+XP1XItvctZPrcd+w2uB6w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=J3kk3jvwjwjuaqsEmnGc3jwW1b51C4w3CxEhivENa82EgoEM16ykW32M8dKVPi+iZ9bycVqttljdTbdx7iDWI0QDbFQOoMGGNuqSLRZjpGFZM1FFa+idAFuKWbOM5D76pVPdqhWPpPJmgMwy5JJElvIAPoBeHzDdob/QKzGITT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J+8sT9vX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHWmt4000836;
	Fri, 23 May 2025 03:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OfeUh3XK3R9ZHXa3B1r4fW
	EB94jyHEkaJCKDeK6h0gA=; b=J+8sT9vXjL60AADivQxwsGF6Nyb8s1q4hTevEY
	qp+w0EEKlNOw4c2HE88FYhAZB/p/ptnedOdlQrZsDr/wb3ZcKwCP7V15t3UffY3e
	AGwhz1Csa8IO8iBAY7TEaZjfQ2/ulo5a+OgWjEcCZ8z1g8rzR6ipcpjb5kvcGNki
	h9Ay3M1Jy1zWKngpjnO2cAYjh5Y8NBdeEigxRZdoTPqwfgSjv99a1xJNnCUVsS6P
	xuXQl3f4NtNMCQUwJs0TvWfC+SZgIZR4w6IS8WVIaR6OXo/P/1rkocUr9lhepu2x
	Im8LVeFYdvKif6W1LIjurC3QiMvcJUczgcwMks7oGSrtKkUQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf70bqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 03:49:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54N3nIcd016066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 03:49:18 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 20:49:16 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: install pairwise key first
Date: Fri, 23 May 2025 11:49:00 +0800
Message-ID: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzwL2gC/4WNQQ6CMBBFr0Jm7Zh2oCKuvIdhgWWQCbFoWwiEc
 HcbLuDu/7z89zcI7IUD3LINPM8SZHSp6FMGtm/ci1Ha1IEUGVUQYRN7TQNOTmwTIg68Yic+pcp
 yce3KqnxqA2n+8dzJcqgfkFboeIlQJ9JLiKNfj885P/h//ZyjQqVbqvhCrTH6/p3EirNnO76h3
 vf9B/9vYkvMAAAA
X-Change-ID: 20250422-ath12k-unicast-key-first-9ce48f797b15
To: Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xjZU0ygqEljs5k0EB-YfKlfYi-pvRECH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAzMyBTYWx0ZWRfX+IB2gTbEz8ir
 u0cthQh1ri0G/y2c4Q2sSP5JCvuj5paSRtu37kt5gp6BCUGvDmbIv2qBWHfH9UArNxDeA4U8Mx1
 /zMWOs4r7oKuMou08R2iqLi8JVPTYh8dejClhQjC7V6ShwClqdwLILJhUacgnmEkTHlhoMe1LFh
 LhvJxdT/fDuslTY19eukuS9ygbPn5RgJzvz+IiBUL99KxdvtnXz63m0QsVIEYuyEvAg9EvaZuat
 8DP1v2taZOOkRRo9SA+l03spyW33tt03HoY2hIcnDLItkwwn70v3/YP4HPw/vSwcP6n3neMsmhp
 EoGyI+PmrKuR58Xkb99Jm+JAHBdbPlaA5OMHZMKMSbtPLWpa3j0pTr0AQNSLjeWhkeDd5V3jhJ3
 I22EuBqyyUBI6QbW1cCXlyXThHRbvRq+XRjZwWqAsRP1Ce/kdPVff1PUBLB/UiHon+xhRP4L
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682ff03f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=COk6AnOGAAAA:8 a=IPQRWuV9YlEYq9QDH4wA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xjZU0ygqEljs5k0EB-YfKlfYi-pvRECH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=724
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230033

We got report that WCN7850 is not working with IWD [1][2]. Debug
shows the reason is that IWD installs group key before pairwise
key, which goes against WCN7850's firmware.

Reorder key install to workaround this.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218733
[2] https://lore.kernel.org/all/AS8P190MB12051DDBD84CD88E71C40AD7873F2@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
---
Baochen Qiang (2):
      wifi: ath12k: avoid bit operation on key flags
      wifi: ath12k: install pairwise key first

 drivers/net/wireless/ath/ath12k/core.h |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 80 ++++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.h  |  1 +
 3 files changed, 76 insertions(+), 9 deletions(-)
---
base-commit: 3d933084a072fd5fb5da54c06a017abc0412c86f
change-id: 20250422-ath12k-unicast-key-first-9ce48f797b15

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


