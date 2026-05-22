Return-Path: <linux-wireless+bounces-36791-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MBFGmEeEGrqTgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36791-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 11:14:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7054E5B0F40
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23E173004C8D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05525B08D;
	Fri, 22 May 2026 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwoSN47U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DaPZcLMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7902D839C
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441151; cv=none; b=NYrSdHo+t8SuVEQUWikhAvSTv4bOX2K0mBQTx0IoHbxE+Xh9rdyW+hMGdt0GRKm/sjiHHoYyoL91H2sZW6yOuwSQFD6A4pE7Fpzm3JUuEzS/b4cKR7dfVEdheA2mbv0AhTDSILz1NJjXEdAO/EToB4b2KnCUFrVRyyH3KQfgYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441151; c=relaxed/simple;
	bh=4i+UKoE+DNga2FlGXGH47jlyyUvNvXFV/dTOs2hWOoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GBb98g0NRoPlWeUQqmc5ckv/37Syz//L1NPSk1xYaNNivLWdR//LePBtemxzZJOcTmu4IzywUM+se6/3dY7O/Df/DTvDq0/CmW/QY1oNmj7gyGJwdlohggLtQVC5Wj782v+0JLhr6zvaiax2sDU5WtbHCO2Ve68xxc6Xg4yWWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwoSN47U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DaPZcLMR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7cTF9778711
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PHJH6x443Ki4p9DJOp/htAz5X1XhDK/9Cuy
	3YGaq0h8=; b=NwoSN47UJSHu2XX87ZDbCHlFCCeJzzys28Nm1icpKohBaC0zHyI
	NB/8Zfklm1fXtLucTKdl9IT23OZsnSlHvHbHj0ABW52ISmJCsu/PGKdn67RSSNUC
	3oHV4q//k4bP+CB45CZrToLGGAvUJST7v94vV7MS01KNjMtQ91ECFYqMp3HBKAqG
	WSrH/sGR/D0H208imfdkCdndZk5vY9nhn+zH0fRrAPYmZ9weaPWjmGVbpJ6b3SFk
	bPJIpAN7h2PA/Sn8Q4VKqd+hreUAR93wDRZTop2oj/bPkBuedoNR3yChOa/bxftk
	kRSJFrDUKtRE1dmtElQQB2GF/AddZCdbY1g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7asygf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 09:12:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b458add85aso77096705ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779441148; x=1780045948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHJH6x443Ki4p9DJOp/htAz5X1XhDK/9Cuy3YGaq0h8=;
        b=DaPZcLMRqa2wOy667MiLccucTV19FcXruhWziH6ys/1phMApXtL/AdHzmVTHrHPCvO
         EJsAkswSxCuN05QA/0Ef9DVWqNjSUMKqzrA0wwR6VTCKKqd1JD2T1aigHJOatLYjDHCJ
         qsoPqIoQfiTpYlh+n39weRiI+i6cRzhs9uXIcxgZ6fOmBSbGaG+82LqHAmfXVXfOkBd2
         /gYWMT4l0dYubI2TuX11LVgQrVRgngxgPcFNp5i9Zg2t98+L2eP7GkApFfzdOsqah7RD
         zlHMvspREaL9AohdQP4FXROKE4KSvEP1DmNjt4Yr7uGClmBVokKaTLPjyoxsBh8mWYN+
         Gxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441148; x=1780045948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHJH6x443Ki4p9DJOp/htAz5X1XhDK/9Cuy3YGaq0h8=;
        b=oFb/JraTpCI6hX78BRUlL7Ugu5lW2EneCjM50IMcWESE1bTrl+Lc7dhnGlYQonZWSt
         Z+9fCHG/ejoa+pDqF3jwjphDXJT7oDxLMJ3T6PxX0h9o67mquIgOh6rlgSIHL9jGSxuz
         dYG22uYO9OLErAIB+IAyCO8+r2a5des9qta1LtXtOa2stMKj6Hxt4F245PxxkrVIzkND
         E194jtDC2oHg3nNoTDmyvjnCjL+8DzCYAhGET9qM+YfHZ41BhzKAY5NfaSetmUrMEo3c
         St8pXqQx+yZsS+22lYN9aAP1Zg5CVqJfzhv2Qr2NHQ2k0Z5v6nSamN/UNLiFg3mmItbF
         Xhjw==
