Return-Path: <linux-wireless+bounces-35440-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEJNCChR8GlNRgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35440-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:18:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF147DFDB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14DA3025F74
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9354C345CBC;
	Tue, 28 Apr 2026 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDlTP7xu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPEo/R6r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB01C5D5E
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357071; cv=none; b=WdstPJ9A5jPiGeUzClCn4Q9u+De5h7GAjZWLUsURlb4BscIam7gjDbuURaRBF2mBj80G4h0PFMszOW32t/wf8KIx6187WxrVzUYiEnIIm5yJ9Z8uzoQ5LYvtU3kPf3EpHYwAaS1c39SBniDAcKLhWPyh5CWEtjhQ+gkhPtMgK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357071; c=relaxed/simple;
	bh=2fWcMDtkWqv1mERO/xRsPdRepKOC4cQyxGY8M0q2Fe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOIACUnwxiSyLJYvihArhtjjXHHDrjCvZ99QqLHJHjjSEfCJcteKRddr4I9fOzlwluu9R2q5kIOBzCHN/MHEmETtPUhmW59ySMu0p5RN0j9tstVah0eo0GBOdGOejpe7UNiveEkMtb8t2dqoetjFATKnAfWmBJnq2ODnsjkbLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDlTP7xu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPEo/R6r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S4EWhB429032
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 06:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=P3I4LYaQOs/4odTpSKMDTViLQA9lm7iSCKm
	mMCvUC2U=; b=XDlTP7xu5+MuWPvZ9onHS1YsyY/5gs3/DFrk85FeFa4iw2oAakQ
	Ans8mgvV6DV1lPLeEapgSgrGgx0xBoQzdv1YaEL2ZqTUK5dk29t2bJhdTho9KV/2
	NjMt1sqfLGhSLch8VXdgMbTJkAjOaa60CMrNUDaMe+VPVJKZFiT/yo9+ZjVR89Hm
	SjGyrYOCQxVTh6PKBy1STSLKQfuwbn85LMa3xK0PZzWwweLfOzbCvPWt3/xAijvK
	Mu0iNx8iiqX4EyJQ8mdH7/k60z4P9QLurnRqK9d7X1cWnmBrjFA0PP+ikvmS2WF6
	HrVB2nDku/OCadAHBPrvgyLiKxyNdmgIi/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7x33m9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 06:17:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c44bf176so12987683a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777357067; x=1777961867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3I4LYaQOs/4odTpSKMDTViLQA9lm7iSCKmmMCvUC2U=;
        b=JPEo/R6rCqpF1nmVIumH0G7KoBv67vdBN+oYz0n9gOqxI8oXb8nlXXF86m1zCSCxlN
         x6GesT+ZwPe3czxGRi5f1HbQpb2Zd6CMWXQo4LkD5NKIAjue/tipeWvBC9Izix7LmPOm
         NmO5mwl15IT5JaUCDczlkJPpnDkCJBS4odusf2no6gF/0Ft92URgEdErnbLSNJOz2M2b
         HxxvrVCpQxdk77epT0DsmCfS5+6a9aARUIC9TRo4Efo4FeyYFDpvQSaleslWwTLjQTcw
         4ilFP7VjL4aCLNFIVkcNdzYNIyILLznV+HsnY7Du2HKW6XE5XfKMcXJhNdloI/VTKojz
         3Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777357067; x=1777961867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3I4LYaQOs/4odTpSKMDTViLQA9lm7iSCKmmMCvUC2U=;
        b=tAL7XQoysndOvbt9LnVp/Yx7z09EYxnA0hmL4HdaQwOeXeaRCa0BL9cZgTlc3xlnD1
         WhJ8FNBrE3m1D9Q1ouK/j5q9vv3noAOg/lT2NikIYnrCvvWtlxaYplS+2WGshZtv3Fkc
         h1+azeWBjnw3airQED32cfS4K1PDf9Pp2NIi8d7KedTrL2YZ0oqRn8m+u8fyxaLo9yIv
         r21fQeSL/WwqnpKY6zXFqxrkW8jqo/IbvqNVd8bSdjsNNIeMb5Ow1hjdZhnts1bh4EOt
         Tz+RZRQW/0TvS5QgPXexq2/FJLR9Vg3c+joVEUi4IBftYRVMTf/kv8NjRG9hSvNaAcf9
         qAnw==
X-Gm-Message-State: AOJu0YyhGbkZx6f7FgcG0TMi7aal+wPJspoVieCqqoL9fAM4AzaeRagG
	hdHSjmaI37al39J0MvpUpz87J3gG8cyEXe70cuatnypmUHCgBL9/9OZY/R9eRwyFLimub4DwzI7
	HJriYZ+jItt1r6gaKWDwGwGu2Q3eGsXIMGk6afLTDCdSLOmW5rkd0TK7DBCWKYWgOuvyvyZG9wg
	cZdQ==
