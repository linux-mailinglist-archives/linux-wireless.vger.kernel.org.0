Return-Path: <linux-wireless+bounces-28111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897DBF2276
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBC14F8262
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374626C3AE;
	Mon, 20 Oct 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oexcu7Fq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242B26B942
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974689; cv=none; b=pwB0GGKWAdtxRk0WEhJ9f6bFOLB/gX/zGZon/kZkkuTFKuX1nIvO+PHMTNY74itrrsa8SHFcnljqnDJNoHG28J3NMGoIvB8sgdeS2hepHH9PPlFbSib/yZB/AaTXIdU1XYdoP1D5F2aEXUU/aXfOleOiKDPePox75CaZ3NhAwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974689; c=relaxed/simple;
	bh=VmqFw6Ea/AQfwK82M1xXkElJl7980NsIfwrZRmpWcAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tgNJtsFAbJr4deNSTu7vZN257bpbC6k8+Sqh8jKzqm3WCBS/WAXAMc1jTrm2IX+DJFYH1DG4fiyeNULMYYYXxApYc3Qj1lSbyOToVPwkInFQ6EipHRMAFOrBGTdiF+Lvgjnlza6nwTXukqNTwg9ub34j6oJxZzp9kXn5dyt05Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oexcu7Fq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KC5TMi015370
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 15:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vsRopZDLOQEj9hwm5Ujn2UKLBTKI7o+Co5C
	ptSwUNMI=; b=oexcu7FqxEK1+Y1OHCofSCrzHm/moBmWVjGOr4Fj9czjwTOLHSO
	D8m7uFgfr2Bz6Kjok6B5G4jXbKtrHSFuU0uDnpmNVwMCZAIrSXnRT+bxnZcHRhDU
	VKvIjOgVTc4kVWq4D0DogeKJ2KkA9TnGuLfusha3RAzPTTyxl+1WA9Iyi75olVod
	J4P6nSocT02K1wA8jHP/f3SL+maDI+QjJ5/J/wnx5cM+e/dtXj2nKbDa7Bbf/Mjo
	LW/KvhoamGWfB/m9jdLXuw3YovaHFKdaDZOU7EfxF/jpUDuP4Sxp8OCdBvqCPkQQ
	eOT10uzBx+jFuvHlN8yWQM/vRq0dt0maBYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469d5bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 15:38:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e91599ee5so1105920785a.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 08:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974684; x=1761579484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsRopZDLOQEj9hwm5Ujn2UKLBTKI7o+Co5CptSwUNMI=;
        b=wG+Psfxn115dhdXVA6lxbj5HvbRxKc7UVg5KUqM2YqBW84jAH/NrnJT8CH1x7LwNje
         24b8HbXF0YvoTl6Qhyhj2mussj+TeExPVGoBiIAuHKDmmFwDEQ9DBEiq5DftajVQJObq
         M8CL/V8nVJeqJFujjCcEJA8uABNGYxfup85OeYiwVBBxf5jg+uN/2g9dLC19oT5tIbOP
         QjI6y+QuqL8phLtoHFRzdQ69xvL9jWx/q561blJ75DQXbNAyZ7LBztUDP6OOL5ueFrFI
         gkbDdou/DLs2oWFxN0CJVyPOV2TVlq7d0++GTlbIXsQpKD+528QecJERztBLPEWbiYaz
         wpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUan71G5zS7qTSMR7EXRkWk+pxxHuDf2pInGbAuAT+BgpPVzN0AG7+OKc0EkEcwJehsjHfYKJgc8w/oDd9YGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6H9DgzCJhs9VtWL/5tlJjQNxuHq1pSaSQrLqFiBqKWQDbrsq+
	IBSyYlfEKfFiiXFjmz8qf6yyNjdyO67B9MT/rBZgJPGC1kK5WlQ3y4bSByIXEXYBxSMZ4mavABn
	YmgGntON0o2TCNiBhY2TX2/J7o7Nhv3EGeg/mTBJ4BqJg6Kn/Yn2sX4aaF06Lix+nbeA4hA==
