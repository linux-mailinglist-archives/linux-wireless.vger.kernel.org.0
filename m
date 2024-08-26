Return-Path: <linux-wireless+bounces-11923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F695E675
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0271C20A02
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296E881E;
	Mon, 26 Aug 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T/+5yZxB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280F4A33
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724637017; cv=none; b=hxajhkIfc53XqsNdNG5K7oYk6++/LO7qLTI0OVxaa/vQ3P5CHAY7ppKtmzYDbmYFGF1Jle9s/AX96AcaS8bFpEN30gv+U75XU1PfZ1MEqc/KdQmNwcDuINCOeUnTEKo7sbdB9krPtzfeS78yqyYAJsRZ7xfjctKXXuygJAENUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724637017; c=relaxed/simple;
	bh=8fqYhkQjUsyQMZen3ikoLUpkzohYqAPUyNPQqmPKqi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjobuy/NuELl0x6ERV+Nc6RnLOSpZM0tZ9UZ4NvtGb78FjalwSgRc1e4HD0GjXDmHT/IrQUq+rj4Gg1tfkR17rKiq1syIgqB9pT2CqSnoZU30mJ9lbpPtkNTc5mr365kdmP9rd80/4JQk/+y/jGI1hTA0hc9Z1UTYG4lDel+9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T/+5yZxB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PNKPTK028932;
	Mon, 26 Aug 2024 01:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5XnTu9WHctTVDM9Hsq5utV513c/jZ+IWuBCLoKB+CE=; b=T/+5yZxBOPUqQDN7
	bSr5FJ70vqn2mgE3xsFdwUOtwUpyAVcf4wVGKftIDtZEuzqRVNx/bIDX3r/wOuYj
	vCcvAZDeuFsoHeFEna5KpGUMp94pYXnny6TiCTnjFA2zHGhX9EKik3lFUx160AA3
	8qorXbOXZ6ZTbKJdGDjTVa9aMeV48aZYuT+yYczE/2IimWOR0TPeH1SqHk5KjHHo
	elNcOvSAiiOZMrwQfstLUSwKB4764pXoQzyI5Pt8XyCJInBTlqrsSXpn/DHSMkH3
	SRNHsiYYdKd45DqLPsMTO+3jbzn8NFFqQlY+yoJKR0YSBJC30gL+cQuNt6GJ0Ecf
	i6qfFw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417976t645-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 01:50:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47Q1o4PR018690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 01:50:04 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 25 Aug
 2024 18:50:02 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 1/3] wifi: ath11k: refactor ath11k_dp_peer_cleanup()
Date: Mon, 26 Aug 2024 09:49:40 +0800
Message-ID: <20240826014942.87783-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826014942.87783-1-quic_bqiang@quicinc.com>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8wBh7Z_CCgyluAcsUFxjjUNUTSam2v9j
X-Proofpoint-GUID: 8wBh7Z_CCgyluAcsUFxjjUNUTSam2v9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_20,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260012

Currently ath11k_dp_peer_cleanup() acquires ab->base_lock inside itself. This is
working because it is only called in below context where that lock is not held:

	ath11k_mac_op_sta_state() --> ath11k_mac_station_remove()

In a upcoming patch that fixes memory leak in reset scenario, we need to do the
same job as ath11k_dp_peer_cleanup(). However ab->base_lock is already held there
so we can not directly call it.

So the decision is to move lock/unlock outside of ath11k_dp_peer_cleanup() such
that we won't get deadlock in a context where the lock is already held. In order
to make sure it is called with lock held, add LOCKDEP assertion there.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp.c  | 5 ++---
 drivers/net/wireless/ath/ath11k/mac.c | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index fbf666d0ecf1..58f57dd8858f 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -26,19 +26,18 @@ void ath11k_dp_peer_cleanup(struct ath11k *ar, int vdev_id, const u8 *addr)
 
 	/* TODO: Any other peer specific DP cleanup */
 
-	spin_lock_bh(&ab->base_lock);
+	lockdep_assert_held(&ab->base_lock);
+
 	peer = ath11k_peer_find(ab, vdev_id, addr);
 	if (!peer) {
 		ath11k_warn(ab, "failed to lookup peer %pM on vdev %d\n",
 			    addr, vdev_id);
-		spin_unlock_bh(&ab->base_lock);
 		return;
 	}
 
 	ath11k_peer_rx_tid_cleanup(ar, peer);
 	peer->dp_setup_done = false;
 	crypto_free_shash(peer->tfm_mmic);
-	spin_unlock_bh(&ab->base_lock);
 }
 
 int ath11k_dp_peer_setup(struct ath11k *ar, int vdev_id, const u8 *addr)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f8068d2e848c..f1dff26bc237 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9531,7 +9531,9 @@ static int ath11k_mac_station_remove(struct ath11k *ar,
 		}
 	}
 
+	spin_lock_bh(&ab->base_lock);
 	ath11k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
+	spin_unlock_bh(&ab->base_lock);
 
 	ret = ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
 	if (ret)
-- 
2.25.1


