Return-Path: <linux-wireless+bounces-29662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE9CB5E9A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 545C93026B3D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD063101D8;
	Thu, 11 Dec 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQu9qBzf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YVsIE5hb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F423101BB
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456900; cv=none; b=Ruq8vHZp/IK8IGaLNoiC7Ts117ZiYQder5Z2Vn/86hpHrwDr9zMfZoLVcaznGQ+zektpqDUdF4WDKqTJv+7Xeti9VD7rpY608gZuGRgiWuET17+MrjCsCHsMF5kaQWsJHblPUuFfJmkWySgz2cQ84SIdTMDYpA+j6io5V9k9KiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456900; c=relaxed/simple;
	bh=sSSn4Catp6cM36baDU2gn1axe6pW+e5O7c5RMbTvEkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDhMCCtRcK3UbobWpXGTw5hbMNAc5ib4+DMn71390p4AWcxe6PcKe8ZgD289xXcfRj4ltabor95UnDXl4yKAYRpUFUnZXlQ0eFHzn5SV21aXWDIxZLJ4bBzQq6SlJQq+anrts5JPKNnJ0ET/PHQdbhGwMB06QjYVANQvAmwUlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQu9qBzf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YVsIE5hb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXnjs1775224
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=OAV8+VfMV5s
	skuRa1gf9fMa77yZFYiTsSsXBnGVjVYk=; b=nQu9qBzfBBjknrLM7doonnLrgAi
	jqWrYLcuzANnOu46Rim2lYaoILamsYAlVNTgAieCnrfnLqtL1TgRVNaaimTXPQ7U
	IHazGyJ150O36vL7cTnHn0dq6hpBEbaApo/hZ0Rtk4oB0mF90nmT8OqwlSVDgVsg
	R7WXzdymtIRmnt14F+7syhRJK+mtOG9F7BibVXOTrWhf1WO/zEXaMBxWpJrNtYVr
	RrEd1ru1fA37vGovv/ySMocQ3AjDMKZZrw2dwMSAHC4g5sep6BrwgmA6p+hEJo6v
	7Uilr07YCAO798KYr0RviHv3+bev7pHl7m29G04VyvvgPa/B8xKliWD5Biw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayt708v17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7d481452732so28030b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456894; x=1766061694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAV8+VfMV5sskuRa1gf9fMa77yZFYiTsSsXBnGVjVYk=;
        b=YVsIE5hb81tgtKuw51SF1Bys8QMAQ2/ifON7YD8Ynk6PLObj2avkTc1dFYZeecgK8j
         pDSEL1vk2irK0FidWjYiIM9afl3li6587bmBTxWZ59ZfuIZKrKxxLs65wDTZibsOyr+Y
         7zsAQaPAIguqLxVtHA9txsTqTtO82qb7MKhhCtqE/sCr351aMH5b588LEi/B4zPSBL9/
         I5uT31Xfnb4hVMEcPHUFO1X32gLVC+xTqTOuUHxM0Ep+yH8x1E8inFYl0DLCmDmWaoIC
         m7Tw3T/w8HegSLXer1PLTYu/PhvfkK05+2szJR49M+K7vUob1vD8CMKU2f6XMZX8OQo/
         iXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456894; x=1766061694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAV8+VfMV5sskuRa1gf9fMa77yZFYiTsSsXBnGVjVYk=;
        b=Ah+6jyM5mvFSs6DZ+uH0SF8yFmA+xoHq864PY4sWNBM9K5EXTiDTCNWnKamaLnhIxN
         l4aGSup6WJqrWoqLsW/gdlEyeuo83+JxxnTcSwLQncJzQY96n5uHCXwSiGGPwey+uI/r
         YArqKrqGV0sgav0jllB9mH8tipNQeYv/loVCLJhyovgWoWilhi3cVsof3S0FZknjtq3X
         35Mn4JTJfMTSjVuMVcVXRmRLdk9uds7uKhDMl0oAeVWl/yuw+R0431AaM80PVCvLpub1
         h3hoAJN34mqJLUXgGGuFh0jO5pn0/JZIixXZhTGTpKl+g94psNyvygKYHE4kfWXdB1Nm
         VcDw==