X-Gm-Gg: ASbGncvBSV2GnNMsKUVURRmoVQCPZ5TwDqxejrU6z9ETkA9N/ZpPWE67dCY4w+CaLXm
	S6PkCeNki7lfTkkdVS83QRwfHz1JYvDfRtLsF85s6eGX5yMaUKPhpda7g42uWMgal7q22mCiepw
	pABzwZ4PFanmn6mcXn/v0SXJWamiEn6gyyp8/E7Sh8Ez2TnhsOT/D+TAjK8aahRLL7gpO6XO1of
	tFbL8P3cog287F6vAW9YlgBFF3U4U/kBuWEaxz5pS7DlDzIUx65T+vyTgtPPc4efqA3tPZPfKbx
	64LfOKdogwpMNijg9uJ4OFLLLw1WBNxs5shm1GyoPL4Z98avkJXLg1kArqwjQjFStEKscYVKUuy
	tYp/lwjdoVGvy3b/d2wcB0ZJXgXkVlQWd9BF6ZW7kdHpDQEtagGvrdEE3lCmgYchx
X-Received: by 2002:a05:622a:1450:b0:4e8:ad2a:b0cf with SMTP id d75a77b69052e-4e8ad2adeb5mr98592381cf.9.1760974683237;
        Mon, 20 Oct 2025 08:38:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM/IlIzVCJ37v1h6Dkzerk5daN+4+YRVlqWBHA0va61aAIx3aCKhdpUNqJYVsDbGYxBUmIgg==
X-Received: by 2002:a05:622a:1450:b0:4e8:ad2a:b0cf with SMTP id d75a77b69052e-4e8ad2adeb5mr98592061cf.9.1760974682638;
        Mon, 20 Oct 2025 08:38:02 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:549:f31b:11b1:14c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm16391257f8f.29.2025.10.20.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:38:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v2] wifi: ath10k: Support for FTM TLV test commands
Date: Mon, 20 Oct 2025 17:37:59 +0200
Message-Id: <20251020153759.407516-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6nYT7xw4XJaZetO7xKfVtZRsn2KfbUeR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX+Ke2GTbQsSB2
 zM0LjkI6jm/clLhqUDBk8mWwtz1co3ql65ExqUNM4yUpL2/Af0Yl4QsJ8C3k6lKa6wC1Vr5xhax
 cJs01Q+KlHv8R4rG1z6vLtrjdXURiumWxCbGayjlNlg6beTwtlwc4ZUxwx4R/ewsVIPtTtLYNPx
 XDpLf2as0MHVA0HquGdFZ1TUSTy0S2gbjmRr3MOZyoKZZf478T+JLv+t+H2cdDq3yWYFS7s3WL4
 G04uEUyUEl1hOYMSII03ZvZuZmjqwOAGqxgYvJovmO65ii6RXbcHU89nxS66BhtNXzIsVbZvq8u
 JmKkb1Uklxtr0I1xxeG0yVx1dvzYTZGXdZTcRYUM9tFr9VSjn4x9xxG+leR2toXf6ZnDzKnJSSR
 EXVAikis+JARGW0PJ/haEm0sssMBNQ==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f6575d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jNky2xIMEC1gJP5me7YA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 6nYT7xw4XJaZetO7xKfVtZRsn2KfbUeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

