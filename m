Return-Path: <linux-wireless+bounces-32451-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLKjDpjcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32451-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4454D1FB7D4
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E7B6303E0B7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99EA369960;
	Wed,  4 Mar 2026 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JsLEpD+n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XspLXQ45"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77943537EB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608608; cv=none; b=laomt7tgHtbfe1bqzh5fSoMInHzf9Y9h9sVyn3hREHFwY80dWeF6ftvWfHCwIuFBFZXkYoCf26H33Ci8UfhQBYh5SaOsOpy8Pt9ju1KD+bxxMglbGUVVlK/yNIKU5CdKGb5tKLJJHZac+U2xRdVrqBwMZClhtU4g6fuV8y9vEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608608; c=relaxed/simple;
	bh=GMa46XPGqJ/hfSipcBwmrDTxYz5c0CcLEh2AdRPjZ/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSI6Wrpdg32/+cghpnfvgljwwCboj10ePb7aIW3oVgxIHoj9fzIpMheoBuj55mlfberDchhVKG67fhZgT304rp5yk9LEJ1xKQf/0Pk2q4Kdzj6o07qbjraJEgYCSCH6isQnToieTiFT8W9QwdLiv5MjRxkaUpaY/nZfMdBV4BQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JsLEpD+n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XspLXQ45; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SVhZ2275166
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vCteEwtOfAw
	2AmKn2ba4RHxNgU00u9VTa2QzfC3jd44=; b=JsLEpD+nB+pZmk8zJs9i5vT5Dl+
	edFuzh97/FntC80M/tpvWjsE2xeD/xuYKjXf2fSn7gc2fRsAbadQH1wMx4dHVxND
	FsSCJeGURt/jXhfVrfSQIRgEQ+A8Vas2D5DaQz5XbehYsgI1cbYjPN3oMxNEkx1k
	ri5erKvuSFomC4E5hIW43szXW49mUfyfIvPUV7JSW/Dt4Dy3Wa1htiD5xQjyx8LJ
	O6tlXQH/6F9l3c1yxGr7Yn7wUtmDCnDBTRAFfQsr3HGHHYcIaxWDitWnzPXQN1Ou
	Vbt2G57yeS/QLLWeHiOpIg1/XFQVlIGlRiyOFxczcNgPfk2UGGNMYXjNp9g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpc4mrsug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c503d6be76fso27230620a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608604; x=1773213404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCteEwtOfAw2AmKn2ba4RHxNgU00u9VTa2QzfC3jd44=;
        b=XspLXQ45iEPfmn3n+aJ37QEEGCBix09d7H49Yh67Dq2IYpMkHk+q9shUdLVmULE9pV
         grKQlgRVcd/DYkDZmoCJSW3DWmgxTTxuVMp638ym0p8KIf0jFh/brJkuvDfYY2BQb2+A
         uSsDe2QIABq9pk5WOn+FwhAOXikMRq6Ya5QvanMThTpXVsRF2l43KNSnxzgvgYCHJyQw
         /4aCw2c1xLiGt6z2K8Da6rCETj9WGsInQMpYCSV2CdmxNTK1w5gqiGhUGlLuPYR3a22P
         tNWJcgLP5L74452ZKcE0fNtYTE0q5XzmcHXLhPDMo29hic7EixUjMzgCbV77blN8rcrJ
         GD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608604; x=1773213404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCteEwtOfAw2AmKn2ba4RHxNgU00u9VTa2QzfC3jd44=;
        b=OIGnAgz7LcIx2+ieZh7g3L1xFo0eNCB30EzK7zq/9NGEXhYb3wIkDyYOIVk6fDUO0f
         VTsZ0LRldHvD8PDalTC8svKLznNn/BjKUoQ00dKOv7cojT9UKI32g5rexWHDOh0iUO7/
         /YQhxOkzOtV6tAuWCf3hy5+l5yLLVMopf2zQkxsE7jzZtzT6seg2l2L/PuUlwS68kLYu
         7BM+O0WJjZp+Aiz82+QwbveOFXmiUqFfYNfKZuYJKH4icTgCOmm24ij8Kl0xRWBq6XKK
         G/ZP+AlQO8W5zGW2/SOxzj1X4LToZjlpHdCtAoeNTYkXMYvlmrKKerUBuokYo5P0SLyv
         d5MA==
