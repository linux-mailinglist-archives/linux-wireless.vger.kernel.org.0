Return-Path: <linux-wireless+bounces-35035-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN4FC7Ht5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35035-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A66428B2A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DED03016B21
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DB382372;
	Mon, 20 Apr 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJxTekEI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KlbvFWFU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2D38836F
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676204; cv=none; b=m/aUCcNzDUPDVUiTxZ5s0tjjhome/j4hM8646/9Pw4Bk62j9F6//fporPBbwYvAixiOOVRJI/ZaqdHg38kBDsnrLpREfAhHnu41sotlSw5ketSOxlb2cQHsR3DVtTBzB2pnBg89g8t53humzWm1qn45Vr+TFx/D0TRvUX6uv2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676204; c=relaxed/simple;
	bh=QREGR4To7thbipj1XtI3nOPNLBCt7z+mnT7ipQ6IiHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFf38W4PSwgU1vsQWLM+cAeUlFUfqlN3BnzgKC4JoSn69v10ZTWfzOxIFcTHjmm6vk/7qNliqih1AigXsYdc1fLku1Tr2hWAk1Ca3zMQqs6xkFZYHvhQLuWsLGcmilqMg3LCiATwMYnTSmPxBkBDcbeITvGjDeBJj/UJ+O35d1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QJxTekEI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KlbvFWFU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7Yr6l3455442
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9qETePNNAMg
	iyXJHuZca2Tc3G+8ODtC26Zq20Bu8ipI=; b=QJxTekEII/Ig9BJD+7KNZxSesZf
	M21rXvo9ZwY+c5tDe0H3qjBz2vf5ha9JVBDFJzk352a0SVHTUDT/IJbElIped7Vs
	21x2ACZgYqJhNJ7rloDn468qgXJgOz2JMy3W/iqivYv5LkkpBL0+muBibxGK5RNx
	SQRlNYu6NgF1p7fnLtSHvItUTqdb3ibBcXMy1HTm1vTol1fy/M8/7jAp4FnGSmhc
	qHE+tijSlj8OPRw9TObG4TudzNc/DqSuhzBszJy9r6S/5Jp08QcYXyNr8kmJo2NQ
	dnCa393ozVFaYFSSxyCLmiw8WSDkhP5q57A4nwhGhydvOX6xxlWabtv6fIQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjrj4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so4957343a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676201; x=1777281001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qETePNNAMgiyXJHuZca2Tc3G+8ODtC26Zq20Bu8ipI=;
        b=KlbvFWFU0RKWkpoKx4t3N+7h6nr+v6cZuONkXWBX0MZ+X8edC2UvuAnfDVWlAdxGkc
         2Vp75nORyP+63GWspaXJvSuAqvFNu/QH05QiOcLLmAu/c36Rq3mL8IDoN0rhdrmIv3eU
         bMJx8QIZivy4lBQsByA6uRCJnZiqrLJD/FeW0HmmN3wdQZJyLq8by2vt3t8ZMuBG03gD
         KXTu3Vv+4mPYL+o3fr9VCvChPkBxoiPUn0nRVHSPuWqRr14y2FMEYsYoIXuZ9FVgCVnW
         cjHogPIiJ7aFpfUiciB/HVIUbrl4OEiZKiLF1n3lUUMrnvSYrvoYUcLJrqsKuNayutM6
         qg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676201; x=1777281001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qETePNNAMgiyXJHuZca2Tc3G+8ODtC26Zq20Bu8ipI=;
        b=qCaI9cpMprK4IqKlSWBsuy7t11JHpQvzebnHnlPuKzk+1ce2yPsT9j4LrzOhqBQPjd
         0gQYZusre4ANLQ43F9ZlWDwGmArEdTtt/+U0YHaxHRJbZgafA43vVj/AwlSm2DGF033l
         3wfAo7D/ZkLLm4u9biab7qFu3Vh2yi8gVzcZHVZmQI/iJ6CQvIUaJin507G1WsW4n744
         3wTYyYbfqBKbcNJO0UaeIhm8e+JcOfoVIn+sALPe4GEV/fgerhdKFC/mB77SgUD6DE51
         NQt5VGJ8f44ueyryGd+r0BkdL6PD3lIHYRB8ODu+dUD8h+/l6aM1mr1o1CwSQX/7ELLw
         8Vcg==
