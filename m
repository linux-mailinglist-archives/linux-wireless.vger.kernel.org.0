Return-Path: <linux-wireless+bounces-29663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61829CB5E8E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FB5A3018EE9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6403A3101C7;
	Thu, 11 Dec 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VLaNcCsp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ckeTwTjf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF84310627
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765456904; cv=none; b=l7ktUaekoo/bCZ6O3XULu3VMEyUlNvkCimhevss0XD1MO5TtTNN6hqWHL7/TGh04BKjUzMUDceKYawUXlnIu7atKaGBRvgmvDeEd3g4zMZlxR2sBeAsthzkppk4Bqk0reFxvZXLbOYpbpH8ZCjV5/GEdKkr+5r92Aakw4XjrzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765456904; c=relaxed/simple;
	bh=AD/EyePXlXVuIPe3lIXGZ23Zpsi4sePHv6ZO8mveQik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETK6vgKAr2/flqaoWwQJkhOqfDECAuAmSgklAI8uZ3vTt+THIODijO70UffD5L8uOU8s9Nz17F1EuIp5RIJp47fwUGL1kBuGv61APYKmMV3zjjoywIn+PSmcVbvwvJsZykmDGjPHr7ZGEpR11RuzNFwLoJGxDhD1M8XcamR/gMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VLaNcCsp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ckeTwTjf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAXnww932640
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPjkCQDzap8oTN6Re21GVh1hr2mZL4uGG5zmb9mc4sA=; b=VLaNcCspNxmJa5mx
	/Y4ruvUlfU/i34R0s7CpjGHTTjH1PUpQfDzGsY+45xdFBh+/E/zpuGS/xtBvIN4V
	fottgwDK4xxVhxWk2ZAcx1QZ9QBQ04PrbPhSZ6WWpYacUpGBp3cbDYoNp8coPd9t
	mxjwLoWmwMBcn15MET83d4a4UkUcGMy1nvye/gZW4zl7yLAi/kVW/9SSdanjWyVA
	qZpJl3xeCl+IoxIv22UAZV81ZHorvqn+O25pSMOUEj3Y8Zsi1dVCgoacr5O3T0o1
	q9aYz9q0oBLgvMs00FZ+78hS5Hk6LdRQ/WO9dncMy61+UVjeG2JXyL/FlqBLwC4O
	+oQCpA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aym581x1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 12:41:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2980ef53fc5so813095ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765456897; x=1766061697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPjkCQDzap8oTN6Re21GVh1hr2mZL4uGG5zmb9mc4sA=;
        b=ckeTwTjfIHu16P3Urm6+Sf5FsOVqabO746WWymkcCHgkHttZMfeb7642MuUV07vj3N
         AhJ0upSFU2ivDd7QuvVbHihVyzkQTbWbZA7FAQcrlZGBW/58TI2k4YPOMPTFba132kKm
         A+BjKqQX4YSJ1Y5vmvy5qfm11R3lczx2tEtHZEL37bwz527AhqILUffRQrhbbp2DfhRH
         S7w/kafuQSuiMqQlNvugGxvtQV+15cCO8/AEGWkszjYbUjCuK/KViQHYS3oEVfjHhlgO
         hnLhKDGCarD/qvOyDs4geRRhU9oOp4BurqzyUihYVObpdLg29Rjf7KYLvwjp4bEJsmAH
         4saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765456897; x=1766061697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPjkCQDzap8oTN6Re21GVh1hr2mZL4uGG5zmb9mc4sA=;
        b=PE6D7iX3ZnFAkAL5lb/tODE6kYCC9m2f9clIWhkosRQhsEi50yaDkHd7jnznvx+Cij
         0dhE5JBYG5UUDaBv4Ao9lk/8WkgUbHUW0lR/qV3k9q8BhzII5/q9d4VA9Lcf+Nv1ss8B
         bHB4F56zesvecU2UCvd/AYyBL+nCmxtRjxKCxVP2pBhktBgDimfs4SbnivdTUuFxQftX
         M16Ik0Yfv0SiGwTpGWa93pGiyCoMwljmNvWFhIxxiLtqbxRrNlGfMpm4jmV+AkmDfGzF
         3pQXJcLGnWDuhNQ9I5puWhqMJBK9D1Ca/3q0BOOJ3jUM/qZluxZYClBfjq9vFO7vTQvW
         2E6Q==
