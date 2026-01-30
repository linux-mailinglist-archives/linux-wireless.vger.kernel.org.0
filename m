Return-Path: <linux-wireless+bounces-31396-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIFeEC3WfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31396-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9332CBC5BA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD5B3007E1A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9A303A3B;
	Fri, 30 Jan 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LX5MKICq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CvxkHtTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7D341660
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788882; cv=none; b=UssGByr4ZVizDB/Izq9ct6KTKutkH11oBxh9+7W5AGeu/wuqIlYgE/RSdMK4+5Axwdz0PQnE/cAZZiJKqYTlhoA27cOJkKlGJ8fclFhXnYZSX6jlWVvfLqDTGinced555NGnsfQUmse2UC5z+YQMJiVCc+aXpl0XYyCUkS/E1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788882; c=relaxed/simple;
	bh=pldg2llEjEyOaGm779mMWq38l+difCmbgBZus5Aqjxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkLMzRw/8C8+KRnuWyuzNOqAd2CjdRA2bmq3pg1ZIFc/kdH2gcjdqeNvbHtiaiTcPoHDLF5L8gNVapXRSxMgid35/Nr8Uw3Xctmymf7MilVGYYrm2FFPU//Kv2Sir8TE6QI47h3DOiZC8ooYnUufTeTFpYE15b3Aj9uyggf/nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LX5MKICq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CvxkHtTJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBw5GC555423
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8JH8Pj1+x9r
	g0tUgHi0xQrWQSBn7a+Wn2nIqN38kB14=; b=LX5MKICq5gyJi46OHbfVUDEyYMn
	lG3OvOhtMamSzGdam6eiS0BJRWb48cJOkeJkYb6jQOAn1bbTEu9jDFmPNJwI4Vvu
	V4gLKoGUPJ3i5Qw/aMA66315IOvuI2eEbORREZ4JOoSus5t4y5qPsLbwOi1trJlh
	PWWRMrhXE8ueIjeNgTfpU1/nL6jMguX2OsuysM1a1LrppI2c0YD1Ym7yxe4YrDJI
	v+tj8LUBcmM4G5DjzzpOWcVyfyGmHNvANN0CbqBgd+U9rZhBAWmVtLoMBX4rd8ax
	ATga7kLSnsYkKGdb65rYuAyuriEJdMGgO4ropPkQ5ah+KlFJjBq/ZMwUKEQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59hwxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c56848e6f45so1584822a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788879; x=1770393679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JH8Pj1+x9rg0tUgHi0xQrWQSBn7a+Wn2nIqN38kB14=;
        b=CvxkHtTJQu4YgTrKepiMsrwrRKgBVuZ3wZDxUv4fwcfcls06fUSzAAJkv8uwH0fjrI
         VZb7QH7lxPJVd4Qh8pcQLqNhrw43PURY+YmNOSA71oqohWUraJ6f16onDzOhgSPbks2r
         834F1uBJrJhmNBk5QukdZOESpHkERwr+8pRwNLzUuQe2eq+qFGigqBCiDVQBtPC/0TdG
         2YAtKoGnXjsJCiMzR4NZrphrVAHEydnvizbCXmWqKRYIHrkUm9SOCD23XBxhO+1wHSQD
         oCu9kW+paNu2hBaxOj6Y+GBBsPLdLjcWyVN386kiWCxyFyhy4J1p28I+PYl5Yug32PyP
         uBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788879; x=1770393679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8JH8Pj1+x9rg0tUgHi0xQrWQSBn7a+Wn2nIqN38kB14=;
        b=vwz3LJpWNyD6fEC0k7awH6/5kVZk9lGa+ErkqP2C2J9W7dNrrttloBcr8Sc+tDKeyl
         6KV1jkZkMTAOJ1p16yoONQdXLHRK9wx0pylFXW+paeIsmLTpmTIkSGC1Qiy6UaoGCKzt
         IgXWfSCFYpbFEXUlZeOKo1Ob7eAXVkoQ74Q/+0kgjxQtjOfc56r8iomEBr3IqB6k2BGl
         b/QlxFJruyL6j0my1BbnMV5tH/7fFr6495gEGbMszy4D1FQjbuPjYTOlg5V3bFmqaziq
         pjc96VdeJjKUl3N+OXUWwPD9IKvzj7RuyeTPRTZaUmaTcsM3JurHhWGveY9ZMnpgIJFQ
         rHxA==
X-Gm-Message-State: AOJu0YxNlwZT8bKHMK92epjKjBE37uDxVubDzF82f1iAUzPUx7wlgr+y
	aryvvonys2GewEhsGzxqbsugd5ni9EgxI8FzC/y9a7I7SKL8uGz+SYdmSp0vhoYBWoGT0aRIrHm
	nqyrd7VlABYGlCjhP5Ufp7uxUMDom6127AtRBUJVphrlOVHnhACKUO57LM8eQCyjkz6j6
X-Gm-Gg: AZuq6aJsxJeMCUATAICaZIOChfsaMk+9JF0heiaLebW9sEej2TjriJAET+xMm8HweAf
	NIT0m2eqdmzHAdsP9MZNEkSXbSz/SZH4Q2t3LToUra2qiIw+ovFNDQJd4pLLNS35hb3+GfvF8M6
	uXPg6IeDatlQXRLz3cR6f4Se5qK93OvCz4NYWE2NpJBKZl3Wkxso0lmvuui0QPd7zjVqSmDrmj8
	WNFIVcX8gkJvlz0GCfGyM2aZJ5l6Wl3f72Vi+suyS4Es6hGa4w0MTx15fr0EIdAbfuI35cMf/xv
	BunSOIe7JjttI/oWjfustgj/9k5CE9gLHXPgto+Wu8UlNSDAkMaQwU0vX9lMg+cnZaQWeMcmqqJ
	M/q8koDm3Ho6O6+O5QD0NDThJJzEJIUtXgh6UT9n2Aa0=
