Return-Path: <linux-wireless+bounces-19532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B451A478B9
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 10:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A43C16E19E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA8422689C;
	Thu, 27 Feb 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K7/WSRID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368E227599;
	Thu, 27 Feb 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647397; cv=none; b=R3vvH9JcLwq++d66J/DpRMtm3aq5V/uyetqxBMKzHZ5V/wYRS5OymVoQhZc/23KOA5Jhh34eSLfhWNiwJDnWwu7T5ecQdLOwQ6Uf4KdPhWbIabV6E1a+14wbmo/81QWdk+QXwVe5m4JO/WcU1abggX10J24gCZs2PKTPO7+1nAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647397; c=relaxed/simple;
	bh=q4fTeH/nbZrefwpHXFO12Wt1mXAveSSHfKduO66DD4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZCcFj+MHCpGk3at7ZeTuZlenstzpmAsALsA3ArpaEXgMS2PBi+Tctm6CrDBUm0YYvZURJNn9Wy1Q5n3q2ZtJE4k0RluIOSeWryT/00R54OZ9ZP8aSY3DpDhV42N75PQT9t0xMZ5FssRxOoueZZELbcuVcJPPtvumiRMbOj6cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K7/WSRID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8xjtH015835;
	Thu, 27 Feb 2025 09:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uNP+sYpdWfNUyQbmq6LgNiGEAnkG36MM90R8M1Njlpo=; b=K7/WSRIDkP7tJK6l
	LnHHjhqNHKhsauweDELC0vWU/alNCdvNNptoMUPk/U/I1+FhhQZODYJ7k+oO3qmv
	MLwX9BRcDAjQZA5btHr1GVPxBzxeYd87OlEg0Qe4mn+fuLi2K0/JzmvE8PFgoRrH
	bItnB2I5n3Ngc3VWwP1iaD1r4SdeeTb6dlVGIrPJRY2N+44Tf5+kinAfOl192uk3
	y6EYCP0fZxwclGSJXRnw1QDpO/c6hkEWYHFBC4aljck+6p/uAgr1OFNoNs+uOMK8
	aMM+zoflq87gJLThc0/wvalYpUD2myyVzhB2ps9JA5APUbCbOfv+uiphE3DEvL3l
	L0h8iw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnn1y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 09:09:49 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R99mWU012790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 09:09:48 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 01:09:45 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <johannes@sipsolutions.net>, <miriam.rachel.korenblit@intel.com>,
        <syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>, <syzkaller-bugs@googlegroups.com>
Subject: [RFC PATCH] wifi: mac80211: Prevent disconnect reports when no AP is associated
Date: Thu, 27 Feb 2025 17:09:32 +0800
Message-ID: <20250227090932.1871272-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67bf36d3.050a0220.38b081.01ff.GAE@google.com>
References: <67bf36d3.050a0220.38b081.01ff.GAE@google.com>
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
X-Proofpoint-GUID: ZnuO2-MDAEpci2UNhs0ZfTQBhNSFOfi5
X-Proofpoint-ORIG-GUID: ZnuO2-MDAEpci2UNhs0ZfTQBhNSFOfi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270069

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

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Fixes: 687a7c8a7227 ("wifi: mac80211: change disassoc sequence a bit")
Reported-by: syzbot+5a7b40bcb34dea5ca959@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67bf36d3.050a0220.38b081.01ff.GAE@google.com/
---
Please kindy help thoroughly review this patch as I am not a wireless network expert.

 net/mac80211/mlme.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4e8f0a5f6251..4f3b535b1174 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4414,6 +4414,10 @@ static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
 		.u.mlme.data = tx ? DEAUTH_TX_EVENT : DEAUTH_RX_EVENT,
 		.u.mlme.reason = reason,
 	};
+	struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+
+	if (WARN_ON(!ap_sta))
+		return;
 
 	if (tx)
 		cfg80211_tx_mlme_mgmt(sdata->dev, buf, len, reconnect);
@@ -8070,7 +8074,7 @@ static void ieee80211_sta_timer(struct timer_list *t)
 void ieee80211_sta_connection_lost(struct ieee80211_sub_if_data *sdata,
 				   u8 reason, bool tx)
 {
-	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
+	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN] = {0};
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH, reason,
 			       tx, frame_buf);
-- 
2.25.1


