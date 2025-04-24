Return-Path: <linux-wireless+bounces-22026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48191A9BA79
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 00:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569031B82192
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6121FDD;
	Thu, 24 Apr 2025 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FpcFaD2N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52D1AA1F4
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532856; cv=none; b=KvzAuvLq6Rich6SrJhpDm6MCd9uK1DqO9tHm0/kCzzgxwO3/w93j3/iEpFeVmXBkNJMAW3/jIUhaf1jsmcdeQB4mqTQ+43g8F3Y6hcu0rLLWyYGp8fACmm7n7YT2bcXxT+koNH/PNrs/DbWHkuTgtOzHav2ljP2LOxAakF+UiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532856; c=relaxed/simple;
	bh=mo2wR2yaEKSUhXisQMlL78+JixrICc9O3CEPBsW2aZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c0oA62B+IkZ7Cl1hzkggFGGjHFksX79cLCLlbYAHozoM2O5v5mj53Xf0VsaidVSyrPahIL7FuFxb1IH+rT+Jyqk19kIwzdU5xY8/JSxTDK5r2QrTJJyfks4EUCMD2JpYao3zWt2Fc15GonEcVMT+mjP8qpgZHdO+FwcH/Bj+C9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FpcFaD2N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJmrek006098
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 22:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BJGNY+N37BwzJNoiNkKD64Fb4HkDj4hP2mz
	10tVLLow=; b=FpcFaD2NHYFaWd5+r8RTeABUv5F4SgxUjKH82FxYnsCNnzHF47o
	NAiThHOQThY8P25tlk1Fvhe4Upiw9EV7ig4p1avwM0p9ED/MjNyYQUY+IBgPg1eH
	PcHl5UNHtj/x8ukA8eocPhI30BvASgqaREn8LWEbvVlcu/P/UorCtNr0+Wdr/kN5
	XM7Za7rcLqIdR37ACGiFWv8qD3UeI6ua8EcEaFxnllWGjzUSDYmyTUs4fSHpCmT4
	K0FkIXXW04raQ1kAaYQduZ8yDVr1lsjaudpiOS6OASYrVe5HB1nKYWwYVoN24Qvj
	yBa+lsWIPPcaZIskoRnSAjSOb5kjVy4UrFw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh3f0tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 22:14:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242ade807fso25405585ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 15:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745532847; x=1746137647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJGNY+N37BwzJNoiNkKD64Fb4HkDj4hP2mz10tVLLow=;
        b=OpSCMPozsoFw9foz0Hytg7j5iUnLR8uCxIzfGUtUXXzpb6PPR8KYRWI9pF+lH/NgYI
         uB6S6J2vtK0sP4FKDeTKzS3QdJKUSHbIwIkZhs6pImSHie4tE3i3raJ5ZCt5XEmxq4Ij
         d0R2OJbG0xQaumFTFc/f1ngEldU/1q6g+U7DjqfYGcPMC8VJSI0LzaBBZsuiQvOGJMNh
         wtAPNkwutolTjnzWfWiYTG+H0zJSi2TSWC6foetkkodUnlt6hPf1meIr1Uo17d690X2X
         JVOokBfpbpPYLCR9NsqYyGSkCq6why3A7uGu3TY/NqHBylYkMtZJucoOMOtS/lzsaaoN
         ivBA==
X-Gm-Message-State: AOJu0Yzp/ucPvtNbGDEQPPf00tz9sF3WtqyW/dy9n8V3JBVsDfHyvEGH
	t/8/wOZB/Ffpe1MOvXlp0NAv9bsOcenKaK5PNd5Y939QzNKjrfe2E5WzeUvpNg3MmFyr7jE2vC/
	Cr9sCdoJsVrH8VF3ZMKiPTZSmfhDMNlYkp0ORoNY68Sf6Gjx4zkYgkgDpQvFsX7CXYs/pXpxZtw
	==
X-Gm-Gg: ASbGnctwgK7BIQybw/q/OO8FWzAsCZ3BLPb8awp69w6t+Xm4Fzw0mmoZdQpaLGDlD56
	FFe5WltYqwgKOHljAxhNa8BGfHZZLGNkUPt7MdmXbdQpO7kweAgonnDtBbc6odBiWTJLszc22Wq
	4AEWk88L/5WDTO10kyFmvpRpGYbdoOvnPKTEPUoRpCJzzgGK26VsUN/VK3eCfWZ4kKND/97D/gE
	kBJUPKHiKQJQqM5cSSiaF2osERBO61QLjOnPGg4i//qH9kD9mO9FIWZOy+nIINHgHOLuDkd1St8
	3b1aH5CgOwNiORXoOXxx7gHQvydjn6WGW1wKDBgzBg6Jm4f7pYDc9GYRhFYZzq6WrloN