X-Gm-Message-State: AOJu0YxQyneGbJR5jp0k8VUKgVZjbqb7RRSQPQpUhg8EpPNrFdslSERn
	HtiBT8F8hplI1DOYuhUXE9rzGEbCJsTYvCJI805uWeef9zLuBiY0nDIR8Zb8YwhH1lNFJuUK4ws
	56qH/ypXiaX3U19T490XdaSAbB5y2iABMGIT4p0iSiEH0zaEO6BhnwQsEQhDTIGqAB/lSbi+HkL
	id
X-Gm-Gg: AeBDiev/Kfb0urNBsSENbO5E3MGd4JmXQsZA2tK7PXKrpTCLMkMHdbTUNgERjtmpydV
	QWkuljBWwyOpe+ALvz9643F4QechAnBfcSYt8VVr+lZ5Tp4eGr7zImSuR9nkRADKFOZ3sSwn6Gj
	DRY5aeGC4nAyjGoshdtGfI6kQskDDEGdcFdsZDBEPYCcm/nH5ZQ+NR746Wpph4vJSaWOPqLLj4Y
	n5+lWyhGQV+fhRECKLfn8UOHNGgxTLbWdiw4nzHaYO5+zMRVim2c46JQUqPl8iWm1uVulmXsArw
	0+CpV99QP3Sfysl0V8SCrLDxccwUfaApdmsOLoJa2nVspZB0q2mpg1wIafr/uSlKaGtGBc5L4nJ
	i9QY1OPg6M7QCYfuLwI11tHT3hfS0KR6QwdXcx8DNUxeJpz08SfXAeajrFaZBMP4jmg==
X-Received: by 2002:a17:90b:1a8d:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-361403fa894mr13024410a91.12.1776676200549;
        Mon, 20 Apr 2026 02:10:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8d:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-361403fa894mr13024377a91.12.1776676199932;
        Mon, 20 Apr 2026 02:09:59 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:59 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 12/13] wifi: cfg80211: add LTF keyseed support for secure ranging
Date: Mon, 20 Apr 2026 14:38:55 +0530
Message-Id: <20260420090856.2152905-13-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BJpCcFm_M3h4FKLSuCzguy2cvfC2rI7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXzESRePCBLzw6
 HcFOcnrpSD7mIChPEPBRo1IRbnZuJrJkfyGYkOuGg+FF5ESdgybFpsSld9qDAW96kgCLmFhspMt
 EDsDrac1zRXNAt614CHDJ6u8hOylZDy5GSQi70fVJNlidpmEjfvtnUhmKjpcex2jnBOvgTu+5Uu
 CY9YX7kleG5I84kXf3trRx2wh2Di1RSTZzb8njIhi/hJndAcXdCQv3nY420xaloor+dAgXM3yio
 ZXWeA7t2FGZS3qkvevtXkAPqDQ5Yp0whZTayDSdoT2B7vecezfEomDOLSkOjZJq/zsVjQwEZxAG
 kos4wLKE52/ykUlHu1yQx0Wn+22KXcRFbQ7Bv4X4yMwggINAo7rASP7wU1ED0SybPSV0IEetHNF
 1s7ZpaiHzBgkUzVumvbOEYUqNtIjRq/4rLsFafIfc/81EFNPWln/gsvz88OpAJbtf9FpUyjl7sy
 9Q6dy2hmBB/BaSb3qkg==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e5ed69 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wJ6IAscJ0N9GpxG7cbAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: BJpCcFm_M3h4FKLSuCzguy2cvfC2rI7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35035-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C0A66428B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently there is no way to install an LTF key seed that can be
used in non-trigger-based (NTB) and trigger-based (TB) FTM ranging
to protect NDP frames. Without this, drivers cannot enable PHY-layer
security for peer measurement sessions, leaving ranging measurements
vulnerable to eavesdropping and manipulation.

Introduce NL80211_KEY_LTF_SEED attribute and the dedicated extended
feature flag NL80211_EXT_FEATURE_SET_KEY_LTF_SEED to allow drivers
to advertise and install LTF key seeds via nl80211. The key seed
must be configured beforehand to ensure the peer measurement session
is secure. The driver must advertise both NL80211_EXT_FEATURE_SECURE_LTF
and NL80211_EXT_FEATURE_SET_KEY_LTF_SEED for the key seed installation
to be permitted.

