Return-Path: <linux-wireless+bounces-31589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNaCNWV9hGl/3AMAu9opvQ
	(envelope-from <linux-wireless+bounces-31589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:22:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCECF1CE8
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C5ED300C990
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4993ACEE7;
	Thu,  5 Feb 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bzfHVJh4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fFgsbuin"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1642DECBA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290526; cv=none; b=cBr84wkfDLT1Gf4nKHIy70jYzzPGiQ2xekz7RAKYKiAy30Bc2UqBhQh5eHzRQ+8Gi5btPMmrkV8M855goGFCkuZTcRRxcXe45DsI5VaGGoPzK85IZSpoYAKWWmKcc4SohOfn4OGEiFFOSoVEdCJ0WmVxFdbfBSHv8xpZSQjyVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290526; c=relaxed/simple;
	bh=Pg5mzM3bsl8Zjp/cBDnu1jTW3NKpnBd90g4CZIN7VVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vb/sOC0y5yhR8eroT8sMZpyz/TghWsVx8Ciprnqh3ypPvCp1+6Dgp0ZjssVDgYNdMSLBKQeQD7tGAadGkJ+H1MfeyOyLU24JopqLKkGhUfMS/6lHf1To8RWBEr8ufBoj6KcntNwlXZvKlwDFokGmPIinwPsXTid1M8MQoK80Srw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bzfHVJh4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fFgsbuin; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Ae50O2639660
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 11:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rDV23EezmrL
	wIkDnp8z3PHZwhmN2sxPytgs3mE1RnD4=; b=bzfHVJh4R9sy+AY9qOEZ/5pImhb
	8lJ8zpIMD4uXZveVv4mSn/Pym81RizEORXf3c5mQrlqgs5qIvAusUp859/Vd5so4
	LpBEmX6S4N+QF+YibKxs6jRT7izlhGsYn01MS9Ug1Cpg2zLHYvu0R2Q+lbSf3KZO
	6RBKSnE4mUrVhRBkXMba7ugl4EKbIu9/SyCi9wI2rRXd0jzN2hzqkBXcknjaU+0p
	4WcNDPxNJy5CZBZF4qI3H8LM2gZRJVDGyXUEFMyK6z7ByH8EZbvq+CfC//JxlZ26
	ouDEb4ioeVSymZwtl3Wxmggx/ZjHnUZYENp85mJZ1cJPv44Ut4J9wvf3WnA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c47qvbjcw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 11:22:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso1069016a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 03:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770290524; x=1770895324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDV23EezmrLwIkDnp8z3PHZwhmN2sxPytgs3mE1RnD4=;
        b=fFgsbuinsNoKFIC3G7CSy08Zf+2uw7LQ3Td7xtpelsxtkl2ujTQb8k6U/N4dq6P36E
         WeLfT9lS39FrKlM6VkX4ulFd1gvq9k2NQzlKKCmDWl8pSJeRHLyYCfz4w7z3gz5O93NO
         7pEArEeM8UbAmajmMW4D0dCCpxP/EHV/gdiSX+chtXZORGHn+hIMS6XVu3097AOX20WQ
         vN5n0u/Ra6G6eLU5svbUEjrY5d00JWNq2++E7XRsOCrisS5uqpW90sqTCJKI2U90G6Om
         yBS25TDwnW5BlJZJIqwhfZ3ls9fCPJlaS1/2AcmBS8NA3g+mgsizl0ky/CCPEJSv2AsX
         3k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290524; x=1770895324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDV23EezmrLwIkDnp8z3PHZwhmN2sxPytgs3mE1RnD4=;
        b=bvYxFxbtHER39ab2rFSVBlkrxw5GuqXuGEdUQ62gCojYU4hb7xHDyFhOuL1Kc4oeAq
         sbdh5Udws0DW5fo5HNE9+UJlQUBTm+FyDedFscvPgJt+jrHOpHn2Pa/5X5F7F/zO9WBZ
         tc1rhjur+cwVj9xbNxty3b+iSQhAFs/FUn0rkMsMH/jhq9YZP8vXhs9xO2Vl85Xl6ePM
         +X/naQdx+JXPvhFIqnyDvIt/c9lxyFao70CwODWcT7YU0Ec2uMe/mGwjl1u74AG2Y0ZP
         DpLd1K8PWPzTzUZ7GMwqCrdoJMYHZbkACT2NpX1hWozgVCQL2Lsoq06YOWsqNueqyrF+
         5+aA==
X-Gm-Message-State: AOJu0YxS9f6sM/6HwoPtnjCs0z4I/18L6SUTfHl2RhUmToaYfcGWY7rT
	YvEspCGMPuvC0cMe+gzL8hHI3rspB0EkY20kAuYhVuGohhtDjZXWgb6IuEEMF3pxaoSZE32uvgK
	AHQpkB1BTLK5/MeD93DMss6dcTF+AmbAPa84wwzEV4Zl5greR/Kx8CV1xRlZMqqqF/9/2Hg==
X-Gm-Gg: AZuq6aLQV7OWJiLNOlNgjdxaxMnGlx3nPmDeBwxYK4X06eFuhE10Vq1VFsYJ6OFsmMY
	koae79yx4FCwApVrxqXJch+2ajwWIpsPdNi5Qw3Ksjxmd+RSKI3gVmmpyPh3Hgwaxn9cBIq7ldg
	3TTNr96ZjcncWjXhezddFQzTz54VpzyvIJtsZQ4/hW3D+6xSasFwq1EsRE6cHPaHZJ1B+a7+iZT
	3nVpepA0Ktbz4Hf4Wgrol+JhTga+mweMu8Yv74Zr2t4urWxv/91pmRBmcat8yRqoW4Ku23kyP0F
	YnMBDtjnpYsi4fwmWskFKU6/8+rXkCLX++6onRfAH3Z59k1alJvRWBhiMWiH0LydK5nk1GpUHVp
	3ZlOmUTgH75CFoFUd6kBmZlDUWhIeGrPV811PskTY2F9yJkv9XnxUXZj36Ve1m0S/izj73NNKri
	l0sgIzHurpxOtGBYzmFv6Jw/A=
X-Received: by 2002:a17:90a:c887:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-3549be815cemr2562853a91.8.1770290524304;
        Thu, 05 Feb 2026 03:22:04 -0800 (PST)
X-Received: by 2002:a17:90a:c887:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-3549be815cemr2562836a91.8.1770290523806;
        Thu, 05 Feb 2026 03:22:03 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16401esm5651998b3a.4.2026.02.05.03.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:22:03 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Hari Chandrakanthan <quic_haric@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 2/3] wifi: mac80211: add support to handle incumbent signal detected event from driver