X-Gm-Message-State: AOJu0YwJEI2ASEB3A10owVO2cwv61WE0tP98zajLLye7aItU/el+11Oj
	ENAjUqWQ4S0Xb8YQqsI/Vt0Z28sMcNwF+gn0AsmrMwZeRsMqQT3Us7qezoZPHp6ocnyJYvAVOJt
	Sj+dMqZ2n7iRr6KXoZ6wLOxONOep4WejSe0++CdlNdWvNV6HG0mFf9wjCncqmD5Z00jHCvA==
X-Gm-Gg: AY/fxX57NtIqxflgyR9dlFrNAH0yq7C/UPLIvSm/VCvmUsSgLZnmbJ7LhXJWP7PZaHe
	cclixTeBvthifg3KEdjUHbP7C9bKY+bq5Y6MElJZpvCaTUDmi2MvoKnGIE69ljRVmr5lZ3gVXXL
	d+tsfrq2ume6kAq9DvrWcyv67mvLL9zVMyytQcwJLldojPLawmg/k2KiQShwrh4HBnf93T8SF/H
	KhdbgZhV3zRBDlKP9XH9WaUtimuA5mB70szFhwiuGG3GB1YSU32a0V+6PC54rCcUlBN4KIYxErt
	G8y+MBTKoQEF4VxmUNaNl0Ff+yE5eSTDyygpQnMzTvTMx8zI35LErOevuwHGsAo6EG3bYO3xHow
	lgWv99Ftp1MZyyAm6rM9O87c9Pp2qNDm6tlUJShpoxg==
X-Received: by 2002:a05:6a20:3941:b0:366:14ac:e1da with SMTP id adf61e73a8af0-366e34c1a3cmr6275757637.64.1765456896609;
        Thu, 11 Dec 2025 04:41:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfGXNyEFBg1wgaafXs50W7+jlPl7ZKJm9tYY8djjT1SkCjwQbnuDAEE2DTHBrKpLUU9X6q5Q==
X-Received: by 2002:a05:6a20:3941:b0:366:14ac:e1da with SMTP id adf61e73a8af0-366e34c1a3cmr6275732637.64.1765456896035;
        Thu, 11 Dec 2025 04:41:36 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e163sm2272297a12.20.2025.12.11.04.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 04:41:35 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next 09/14] wifi: mac80211: add MIC generation support for EPPKE authentication in non-AP STA mode
Date: Thu, 11 Dec 2025 18:10:46 +0530
Message-Id: <20251211124051.3094878-10-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
References: <20251211124051.3094878-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HKpcpVN1vEc4ayECYpZSJlD9PUMQdnHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA5OSBTYWx0ZWRfX+PEZH6Cy0+Oz
 P25SWNKYmEaxEBmTkwo2oft38v5AEriKI/eXkbW1UUumxr50Ccn5HPJVn8a1gvnweuBFXC29XzI
 5MsmkyMLMmF+kgGmwDp4yqe3jI6tGRrepX2eWoKIG41bJLl/PanBOg0ARnA+OZz+hIeD7+dXWku
 aWB4/h/xonZ9XQhHCM/LE4kzp2DTF5990xQohUKJlo83NKfi2JBUgSUAIQp42qdbMdNzcKpEELj
 gf9TBDR8cFd4V1XsmpCZY8qb1XLO5mrUbp5rnkMcZpZD4eczdv7vvc9hwCrhkHZvsg3DT5b+9Vw
 RywRDzVYQZcnN96xHbvLSih8aZOJqteriI/xz8xjKVr4A7WR8MtAJKjCcvxM8Q7qD8Mh2ITm+To
 oOlUKkOXSvnObvD3LMtV8GqWkT6OPw==
X-Authority-Analysis: v=2.4 cv=FYU6BZ+6 c=1 sm=1 tr=0 ts=693abc02 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=BI07Ezm16H5Q64etzFcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: HKpcpVN1vEc4ayECYpZSJlD9PUMQdnHD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110099

According to the IEEE Std 802.11-2024 specification (Table 9-70),
the Message Integrity Code (MIC) element must be the last element
in the authentication frame body and is present only in certain
authentication frames, as defined in Table 9-71.
For Enhanced Privacy Protection Key Exchange (EPPKE) authentication,
as specified in "IEEE P802.11bi/D3.0, 12.16.9", the MIC is mandatory
per Table 9-71.

