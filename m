Return-Path: <linux-wireless+bounces-32563-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKItMOCqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32563-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:10:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84E2152A1
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726B1301778C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735B3A4F51;
	Thu,  5 Mar 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1zceV16";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jk9JpiH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194A3CF68C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726903; cv=none; b=sCoJJL41bYEEQ2JvJ+enVhTuEl0EB3sMWfLJcQU1AyKpSvqZqj4OBPlmAfGLXj28dV2kM7OacGUxBAofXaUZrEMHzyLhQqheP1XZbnWL0HL+rfy+keAsVJZ2xIckg2MGD9ptquAeBUad02DnmGpvjhi9VJRgojVQHT8NhMZYB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726903; c=relaxed/simple;
	bh=nSHK0UZFkmLkd9qVz9DEy4zIOKtZJMsuo5W+mhcagO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTD4MeWye5rqOZQ7U4KrcH7PMAo1hqtmNLREXy9e+Z3XNKlX9+mht4wg5yKfWdfKOBXvnl7rYmJgfTz9d+vsqKRNUsJTEYlzICyk2VHq7RMA2oYNc2/yTF362VmWiXSFZvXNMgsNu6yuyRGzNMCYy4r0s29Ws0w6qnxjTla5vlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1zceV16; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jk9JpiH/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625CMxEd719996
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZI5Y1ccQcLv
	qyU+exiHUdEo2grdfMFOCtFqfsJ4Gk3I=; b=a1zceV16mCGTHogi+LvhH7btchP
	Pf8EeDAV00PdxfQL9H96bX7DJFUgK8N3HG4++fpUVDbPUClR1dz4MXmLBjOqSWf9
	ged9v6XWbwROlvlX+VJolLNcY8i7Z1QfBS7EpgefAZvUCR5STId1GfMTa1AzBqd5
	+ewf8eYqJBhJtvCiYJVGDZh1I8Mc12J7+NKYGAK1VVkcBhNa9XWO6AWPp4mBK/9q
	0p2LJUHgYEr6B7QoYVzSedaRhL8MR3O3ZBpNbT6DDpuhECu3yJ4sIv+Cc6fmDexa
	dPUWa+lFtSGnJa4YFHlNHXMlaH5GoOyr7tA2CwbWXHzQzUfJKkMjFEFYTVQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq9srgr06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae53ec06b0so198860735ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726898; x=1773331698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI5Y1ccQcLvqyU+exiHUdEo2grdfMFOCtFqfsJ4Gk3I=;
        b=jk9JpiH/5gbkPe52yhE1fMxShlQtF7FxvLxaJKlHAdg7Z78O1K1XIjqPRw3yfltpH8
         sozNTnT18mepB7xNd4RN9j/+YykFBuOwHFk3LMV2QU8ewawR2RfjakRN7HLWrszx0Fuv
         qWXCQYhL2Guas0uMXtQQdOV3oxOwLzboajSp2Wqc6PV6z+PRSnxkKVog8iLx+b+wzC3X
         247/0+mTK8jwuANLEuzWThBOBm7Sk15NX99Tw+qM88PenJkEkVt/HWRlhI960YVBhST/
         6fFOPSeGdt96Ng/4g5VnT2RYxoty3OtwGa4K+p8N/JEDARtpFE7CRTvsuStT8suEf3nA
         xp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726898; x=1773331698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZI5Y1ccQcLvqyU+exiHUdEo2grdfMFOCtFqfsJ4Gk3I=;
        b=Q5/LS4kb+7m0gkDuJZKjuTnP0iHbFnVRW3boXUEminVNF1QO/WkswL7IuvbcjuuXcU
         S/ngbbAZktmCzoOo6FkLCaE7BriiUxdUyOPtD5Wrbd4FYpuicoWJrITVNefulv7wQSHp
         QTJNumgON/iS+XPld6jg6D/yzRkbb8CkiX2YqRzbZu+m9HEAZdqkmkqAKqwP90kam23r
         MjSCR6eMInbYSI/XEV8gOtaI8NHF8imvcBsySbMww0OkjNH+qPP6evH2fdudehFZSJ8O
         d7u+jKvmbMxco+k5Wsa2fpkzaMwofrmuEe9rnQEBB7Ft7iNfC3+YQQ43h6mHuikdOrWo
         kS6g==
X-Gm-Message-State: AOJu0YyzznJTcftIKJZ9txsm4J3CwCbHkMe00Z7XSO/guh/v6Vom36uy
	lH6ZBfDTDt/rPuWCjP8XtqKFQbNCzPcw4nJUK8L4Rtw4voa2xxZ154KV7wI63AH/VA035A2odpr
	KJYMQ9rWOSyk2h8YVU+SlQ3qVUiqcyNC7X3qjBcR3O6rsZlzefSsaI3jWalliC/iu0ty7hlrC7W
	nJ
X-Gm-Gg: ATEYQzz1gl2UMWfevD7T9K6lb6CDhT6PQZV4k/ExO6GWNjFfspBNgcuTgitnRMH4baO
	6/f2GJVS5eBZg8KMLqaHaMGExau5Zsn2SE25r2q6/Z6Q8+WxOGv1BgFgO2eG150S7cCH3k8NjSL
	H3CAfLrKedqnvSbqstNacp5NUswQdzsC0VjRFSDDHd2OmJ7iMaoMkh7EgcrryqRfF07Wcvf8nLT
	UAE/kZN84ATViiWTMARY5gsiSp4Eiubk66p3EdIueuyClqluOf0c+Obb+gida3bODWIC5n3tJPR
	KfUh25PlRNXaqoiYXocjPic2dvUhfjklyNB/aN6ecc0AK1U2hDM2rjCdXZ7BgYP/zOMqMhUzk5m
	LQJmzGU4EnfLF5tsFq2QkotYR7op99o8gjcrBIaXAhxeCQSBX2LNVEaA=