Date: Thu,  5 Feb 2026 16:51:45 +0530
Message-Id: <20260205112146.3997044-3-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
References: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GaEaXAXL c=1 sm=1 tr=0 ts=69847d5d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TrMrth1LfLSB4MfFtaAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: j5zQefAbF4QreMLcfQ5NU2LX1IHKB1nh
X-Proofpoint-ORIG-GUID: j5zQefAbF4QreMLcfQ5NU2LX1IHKB1nh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4NCBTYWx0ZWRfX4NoBEyz41BMT
 cmE3MoWO+uKKn6CfPF1tRMRDRjiz6z1ZWnbmN2EDd0WFeoopgCStJ4ZRDfcMUOF8J1EcdKJ1NvZ
 qmumBbuDMvipf4sI/9WmfD/ZsGuLpB/VjqzCceJ6uomH1kIS2x0iPbQ/q4C4Rz3wzNvbrpfTM6/
 3Pguas+NyIfgb4esCFvbHuqdXJiu9Sgp5bRGs8JfW46WCRkmpqt8MQo+d8QBrZtmez+v5mhT34S
 DER98IsY8/9AjTsnYs16FhmZ7J3lNcC/CSOG78tI28/PaAKK9zc9mYy+Kh9R8cDZ/gl2te9fGTE
 nuXhuJn3PX8iy9h1OvJlFuAHIN7eeSSI6c1tF2i56PdsnBJKtJqeKb7fH1p30pJGgKnZ+RlnDFn
 CNs3NwKdmD4MKPgmbmHqJr8JXx0bV/yeFWyzVt8SpaUQdzUPg5YnK8xFkuBfCmApqhHFMIG4vH6
 gfgy2r3UMOQ2/G4K46w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31589-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,quicinc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1DCECF1CE8
