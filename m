Return-Path: <linux-wireless+bounces-8777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F82902EEC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 05:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C511F22A44
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 03:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D616F8E0;
	Tue, 11 Jun 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MuB6A/O1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0C16F914
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075458; cv=none; b=mrRdHHrpQ95zSbTiHtvIYpTj9J2AH2T2xWBOuitazfsLm1lk1RjCdX6NDhPKIPZP75mBsT/0o51jIvUmLI166rOT+aktpe03z00dbtf95QUHuKTXIAMy5KSNvepSbwWoanpbKJNy1JTCwqeO2Zeb5VLV+k91QDbqEbEH5K1mGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075458; c=relaxed/simple;
	bh=UNAN3rhffugfFSHJyzZ9LQi1Y4e7v4nL1o7cbxfWxh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmUmUbyUEhgP8BK2rrrFgD3V6kPW+ZSewvurO2pSCN3DQka/acISB6neM7xkoiEp2HitcGohtInP5Wluyq/UpeeeMwJ1A+1edjN5yokTeP/KOt5yjZO/u/vt4iwz6mMCfU4jUFd2uL1YLKRZBilf+SPn8xzsKGyuAh0fvAfThuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MuB6A/O1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B2wjHY008531;
	Tue, 11 Jun 2024 03:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ECIsG8AncEKWI7bypJ/0x0
	Kywyt4sB2Jj9/dj5Ywd4w=; b=MuB6A/O1YArrm4bZmALro1B70vpXtRjGXDtot5
	31xDn6qNbVq57oyoJmk+/L1dMkEc5bIDIyNbquCec/lwQa8lN+J+sFZa5ZVUrb0b
	wGGbs76Gx3zDuPFcoFxtg8MOI/pn9DLCJfIV8YtiqSyaoQ2sxDDtLfG4pablWeO1
	JMKSIsU/EtkpKBhvg1AV7jHqs8ldMxvvpamENxUjd3UIhfgz2VP1YBpaT0Iu6mqU
	rS4VFD1KdtlXahKWC4b2wBTIqpLYWzSMTjlA42x69VF9ClzexLziMDvdMEsD6Now
	JRs5ejAk6JRd7RUKGWbBfA5Ag7aVcBql9LaGPs2lrVWI7geA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ype9100jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 03:10:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B3AZ4S013729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 03:10:35 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Jun 2024 20:10:34 -0700
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH 0/2] wifi: ath12k: Fix the smatch error
Date: Tue, 11 Jun 2024 08:40:15 +0530
Message-ID: <20240611031017.297927-1-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nRak0mx027rWXt5hmCij8Tf5ydB7sPIa
X-Proofpoint-ORIG-GUID: nRak0mx027rWXt5hmCij8Tf5ydB7sPIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_08,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=592 impostorscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406110024

This patch series fix the Smatch error in
ath12k_mac_op_get_survey() and ath12k_peer_assoc_h_he().

Aaradhana Sahu (2):
  wifi: ath12k: fix NULL pointer access in ath12k_mac_op_get_survey()
  wifi: ath12k: fix uninitialize symbol error on
    ath12k_peer_assoc_h_he()

 drivers/net/wireless/ath/ath12k/mac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)


base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
-- 
2.34.1


