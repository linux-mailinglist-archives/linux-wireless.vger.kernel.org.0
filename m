Return-Path: <linux-wireless+bounces-12522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515B96CDFD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 06:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426FC284A53
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 04:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8514F11E;
	Thu,  5 Sep 2024 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B27AVMej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBB1494DB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510606; cv=none; b=t55YZaYOursVzR/A7Ef9I9N+piKDqVjKMwSkBNsfnaraQSW631J1U4ZGuQTwjRj+LDxmBEN3C9QDpuZXjeYEGM2zXzuMqgiV501lLelgs/o9HTIL/7AjcwSmaPVpb2gpnuV58z8vE7d0h2IsCV/LeryOk2UgkfoS9BbMiw8voL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510606; c=relaxed/simple;
	bh=PzOw19qFCiJT4BysDjWzRMJRvSFfMMCoOvJPtz8hfw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9SW1wxB18vqIpntI0pjCEwDKUsUVgZQGESVDd1DTKkD7VeVu0ZQEhB+cTqcLexFj93ONgKeIJ1uhEk/zAERMajGitAswWu+bwxmxx+EuVKumQykUWFQxnW1oF07TWG2Q4bLnm46nU5xW8a4w/zKMnna5ZIolo4xwZung1zDzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B27AVMej; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4851889A015575;
	Thu, 5 Sep 2024 04:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iLjqw6FfBNC3kuKuW+BgZ49dqvDK5rZy7V6
	Yh+gTADE=; b=B27AVMejFJ0DXxwiGjToXwCuRetgRkCyMbdx71pEHIsB7UE+cni
	Qmd1+9i9zPVGYg7cVpKvmHu5+VqjTf5OBfloaRgcqFXZpQdQwx9vrOu6uhPhHxb4
	1o2QnWKCPZrFDY1JLsbzepqWGN8LgH3O+nz4ZNwoSO8zWtYAadmxYduhipi87Tpq
	11YsjD6Nkh+VjRmSnLdsF8QXaxbgkCZ+N04gOxR81jK1c/LadTNglF5pmNIVmqZZ
	6zATrGiVcCxS404OUu10D0QkRgNi2w8/ViSWab6XxrgP3CEtF4gdd8fjTtk6DdL6
	11lmEWF0D9Q5lM/XsHA11VnNXN2pCnYpk3g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dt69evy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:29:59 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4854TuL4029891;
	Thu, 5 Sep 2024 04:29:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 41bv8mhndg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:29:56 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4854TtsY029882;
	Thu, 5 Sep 2024 04:29:55 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4854TtBd029881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 04:29:55 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id EEBB84114A; Thu,  5 Sep 2024 09:59:54 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: Skip Rx TID cleanup for self peer
Date: Thu,  5 Sep 2024 09:58:51 +0530
Message-Id: <20240905042851.2282306-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: MC0SKehR3U0oh5qxYhjRklMpB7Ic3mMj
X-Proofpoint-ORIG-GUID: MC0SKehR3U0oh5qxYhjRklMpB7Ic3mMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_03,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=836 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050030

During peer create, dp setup for the peer is done where Rx TID is
updated for all the TIDs. Peer object for self peer will not go through
dp setup.

When core halts, dp cleanup is done for all the peers. While cleanup,
rx_tid::ab is accessed which causes below stack trace for self peer.

WARNING: CPU: 6 PID: 12297 at drivers/net/wireless/ath/ath12k/dp_rx.c:851
Call Trace:
__warn+0x7b/0x1a0
ath12k_dp_rx_frags_cleanup+0xd2/0xe0 [ath12k]
report_bug+0x10b/0x200
handle_bug+0x3f/0x70
exc_invalid_op+0x13/0x60
asm_exc_invalid_op+0x16/0x20
ath12k_dp_rx_frags_cleanup+0xd2/0xe0 [ath12k]
ath12k_dp_rx_frags_cleanup+0xca/0xe0 [ath12k]
ath12k_dp_rx_peer_tid_cleanup+0x39/0xa0 [ath12k]
ath12k_mac_peer_cleanup_all+0x61/0x100 [ath12k]
ath12k_core_halt+0x3b/0x100 [ath12k]
ath12k_core_reset+0x494/0x4c0 [ath12k]

sta object in peer will be updated when remote peer is created. Hence
use peer::sta to detect the self peer and skip the cleanup.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8106297f0bc1..3949bef1db3c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -917,7 +917,9 @@ void ath12k_mac_peer_cleanup_all(struct ath12k *ar)
 
 	spin_lock_bh(&ab->base_lock);
 	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
-		ath12k_dp_rx_peer_tid_cleanup(ar, peer);
+		/* Skip Rx TID cleanup for self peer */
+		if (peer->sta)
+			ath12k_dp_rx_peer_tid_cleanup(ar, peer);
 		list_del(&peer->list);
 		kfree(peer);
 	}
-- 
2.17.1