X-Received: by 2002:a17:902:fc4c:b0:224:f12:3734 with SMTP id d9443c01a7336-22dbd424e7bmr12242795ad.30.1745532847528;
        Thu, 24 Apr 2025 15:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESRcc/Uvf/LaF9r4L5Ep+TXJTiltSLeQSlvIv4RohawNMNyB2iGdo6h7G7E+8eIVklz4ZcGA==
X-Received: by 2002:a17:902:fc4c:b0:224:f12:3734 with SMTP id d9443c01a7336-22dbd424e7bmr12242545ad.30.1745532847170;
        Thu, 24 Apr 2025 15:14:07 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76fcbsm18952305ad.16.2025.04.24.15.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:14:06 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Prevent multicast duplication for dynamic VLAN
Date: Thu, 24 Apr 2025 15:14:04 -0700
Message-Id: <20250424221404.1262597-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: g7WwDLq0KB2Hlytm7izlqfg_z08GGULv
X-Proofpoint-GUID: g7WwDLq0KB2Hlytm7izlqfg_z08GGULv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE1NyBTYWx0ZWRfX+YHMuiIrgrma M2klxXRHtIgeOilevynTUHJrzpcusGaRj2okySocpNsnVZe12tBevsjdQYNWu9Ayy30C2Uwbr7v zl38yUrQ4xFMGK2F9gnp5kWZJHtzKAXs3oRP5trFq0CVIrswRFLKReW8sk5zGwvBW+0HKrkTJji
 HQcXcXWhZUAbQOjY4oFeM8ZwbFncekn7EXHMRueXnzclw1q8M2gTg2HRfzYayX+SYEgY/+Q5i8p hSqOwaMKZUjdI6depXji475yvogRa+ZzrqOgw1NvqC8gSS4lrDfxExT9EvdVRdkSfG4Iptekvjc 3vvZK38TkfyXz/jlYFx1uiCeUqCPpDeCRjry7kfdoTAoPXajXTs0h8IkzBGkx+DsCy55A56sPc3
 G7IwSm8g3txFpOsCqxW3qBiJlVtpWQmvL7DLA5GrsbLe2AaMTKX6Nrra3H0xyIJLayeYLJTd
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=680ab7b0 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=xW75EOlAb0IjOozs2BkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=947 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240157

Since dynamic VLAN traffic is software encrypted and encapsulated,
mac80211 handles the duplication on each link for MLO dynamic VLAN
multicast.

Currently in ath12k_mac_op_tx(), all multicast frames are duplicated
and are assigned a mcbc_gsn. This is causing dynamic VLAN multicast
traffic to be dropped in hardware.

Prevent dynamic VLAN multicast traffic from being duplicated again in
the driver. Check if incoming packet is a dynamic VLAN packet and
avoid defaulting to multicast conditional.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>

---
v2:
 - rebase
 - minor changes in commit message to spell out abbreviations

---
 drivers/net/wireless/ath/ath12k/mac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d170bca72948..c5f07361c1ef 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7452,6 +7452,7 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ath12k_peer *peer;
 	unsigned long links_map;
 	bool is_mcast = false;
+	bool is_dvlan = false;
 	struct ethhdr *eth;
 	bool is_prb_rsp;
 	u16 mcbc_gsn;
@@ -7517,7 +7518,14 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_AP && vif->p2p)
 		ath12k_mac_add_p2p_noa_ie(ar, vif, skb, is_prb_rsp);
 
-	if (!vif->valid_links || !is_mcast ||
+	/* Checking if it is a DVLAN frame */
+	if (!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
+	    !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
+	    !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
+	    ieee80211_has_protected(hdr->frame_control))
+		is_dvlan = true;
+
+	if (!vif->valid_links || !is_mcast || is_dvlan ||
 	    test_bit(ATH12K_FLAG_RAW_MODE, &ar->ab->dev_flags)) {
 		ret = ath12k_dp_tx(ar, arvif, skb, false, 0, is_mcast);
 		if (unlikely(ret)) {

base-commit: 75f90ba47b2cda7de7a7bc1d099172516f6f96fa
-- 
2.34.1