X-Gm-Message-State: AOJu0YyOekh0OohrC7GiZxgdgEY/dOxGZbMEkd+DiTXTwx2WkiJnzHPK
	V+WgWvGFNcssnDWhFffuqEeaKpZOnF1npVjX1ReiTWPEGwqiSdsQKwRjdK1TlVJrnWfa/cRCWc7
	w1l3oN9lkE3mbhotvxiPMpUxAPh13Fp693i7xpTohsPt2A5ZUm4lAFVkRVvoSE+DAEt7w2A==
X-Gm-Gg: Acq92OGwCD6n/lF/wNK61m77sFyXB0IAslqcERx+nPS8BpJcKsvGllIrccfryh/6r8d
	2Xr3hLISDJOaxs21hisuxPLxsmwH2MEmd0/OZRFedZLsuTcP0AFJblMTtIuufaMPnt+aB5+LdY9
	ETxnzXtAhbIbHHNUbNvU3UzDB6W//b/3N/oA2Uo6jXAjQcUZfFr9p79bpLXWWuvz4DamnJhB2UO
	h6mDBWLGnQT4C3Okl9WJBlAERUYeFUzgC5IJWV4XUX/UJqVyfHZnusQxKqlD3pm5fP48gSdVVjA
	ie+3u8vb8u9XHJP1Wxy/JnJBM26UP1Q+QYbBEfFx1gCkfNfEudmjI6L0MtqWMpw5LR4vf2UMsEJ
	Qojj59VoD0lJ5/qPcWLYHv3AJX9SSd1Kl1Mh3G0NoJy159CicCP5Md4nZ22zW+y54hQO4hwkRAO
	SbCvkQa05nLMa35MS2k7X5mZuj5xg6jemvViQztxE0CfRB4apqZzg=
X-Received: by 2002:a17:903:1ac5:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2beb070c102mr29301165ad.38.1779441147762;
        Fri, 22 May 2026 02:12:27 -0700 (PDT)
X-Received: by 2002:a17:903:1ac5:b0:2b2:4fe3:7b89 with SMTP id d9443c01a7336-2beb070c102mr29300765ad.38.1779441147283;
        Fri, 22 May 2026 02:12:27 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5914287sm14958485ad.79.2026.05.22.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:12:26 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Prevent incorrect vif chanctx switch when handling multi-radio contexts
Date: Fri, 22 May 2026 14:42:00 +0530
Message-Id: <20260522091200.3179640-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YfzHnLnq6i5eExfqJ9M9XRV8KVnT3fcz
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a101dfc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=W-UYK7jDyllEtgm6_WIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: YfzHnLnq6i5eExfqJ9M9XRV8KVnT3fcz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5MSBTYWx0ZWRfX58UpxXXdzT2k
 AJdKBJWUUUXkxs+qnHVZ4Z5F92I8M4TrEbHLQ/nJSXG5aUcNOHb7hoAHdwQQq3JK8ctGzngYRmY
 5N8loFnPN1nqJKBgcpez4ZqSSnJWSJ7+ZHqfXHdK8AmFFtUHm4AeWgiWQF1+LuYasCJa2nvjR89
 QI3Ve9n8XUvWopLVv/butPUHv3CuJQ4oHcvLri6FsiMLuU0slGbvzIO9hKWrq3LNS0fiC8ND6vY
 Tq5FFxqlpq4xjZ7wy5MLIy+J+SPbgfNPQAd2TuKYs7ekGKHd2OMe5nx/TH2Um0yRKyu+UzHrDey
 yKNGeRvc9kw8YzzUwep6Lpk0nGcFjtXoof30WulBRShovvgz2y4fgAVXCzl9fwM6z+D7kzWU4/d
 KO9yd5qakPIc6xco6aJjbuVvqB/N5VJdzDp1BmtNOK8ozH7eMh+qKEsNiUUlyCIwOBjizQhj2Pg
 jfRBjaW+00pbV0hn2sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220091
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36791-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7054E5B0F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

When multiple links switch channel contexts around the same time, mac80211
may complete CSA for several links together and invoke
ath12k_mac_op_switch_vif_chanctx() with an array of vifs spanning more than
one underlying radio in a single-wiphy configuration.

The driver currently assumes that all entries in the vifs array belong to the
same radio and derives the radio context from the first element. On multi-radio
hardware, this can lead to incorrect vdev selection/updates and may corrupt
driver state when the number of vifs exceeds what a single radio supports.

Fix this by validating each vif's switch request and then processing vifs
grouped by their associated radio. For each vif, ensure the band does not
change across the switch and that both old/new channel contexts resolve to a
valid ath12k device. Reject attempts to move a vif between radios (not
supported for now) and return -EOPNOTSUPP to upper layers.