X-Received: by 2002:a05:6a21:a98:b0:38e:b618:dd7e with SMTP id adf61e73a8af0-392e0181f5fmr3301983637.74.1769788878635;
        Fri, 30 Jan 2026 08:01:18 -0800 (PST)
X-Received: by 2002:a05:6a21:a98:b0:38e:b618:dd7e with SMTP id adf61e73a8af0-392e0181f5fmr3301909637.74.1769788877792;
        Fri, 30 Jan 2026 08:01:17 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:17 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 12/13] wifi: nl80211/cfg80211: add LTF keyseed support for secure ranging
Date: Fri, 30 Jan 2026 21:30:38 +0530
Message-Id: <20260130160039.2823409-13-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vJwvztt3BQHxIVeAt5EsDuUQoDoSQJQz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfXzZoz4HSqEc7j
 MSymyLPjpZq5+KNDXpeZQ0yPFFQNE4wWa1cQcmDTTH6TxOJn8qMEaV9KMSwC2MNVnYdwOYuJpF7
 q1TZU+F1gWhb/jrP8MFeSOLVPx7f9CxuCAzsKoUIUSbY2Xlu5jHq3OIQGf1TJyCiXpTYywnpG4V
 aIBc7r1eWaulomK/XUSidxXgqnrareT2LXTi4QeQysgrlLccoSFOuNIYb7K0EKEz6gjhhno5+Dc
 cjmkyyv1/EC/9YKuB1Hwx54eNYZmIYGxARV29WyG8iU9FPZmYJJODyZzYNXgbjdlZtmmJRaAD4n
 v8c4Pa6aYaLl8Wlt2iK7OyYJOyYtiQZozpNIfXXl7DBTjqPvsPkTrKaGTWZ9voJrioL43OKkxFz
 VzNp0emUMM2+WDgVWIhzy851+EcbtarG0TOWINTEbyO6/LY5sXigasmA6vPJpZE+3g9Rj7tl9Ca
 i8PpXfIwA//RRaKXkPA==
X-Proofpoint-GUID: vJwvztt3BQHxIVeAt5EsDuUQoDoSQJQz
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697cd5cf cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=RLl37CfbZXLVIz5jBOIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31396-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9332CBC5BA
X-Rspamd-Action: no action

Add NL80211_ATTR_LTF_KEYSEED attribute to support secure FTM
measurements. This allows drivers to generate secure LTF keys
for PHY-layer security in ranging operations.

The keyseed is used with trigger-based and non-trigger-based
FTM requests to enable secure peer measurement sessions.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h | 15 ++++++++++++---
 net/wireless/nl80211.c       |  7 +++++++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index dd45dda7e619..ea6b9c994455 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -800,6 +800,8 @@ struct key_params {
 	u16 vlan_id;
 	u32 cipher;
 	enum nl80211_key_mode mode;
+	const u8 *ltf_keyseed;
+	int ltf_keyseed_len;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c102a54ff335..4db71f400571 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -395,9 +395,10 @@
  *	%NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
  *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
- *	and %NL80211_ATTR_KEY_SEQ attributes. %NL80211_ATTR_MAC represents
- *	peer's MLD address for MLO pairwise key. The link to add MLO
- *	group key is identified by %NL80211_ATTR_MLO_LINK_ID.
+ *	%NL80211_ATTR_KEY_SEQ and %NL80211_ATTR_LTF_KEYSEED attributes.
+ *	%NL80211_ATTR_MAC represents peer's MLD address for MLO pairwise key.
+ *	The link to add MLO group key is identified by
+ *	%NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_IDX
  *	or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC represents peer's MLD address
  *	for MLO pairwise key. The link to delete group key is identified by
@@ -5536,6 +5537,13 @@ enum nl80211_key_default_types {
  * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
  *	Defaults to @NL80211_KEY_RX_TX.
  * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
+ * @NL80211_ATTR_LTF_KEYSEED: LTF key seed is used by the driver to generate
+ *	secure LTF keys used in case of peer measurement request with FTM
+ *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds will
+ *	help enable PHY security in peer measurement session. The corresponding
+ *	keys need to be configured before hand to ensure peer measurement
+ *	session is secure.
  *
  * @__NL80211_KEY_AFTER_LAST: internal
  * @NL80211_KEY_MAX: highest key attribute
@@ -5552,6 +5560,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
 	NL80211_KEY_DEFAULT_BEACON,
+	NL80211_ATTR_LTF_KEYSEED,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2909520bb949..3aaa5734be57 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -968,6 +968,8 @@ static const struct nla_policy nl80211_key_policy[NL80211_KEY_MAX + 1] = {
 	[NL80211_KEY_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1),
 	[NL80211_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
 	[NL80211_KEY_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
+	[NL80211_ATTR_LTF_KEYSEED] = { .type = NLA_BINARY,
+				       .len = WLAN_MAX_KEY_LEN },
 };
 
 /* policy for the key default flags */
@@ -1491,6 +1493,11 @@ static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 	if (tb[NL80211_KEY_MODE])
 		k->p.mode = nla_get_u8(tb[NL80211_KEY_MODE]);
 
+	if (tb[NL80211_ATTR_LTF_KEYSEED]) {
+		k->p.ltf_keyseed = nla_data(tb[NL80211_ATTR_LTF_KEYSEED]);
+		k->p.ltf_keyseed_len = nla_len(tb[NL80211_ATTR_LTF_KEYSEED]);
+	}
+
 	return 0;
 }
 
-- 
2.34.1