X-Received: by 2002:a17:902:cecf:b0:2ae:5a76:e26c with SMTP id d9443c01a7336-2ae6ab67292mr56134725ad.55.1772726897447;
        Thu, 05 Mar 2026 08:08:17 -0800 (PST)
X-Received: by 2002:a17:902:cecf:b0:2ae:5a76:e26c with SMTP id d9443c01a7336-2ae6ab67292mr56134405ad.55.1772726896874;
        Thu, 05 Mar 2026 08:08:16 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:16 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 14/15] wifi: cfg80211: add LTF keyseed support for secure ranging
Date: Thu,  5 Mar 2026 21:37:11 +0530
Message-Id: <20260305160712.1263829-15-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a/I9NESF c=1 sm=1 tr=0 ts=69a9aa72 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=SKemYOvrt_e1GwWrTtoA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 1F993_13ueXd_E79PAd14LlNjTy4S_DO
X-Proofpoint-ORIG-GUID: 1F993_13ueXd_E79PAd14LlNjTy4S_DO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX55bXFeKlzzPL
 AiWGGjxJ1TrTT+V3S0YxavPhzFCh0l8ESbh7bfgKhRjPFt63Xm1QHnDqrZ/+NLQw/QSMaGxLK/8
 7Ij2vd6/fWJFA0/RMzNBbzTQBD+0xw4sjzS5G9zIy2F6CSyPXghffDnhaKcBGLFPvVUEo58tqQL
 MFRgLL9r4pzhV2dk8NfBgHMxsm5TCpQ5ZFUaDBJsM1CU/uIEGx2UqNgrPXNVNLhpTm24DO1DldQ
 eC+lcTeQKceYlBFo5VbmxHENJTS3hEKCg88BVCRX2xhx+RJMTrzISoFuXunS3B82u5m7Z1BNBtq
 D7wSqGW+JnAJR/vJsnbxe/5ANJiwgcovO/f/iDk05uYxNkSQ8MHV7pjChBeir0HBYk/pyyDx8bA
 6A5KFPrqbr496CWVINXiLHl8lbYcPWTVMMgrUqdZzXRKekn4tN5l7Yrz11H+6HMw2DZdCCuT+pH
 CyiesFOdi2e8scaPi8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 5A84E2152A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32563-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/linux/ieee80211.h    |  1 +
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       | 13 +++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 3651b2e6c518..20e243cef210 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2241,6 +2241,7 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_WFA_DPP			SUITE(WLAN_OUI_WFA, 2)
 
 #define WLAN_MAX_KEY_LEN		32
+#define WLAN_MAX_SECURE_LTF_KEYSEED_LEN	48
 
 #define WLAN_PMK_NAME_LEN		16
 #define WLAN_PMKID_LEN			16
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8dc2ccafb88b..66ea250f0b27 100644
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
index cafa73280758..923d2396b8f6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5602,6 +5602,14 @@ enum nl80211_key_default_types {
  * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
  *	Defaults to @NL80211_KEY_RX_TX.
  * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
+ * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
+ *	secure LTF keys used in case of peer measurement request with FTM
+ *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds will
+ *	help enable PHY security in peer measurement session. The corresponding
+ *	keys need to be configured beforehand to ensure peer measurement
+ *	session is secure. Only valid if %NL80211_EXT_FEATURE_SET_KEY_LTF_SEED
+ *	and %NL80211_EXT_FEATURE_SECURE_LTF is set.
  *
  * @__NL80211_KEY_AFTER_LAST: internal
  * @NL80211_KEY_MAX: highest key attribute
@@ -5618,6 +5626,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
 	NL80211_KEY_DEFAULT_BEACON,
+	NL80211_KEY_LTF_SEED,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
@@ -6847,6 +6856,10 @@ enum nl80211_feature_flags {
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
@@ -6927,6 +6940,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
+	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 313bad0d4a77..43dbd6faed4a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -975,6 +975,8 @@ static const struct nla_policy nl80211_key_policy[NL80211_KEY_MAX + 1] = {
 	[NL80211_KEY_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1),
 	[NL80211_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
 	[NL80211_KEY_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
+	[NL80211_KEY_LTF_SEED] = { .type = NLA_BINARY,
+				   .len = WLAN_MAX_SECURE_LTF_KEYSEED_LEN },
 };
 
 /* policy for the key default flags */
@@ -1451,6 +1453,7 @@ struct key_parse {
 static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 				 struct key_parse *k)
 {
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct nlattr *tb[NL80211_KEY_MAX + 1];
 	int err = nla_parse_nested_deprecated(tb, NL80211_KEY_MAX, key,
 					      nl80211_key_policy,
@@ -1506,6 +1509,16 @@ static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 	if (tb[NL80211_KEY_MODE])
 		k->p.mode = nla_get_u8(tb[NL80211_KEY_MODE]);
 
+	if (tb[NL80211_KEY_LTF_SEED]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_LTF) ||
+		    !wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SET_KEY_LTF_SEED))
+			return -EOPNOTSUPP;
+		k->p.ltf_keyseed = nla_data(tb[NL80211_KEY_LTF_SEED]);
+		k->p.ltf_keyseed_len = nla_len(tb[NL80211_KEY_LTF_SEED]);
+	}
+
 	return 0;
 }
 
-- 
2.34.1