X-Gm-Message-State: AOJu0YyNdwu0O7Tkoq0X0fEIAXGP5zPJUX9/vkOxGFnJfqzuXNzEsK6D
	cYiBcbbFVS9UtBhcQSoJQF0NBKazaAVFXCaURdyLBBqSFbb806gO9Ye9TgHQnHD5GYRE1oERZim
	2vtgURI+ERVkPrYcPesnV6tO8scWrfI4nHQEGUshw2ObnQC1VweY53y8xXNl3Uz9hzKqM
X-Gm-Gg: ATEYQzz1KiRfyPv6ezzmGbYVzVwUGwpXyxrjCZSyEPYvG5Nqk4lFzrOHLJPUQevCuyV
	CBrb+9PQHegndlDroL1NS+4R9/QL4TPbekEw4Tqdvp/3vw17VjMJo6KeyJwtfpg9q/M01KRXDbi
	TEn721nYiopk6o4NHCmcsPpvQ8P5z7Ov9NTncRxZ5BVh6oByv0wvRx51uSv3jYexkZtp1r4TqfM
	cTwz8kjrGFo5Clm+EWINV+ovexnyXwp8w86h+9Zz1QSOCXJwWPnVG9V1f/FGB2W0hx5MNz7TVPG
	kBpY9jH/AR/Xk9DcZNHRND9+6Zjef1COM3ca845TudeLbytIQ4YKePTsxAAi+veZ4M40SiIdiBs
	XTQyoWFu24IREaiCN1rJUQbVB5css6V9W1jhncR+YPJttNDZS9D4JBVE=
X-Received: by 2002:a05:6a21:9a4a:b0:35d:6b4e:91e6 with SMTP id adf61e73a8af0-3982e1647ccmr1070154637.46.1772608603726;
        Tue, 03 Mar 2026 23:16:43 -0800 (PST)
X-Received: by 2002:a05:6a21:9a4a:b0:35d:6b4e:91e6 with SMTP id adf61e73a8af0-3982e1647ccmr1070135637.46.1772608603234;
        Tue, 03 Mar 2026 23:16:43 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:42 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 15/16] wifi: cfg80211: add LTF keyseed support for secure ranging
Date: Wed,  4 Mar 2026 12:45:37 +0530
Message-Id: <20260304071538.3833062-16-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -RI66weDlOWW2vd7I7983yrUeAqAUmRf
X-Proofpoint-GUID: -RI66weDlOWW2vd7I7983yrUeAqAUmRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX6yLpLOkHVxrb
 YVJadJqDzzB8QVM4dNjjggcUkXC1uTS+Ymt2dtz9A1D96VYxLDKkjVB4acBpC2TpMoIyN/sc1uH
 mcGsfPn/ZltjEXq2sdJ+zUG2ir3r1LgUGbMiyT6nz5ba5e9ikszOE5yLGfsuOSnhXTATN7u7Wfr
 eN8xtIhvyMx61WBXt98abtuicRCGNCBffXA8n+kqDNw2MHZP6UtbxHMhzTSws0qjZOp55K900Zt
 7LjWkHCYWVyEhfCBcT2uM3V7F8ZotSEuaRKBvCksOxgRcGhoIpQjjf+pTJF+BSr2kmsM4fas16o
 1ymLO9itpTZ4eNRwUjBXJfGI1SwMpHb6CSriA7/U/tTVt8RoYkYo6QJ/95jrl7NgmnwJl1n7O26
 DfajLsVDCLZFGX+J7pQppHw4yxsR7KnE11HXViMFtOYbVrBfIA5Z8uIiEPVgUUcHJOAMTUFXD6I
 WXdvrcy4jVCVayOaSbg==
