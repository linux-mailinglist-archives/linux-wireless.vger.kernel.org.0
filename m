Return-Path: <linux-wireless+bounces-31590-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDdWH2p9hGl/3AMAu9opvQ
	(envelope-from <linux-wireless+bounces-31590-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:22:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E8F1CEF
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41AC0301D96F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 11:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1635581F;
	Thu,  5 Feb 2026 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CH51mSAE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GF/sypie"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9222DECBA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290528; cv=none; b=KmXUmUHlaKfZGJohwIzeAy0MDd7U0wMmLHsDd9k1orOgk4F5y1VJnOneg9/wOusG/A5OS/8g62wloupIS9wzbfT8FibYBsvaP9TWiPHva9i6+B+Xz2d+xo94vwHc41WdDv7rrCChkm7pT9oj4Pc4V3XWrRh46dDCYFWP84V/kkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290528; c=relaxed/simple;
	bh=6JR7o0/LB5SZR1wjIlEy3co7TD7j56CV7o0rwKZUI/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfpIC+6fxapUC7hYePlenvxfjdQkQxqNAqFufsFnV8oEFN7AqExUu8coafs2TVYmSTYSsIXFtYVAHkZ2hBHUyGwVrxaA8eoBqtkkyJaOtrQokXQ/QeX+iA6OgjlHLFWmO06r4wAQGu1UIOlq9liBjR8mV36qqD7+6GIdo3MVSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CH51mSAE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GF/sypie; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615AorOw2639846
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 11:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7uts0EJed1z
	+UAvKbeehqXWrqJhT37AqcUM2ewQZisk=; b=CH51mSAENpC6RmcxO4ntETtFuQc
	lg0cQz24HcJx5O4LrCVytmeKkWwGEewPjflz7uX1xeDvczGT8dvbPBx8mOj2Mxn4
	ke1pvuXf1jOvaCPK0dJqRnOGdBNL0SVAh0tjQ5KcOpGm6FUNDpi8YNbPZ1E0uD8V
	4r145GmSFX91pdETaNjbAEixNyt+N61pcu8oY9/5LhR0IeYLKCAZNSGIbVXBctv2
	cIu5E1X26X7UxLhtfJKB39gWOl5C3SIjpCj68q7vyPsKgSZnt1MVG32xUJivfG5y
	DxXs0r/3wi7tp5R9aQOTxspP/KBjaBAAqab+fHUhTqIGUgso0LlWvD8TJxQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c47qvbjcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 11:22:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8243b286ecbso167646b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 03:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770290526; x=1770895326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uts0EJed1z+UAvKbeehqXWrqJhT37AqcUM2ewQZisk=;
        b=GF/sypieCQ6k42ynz6vBIqoBcieMOWS+w7V7W4kq49U0CYCBb8qXZna3leLDtjXP24
         yOg0YAQFmSuIoGZbdQPvu4EV63NSKS7phcgl80cLJDZYe9ufrnZ3CbSefPHG0ZlVG/rx
         VvN8bXGiHPLFWBl33T38aeG3j47cs8RCK5hJMLVYO1i5veYU4sRWujBsrXocWAP7Q1OD
         cNF+3xTwViWuZexcTilKDnSp4jdBURdRn5VJ0ZnhCjn7pNdhXSjV4/J5WXVnggo5bmoQ
         UELtvmFr/QIsFWEcilZrA5TbAlcn+fb0oHP2smoP9KERKFDm7jhMZCan6+v99ge204sT
         zLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290526; x=1770895326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uts0EJed1z+UAvKbeehqXWrqJhT37AqcUM2ewQZisk=;
        b=XN/0cr08xxc2SUksbChLfty5WlnqHxfQkIc2/UrZUxSYWNCKWDdGA5oPNGhTvxyzwv
         jEX+c5mldQj/CIQmTY6HABg6nb5dR5KHONVizc5HmmjFI3zyI9wxhEVFRBVtLNOECFAT
         9ApsvCBWhLhtHWeii6tOZXKLww2W5vB3eiawTw7S5B34Ew1V4KRXO47OMAPTDQGqR+GM
         G+PTyxFJk7SjyWqe2et1amI0n5JMqhPxE/UZgSdE5jZLx3QawKXrjODf7+wzrBTz6K4R
         EDHekcdXDZsce1y5aZNdn51y+T1sTgfJAgylzIvmWpG5+zMHsv/VDPnWuSZIs7hkWYHQ
         dmJQ==
X-Gm-Message-State: AOJu0Ywy4ILm+XuZhxOFDd50xhz7PHxl/actRTZBUf8NHtKBqD0C125b
	hgWoqpRz6atD0z0gKQcekMT4vZvo1tJjtmsNu6a2SP8NkT2ltTCoadT6jwn0YsKvQV0bhzpGsx0
	8zHeDG72fiqWtYDQjJMsbHXDsu7Rg0en2CHSMcvFcoY5XYjbMooj/8/7LgCXAPl1IloJO4f2Pv3
	DM7Q==
X-Gm-Gg: AZuq6aIMjJNSap9BdyhR0qqbJWWHIxrpcYKzPE1dxzztZn2dOns1RnXzWKIYdc4IYSa
	wF415bwmUwTGfEU3tveoDlWQX9z7WMbWG2m+AGDa6bqQCKdvF5fzMcI8r5AC6OkjRLeYZMCYaub
	TqI/jx492xdgrcGyLxz0tEhxE/cycufAUBfa04ee2BweBrnUX9WEAvm00a8GVNoPrYBvNmRBc3k
	FBcmXs2A4PdS0+/BNzjJHlkUC+Wyygu1gEvglEly4kKeIhS01gw8V+jg/gUgUb+6vDdqE+vtNX9
	fkbb1Dyd9MzroTpEgQIvR5AZbHiTrryhwnbeMOh3InXHU0B5xGbYsoOzcJMhbiLLwl6clYFgKiy
	ALE4k0J53R4FQ+VmEPvfvsjI2waUsR1y0LE9sO/LfF6XN0BxfbGu11jvvd22nQDRE2UsFTK22sX
	Io46HNEKxcwHDq3ugYkCHJgCA=
X-Received: by 2002:a05:6a00:a210:b0:81f:3eda:9d65 with SMTP id d2e1a72fcca58-8241c1cdb8fmr5673442b3a.18.1770290526521;
        Thu, 05 Feb 2026 03:22:06 -0800 (PST)
X-Received: by 2002:a05:6a00:a210:b0:81f:3eda:9d65 with SMTP id d2e1a72fcca58-8241c1cdb8fmr5673425b3a.18.1770290525998;
        Thu, 05 Feb 2026 03:22:05 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16401esm5651998b3a.4.2026.02.05.03.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:22:05 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 3/3] wifi: mac80211_hwsim: add incumbent signal interference detection support