The LTF key seed is pairwise key material and must only be used with
pairwise key type. Reject attempts to use it with other key types.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/linux/ieee80211.h    |  1 +
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 18 ++++++++++++++++++
 net/wireless/nl80211.c       |  7 +++++++
 net/wireless/util.c          | 15 +++++++++++++++
 5 files changed, 45 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 23f9df9be837..11106589acc6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2236,6 +2236,7 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_WFA_DPP			SUITE(WLAN_OUI_WFA, 2)
 
 #define WLAN_MAX_KEY_LEN		32
+#define WLAN_MAX_SECURE_LTF_KEYSEED_LEN	48
 
 #define WLAN_PMK_NAME_LEN		16
 #define WLAN_PMKID_LEN			16
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3efa8a124bba..1d5de82ad4c5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -830,6 +830,8 @@ struct vif_params {
  * @seq_len: length of @seq.
  * @vlan_id: vlan_id for VLAN group key (if nonzero)
  * @mode: key install mode (RX_TX, NO_TX or SET_TX)
+ * @ltf_keyseed: LTF key seed material
+ * @ltf_keyseed_len: length of LTF key seed material
  */
 struct key_params {
 	const u8 *key;
@@ -839,6 +841,8 @@ struct key_params {
 	u16 vlan_id;
 	u32 cipher;
 	enum nl80211_key_mode mode;
+	const u8 *ltf_keyseed;
+	size_t ltf_keyseed_len;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bbf1447162d8..190bae9efdd9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5803,6 +5803,18 @@ enum nl80211_key_default_types {
  * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
  *	Defaults to @NL80211_KEY_RX_TX.
  * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
+ * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
+ *	secure LTF keys used in case of peer measurement request with FTM
+ *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED. Secure LTF key seeds
+ *	will help enable PHY security in peer measurement session.
+ *	The LTF key seed is installed along with the TK (Temporal Key) using
+ *	%NL80211_CMD_NEW_KEY. The TK is configured using the
+ *	%NL80211_ATTR_KEY_DATA attribute, while the LTF key seed is configured
+ *	using this attribute. Both keys must be	configured before initiation
+ *	of peer measurement to ensure peer measurement session is secure.
+ *	Only valid if %NL80211_EXT_FEATURE_SET_KEY_LTF_SEED is set. This
+ *	attribute is restricted to pairwise keys (%NL80211_KEYTYPE_PAIRWISE).
  *
  * @__NL80211_KEY_AFTER_LAST: internal
  * @NL80211_KEY_MAX: highest key attribute
@@ -5819,6 +5831,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
 	NL80211_KEY_DEFAULT_BEACON,
+	NL80211_KEY_LTF_SEED,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
@@ -7048,6 +7061,10 @@ enum nl80211_feature_flags {
  *	forward frames with a matching MAC address to userspace during
  *	the off-channel period.
  *
+ * @NL80211_EXT_FEATURE_SET_KEY_LTF_SEED: Driver supports installing the
+ *	LTF key seed via %NL80211_KEY_LTF_SEED. The seed is used to generate
+ *	secure LTF keys for secure LTF measurement sessions.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -7128,6 +7145,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
+	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index feb770fa6a87..9d6810cfb3d6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1103,6 +1103,8 @@ static const struct nla_policy nl80211_key_policy[NL80211_KEY_MAX + 1] = {
 	[NL80211_KEY_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1),
 	[NL80211_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
 	[NL80211_KEY_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
+	[NL80211_KEY_LTF_SEED] = { .type = NLA_BINARY,
+				   .len = WLAN_MAX_SECURE_LTF_KEYSEED_LEN },
 };
 
 /* policy for the key default flags */
@@ -1634,6 +1636,11 @@ static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 	if (tb[NL80211_KEY_MODE])
 		k->p.mode = nla_get_u8(tb[NL80211_KEY_MODE]);
 
+	if (tb[NL80211_KEY_LTF_SEED]) {
+		k->p.ltf_keyseed = nla_data(tb[NL80211_KEY_LTF_SEED]);
+		k->p.ltf_keyseed_len = nla_len(tb[NL80211_KEY_LTF_SEED]);
+	}
+
 	return 0;
 }
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index df407ce9db3d..f5a95405280d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -424,6 +424,21 @@ int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_supported_cipher_suite(&rdev->wiphy, params->cipher))
 		return -EINVAL;
 
+	if (params->ltf_keyseed) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_LTF) ||
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SET_KEY_LTF_SEED))
+			return -EOPNOTSUPP;
+
+		/*
+		 * LTF key seed is pairwise key material and must only be
+		 * used with a pairwise key
+		 */
+		if (!pairwise)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