X-Gm-Message-State: AOJu0YyTyMfm1zkg38pGkCjSdabtb5YVEKGEOI6JAkwj2CHJljVBSu7F
	bHXaAEU75+ClIrfFyLFQ5J7QifJVXduov7wMIJV/9FmCZe+cbNE8e7bc4D+5QTv+a1ng+nWCwDU
	WZdLATRvMjWymtJZqJ6YHPF6qD+FrHgtTipIMxM05KGHx8AFPuQRWbJfUSPEFEwMbVVUf7A==
X-Gm-Gg: AY/fxX7laa7Tn2zCOtk4d22/QRwHDG6l5lDpRSP61GIfmBPW6hO6FqmycVWwNuv6rmn
	H2OthMPUaquxLXH/sqN11VtqiAp4wXRa0hwotu6H99DnyecRpd4AdLYhxUGpaaSz6RXk7ewsm/g
	2q4lBOmNRczmRPZSuECOcl98QQ8Cyei6opMFGE1bk1gEAN/G2x4OZkE2KYlJ696CIvMTDQVvgRe
	XRtMEJzKm0fC42JDWE99j8B4U7RkVTY7w5cyRsh/gPgnTL7SJCBmuvCFSCkNyx6N/x8YMiyG/rm
	eaKR0wNOL42/CDvEZkYMtpFR5S8Y5WPFKzZa6JJTJjwVaakmaP0Tq08M+qk026MZ2J7TxzC56uc
	ORTOe6BKMCYfP4P0X7iAJW6zfSrLymampzt0noOa0Mw==
X-Received: by 2002:a05:6a20:258a:b0:35e:7605:56a4 with SMTP id adf61e73a8af0-366e299a88emr6071926637.51.1765456894033;
        Thu, 11 Dec 2025 04:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLtEP3VZofSq04qddkZ81K9VYPJBkOEImIIHikSLggQFVD8cO0HwYqDBewwlvXgFY188knKw==
X-Received: by 2002:a05:6a20:258a:b0:35e:7605:56a4 with SMTP id adf61e73a8af0-366e299a88emr6071900637.51.1765456893484;
        Thu, 11 Dec 2025 04:41:33 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:33 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 08/14] wifi: nl80211: add a new netlink attribute for hash algorithm
Date: Thu, 11 Dec 2025 18:10:45 +0530
Message-Id: <20251211124051.3094878-9-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfXzRlKBKFUrbhu
 Bu5r38ZqoASKByfaaRVO9WW6LW1bXwEzK5mgdSWoaWMccoo4JX+d3EcZNNze7hGTXUoASnHOZ+p
 pw888XSnRnHRat9iNNrIoQWlLHkKZ2iKoS/B780ZBHWZARqC9gX0xaqD5YsyGKPPlnyvS3fYitJ
 lU0/xL+XBI/BGvhZPGAHUDhXoc9bxxVkojKgiQ+9j1UGqr6pNdaJ4mcCoDEWVg/YKd0dR66c5yV
 Vnjr0ZRtQTMkh250mNvSUOx+Dh26cWYp/HrhsPuMrYtUFuRuAIhkCdmMBO6ME/C0S85eD9fZM16
 jldCw2+ISSuShR/zUxPk9QqUh3WRDWMPLnZSVtKAe02SoGNt+uRRRjYltsinYDkF+q55WpqK+pe
 lg+/D4AFJwz1eKwwkBwV2ppfmw0m1Q==
X-Authority-Analysis: v=2.4 cv=WYIBqkhX c=1 sm=1 tr=0 ts=693abbff cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=eKadUipa5mwdCKUGqpwA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: U-u3e5kTs_V28g8Lk3N8d_Chf0QPeh4R
X-Proofpoint-ORIG-GUID: U-u3e5kTs_V28g8Lk3N8d_Chf0QPeh4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

The IEEE 802.11bi standard introduces the Enhanced Privacy Protection
Key Exchange (EPPKE) authentication protocol as specified in
"IEEE P802.11bi/D3.0, 12.16.9". This protocol requires selecting a
hash algorithm such as SHA-256, SHA-384, or SHA-512 to use for
Message Integrity Code (MIC) computation and for generating the hash
of the Authentication frame.