Existing tools like myftm use 'legacy' test command API. Similarly
to ath11k and ath12k, we want to support raw TLV payload submitted
from the test tool. This requires segmenting the TLV payload and
encapsulating it within a WMI command. The opposite operation needs
to be done upon corresponding event receiving.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 v2: Fix endianness issues reported by kernel test robot

 drivers/net/wireless/ath/ath10k/core.h       |   5 +-
 drivers/net/wireless/ath/ath10k/testmode.c   | 252 ++++++++++++++++---
 drivers/net/wireless/ath/ath10k/testmode_i.h |  15 ++
 drivers/net/wireless/ath/ath10k/wmi.h        |  19 +-
 4 files changed, 259 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 8c72ed386edb..3b4dde292a7a 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -1259,9 +1258,13 @@ struct ath10k {
 	struct {
 		/* protected by conf_mutex */
 		struct ath10k_fw_components utf_mode_fw;
+		u8 ftm_msgref;
 
 		/* protected by data_lock */
 		bool utf_monitor;
+		u32 data_pos;
+		u32 expected_seq;
+		u8 *eventdata;
 	} testmode;
 
 	struct {
diff --git a/drivers/net/wireless/ath/ath10k/testmode.c b/drivers/net/wireless/ath/ath10k/testmode.c
index 3fcefc55b74f..2b042c12265a 100644
--- a/drivers/net/wireless/ath/ath10k/testmode.c
+++ b/drivers/net/wireless/ath/ath10k/testmode.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /*
  * Copyright (c) 2014-2017 Qualcomm Atheros, Inc.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "testmode.h"
@@ -10,12 +11,17 @@
 
 #include "debug.h"
 #include "wmi.h"
+#include "wmi-tlv.h"
 #include "hif.h"
 #include "hw.h"
 #include "core.h"
 
 #include "testmode_i.h"
 
+#define ATH10K_FTM_SEG_NONE			((u32)-1)
+#define ATH10K_FTM_SEGHDR_CURRENT_SEQ		GENMASK(3, 0)
+#define ATH10K_FTM_SEGHDR_TOTAL_SEGMENTS	GENMASK(7, 4)
+
 static const struct nla_policy ath10k_tm_policy[ATH10K_TM_ATTR_MAX + 1] = {
 	[ATH10K_TM_ATTR_CMD]		= { .type = NLA_U32 },
 	[ATH10K_TM_ATTR_DATA]		= { .type = NLA_BINARY,
@@ -25,41 +31,18 @@ static const struct nla_policy ath10k_tm_policy[ATH10K_TM_ATTR_MAX + 1] = {
 	[ATH10K_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
 };
 
-/* Returns true if callee consumes the skb and the skb should be discarded.
- * Returns false if skb is not used. Does not sleep.
- */
-bool ath10k_tm_event_wmi(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
+static void ath10k_tm_event_unsegmented(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
 {
 	struct sk_buff *nl_skb;
-	bool consumed;
 	int ret;
 
-	ath10k_dbg(ar, ATH10K_DBG_TESTMODE,
-		   "testmode event wmi cmd_id %d skb %p skb->len %d\n",
-		   cmd_id, skb, skb->len);
-
-	ath10k_dbg_dump(ar, ATH10K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
-
-	spin_lock_bh(&ar->data_lock);
-
-	if (!ar->testmode.utf_monitor) {
-		consumed = false;
-		goto out;
-	}
-
-	/* Only testmode.c should be handling events from utf firmware,
-	 * otherwise all sort of problems will arise as mac80211 operations
-	 * are not initialised.
-	 */
-	consumed = true;
-
 	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
 						   2 * sizeof(u32) + skb->len,
 						   GFP_ATOMIC);
 	if (!nl_skb) {
 		ath10k_warn(ar,
 			    "failed to allocate skb for testmode wmi event\n");
-		goto out;
+		return;
 	}
 
 	ret = nla_put_u32(nl_skb, ATH10K_TM_ATTR_CMD, ATH10K_TM_CMD_WMI);
@@ -68,7 +51,7 @@ bool ath10k_tm_event_wmi(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
 			    "failed to put testmode wmi event cmd attribute: %d\n",
 			    ret);
 		kfree_skb(nl_skb);
-		goto out;
+		return;
 	}
 
 	ret = nla_put_u32(nl_skb, ATH10K_TM_ATTR_WMI_CMDID, cmd_id);
@@ -77,7 +60,7 @@ bool ath10k_tm_event_wmi(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
 			    "failed to put testmode wmi event cmd_id: %d\n",
 			    ret);
 		kfree_skb(nl_skb);
-		goto out;
+		return;
 	}
 
 	ret = nla_put(nl_skb, ATH10K_TM_ATTR_DATA, skb->len, skb->data);
@@ -86,10 +69,122 @@ bool ath10k_tm_event_wmi(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
 			    "failed to copy skb to testmode wmi event: %d\n",
 			    ret);
 		kfree_skb(nl_skb);
-		goto out;
+		return;
+	}
+
+	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+}
+
+static void ath10k_tm_event_segmented(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
+{
+	struct wmi_ftm_cmd *ftm = (struct wmi_ftm_cmd *)skb->data;
+	u8 total_segments, current_seq;
+	struct sk_buff *nl_skb;
+	u8 const *buf_pos;
+	u16 datalen;
+	u32 data_pos;
+	int ret;
+
+	if (skb->len < sizeof(*ftm)) {
+		ath10k_warn(ar, "Invalid ftm event length: %d\n", skb->len);
+		return;
+	}
+
+	current_seq = FIELD_GET(ATH10K_FTM_SEGHDR_CURRENT_SEQ,
+				__le32_to_cpu(ftm->seg_hdr.segmentinfo));
+	total_segments = FIELD_GET(ATH10K_FTM_SEGHDR_TOTAL_SEGMENTS,
+				   __le32_to_cpu(ftm->seg_hdr.segmentinfo));
+	datalen = skb->len - sizeof(*ftm);
+	buf_pos = ftm->data;
+
+	if (current_seq == 0) {
+		ar->testmode.expected_seq = 0;
+		ar->testmode.data_pos = 0;
+	}
+
+	data_pos = ar->testmode.data_pos;
+
+	if ((data_pos + datalen) > ATH_FTM_EVENT_MAX_BUF_LENGTH) {
+		ath10k_warn(ar, "Invalid ftm event length at %u: %u\n",
+			    data_pos, datalen);
+		ret = -EINVAL;
+		return;
+	}
+
+	memcpy(&ar->testmode.eventdata[data_pos], buf_pos, datalen);
+	data_pos += datalen;
+
+	if (++ar->testmode.expected_seq != total_segments) {
+		ar->testmode.data_pos = data_pos;
+		ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "partial data received %u/%u\n",
+			   current_seq + 1, total_segments);
+		return;
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_TESTMODE, "total data length %u\n", data_pos);
+
+	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
+						   2 * sizeof(u32) + data_pos,
+						   GFP_ATOMIC);
+	if (!nl_skb) {
+		ath10k_warn(ar, "failed to allocate skb for testmode wmi event\n");
+		return;
+	}
+
+	ret = nla_put_u32(nl_skb, ATH10K_TM_ATTR_CMD, ATH10K_TM_CMD_TLV);
+	if (ret) {
+		ath10k_warn(ar, "failed to put testmode wmi event attribute: %d\n", ret);
+		kfree_skb(nl_skb);
+		return;
+	}
+
+	ret = nla_put_u32(nl_skb, ATH10K_TM_ATTR_WMI_CMDID, cmd_id);
+	if (ret) {
+		ath10k_warn(ar, "failed to put testmode wmi event cmd_id: %d\n", ret);
+		kfree_skb(nl_skb);
+		return;
+	}
+
+	ret = nla_put(nl_skb, ATH10K_TM_ATTR_DATA, data_pos, &ar->testmode.eventdata[0]);
+	if (ret) {
+		ath10k_warn(ar, "failed to copy skb to testmode wmi event: %d\n", ret);
+		kfree_skb(nl_skb);
+		return;
 	}
 
 	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
+}
+
+/* Returns true if callee consumes the skb and the skb should be discarded.
+ * Returns false if skb is not used. Does not sleep.
+ */
+bool ath10k_tm_event_wmi(struct ath10k *ar, u32 cmd_id, struct sk_buff *skb)
+{
+	bool consumed;
+
+	ath10k_dbg(ar, ATH10K_DBG_TESTMODE,
+		   "testmode event wmi cmd_id %d skb %p skb->len %d\n",
+		   cmd_id, skb, skb->len);
+
+	ath10k_dbg_dump(ar, ATH10K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
+
+	spin_lock_bh(&ar->data_lock);
+
+	if (!ar->testmode.utf_monitor) {
+		consumed = false;
+		goto out;
+	}
+
+	/* Only testmode.c should be handling events from utf firmware,
+	 * otherwise all sort of problems will arise as mac80211 operations
+	 * are not initialised.
+	 */
+	consumed = true;
+
+	if (ar->testmode.expected_seq != ATH10K_FTM_SEG_NONE)
+		ath10k_tm_event_segmented(ar, cmd_id, skb);
+	else
+		ath10k_tm_event_unsegmented(ar, cmd_id, skb);
 
 out:
 	spin_unlock_bh(&ar->data_lock);
@@ -281,12 +376,18 @@ static int ath10k_tm_cmd_utf_start(struct ath10k *ar, struct nlattr *tb[])
 		goto err_release_utf_mode_fw;
 	}
 
+	ar->testmode.eventdata = kzalloc(ATH_FTM_EVENT_MAX_BUF_LENGTH, GFP_KERNEL);
+	if (!ar->testmode.eventdata) {
+		ret = -ENOMEM;
+		goto err_power_down;
+	}
+
 	ret = ath10k_core_start(ar, ATH10K_FIRMWARE_MODE_UTF,
 				&ar->testmode.utf_mode_fw);
 	if (ret) {
 		ath10k_err(ar, "failed to start core (testmode): %d\n", ret);
 		ar->state = ATH10K_STATE_OFF;
-		goto err_power_down;
+		goto err_release_eventdata;
 	}
 
 	ar->state = ATH10K_STATE_UTF;
@@ -302,6 +403,10 @@ static int ath10k_tm_cmd_utf_start(struct ath10k *ar, struct nlattr *tb[])
 
 	return 0;
 
+err_release_eventdata:
+	kfree(ar->testmode.eventdata);
+	ar->testmode.eventdata = NULL;
+
 err_power_down:
 	ath10k_hif_power_down(ar);
 
@@ -341,6 +446,9 @@ static void __ath10k_tm_cmd_utf_stop(struct ath10k *ar)
 	release_firmware(ar->testmode.utf_mode_fw.fw_file.firmware);
 	ar->testmode.utf_mode_fw.fw_file.firmware = NULL;
 
+	kfree(ar->testmode.eventdata);
+	ar->testmode.eventdata = NULL;
+
 	ar->state = ATH10K_STATE_OFF;
 }
 
