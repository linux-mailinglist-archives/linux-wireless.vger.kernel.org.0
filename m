Return-Path: <linux-wireless+bounces-33609-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GdsOnaMvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33609-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 938D12DF24D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03279309A048
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63331A07B;
	Fri, 20 Mar 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlf1Csdu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJQBdWZS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D731197F
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029665; cv=none; b=DVoIwSwTxSHmfTpm8uhc9+OBc7uMRvrnz8xvqKcFr6xY0oWq3amADMnk6Qk9omE+wl2/OmkoPoxzuOw+75UlAsd/zhFP116rbBlCq6Cty7ToAKhjqusimZ/Nui01yWQ2MDwHm1fX3PC1vSsQBwD3T6OR2L5oKbZW9fKoxgURB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029665; c=relaxed/simple;
	bh=mC8G0eH78OGNoAc3sz3gN0lJ3qJW5nZ34yEdADauxpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=extJ/HiKMRNCKx21DDLpsSEywxkAHsaPOQjx/+5kb1DRd5TP8H3OKLx1cbn+4afJuhsDw5Re++3JIQFdsMP3uHDQMaurffMzI1JYT2Vrm0Mt+3GTZ7q28df3Z/yvLoDJrRlJPrXdMf7jzaE0nx8Y14XMpbFmEQnrpbcTsUW/Is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlf1Csdu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJQBdWZS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K94T2H700879
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LPdT3XWtFuB
	BOXUR2u/s1bUfmq3SUActdxO17QL94Ww=; b=nlf1CsdumX0tmhASnJV9LWT8e3y
	FwlJu4/GOn1x7LD4m9htyCWgJ2BpJOA6ICsW9zjJ7vOQMYFFO7GMlrcnUg8Y41m0
	PBnPPdnalAUnc/EyaYWwK45jnJKc4ogou6lFDLt68+BLxKvat8jT1rwicqQstbnG
	u9fHcmPi35K9e97K2g611KXNO4W+BPCYYsWxWRsfvNH6bYNWjlwK28HR/WIlp+F8
	PX/d6ImIkwVyvR0N8FD8VT5L53ALyDv0D2BoFgcI8bzAoIeJOMRtv0W+EIU4tazZ
	/9e3iYGm+KXQIZ5zw+xY3ggCc09SkprbouQBszPCnlD7oMfXdHPP8mr2RZg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d139q190k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adc527eaf5so20175115ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029661; x=1774634461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPdT3XWtFuBBOXUR2u/s1bUfmq3SUActdxO17QL94Ww=;
        b=aJQBdWZStPJwzFIS06KgcF5X/erBjkO41dAhhUT/pF9JeyMIgVcgtsdZP1shg6rar4
         tZNQFFD4eLI+nDO0g+TboBWAHtvVhtICJuDFbb+0SfDpvdv7AyvKD+ri10shyeAC1phO
         UJC6cysF8kNr+F+Ewc88UCFRzz8lq+W0RT96hI2irE3xo1BN44FnzNdRUateBt3xYtkC
         CS/peMa3NP+gbR6E2Aid0BKTTf5b4QIju6Fqj5BpquuQ8cjOa8UTQyNjnwGvSTZ9O2aQ
         cgq+IWisN/Fo1sQtnqQJpzTGgp49Wr0MZSV3X2j9iVbX8BeQfRk2k9q6YZG2W6uKZ6C/
         /vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029661; x=1774634461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPdT3XWtFuBBOXUR2u/s1bUfmq3SUActdxO17QL94Ww=;
        b=q+O+x3prXQZx3KBtNGrAsmDqncrrAXLxYYSFQ7oDyrl+2MeV1Bi3ZAavCNCgdQegYo
         haYiIddrTnh07FCyYAZEp+ATOZ6Zg4tEyrXN4lnpxqu57hAXtojwRVyzQ8ZCGDvWeP/G
         veqK3rfrX4LS9ssxS2w04PlPsrA9e9oIlNtU32jQLMUbU2/at2qjMmafd04u0978hpke
         0SUM82dRzmGhvBPLoKK5JvZ74ZfGwE69OXDMu+RkZSZDR5g5hGw6Q8WNLZa+aWhO6AL2
         IkreXD7rhwdNcqoQ74AzMOe11nMhEk1qigaRW7ahc0GmwMpzF0jvvv+1jPiIOdYz8N5n
         +ZMg==
X-Gm-Message-State: AOJu0YxgmeAQ+4JWw9aweuAP1COBpJfTCTk1nyIju72V76RGG4WYxiUy
	OyBNwty6PVUzz8B0t5yyDWgdz2xr+OcTq85vI3nT5Qerqxo76g55XqNYGc9U3O416AEWMmk17D9
	Lz3V0WZl/ROQHpGH1beusrZrfE3ryjYEStQEw5MFqaxLnrmWWm+sZNXoInoqdvHPP2vP8
