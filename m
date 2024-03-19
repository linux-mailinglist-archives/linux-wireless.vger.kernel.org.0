Return-Path: <linux-wireless+bounces-4904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9EA87FF05
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 14:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5360A1F21AE0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730C8060C;
	Tue, 19 Mar 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KU83rwaf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B0F80607
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855934; cv=none; b=tnhjLkD+Idk7xtPlGK41I7+6XvepYhCu6nKiiVPzZanWGVijuTAdLTiCNROUs2f8/SD77Bf32gzVzYK0AOnrseBuBXKhzAQqN845JjyAS89pExBC+000j2FKb844tKDUKGEr9VpUZgaXGfKui8exUeaJ8KxwKBui3EuR0sguZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855934; c=relaxed/simple;
	bh=0APkI9KqNHyMFRCCkWpjSwWjmns4x7uEhLYNbVhebNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V62p0zfeiq2hakahEBrpEjYLX+YLt1zrBTccvDrmcjMQjSqFfSxk96xBVydVt1rjfKiyXTQMRnOOlT0JMOHujJgQXCPz5gQg+2us2AAYUCEy4TQ8p14y0OXAGZJvoFayL8k1bF6wIyhXd/ZwNK1CDbPwhyX7ivwWM+AZagjNdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KU83rwaf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JCbZ9O005993;
	Tue, 19 Mar 2024 13:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=ZouL0q0CYDy3Ap0rdMDB
	Y+DxKyvsgs2LrhS9NVf/WWI=; b=KU83rwaf0d94wAgVihQtCm/rQ6KpFEUIGKeQ
	BTE5zsLom/Cf71ceWZ4i7qZh0KJynYVCbm8F7UtoKNw35glNceJ5B+W0ODyTQI93
	TEi+Ttw2bL09QX/wmmIhm8YMuPoqwCjbGclxH4Zqzy6O9Iw2ueDaMlxPb6NLkHXU
	SVZExgW9f2JbjLKF1/zMljb7Tj1JHDlzUHVVaWg7IF3kdMytlYKmi8CFTYXCUYBI
	TOZfZAfBrxAUMTlhsvJFUuZctTFEAeNzI1QStTNCSHzfLBI8O7tdg9x+nNkmClgu
	Sd7QiNj8mJpdkwjDkz4WnxJT1XR1PW0jmPKaUKtL1o97BDwm2A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy1j2hdem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:45:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42JDjO8B031277;
	Tue, 19 Mar 2024 13:45:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3ww4gkbeyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:45:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JDjOSH031272;
	Tue, 19 Mar 2024 13:45:24 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-haric-blr.qualcomm.com [10.131.39.39])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42JDjO99031271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 13:45:24 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 3844793)
	id 9A62041330; Tue, 19 Mar 2024 19:15:23 +0530 (+0530)
From: Hari Chandrakanthan <quic_haric@quicinc.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH v2 0/2] wifi: cfg80211/ath12k: Add support to rx retry stats
Date: Tue, 19 Mar 2024 19:15:20 +0530
Message-Id: <20240319134522.4021062-1-quic_haric@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eRE9736lPYcmT9jRN-02mN1SfaonLBQ3
X-Proofpoint-ORIG-GUID: eRE9736lPYcmT9jRN-02mN1SfaonLBQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=550 spamscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190105

This patch series adds support to count station level rx retries.

wifi: cfg80211/mac80211: Add support to rx retry stats
wifi: ath12k: Add support to rx retry stats

Tested-on: QCN9274 hw1.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1

Hari Chandrakanthan (2):
  wifi: cfg80211/mac80211: Add support to rx retry stats
  wifi: ath12k: Add support to rx retry stats

 drivers/net/wireless/ath/ath12k/core.h   | 1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 8 ++++++++
 drivers/net/wireless/ath/ath12k/hal_rx.h | 7 ++++++-
 drivers/net/wireless/ath/ath12k/mac.c    | 3 +++
 include/net/cfg80211.h                   | 2 ++
 include/uapi/linux/nl80211.h             | 3 +++
 net/mac80211/rx.c                        | 6 ++++++
 net/mac80211/sta_info.c                  | 5 +++++
 net/mac80211/sta_info.h                  | 1 +
 net/wireless/nl80211.c                   | 1 +
 10 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.34.1