X-Rspamd-Action: no action

From: Hari Chandrakanthan <quic_haric@quicinc.com>

Add a new API ieee80211_incumbent_signal_detected() that can be used by
wireless drivers to notify the higher layers about the interference of
incumbent signals in 6 GHz band with the operating channel (mandatory to
pass during MLO) and the interference bitmap in which each bit denotes
the affected 20 MHz in the operating channel.

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Co-developed-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 include/net/mac80211.h | 14 ++++++++++++++
 net/mac80211/trace.h   | 26 ++++++++++++++++++++++++++
 net/mac80211/util.c    | 14 ++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 36ae7fe9ddf3..d586eab10f26 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7899,4 +7899,18 @@ int ieee80211_emulate_switch_vif_chanctx(struct ieee80211_hw *hw,
  * Return: %true iff the vif is a NAN interface and NAN is started
  */
 bool ieee80211_vif_nan_started(struct ieee80211_vif *vif);
+
+/**
+ * ieee80211_incumbent_signal_detected - inform that an incumbent signal
+ *	interference was detected
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @chanctx_conf: Channel context on which the signal interference was detected.
+ *	Mandatory to pass a valid pointer for MLO. For non-MLO %NULL can be
+ *	passed
+ * @incumbt_sig_intf_bmap: Bitmap indicating where the incumbent signal was
+ *	detected.
+ */
+void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
+					 struct ieee80211_chanctx_conf *chanctx_conf,
+					 u32 incumbt_sig_intf_bmap);
 #endif /* MAC80211_H */
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 0bfbce157486..74741a61546c 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -3136,6 +3136,32 @@ TRACE_EVENT(api_radar_detected,
 	)
 );
 
+TRACE_EVENT(api_incumbent_signal_detected,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_chanctx_conf *chanctx_conf,
+		 u32 bitmap),
+
+	TP_ARGS(local, chanctx_conf, bitmap),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		CHANDEF_ENTRY
+		__field(u32, bitmap)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		CHANDEF_ASSIGN(&chanctx_conf->def)
+		__entry->bitmap = bitmap;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT " Incumbent signal detected."
+		CHANDEF_PR_FMT " Bitmap: 0x%x ",
+		LOCAL_PR_ARG, CHANDEF_PR_ARG, __entry->bitmap
+	)
+);
+
 TRACE_EVENT(api_request_smps,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 4d5680da7aa0..0e1ee2559130 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3670,6 +3670,20 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
 
+void ieee80211_incumbent_signal_detected(struct ieee80211_hw *hw,
+					 struct ieee80211_chanctx_conf *chanctx_conf,
+					 u32 incumbt_sig_intf_bmap)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	trace_api_incumbent_signal_detected(local, chanctx_conf, incumbt_sig_intf_bmap);
+	cfg80211_incumbent_signal_notify(hw->wiphy,
+					 &chanctx_conf->def,
+					 incumbt_sig_intf_bmap,
+					 GFP_ATOMIC);
+}
+EXPORT_SYMBOL(ieee80211_incumbent_signal_detected);
+
 void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 				 struct ieee80211_conn_settings *conn)
 {
-- 
2.34.1