In the SME-supplicant case, userspace constructs the authentication
frame body, computes the MIC over that body, appends the MIC element,
and passes it to cfg80211 via NL80211_ATTR_AUTH_DATA with
NL80211_CMD_AUTHENTICATE.

In MLO connections, userspace constructs most of the authentication
frame body, excluding the MLE, which mac80211 appends later in
ieee80211_send_assoc(). If userspace computes the MIC before this,
it produces an incorrect value over an incomplete frame body.
Moreover, the MIC element must be the last element in the frame to
comply with the specification. Since mac80211 appends the MLE after
the userspace-calculated MIC, the ordering is violated.

Add support for MIC generation as specified in specification
"IEEE Std802.11-2024, 12.13.9.2" and append the MIC element at the
end of the frame body for the EPPKE authentication protocol.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/ieee80211_i.h |   4 +
 net/mac80211/mlme.c        |   9 ++
 net/mac80211/sta_info.h    |   9 ++
 net/mac80211/util.c        | 278 +++++++++++++++++++++++++++++++++++++
 4 files changed, 300 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 50fd5e83ed6d..76682933f4fa 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -423,6 +423,8 @@ struct ieee80211_mgd_auth_data {
 
 	u8 key[WLAN_KEY_LEN_WEP104];
 	u8 key_len, key_idx;
+	u8 kck[WLAN_MAX_KEY_LEN];
+	u8 kck_len;
 	bool done, waiting;
 	bool peer_confirmed;
 	bool timeout_started;
@@ -430,6 +432,8 @@ struct ieee80211_mgd_auth_data {
 
 	u8 ap_addr[ETH_ALEN] __aligned(2);
 
+	u32 hash_alg;
+
 	u16 trans, status;
 	size_t data_len;
 	u8 data[];
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cc6bc58b0f1f..73e7f76e92ef 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9279,6 +9279,15 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		memcpy(auth_data->key, req->key, req->key_len);
 	}
 
+	if (req->auth_type == NL80211_AUTHTYPE_EPPKE && req->kck &&
+	    req->kck_len) {
+		auth_data->kck_len = req->kck_len;
+		memcpy(auth_data->kck, req->kck, req->kck_len);
+	}
+
+	if (req->auth_type == NL80211_AUTHTYPE_EPPKE && auth_data->trans == 1)
+		auth_data->hash_alg = req->hash_alg;
+
 	ieee80211_parse_cfg_selectors(auth_data->userspace_selectors,
 				      req->supported_selectors,
 				      req->supported_selectors_len);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..a5891fa8f146 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -620,6 +620,8 @@ struct ieee80211_sta_removed_link_stats {
 	} pertid_stats;
 };
 