@@ -424,6 +532,85 @@ static int ath10k_tm_cmd_wmi(struct ath10k *ar, struct nlattr *tb[])
 	return ret;
 }
 
+static int ath10k_tm_cmd_tlv(struct ath10k *ar, struct nlattr *tb[])
+{
+	u16 total_bytes, num_segments;
+	u32 cmd_id, buf_len;
+	u8 segnumber = 0;
+	u8 *bufpos;
+	void *buf;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH10K_STATE_UTF) {
+		ret = -ENETDOWN;
+		goto out;
+	}
+
+	buf = nla_data(tb[ATH10K_TM_ATTR_DATA]);
+	buf_len = nla_len(tb[ATH10K_TM_ATTR_DATA]);
+	cmd_id = WMI_PDEV_UTF_CMDID;
+
+	ath10k_dbg(ar, ATH10K_DBG_TESTMODE,
+		   "cmd wmi ftm cmd_id %d buffer length %d\n",
+		   cmd_id, buf_len);
+	ath10k_dbg_dump(ar, ATH10K_DBG_TESTMODE, NULL, "", buf, buf_len);
+
+	bufpos = buf;
+	total_bytes = buf_len;
+	num_segments = total_bytes / MAX_WMI_UTF_LEN;
+	ar->testmode.expected_seq = 0;
+
+	if (buf_len - (num_segments * MAX_WMI_UTF_LEN))
+		num_segments++;
+
+	while (buf_len) {
+		u16 chunk_len = min_t(u16, buf_len, MAX_WMI_UTF_LEN);
+		struct wmi_ftm_cmd *ftm_cmd;
+		struct sk_buff *skb;
+		u32 hdr_info;
+		u8 seginfo;
+
+		skb = ath10k_wmi_alloc_skb(ar, (chunk_len +
+					   sizeof(struct wmi_ftm_cmd)));
+		if (!skb) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ftm_cmd = (struct wmi_ftm_cmd *)skb->data;
+		hdr_info = FIELD_PREP(WMI_TLV_TAG, WMI_TLV_TAG_ARRAY_BYTE) |
+			   FIELD_PREP(WMI_TLV_LEN, (chunk_len +
+				      sizeof(struct wmi_ftm_seg_hdr)));
+		ftm_cmd->tlv_header = __cpu_to_le32(hdr_info);
+		ftm_cmd->seg_hdr.len = __cpu_to_le32(total_bytes);
+		ftm_cmd->seg_hdr.msgref = __cpu_to_le32(ar->testmode.ftm_msgref);
+		seginfo = FIELD_PREP(ATH10K_FTM_SEGHDR_TOTAL_SEGMENTS, num_segments) |
+			  FIELD_PREP(ATH10K_FTM_SEGHDR_CURRENT_SEQ, segnumber);
+		ftm_cmd->seg_hdr.segmentinfo = __cpu_to_le32(seginfo);
+		segnumber++;
+
+		memcpy(&ftm_cmd->data, bufpos, chunk_len);
+
+		ret = ath10k_wmi_cmd_send(ar, skb, cmd_id);
+		if (ret) {
+			ath10k_warn(ar, "failed to send wmi ftm command: %d\n", ret);
+			goto out;
+		}
+
+		buf_len -= chunk_len;
+		bufpos += chunk_len;
+	}
+
+	ar->testmode.ftm_msgref++;
+	ret = 0;
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 int ath10k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  void *data, int len)
 {
@@ -439,9 +626,14 @@ int ath10k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!tb[ATH10K_TM_ATTR_CMD])
 		return -EINVAL;
 
