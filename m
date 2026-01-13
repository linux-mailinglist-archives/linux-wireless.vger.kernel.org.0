Return-Path: <linux-wireless+bounces-30717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6DD16355
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 02:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2843F3012DD5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09CE2652B0;
	Tue, 13 Jan 2026 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6KCaHyt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KJNIjj3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44C22B8CB
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268919; cv=none; b=LQEuEpAPdTZtjd9SG1FngPfVuZR3p0zQ+zO+90Q348b61YuvJMi4ZLewAviNeu2ekfru1QeZ5TSlMglSmkmRGTTaEmgnvlvA+9UPSRRgJ+aD0s5eO0ON/7Ha5dmT4azbqzm1ff67jjodSkuR9WLIfOgUVCojx1IVP8izZFSek1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268919; c=relaxed/simple;
	bh=xwg1yt4L88RfPIT25G8HW/hAWUaaAAtXiB9XgaXcyLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W0oULasiIagt1Ji39sK/XB+k3ajsCfEwU75Hdpz/IEvuJH8usTMYqqwjeKTjhK1RrAiIvtmRK/bECnLajF5833RXeIy1+9jPmv5PIbp1DQ6gZQjpRZGMZ5jqwYGim7d9fZLyl+ijrkgYJUFPydWNIyfsmHfvS8ZnLL9a2BlCKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6KCaHyt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KJNIjj3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN5Bu21935703
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 01:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ieojKhXThRN+C7P57uEKkf
	j6UzSQobkcw4rlPKBrjck=; b=J6KCaHytO3gMTImGn1vGTBcNq2ds3R1/JyY8RQ
	u49tyIENUhpueUfWBFnh4oNEE/4vIw0PijqKdatOo4izhnV/ItChHJsjC12MSQ6d
	JWedw204UZuXJcmfRwIHJG8Gtt0O+k2FoH26H5Q7ED2cD1xevD+SDpo4dn3t6lZx
	tc1f2j6w+7Z+mETiHy9i1o0wyLIxtYZaPPN8jDVv+G/bekhYx64vXO1IEjxIseIN
	p5dgsP/weq3Wn+vm0ux4UbpmaDu4qHbhfbTcwETsGT5crljfxmlAJsYk++vuYWRZ
	25fULjtieUwwzm0k1h5lQRghX08/mtEb9g/z/sCie4ECpf7w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6cnh2nu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 01:48:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so2688422a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 17:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768268916; x=1768873716; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ieojKhXThRN+C7P57uEKkfj6UzSQobkcw4rlPKBrjck=;
        b=KJNIjj3DanL6n3xr3XcBeRcNroyuVkZSH+Dd/9Os9Lbya+jo/kuh0V7JVQqQ0dxqJi
         fltCfIoXDQKLS89L9JhlSP3LWY9IM+dESQgolnmYg3eKRw0NT/IX8/YQAumKyhc+nv7S
         xyUAJ3P047WXNXZVBDHUM9e7863+uKbeCeFLt9WjyzTaem5UYTXc2sodcgiThD6WYzx5
         42k3usUg6NoyKADOWfw5HBLXs8okVUJRp0ZHj1bcm614VjEzDdelg71qPAF46jBxOnob
         +LbZCJBbLnTKzlEJn88ojs0Cap3VMFXoF1A5u9Nyrh++iHCNzeNPmIMn1RukCDGFfTk1
         +Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768268916; x=1768873716;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieojKhXThRN+C7P57uEKkfj6UzSQobkcw4rlPKBrjck=;
        b=FxpkL1n5kmOCMNZL32iawZaWW5TQ8L3uWsR7cOjsgk5UiKFIheQysXRnt77OPK2PrF
         GupnkECWoSvmjN5jTBMa7Mwi1e5h+3Cf5qS1ud2Kp8lzTksjhlMI8JLoQpxEJATzcHRd
         /68MOtFIunpiSf0hD9ZrA/Lmw/MhZ9KHqSNWw7DCQkqILaMF7ZBqqaXYfeiGJd4blIBh
         l6nA0pvbeuPIoEC9hpn6Z3gEzAIN2ensLbgKaFYHmqCbFi4jZmb1xbcoAtQ64qVG6uhh
         sFmPdEuas5Z561Lb2pIf4WCRIti5+cxyQVUqJxGNIPA7fLtd133zQlc6VV7CLoS6sg+Y
         7j0A==