Then, iterate through the input vifs, collect all unprocessed entries that map
to the same radio, and invoke ath12k_mac_update_vif_chan() separately for each
radio group. This removes any reliance on mac80211 providing the array grouped
by radio or sharing old_ctx pointers across vifs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 87 +++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 54081beb9a5f..5c8e25d40a98 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11476,6 +11476,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			continue;
 		}
 
+		if (WARN_ON(!arvif))
+			continue;
+
 		ath12k_dbg(ab, ATH12K_DBG_MAC,
 			   "mac chanctx switch vdev_id %i freq %u->%u width %d->%d\n",
 			   arvif->vdev_id,
@@ -12267,23 +12270,85 @@ ath12k_mac_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 				 int n_vifs,
 				 enum ieee80211_chanctx_switch_mode mode)
 {
-	struct ath12k *ar;
+	struct ath12k *curr_ar, *new_ar, *group_ar;
+	struct ieee80211_vif_chanctx_switch *v;
+	int i, j, count = 0;
 
 	lockdep_assert_wiphy(hw->wiphy);
 
-	ar = ath12k_get_ar_by_ctx(hw, vifs->old_ctx);
-	if (!ar)
-		return -EINVAL;
+	if (n_vifs == 0)
+		return 0;
 
-	/* Switching channels across radio is not allowed */
-	if (ar != ath12k_get_ar_by_ctx(hw, vifs->new_ctx))
-		return -EINVAL;
+	struct ath12k **ar_map __free(kfree) = kzalloc_objs(*ar_map, n_vifs);
 
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-		   "mac chanctx switch n_vifs %d mode %d\n",
-		   n_vifs, mode);
-	ath12k_mac_update_vif_chan(ar, vifs, n_vifs);
+	if (!ar_map)
+		return -ENOMEM;
+
+	for (i = 0; i < n_vifs; i++) {
+		v = &vifs[i];
+
+		if (v->old_ctx->def.chan->band != v->new_ctx->def.chan->band) {
+			ath12k_generic_dbg(ATH12K_DBG_MAC,
+					   "mac chanctx switch band change not supported\n");
+			return -EOPNOTSUPP;
+		}
+
+		curr_ar = ath12k_get_ar_by_ctx(hw, v->old_ctx);
+		new_ar = ath12k_get_ar_by_ctx(hw, v->new_ctx);
+
+		if (!curr_ar || !new_ar) {
+			ath12k_generic_dbg(ATH12K_DBG_MAC,
+					   "unable to determine device for the passed channel ctx\n");
+			ath12k_generic_dbg(ATH12K_DBG_MAC,
+					   "Old freq %d MHz (device %s) to new freq %d MHz (device %s)\n",
+					   v->old_ctx->def.chan->center_freq,
+					   curr_ar ? "valid" : "invalid",
+					   v->new_ctx->def.chan->center_freq,
+					   new_ar ? "valid" : "invalid");
+			return -EINVAL;
+		}
 
+		/* Switching a vif between two radios is not allowed */
+		if (curr_ar != new_ar) {
+			ath12k_dbg(curr_ar->ab, ATH12K_DBG_MAC,
+				   "mac chanctx switch to another radio not supported\n");
+			return -EOPNOTSUPP;
+		}
+
+		ar_map[i] = curr_ar;
+	}
+
+	/* Group vifs by radio (ar) and process each group independently. */
+	bool *processed __free(kfree) = kzalloc_objs(*processed, n_vifs);
+
+	if (!processed)
+		return -ENOMEM;
+
+	struct ieee80211_vif_chanctx_switch *group_vifs __free(kfree) =
+						kzalloc_objs(*group_vifs, n_vifs);
+
+	if (!group_vifs)
+		return -ENOMEM;
+
+	for (i = 0; i < n_vifs; i++) {
+		if (processed[i])
+			continue;
+
+		group_ar = ar_map[i];
+
+		count = 0;
+		for (j = 0; j < n_vifs; j++) {
+			if (!processed[j] && ar_map[j] == group_ar) {
+				group_vifs[count++] = vifs[j];
+				processed[j] = true;
+			}
+		}
+
+		ath12k_dbg(group_ar->ab, ATH12K_DBG_MAC,
+			   "mac chanctx switch n_vifs %d mode %d\n",
+			   count, mode);
+		ath12k_mac_update_vif_chan(group_ar, group_vifs, count);
+	}
 	return 0;
 }
 EXPORT_SYMBOL(ath12k_mac_op_switch_vif_chanctx);

base-commit: 30d516006fa1f72f957c18c6171f5680dcdebfb0
-- 
2.34.1