X-Authority-Analysis: v=2.4 cv=C67kCAP+ c=1 sm=1 tr=0 ts=69a7dc5c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=dvtPdJCZYBYyGhnXmg0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: 4454D1FB7D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32451-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Introduce NL80211_KEY_LTF_SEED attribute to enable secure FTM
measurements with PHY-layer security. This allows drivers to generate
secure LTF keys for ranging operations, protecting against
eavesdropping and manipulation of ranging measurements.

Support the keyseed with trigger-based and non-trigger-based FTM
requests to enable secure peer measurement sessions. The keyseed must
be configured before initiating the measurement session to ensure
end-to-end security throughout the ranging operation.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 16 +++++++++++++---
 net/wireless/nl80211.c       | 10 ++++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6f7abb118a27..ac69cb200c0f 100644
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
index 9c647c184e7f..0ae56bd66e7e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -395,9 +395,10 @@
  *	%NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
  *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
- *	and %NL80211_ATTR_KEY_SEQ attributes. %NL80211_ATTR_MAC represents
- *	peer's MLD address for MLO pairwise key. The link to add MLO
- *	group key is identified by %NL80211_ATTR_MLO_LINK_ID.
+ *	%NL80211_ATTR_KEY_SEQ and %NL80211_KEY_LTF_SEED attributes.
+ *	%NL80211_ATTR_MAC represents peer's MLD address for MLO pairwise key.
+ *	The link to add MLO group key is identified by
+ *	%NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_IDX
  *	or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC represents peer's MLD address
  *	for MLO pairwise key. The link to delete group key is identified by
@@ -5602,6 +5603,14 @@ enum nl80211_key_default_types {
  * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
  *	Defaults to @NL80211_KEY_RX_TX.
  * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
+ * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
+ *	secure LTF keys used in case of peer measurement request with FTM
+ *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds will
+ *	help enable PHY security in peer measurement session. The corresponding
+ *	keys need to be configured before hand to ensure peer measurement
+ *	session is secure. Only valid if %NL80211_EXT_FEATURE_SECURE_LTF
+ *	is set.
  *
  * @__NL80211_KEY_AFTER_LAST: internal
  * @NL80211_KEY_MAX: highest key attribute
@@ -5618,6 +5627,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
 	NL80211_KEY_DEFAULT_BEACON,
+	NL80211_KEY_LTF_SEED,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 281a15226edb..68bf941122ae 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -983,6 +983,7 @@ static const struct nla_policy nl80211_key_policy[NL80211_KEY_MAX + 1] = {
 	[NL80211_KEY_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1),
 	[NL80211_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
 	[NL80211_KEY_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
+	[NL80211_KEY_LTF_SEED] = { .type = NLA_BINARY, .len = 48 },
 };
 
 /* policy for the key default flags */
@@ -1459,6 +1460,7 @@ struct key_parse {
 static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 				 struct key_parse *k)
 {
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct nlattr *tb[NL80211_KEY_MAX + 1];
 	int err = nla_parse_nested_deprecated(tb, NL80211_KEY_MAX, key,
 					      nl80211_key_policy,
@@ -1514,6 +1516,14 @@ static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 	if (tb[NL80211_KEY_MODE])
 		k->p.mode = nla_get_u8(tb[NL80211_KEY_MODE]);
 
+	if (tb[NL80211_KEY_LTF_SEED]) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_SECURE_LTF))
+			return -EOPNOTSUPP;
+		k->p.ltf_keyseed = nla_data(tb[NL80211_KEY_LTF_SEED]);
+		k->p.ltf_keyseed_len = nla_len(tb[NL80211_KEY_LTF_SEED]);
+	}
+
 	return 0;
 }
 
-- 
2.34.1