X-Gm-Message-State: AOJu0YyGvK8q0Oj1KJtyX2gmtaI5zn8E5jRMMVvgiHks0YbWfhma1IAe
	WeuD/lQs/SYH4pxcRttHf1EtuXmleqCyokW4yCXZx5Itz17AnE/HvRR4lH8C2QM5LmqXpU8bd8o
	hxXyE2fd4/UyzDrhC6aA4ranBFnfF4YJWQPBtT2KWywBxxoGeJlT87yphpn5d5qdpoLwTyw==
X-Gm-Gg: AY/fxX5vRtCWLBomTZoKCUxisVl7pxLFvu1Lsm5IjVMapNLP03kpwDgeyCDePWPwe7z
	gzJtcrVO1r5jzWEqTX+dXtAAagBmgAiWR2bBcXVHQ2pciuMpi3nTvXH7bdnZCoODwdzLQTzaFp9
	b6sIv1jZ9dCICS9BeRigqhgFH+fA8anmczHekTFQuQrA56OPtpQ5NCl6RT0JdRTWdGFE0np5hU0
	T4BSgOQO5RONu01eBknphobIhkuMXDK3IFckjIt6uQL6o3RykhYGkjl3Zh+i/OqbTv/zWgnnxEL
	MmWoFkdlhn7mqqvnR9CsoUm74rxQlfFwLznWdZdClUW9X7OjKUHBqlDqqLTZ5KlQzSADhPpBTVd
	aGkCKHjQCJH3AHPfIqO9soij1RWMyLNSv/2E7eEPc36+COHXz6sUqmmYSHEXl/9E=
X-Received: by 2002:a17:903:2f4e:b0:2a0:9656:a218 with SMTP id d9443c01a7336-2a3ee48ac03mr163903035ad.28.1768268916129;
        Mon, 12 Jan 2026 17:48:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGidp+jBRgz04GYtZ8OmOSzsrb7r1m0eGD1vcWUi69Yfc67hjnqFvny2Z5ls9GvPewXDay40A==
X-Received: by 2002:a17:903:2f4e:b0:2a0:9656:a218 with SMTP id d9443c01a7336-2a3ee48ac03mr163902875ad.28.1768268915641;
        Mon, 12 Jan 2026 17:48:35 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4be5sm187290185ad.99.2026.01.12.17.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 17:48:35 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 09:48:11 +0800
Subject: [PATCH ath-current] wifi: ath12k: fix dead lock while flushing
 management frames
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-ath12k-fix-dead-lock-while-flushing-v1-1-9713621f3a0f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFqkZWkC/5WOQQ6CMBBFr0K6dkhbQKgr72FclDLQBmi1BdQQ7
 m7DyoUL3Uzy83/em5UE9AYDOSUr8biYYJyNgR0SorS0HYJpYiac8iNlVICcNOM9tOYJDcoGBqd
 6eGgzILTDHLSxHQiZN1WNQmGtSCTdPMb9brmQCAA1e492ItdYahMm51/7BwvbJ3/JFgYMqqzNs
 yKjpajE2YWQ3mc5KDeOaTy7ZuEfaMZ/Q/OIbus8pwXlgpflF/S2bW+U62c+RQEAAA==