X-Gm-Gg: AeBDievRs7tDIpbth1ZUzAB25PD2gKX2dlp1Gh1JWscaKK/LFNcDit87dvR9yLIThsV
	UYOIkXruYw1ekpABb3PmOAB/Yijys4NpCIK9Xs6e+puVzbB2gzsXxC0deeWqj30IkAyDfb010RX
	B87W9OmMTlZLfkBBkX4M0Z6U2eXQHHhU7zqqfrsor/z1P+d/Z5vCnroDHORWHvhyFA2ku/ov88L
	1mVkdll+1zpcgFzJeToC4iTdwa/Uk756OIcqJ19W7svMp7A1ijZjf8kPF9G6a/e0qzEsiT/DmHM
	cNqMOAb1d9QYbqmrpGU2uHfJUDyzlDOGSHqNlTfFs/jMInf87I3VADvLfXXXePTM9i8uQMc+v6U
	7qRbegopFSCGWkVLZJkmfovAjxb+gHckxruxSeaO+5hUvWsSza2NVt2R/GqLzOaHVLLTuVi8sff
	uR0pjn1pNXq3goXSvy9x1hyg4+IJ7U54NbSagswDEg4UFHNA==
X-Received: by 2002:a17:90b:1dc5:b0:35f:bf4b:c396 with SMTP id 98e67ed59e1d1-36491f89e45mr1878524a91.1.1777357067589;
        Mon, 27 Apr 2026 23:17:47 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc5:b0:35f:bf4b:c396 with SMTP id 98e67ed59e1d1-36491f89e45mr1878492a91.1.1777357066981;
        Mon, 27 Apr 2026 23:17:46 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490dd333csm1455604a91.5.2026.04.27.23.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 23:17:46 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2] wifi: ath10k: skip WMI and beacon transmission when device is wedged
Date: Tue, 28 Apr 2026 14:17:37 +0800
Message-ID: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA1NCBTYWx0ZWRfX7kwoO4/zhXN4
 sgOIbFCyM4o6SLN00O9xtjUgucgf+7CBQdUxNOEt79pgIASx1IB5bw5ET/Q9naasJTA8AFHSDkG
 NBRT9MVTodG5jyE4LTn4KpqMK8k27CubxUGt43By1hgqqkPPIbBkBnNt2f0ucQ5N4nxCqKBF4Pw
 RfN/+tEO/jNu0wsWhxdbw4Au5IClrJfyPEjXP0H89fWchO0OH9HL4/unGwL582KTJaGBmL+96vw
 vv0uu71WkMTTp7ZR3IB3XvHfHGjGy0qxU7goTdE1M3buGabNq5tDXJ9Lq8B1kZf/Dsg3ZBKxCCM
 3M7sn0yBsUXYfkwfw+qgU7E1LjBnWeWwrFCsS80CWfd4pQ0CaLc9I3E9FUIwOzG4NzddWcyMdHs
 vt6uGw3/9gNAA+de1sf4uT2XwbDJI5Y273hslCkWI7Q00RQBfzHdbgfueD4ej8V6k2brfFA6D9p
 eYqtt0gB+/D4cDw3CIg==
X-Proofpoint-ORIG-GUID: kAHBYo5mJKzbZPjHSRWLl-thVi3eqZGn
X-Authority-Analysis: v=2.4 cv=AJEsYPsu c=1 sm=1 tr=0 ts=69f0510c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ojnUS93u_2yoTveIRj4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: kAHBYo5mJKzbZPjHSRWLl-thVi3eqZGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280054
X-Rspamd-Queue-Id: 74AF147DFDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35440-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kang.yang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

In ath10k_wmi_cmd_send(), the current code detects ATH10K_STATE_WEDGED
and sets ret to -ESHUTDOWN, but still proceeds to transmit pending
beacons and calls ath10k_wmi_cmd_send_nowait().

This can lead to incorrect behavior, as WMI commands and beacons are
still sent after the device has been marked as wedged, and the original
-ESHUTDOWN return value may be overwritten by the result of the send
path.

The wedged state indicates the hardware is already unreliable, and no
further interaction with firmware is expected or meaningful in this
state.

Fix this by skipping beacon transmission and the WMI send path entirely
once ATH10K_STATE_WEDGED is detected, ensuring consistent return values
and avoiding unnecessary firmware interaction.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---

v2: remove QUIC copyright.

---
 drivers/net/wireless/ath/ath10k/wmi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 0bdb38edd915..e57588c19c80 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
  * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
@@ -1947,15 +1946,15 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 			ret = -ESHUTDOWN;
 			ath10k_dbg(ar, ATH10K_DBG_WMI,
 				   "drop wmi command %d, hardware is wedged\n", cmd_id);
-		}
-		/* try to send pending beacons first. they take priority */
-		ath10k_wmi_tx_beacons_nowait(ar);
+		} else {
+			/* try to send pending beacons first. they take priority */
+			ath10k_wmi_tx_beacons_nowait(ar);
 
-		ret = ath10k_wmi_cmd_send_nowait(ar, skb, cmd_id);
-
-		if (ret && test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
-			ret = -ESHUTDOWN;
+			ret = ath10k_wmi_cmd_send_nowait(ar, skb, cmd_id);
 
+			if (ret && test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
+				ret = -ESHUTDOWN;
+		}
 		(ret != -EAGAIN);
 	}), 3 * HZ);
 

base-commit: 34a5329beee86a22a446e27eb37f06caa63479ca
-- 
2.34.1