+	ar->testmode.expected_seq = ATH10K_FTM_SEG_NONE;
+
 	switch (nla_get_u32(tb[ATH10K_TM_ATTR_CMD])) {
 	case ATH10K_TM_CMD_GET_VERSION:
-		return ath10k_tm_cmd_get_version(ar, tb);
+		if (!tb[ATH10K_TM_ATTR_DATA])
+			return ath10k_tm_cmd_get_version(ar, tb);
+		else /* ATH10K_TM_CMD_TLV */
+			return ath10k_tm_cmd_tlv(ar, tb);
 	case ATH10K_TM_CMD_UTF_START:
 		return ath10k_tm_cmd_utf_start(ar, tb);
 	case ATH10K_TM_CMD_UTF_STOP:
diff --git a/drivers/net/wireless/ath/ath10k/testmode_i.h b/drivers/net/wireless/ath/ath10k/testmode_i.h
index ee1cb27c1d60..1603f5276682 100644
--- a/drivers/net/wireless/ath/ath10k/testmode_i.h
+++ b/drivers/net/wireless/ath/ath10k/testmode_i.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: ISC */
 /*
  * Copyright (c) 2014,2017 Qualcomm Atheros, Inc.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 /* "API" level of the ath10k testmode interface. Bump it after every
@@ -14,6 +15,7 @@
 #define ATH10K_TESTMODE_VERSION_MINOR 0
 
 #define ATH10K_TM_DATA_MAX_LEN		5000
+#define ATH_FTM_EVENT_MAX_BUF_LENGTH	2048
 
 enum ath10k_tm_attr {
 	__ATH10K_TM_ATTR_INVALID	= 0,
@@ -57,4 +59,17 @@ enum ath10k_tm_cmd {
 	 * ATH10K_TM_ATTR_DATA.
 	 */
 	ATH10K_TM_CMD_WMI = 3,
+
+	/* The command used to transmit a test command to the firmware
+	 * and the event to receive test events from the firmware. The data
+	 * received only contain the TLV payload, need to add the tlv header
+	 * and send the cmd to firmware with command id WMI_PDEV_UTF_CMDID.
+	 * The data payload size could be large and the driver needs to
+	 * send segmented data to firmware.
+	 *
+	 * This legacy testmode command shares the same value as the get-version
+	 * command. To distinguish between them, we check whether the data attribute
+	 * is present.
+	 */
+	ATH10K_TM_CMD_TLV = ATH10K_TM_CMD_GET_VERSION,
 };
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 0faefc0a9a40..7f50a1de6b97 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3,7 +3,7 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef _WMI_H_
@@ -7418,6 +7418,23 @@ struct wmi_pdev_bb_timing_cfg_cmd {
 	__le32 bb_xpa_timing;
 } __packed;
 
+struct wmi_ftm_seg_hdr {
+	__le32 len;
+	__le32 msgref;
+	__le32 segmentinfo;
+	__le32 pdev_id;
+} __packed;
+
+struct wmi_ftm_cmd {
+	__le32 tlv_header;
+	struct wmi_ftm_seg_hdr seg_hdr;
+	u8 data[];
+} __packed;
+
+#define WMI_TLV_LEN      GENMASK(15, 0)
+#define WMI_TLV_TAG	 GENMASK(31, 16)
+#define MAX_WMI_UTF_LEN  252
+
 struct ath10k;
 struct ath10k_vif;
 struct ath10k_fw_stats_pdev;
-- 
2.34.1