X-Gm-Gg: ATEYQzzvYblHfBBoy2Np53v2Vi45xxPJfGiw9+ImhTsoGFEXu/QxxSlYpvnVFX95EQF
	BIoj8IgNmHGizjPos8M5l9TjnTJcZ6mUlCmHD9POUxwPYJdWSNLyEOLw/hoCe0rUHKmmwKhdYsk
	7hCgUB5NaYveOJ9AqQgOSbRIdtgsvFm6iCaFy9lroJ69Ehcnor3ekXPCN4O7kPUDYvw80BbYOAM
	VGvOUnoQfNEb4RhchM3+aKT3A3o328yurBRD9cnBJ0YJtwE2nazOrGJWgFBsfCSgXA9YBaoGthT
	rl68FDMnVwXiaNEAhkssZOkjVmMlXhOFtgrtpkJZUIz3xfLIXfb+h4kh/snFRHaDRuc3nYoedWc
	ilMF6VG+5ROfa3kl6Bb8qd8k+GsTYGnH0Dp1RvJws5NMgi7WiEYMSTFE=
X-Received: by 2002:a17:902:d60f:b0:2b0:6b98:59ec with SMTP id d9443c01a7336-2b08276ecb6mr34830865ad.34.1774029661361;
        Fri, 20 Mar 2026 11:01:01 -0700 (PDT)
X-Received: by 2002:a17:902:d60f:b0:2b0:6b98:59ec with SMTP id d9443c01a7336-2b08276ecb6mr34830055ad.34.1774029659947;
        Fri, 20 Mar 2026 11:00:59 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:59 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 13/14] wifi: cfg80211: add LTF keyseed support for secure ranging
Date: Fri, 20 Mar 2026 23:29:37 +0530
Message-Id: <20260320175938.2547288-14-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX5HD24U0bUAF4
 DNuvNSiDMc6J475MOkmvFv8mpOG41CfHXUplH+bFMwTcL83f9r152VDUzsRD3i3KpF6jpX31Tyw
 SBAUEDbINlWg4HOGOSAPl1wZgvbw+L6jiqHjXAJflABVubLL24Dw6rGXyjPCzEuTFQ3uvc5kQA4
 gwtIPipHcJgCuLcA6DD5nGjZVTQZQaJxrR553D+hbZOe+LtLhjyKa0IAC63bECqEP6+/oMPp9AF
 3+qQesyd1VmHSLEkXhJ3CzMkSYGV7Joqy+9P5XOxNqvbnFHiaLQsKe7s9xQNOZ0LtFsnT2/i3aH
 ncZ91sjznyMQiLXqSw96RpJ2w7IfPX+uVWNN6EyBbPhhruor2uaFqZjLck6DZEf8CIPGFUyZ22a
 ykUdKielALmPU96hy+ML3FA5gWfWZVSCj/RJ4nSWuAkhVVA4MIw7xaTDs46qeWgENC4SS+CRv+4
 qYuTwOOR9av1SCRWk5w==
X-Authority-Analysis: v=2.4 cv=FOAWBuos c=1 sm=1 tr=0 ts=69bd8b5e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=wJ6IAscJ0N9GpxG7cbAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: XUPouxT-SFvcEsvQuzEPJIQcRkU6i04g
X-Proofpoint-ORIG-GUID: XUPouxT-SFvcEsvQuzEPJIQcRkU6i04g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33609-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 938D12DF24D
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
index 52db36120314..51eec09166d1 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2224,6 +2224,7 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_WFA_DPP			SUITE(WLAN_OUI_WFA, 2)
 
 #define WLAN_MAX_KEY_LEN		32
+#define WLAN_MAX_SECURE_LTF_KEYSEED_LEN	48
 
 #define WLAN_PMK_NAME_LEN		16
 #define WLAN_PMKID_LEN			16
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 96abe2eb28bb..d11c10b38b96 100644
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
index d5ac40a385f0..049e82b79efc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5608,6 +5608,18 @@ enum nl80211_key_default_types {
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
@@ -5624,6 +5636,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
 	NL80211_KEY_DEFAULT_BEACON,
+	NL80211_KEY_LTF_SEED,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
@@ -6853,6 +6866,10 @@ enum nl80211_feature_flags {
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
@@ -6933,6 +6950,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
+	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cd4129ae61eb..6a0bbf832cc9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -989,6 +989,8 @@ static const struct nla_policy nl80211_key_policy[NL80211_KEY_MAX + 1] = {
 	[NL80211_KEY_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1),
 	[NL80211_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
 	[NL80211_KEY_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
+	[NL80211_KEY_LTF_SEED] = { .type = NLA_BINARY,
+				   .len = WLAN_MAX_SECURE_LTF_KEYSEED_LEN },
 };
 
 /* policy for the key default flags */
@@ -1520,6 +1522,11 @@ static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
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
index d558c4bc00f0..c38ef5e3846b 100644
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