Date: Thu,  5 Feb 2026 16:51:46 +0530
Message-Id: <20260205112146.3997044-4-amith.a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GaEaXAXL c=1 sm=1 tr=0 ts=69847d5f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MkHOkvIKxj3EjjMPQvAA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: mdeNsouB71L_wwhEEFpbFKCaGHNT1apo
X-Proofpoint-ORIG-GUID: mdeNsouB71L_wwhEEFpbFKCaGHNT1apo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4NCBTYWx0ZWRfX07jRODEaLIOi
 hO439lJewu1BHPPPIsXD0UjIt0a7klmgcQ8bJhG/+gOV9I0GUZf4/ZHUlnNb713oWiH7zF8x3qx
 g89DpBr/FdOB9dY9Z7lmyoHgBXBpOD60vf5oQQwJffqkBYiSmRp/3eIajmJGUOvhpJDtZ80uNZt
 ghzkkn3wJfzt9qAV/RaFl2a3H8c/IAGmzzVufbLOVibDHsM9asjN9/k2ajKQthELLEHJFlsEDPO
 TkYiF/inuSNLcnCSCWbiArUri12yJzWtOE/N+E0hI3pqTiomFjuCex+o2mXWMf3mDPBuBbrmWxU
 HR+paGILVqVNmsV0n38khC3OaJejK6TMLRR8IhT1DtC/IyMXy83kFyOIQxiuhZ4m92jaLb0ksL5
 IS4j7xKhpMnTd0oHpJpRFQl4OVq5syUCGLzAYoQOpA41YA0+p/mlc9Q2zuOUQLhrGu5ZVi1uBdi
 x72Qx7BjA1KDC2QLJrA==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31590-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E6E8F1CEF
X-Rspamd-Action: no action

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Add a debugfs 'simulate_incumbent_signal_interference' which calls the
function ieee80211_incumbent_signal_detected() to report that incumbent
signal interference has been detected on the current 6 GHz operating
channel. The written value is a bitmap of affected 20 MHz segments.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 +++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..f1105f97504b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -1164,6 +1164,36 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_radar, NULL,
 			 hwsim_write_simulate_radar, "%llu\n");
 
+static void hwsim_6ghz_chanctx_iter(struct ieee80211_hw *hw,
+				    struct ieee80211_chanctx_conf *conf,
+				    void *data)
+{
+	struct ieee80211_chanctx_conf **out = data;
+
+	if (conf->def.chan && conf->def.chan->band == NL80211_BAND_6GHZ)
+		*out = conf;
+}
+
+static int hwsim_write_simulate_incumbent_signal(void *dat, u64 val)
+{
+	struct mac80211_hwsim_data *data = dat;
+	struct ieee80211_chanctx_conf *chanctx_conf = NULL;
+
+	ieee80211_iter_chan_contexts_atomic(data->hw,
+					    hwsim_6ghz_chanctx_iter,
+					    &chanctx_conf);
+
+	if (!chanctx_conf)
+		return -EINVAL;
+
+	ieee80211_incumbent_signal_detected(data->hw, chanctx_conf, (u32)val);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_incumbent_signal, NULL,
+			 hwsim_write_simulate_incumbent_signal, "%llu\n");
+
 static int hwsim_fops_group_read(void *dat, u64 *val)
 {
 	struct mac80211_hwsim_data *data = dat;
@@ -5832,6 +5862,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+	debugfs_create_file("simulate_incumbent_signal_interference", 0200,
+			    data->debugfs,
+			    data, &hwsim_simulate_incumbent_signal);
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
index c2d06cf852a5..d897aa720ec2 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
@@ -343,4 +343,6 @@ enum hwsim_rate_info_attributes {
 	HWSIM_RATE_INFO_ATTR_MAX = NUM_HWSIM_RATE_INFO_ATTRS - 1
 };
 
+/* no longer used - previously used for debugfs iterator */
+
 #endif /* __MAC80211_HWSIM_H */
-- 
2.34.1