X-Change-ID: 20260109-ath12k-fix-dead-lock-while-flushing-9a4d8be9cebc
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: QUEKg_6M4NKlydQ5ECG0vbXCI9MhEach
X-Authority-Analysis: v=2.4 cv=KK5XzVFo c=1 sm=1 tr=0 ts=6965a475 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=P_pM7coAr74OfPD3JcoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: QUEKg_6M4NKlydQ5ECG0vbXCI9MhEach
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAxMyBTYWx0ZWRfXzlpZF9kQeD8r
 ZNtQzC+AyKfO4vN4HHEIIhDCuke1cOjPqf+Wox6+nbD8xFNEqNa7YSzzNDjZdNqh6VtHdaHQ6dB
 f93AjT7ZObgwjMhFTZdIEl7JihPcx2qZtLOG6vnxp0nc9oINYOxshZIImI7NmQVvV0k3i/UcoVs
 V7T97wGMQiUArM5H+q2BShRnAOPhXWixEJM1ocoTCZOMuFstrm+D1XMeY9jyX0kyGiZ/1XfJFuu
 V0It7a1aMYNtjalsrMqOI0mhF1clhzVSijvEn/Zs5Te/sVfP7xyXOar2F3MYoSSr6rM56sxoae9
 Co9ahjQSCGb458gMrr/NlMYq4PMcOG2OjQRb5JlvO92E5flsDeyUFlYSgGQNWy1vb6ByuFGeYK5
 kmH7m+/pxoS8bsp8Og3luPSKb4EGphogaoMoZ676i2NXjGPsgR2I/nG6bL5YXAT/zjDN0TtDYyY
 oQ4UM4ySVOO/SY7RFww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130013

Commit [1] converted the management transmission work item into a
wiphy work. Since a wiphy work can only run under wiphy lock
protection, a race condition happens in below scenario:

1. a management frame is queued for transmission.
2. ath12k_mac_op_flush() gets called to flush pending frames associated
   with the hardware (i.e, vif being NULL). Then in ath12k_mac_flush()
   the process waits for the transmission done.
3. Since wiphy lock has been taken by the flush process, the transmission
   work item has no chance to run, hence the dead lock.

From user view, this dead lock results in below issue:

 wlp8s0: authenticate with xxxxxx (local address=xxxxxx)
 wlp8s0: send auth to xxxxxx (try 1/3)
 wlp8s0: authenticate with xxxxxx (local address=xxxxxx)
 wlp8s0: send auth to xxxxxx (try 1/3)
 wlp8s0: authenticated
 wlp8s0: associate with xxxxxx (try 1/3)
 wlp8s0: aborting association with xxxxxx by local choice (Reason: 3=DEAUTH_LEAVING)
 ath12k_pci 0000:08:00.0: failed to flush mgmt transmit queue, mgmt pkts pending 1

The dead lock can be avoided by invoking wiphy_work_flush() to proactively
run the queued work item. Note actually it is already present in
ath12k_mac_op_flush(), however it does not protect the case where vif
being NULL. Hence move it ahead to cover this case as well.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 56dcbf0b5207 ("wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work") # [1]
Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220959
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2f4daee9e2f0..7481f64f6937 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12214,6 +12214,9 @@ void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (drop)
 		return;
 
+	for_each_ar(ah, ar, i)
+		wiphy_work_flush(hw->wiphy, &ar->wmi_mgmt_tx_work);
+
 	/* vif can be NULL when flush() is considered for hw */
 	if (!vif) {
 		for_each_ar(ah, ar, i)
@@ -12221,9 +12224,6 @@ void ath12k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return;
 	}
 
-	for_each_ar(ah, ar, i)
-		wiphy_work_flush(hw->wiphy, &ar->wmi_mgmt_tx_work);
-
 	ahvif = ath12k_vif_to_ahvif(vif);
 	links = ahvif->links_map;
 	for_each_set_bit(link_id, &links, IEEE80211_MLD_MAX_NUM_LINKS) {

---
base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc
change-id: 20260109-ath12k-fix-dead-lock-while-flushing-9a4d8be9cebc

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