Add a new netlink attribute, NL80211_ATTR_HASH_ALG, to allow userspace
to provide the hash algorithm via the NL80211_CMD_AUTHENTICATE command.
This attribute is only present when the connection uses the EPPKE
authentication protocol.

Extend struct cfg80211_auth_request with a hash_alg field to carry the
hash algorithm from cfg80211 to the mac80211 layer.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  3 +++
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       |  9 +++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6f02d2fdfc71..8f2ad094779f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3200,6 +3200,8 @@ static inline const u8 *ieee80211_bss_get_ie(struct cfg80211_bss *bss, u8 id)
  *	given an MLD address) by the driver
  * @ap_mld_addr: AP MLD address in case of authentication request with
  *	an AP MLD, valid iff @link_id >= 0
+ * @hash_alg: Hash algorithm defined in @enum nl80211_hash_alg used in EPPKE
+ *	Authentication.
  */
 struct cfg80211_auth_request {
 	struct cfg80211_bss *bss;
@@ -3217,6 +3219,7 @@ struct cfg80211_auth_request {
 	size_t auth_data_len;
 	s8 link_id;
 	const u8 *ap_mld_addr;
+	u32 hash_alg;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d0008780ffcb..0074fccd4b51 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2987,6 +2987,13 @@ enum nl80211_commands {
  *	as specified in "IEEE P802.11bi/D3.0, 12.16.9", this attribute
  *	is used for MIC calculation.
  *
+ * @NL80211_ATTR_HASH_ALG: (u32) Hash algorithm used both for Message Integrity
+ *	Code (MIC) computation and for generating the hash of the Authentication
+ *	frame in the Enhanced Privacy Protection Key Exchange (EPPKE)
+ *	authentication protocol as specified in "IEEE P802.11bi/D3.0, 12.16.9".
+ *	This attribute is used with %NL80211_CMD_AUTHENTICATE.
+ *	See &enum nl80211_hash_alg for details.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3559,6 +3566,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_KEY_KCK,
 
+	NL80211_ATTR_HASH_ALG,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8463,4 +8472,31 @@ enum nl80211_nan_capabilities {
 	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
 };
 
+/**
+ * enum nl80211_hash_alg - Hash algorithms used in EPPKE
+ *
+ * @__NL80211_HASH_ALG_INVALID: invalid, not used
+ * @NL80211_HASH_ALG_SHA256: SHA-256
+ * @NL80211_HASH_ALG_SHA384: SHA-384
+ * @NL80211_HASH_ALG_SHA512: SHA-512
+ * @__NL80211_HASH_ALG_LAST: internal use
+ * @NL80211_HASH_ALG_MAX: highest hash algorithm number currently defined
+ *
+ * These values are used with %NL80211_ATTR_HASH_ALG to select the hash
+ * algorithm used both for computing the MIC and for generating the hash
+ * of the Authentication frame in the EPPKE authentication protocol.
+ */
+
+enum nl80211_hash_alg {
+	__NL80211_HASH_ALG_INVALID,
+
+	NL80211_HASH_ALG_SHA256,
+	NL80211_HASH_ALG_SHA384,
+	NL80211_HASH_ALG_SHA512,
+
+	/* keep last */
+	__NL80211_HASH_ALG_LAST,
+	NL80211_HASH_ALG_MAX = __NL80211_HASH_ALG_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d890d0f25191..c83252cfc0bb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -935,6 +935,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_KEY_PREASSOC] = { .type = NLA_FLAG },
 	[NL80211_ATTR_KEY_KCK] = { .type = NLA_BINARY,
 				   .len = WLAN_MAX_KEY_LEN },
+	[NL80211_ATTR_HASH_ALG] = { .type = NLA_U32,
+				    .min = NL80211_HASH_ALG_SHA256,
+				    .max = NL80211_HASH_ALG_MAX },
 };
 
 /* policy for the key attributes */
@@ -12035,6 +12038,12 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 			akm_suite = get_unaligned_be32(akm_list);
 			if (!cfg80211_is_sae_akmp(akm_suite))
 				return -EINVAL;
+
+			if (!info->attrs[NL80211_ATTR_HASH_ALG])
+				return -EINVAL;
+
+			req.hash_alg =
+				nla_get_u32(info->attrs[NL80211_ATTR_HASH_ALG]);
 		}
 
 		if (auth_trans == 3) {
-- 
2.34.1