+#define SHA512_DIGEST_LEN 64
+
 /**
  * struct sta_info - STA information
  *
@@ -680,6 +682,10 @@ struct ieee80211_sta_removed_link_stats {
  *
  * @fast_tx: TX fastpath information
  * @fast_rx: RX fastpath information
+ * @f1_hash: The HASH of body of the first EPPKE Authentication frame. Used
+ *	only for non-AP STA.
+ * @hash_alg: (u32) Hash algorithm used to drive @f1_ hash and used for MIC
+ *	computation in EPPKE Authentication. Used only for non-AP STA.
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to
  *	the BSS one.
  * @frags: fragment cache
@@ -716,6 +722,9 @@ struct sta_info {
 	struct ieee80211_fast_tx __rcu *fast_tx;
 	struct ieee80211_fast_rx __rcu *fast_rx;
 
+	u8 f1_hash[SHA512_DIGEST_LEN];
+	u32 hash_alg;
+
 #ifdef CONFIG_MAC80211_MESH
 	struct mesh_sta *mesh;
 #endif
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..b1aba0395d12 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -25,6 +25,7 @@
 #include <net/cfg80211.h>
 #include <net/rtnetlink.h>
 #include <kunit/visibility.h>
+#include <crypto/hash.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -1073,6 +1074,240 @@ void ieee80211_set_wmm_default(struct ieee80211_link_data *link,
 	}
 }
 
+static const char *ieee80211_crypto_alg(u32 alg, bool hmac)
+{
+	switch (alg) {
+	case NL80211_HASH_ALG_SHA256:
+		return hmac ? "hmac(sha256)" : "sha256";
+	case NL80211_HASH_ALG_SHA384:
+		return hmac ? "hmac(sha384)" : "sha384";
+	case NL80211_HASH_ALG_SHA512:
+		return hmac ? "hmac(sha512)" : "sha512";
+	default:
+		return NULL;
+	}
+}
+
+static size_t ieee80211_hash_digest_len(u32 alg)
+{
+	switch (alg) {
+	case NL80211_HASH_ALG_SHA256:
+		return 32;
+	case NL80211_HASH_ALG_SHA384:
+		return 48;
+	case NL80211_HASH_ALG_SHA512:
+		return 64;
+	default:
+		return 0;
+	}
+}
+
+static size_t ieee80211_mic_len(u32 alg)
+{
+	return ieee80211_hash_digest_len(alg) / 2;
+}
+
+static int ieee80211_compute_hash(const char *alg, const u8 *data,
+				  size_t data_len, u8 *hash)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int ret;
+
+	/*
+	 * Compute a hash over the input buffer.
+	 *
+	 * Steps:
+	 * - crypto_alloc_shash: Allocate a transform handle for the "alg"
+	 *	algorithm.
+	 * - crypto_shash_init: Initialize a shash descriptor.
+	 * - crypto_shash_update: Feed input data into the hash context.
+	 * - crypto_shash_final: Finalize the hash and store the digest.
+	 *
+	 * The calls are chained: if any step fails, the subsequent ones are
+	 * skipped and the error code from the failing call is returned.
+	 */
+	tfm = crypto_alloc_shash(alg, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+	desc->tfm = tfm;
+
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto free;
+
+	ret = crypto_shash_update(desc, data, data_len);
+	if (ret)
+		goto free;
+
+	ret = crypto_shash_final(desc, hash);
+free:
+	kfree(desc);
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static int calc_f1_hash(struct sk_buff *skb, struct ieee80211_mgmt *mgmt,
+			struct sta_info *sta)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)mgmt;
+	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	const u8 *body = (const u8 *)mgmt + hdrlen;
+	size_t body_len = skb->len - hdrlen;
+	const char *hash_alg;
+
+	hash_alg = ieee80211_crypto_alg(sta->hash_alg, false);
+	if (!hash_alg)
+		return -EINVAL;
+
+	return ieee80211_compute_hash(hash_alg, body, body_len, sta->f1_hash);
+}
+
+static int ieee80211_hmac_hash(const char *alg, const u8 *key, size_t key_len,
+			       const u8 **fields, const size_t *len,
+			       size_t num_elem, u8 *out)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int ret, i;
+
+	/*
+	 * Compute an HMAC-HASH over multiple input fields.
+	 *
+	 * Steps:
+	 * - crypto_alloc_shash: Allocate a handle for HMAC-SHA256 transform.
+	 * - crypto_shash_setkey: Configure the transform with the provided key.
+	 * - crypto_shash_init: Initialize the hashing context.
+	 * - crypto_shash_update: Feed input buffer into the HMAC state in
+	 *	sequence.
+	 * - crypto_shash_final: Finalize the hash and store the digest.
+	 *
+	 * If any step fails, execution jumps to "free", skipping the remaining
+	 * operations. The error code from the failing call is returned.
+	 */
+	tfm = crypto_alloc_shash(alg, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = crypto_shash_setkey(tfm, key, key_len);
+	if (ret)
+		goto free_tfm;
+
+	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	if (!desc) {
+		crypto_free_shash(tfm);
+		return -ENOMEM;
+	}
+	desc->tfm = tfm;
+
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto free;
+
+	for (i = 0; i < num_elem; i++) {
+		ret = crypto_shash_update(desc, fields[i], len[i]);
+		if (ret)
+			goto free;
+	}
+	ret = crypto_shash_final(desc, out);
+free:
+	kfree(desc);
+
+free_tfm:
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static int add_mic_element(struct ieee80211_sub_if_data *sdata,
+			   struct sk_buff *skb,
+			   struct ieee80211_mgmt *mgmt,
+			   struct sta_info *sta, size_t mic_len)
+{
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_mgd_auth_data *auth_data = ifmgd->auth_data;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)mgmt;
+	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	u8 *frame_body;
+	size_t body_len;
+	const u8 *spa = sdata->vif.addr;
+	const u8 *bssid = mgmt->da;
+	const u8 *f1_hash = sta->f1_hash;
+	const char *alg;
+	size_t digest_len;
+	const u8 *fields[4];
+	size_t len[4];
+	u8 mic_elem[2 + 24];
+	u8 mic_buf[SHA512_DIGEST_SIZE];
+	int n = 0, ret;
+	size_t mic_ie_offset;
+
+	if (!mic_len || mic_len > 32)
+		return -EINVAL;
+
+	if (skb_tailroom(skb) < (2 + mic_len))
+		return -ENOMEM;
+
+	alg = ieee80211_crypto_alg(sta->hash_alg, true);
+	if (!alg)
+		return -EINVAL;
+
+	digest_len = ieee80211_hash_digest_len(sta->hash_alg);
+	if (!digest_len)
+		return -EINVAL;
+	/*
+	 * Append and compute the MIC element for the Authentication frame.
+	 *
+	 * The MIC as specified in "IEEE 802.11-2024, 12.13.9.2" is
+	 * constructed as follows:
+	 *
+	 *   MIC = first MMM octets of
+	 *         HMAC-HASH(KCK, SPA || BSSID || F1-Auth || Frame-Data)
+	 *
+	 *   - HASH is the algorithm used in 12.13.8.
+	 *   - KCK is the Key Confirmation Key.
+	 *   - SPA is the MAC address of the non-AP STA (transmitter of the
+	 *     first Auth frame)
+	 *   - BSSID is the BSSID for the AP’s BSS.
+	 *   - F1-Auth is the HASH of the body of the 1st Auth frame.
+	 *   - Frame-Data is the body of the Auth frame, including the MIC
+	 *     element with its MIC field set to all zeros during computation.
+	 *   - MMM is half the digest length of the hash function
+	 *     (16 for SHA-256, 24 for SHA-384 etc).
+	 */
+	mic_elem[0] = WLAN_EID_MIC;
+	mic_elem[1] = mic_len;
+	memset(&mic_elem[2], 0, mic_len);
+	skb_put_data(skb, mic_elem, 2 + mic_len);
+
+	frame_body = ((u8 *)mgmt) + hdrlen;
+	body_len = skb->len - hdrlen;
+
+	fields[n] = spa;
+	len[n++] = ETH_ALEN;
+	fields[n] = bssid;
+	len[n++] = ETH_ALEN;
+	fields[n] = f1_hash;
+	len[n++] = digest_len;
+	fields[n] = frame_body;
+	len[n++] = body_len;
+
+	ret = ieee80211_hmac_hash(alg, auth_data->kck, auth_data->kck_len,
+				  fields, len, n, mic_buf);
+	if (ret)
+		return ret;
+
+	mic_ie_offset = skb->len - (2 + mic_len);
+	memcpy(skb->data + mic_ie_offset + 2, mic_buf, mic_len);
+
+	return 0;
+}
+
 void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 			 u16 transaction, u16 auth_alg, u16 status,
 			 const u8 *extra, size_t extra_len, const u8 *da,
