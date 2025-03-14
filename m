Return-Path: <linux-wireless+bounces-20380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08C1A6109E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 13:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E417A3A387A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 12:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881701FAC3D;
	Fri, 14 Mar 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mqJ37J7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A09192D6B;
	Fri, 14 Mar 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954004; cv=none; b=DvHjrDha+RZoW684U0EldqYCX8HIN9jgPdIAKHS7FvCDMQc6lLV4Hs7egyu3NvT6UOwAh5YYhaURjI8z+mvOYn8S3fPO3Xo+xDp3WYkMTy5QwzRcIa7wq8QlV3RmP2onqDM+alfCmGwfyxXqDg8U0U/uVWA52xv8qXruqbBKcG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954004; c=relaxed/simple;
	bh=8pNOnJ2LC70pKfJZznXtgqsVw3dIIVR2oklK86YS4/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BDtBMv4/0Lf4GohNn8Mf2WugTea89Ei/u6RxxZRw8jCUL813yyx5wH3sCBsadH0eQB4Z25MUETtTr6zZPLVjDiQAN9QF8G/5k/RmA6KdFqtoN14K90pWFQO+RnOzekRPq2l512ojPvoznKzEfOIhMmHAZUNIVoPo3QP0eOXITYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mqJ37J7F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9YDkr019596;
	Fri, 14 Mar 2025 12:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bh21o9dLy7lEDe68zirb2d
	JGXUgB9M6JRV3a9ZiHRpQ=; b=mqJ37J7FFAoxjprTR+G2mcoRA0gD2U5mKoxy4c
	dA4YIywenHa9qQKGqGVXZCcjdxmU2f7OZHJj+nrSis8q++VdUokC0yi8pnQ4+1Ze
	8WDWJsidCfwfts9anqPlBT3L0OcQwhUt/eG0oMvOp8XpLqN3XKZrC7RTrJEmaRUb
	zBzlNhiydZ3XsE3NieBPaGQLmX0jKHMmVhsbPuxcSFWRLkfCNe9PWgxf/+y0eKfx
	dhHtVGeOnen6Bou2zM+qi0RVBlCGjumXNHd51i3UMvDmQ20ysytmYdme0fhwOspl
	XJGqZ93LvFH7EY/Q1xvPOn/WHCyW6KQj74p7+m/ZKTNknY1Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2p1752-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 12:06:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52EC6W4T027291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 12:06:32 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 14 Mar 2025 05:06:30 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <johannes@sipsolutions.net>, <miriam.rachel.korenblit@intel.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
Subject: [PATCH v2] wifi: mac80211: Prevent disconnect reports when no AP is associated
Date: Fri, 14 Mar 2025 20:06:14 +0800
Message-ID: <20250314120614.4032434-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: _yH3PE4g3TpHY-sTnofQESHunOcXBlqB
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d41bc9 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8 a=hSkVLCK3AAAA:8
 a=IS6kxbfz1l1t9IyL_bAA:9 a=TjNXssC_j7lpFel5tvFf:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: _yH3PE4g3TpHY-sTnofQESHunOcXBlqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_05,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140095

syzbot reports that cfg80211_tx_mlme_mgmt is using uninit-value:

=====================================================
BUG: KMSAN: uninit-value in cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
cfg80211_tx_mlme_mgmt+0x155/0x300 net/wireless/mlme.c:226
ieee80211_report_disconnect net/mac80211/mlme.c:4238 [inline]
ieee80211_sta_connection_lost+0xfa/0x150 net/mac80211/mlme.c:7811
ieee80211_sta_work+0x1dea/0x4ef0
ieee80211_iface_work+0x1900/0x1970 net/mac80211/iface.c:1684
cfg80211_wiphy_work+0x396/0x860 net/wireless/core.c:435
process_one_work kernel/workqueue.c:3236 [inline]
process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
kthread+0x6b9/0xef0 kernel/kthread.c:464
ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable frame_buf created at:
ieee80211_sta_connection_lost+0x43/0x150 net/mac80211/mlme.c:7806
ieee80211_sta_work+0x1dea/0x4ef0
=====================================================

The reason is that the local variable frame_buf on the stack cannot be
initialized by default. However one more question is that avoiding the
uninit-value bug by explicitly initializing it is not enough. Since commit
687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit"), if there
is no AP station, frame_buf has no chance to be assigned a valid value.
The function ieee80211_report_disconnect should not continue executing
with the frame_buf parameter that is merely initialized to zero.

Reported-by: syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67bf36d3.050a0220.38b081.01ff.GAE@google.com/
Fixes: 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
v1 -> v2:
- Rebased on top of current next.
- Reorder the tags.
- Link to v1: https://lore.kernel.org/all/20250227090932.1871272-1-quic_zhonhan@quicinc.com/

 net/mac80211/mlme.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c010bb3d24e3..08fb3fb740fd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4433,6 +4433,10 @@ static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
 		.u.mlme.data = tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
 		.u.mlme.reason = reason,
 	};
+	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+
+	if (WARN_ON(!ap_sta))
+		return;
 
 	if (tx)
 		cfg80211_tx_mlme_mgmt(sdata->dev, buf, len, reconnect);
@@ -8090,7 +8094,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 				   u8 reason, bool tx)
 {
-	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {0};
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH, reason,
 			       tx, frame_buf);
-- 
2.25.1