@@ -1123,6 +1358,49 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	if (multi_link)
 		skb_put_data(skb, &mle, sizeof(mle));
 
+	if (auth_alg == WLAN_AUTH_EPPKE && transaction == 1) {
+		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+		struct ieee80211_mgd_auth_data *auth_data = ifmgd->auth_data;
+		struct sta_info *sta;
+
+		sta = sta_info_get_bss(sdata, mgmt->da);
+		if (!sta) {
+			kfree_skb(skb);
+			return;
+		}
+
+		spin_lock_bh(&sta->lock);
+		sta->hash_alg = auth_data->hash_alg;
+		err = calc_f1_hash(skb, mgmt, sta);
+		spin_unlock_bh(&sta->lock);
+
+		if (WARN_ON(err)) {
+			kfree_skb(skb);
+			return;
+		}
+	}
+
+	if (auth_alg == WLAN_AUTH_EPPKE && transaction == 3) {
+		struct sta_info *sta;
+		size_t mic_len;
+
+		sta = sta_info_get_bss(sdata, mgmt->da);
+		if (!sta) {
+			kfree_skb(skb);
+			return;
+		}
+
+		spin_lock_bh(&sta->lock);
+		mic_len = ieee80211_mic_len(sta->hash_alg);
+		err = add_mic_element(sdata, skb, mgmt, sta, mic_len);
+		spin_unlock_bh(&sta->lock);
+
+		if (WARN_ON(err)) {
+			kfree_skb(skb);
+			return;
+		}
+	}
+
 	if (auth_alg == WLAN_AUTH_SHARED_KEY && transaction == 3) {
 		mgmt->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 		err = ieee80211_wep_encrypt(local, skb, key, key_len, key_idx);
-- 
2.34.1


