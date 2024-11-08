Return-Path: <linux-wireless+bounces-15137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC09C1ADA
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 11:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4947828354F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F91E25E3;
	Fri,  8 Nov 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Z0nXrcV/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFE47F69;
	Fri,  8 Nov 2024 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062514; cv=none; b=Gat6LmZgAAZwQbfc8Uc/ljvPpnY6mWicH3uk5Xu7AwgYAUsNpA/UoVv804ebdjj+/gwsRYHHfPSa7H014Wo5444Ve7D/8K2UdcoqozsP6qp41ZwVM7pd4cfcbQt57sl3uiPxDGNKCgyu9kIo2DqLBt9KUsX4OzX5GdpDTaFAsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062514; c=relaxed/simple;
	bh=mrUtwoLhyryQEAd+3mKtWtK+HGJojM6h9i//fhRGfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NfIyZoTQO8Q6SEdJlC5CcTu1dzI1xildKVA3YrzNcbB6i/0mYT2nBOJUlFX7ZvIuwf6pkscMYmYsAbTyrehisxsjOcTXH9k/Uph0Motq3fdYS8hQ+wnRuUVnaWN8ZXeeU4W+Oa5JPLQuSKQaGuUQWNUV12xr2ejYSm8xN0WuBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Z0nXrcV/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZGEFlv+MHDSVTxOHh9vNQJnCe/It8qLBgAj/8f1xnUo=; t=1731062512; x=1732272112; 
	b=Z0nXrcV/Awcy/Lw0qD28FlSKvlVBaoZYAEY5LaqvW2BggNm3FjxtXqnVF2YMy+YXry9KtoJP6A0
	L/NKmwvvPDcTSMCyTn9mOV4MNMZFxzCuzTnYF8ZG5aWGi7Nneu6VB1IvtKBvcxTC4/+tJGSzm9BPJ
	I5bU81g5t4jM3t+ehi+GCk7eL+cXbB/Jz8jHinPCtkWbe/8SYMtkFoOzVIrCsNp9aMsioQiGTaqSJ
	H4XizBFCqJDJWhwQa14+XlnSIu4VRdskIfIA5vJHQJR5V8u6IgVBwov1h+U2hYUWJCqlvjpsi2wJ5
	rsgjI8t1zVP1QF4WHU4z2yxeLLsExvEdOTIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t9MR2-0000000HDCF-2nLC;
	Fri, 08 Nov 2024 11:41:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/2] net: netlink: add nla_get_*_default() accessors
Date: Fri,  8 Nov 2024 11:41:44 +0100
Message-ID: <20241108114145.acd2aadb03ac.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Johannes Berg <johannes.berg@intel.com>

There are quite a number of places that use patterns
such as

  if (attr)
     val = nla_get_u16(attr);
  else
     val = DEFAULT;

Add nla_get_u16_default() and friends like that to
not have to type this out all the time.

Acked-by: Toke Høiland-Jørgensen <toke@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: switch to individual inline functions
v3: kernel-doc
---
 include/net/netlink.h | 273 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 273 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 2dc671c977ff..8575ad09d83f 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -142,6 +142,8 @@
  *   nla_get_flag(nla)			return 1 if flag is true
  *   nla_get_msecs(nla)			get payload for a msecs attribute
  *
+ *   The same functions also exist with _default().
+ *
  * Attribute Misc:
  *   nla_memcpy(dest, nla, count)	copy attribute into memory
  *   nla_memcmp(nla, data, size)	compare attribute with memory area
@@ -1695,6 +1697,21 @@ static inline u32 nla_get_u32(const struct nlattr *nla)
 	return *(u32 *) nla_data(nla);
 }
 
+/**
+ * nla_get_u32_default - return payload of u32 attribute or default
+ * @nla: u32 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline u32 nla_get_u32_default(const struct nlattr *nla,
+				      u32 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_u32(nla);
+}
+
 /**
  * nla_get_be32 - return payload of __be32 attribute
  * @nla: __be32 netlink attribute
@@ -1704,6 +1721,21 @@ static inline __be32 nla_get_be32(const struct nlattr *nla)
 	return *(__be32 *) nla_data(nla);
 }
 
+/**
+ * nla_get_be32_default - return payload of be32 attribute or default
+ * @nla: __be32 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __be32 nla_get_be32_default(const struct nlattr *nla,
+					  __be32 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_be32(nla);
+}
+
 /**
  * nla_get_le32 - return payload of __le32 attribute
  * @nla: __le32 netlink attribute
@@ -1713,6 +1745,21 @@ static inline __le32 nla_get_le32(const struct nlattr *nla)
 	return *(__le32 *) nla_data(nla);
 }
 
+/**
+ * nla_get_le32_default - return payload of le32 attribute or default
+ * @nla: __le32 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __le32 nla_get_le32_default(const struct nlattr *nla,
+					  __le32 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_le32(nla);
+}
+
 /**
  * nla_get_u16 - return payload of u16 attribute
  * @nla: u16 netlink attribute
@@ -1722,6 +1769,21 @@ static inline u16 nla_get_u16(const struct nlattr *nla)
 	return *(u16 *) nla_data(nla);
 }
 
+/**
+ * nla_get_u16_default - return payload of u16 attribute or default
+ * @nla: u16 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline u16 nla_get_u16_default(const struct nlattr *nla,
+				      u16 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_u16(nla);
+}
+
 /**
  * nla_get_be16 - return payload of __be16 attribute
  * @nla: __be16 netlink attribute
@@ -1731,6 +1793,21 @@ static inline __be16 nla_get_be16(const struct nlattr *nla)
 	return *(__be16 *) nla_data(nla);
 }
 
+/**
+ * nla_get_be16_default - return payload of be16 attribute or default
+ * @nla: __be16 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __be16 nla_get_be16_default(const struct nlattr *nla,
+					  __be16 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_be16(nla);
+}
+
 /**
  * nla_get_le16 - return payload of __le16 attribute
  * @nla: __le16 netlink attribute
@@ -1740,6 +1817,21 @@ static inline __le16 nla_get_le16(const struct nlattr *nla)
 	return *(__le16 *) nla_data(nla);
 }
 
+/**
+ * nla_get_le16_default - return payload of le16 attribute or default
+ * @nla: __le16 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __le16 nla_get_le16_default(const struct nlattr *nla,
+					  __le16 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_le16(nla);
+}
+
 /**
  * nla_get_u8 - return payload of u8 attribute
  * @nla: u8 netlink attribute
@@ -1749,6 +1841,21 @@ static inline u8 nla_get_u8(const struct nlattr *nla)
 	return *(u8 *) nla_data(nla);
 }
 
+/**
+ * nla_get_u8_default - return payload of u8 attribute or default
+ * @nla: u8 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline u8 nla_get_u8_default(const struct nlattr *nla,
+				    u8 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_u8(nla);
+}
+
 /**
  * nla_get_u64 - return payload of u64 attribute
  * @nla: u64 netlink attribute
@@ -1762,6 +1869,21 @@ static inline u64 nla_get_u64(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_get_u64_default - return payload of u64 attribute or default
+ * @nla: u64 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline u64 nla_get_u64_default(const struct nlattr *nla,
+				      u64 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_u64(nla);
+}
+
 /**
  * nla_get_uint - return payload of uint attribute
  * @nla: uint netlink attribute
@@ -1773,6 +1895,21 @@ static inline u64 nla_get_uint(const struct nlattr *nla)
 	return nla_get_u64(nla);
 }
 
+/**
+ * nla_get_uint_default - return payload of uint attribute or default
+ * @nla: uint netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline u64 nla_get_uint_default(const struct nlattr *nla,
+				       u64 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_uint(nla);
+}
+
 /**
  * nla_get_be64 - return payload of __be64 attribute
  * @nla: __be64 netlink attribute
@@ -1786,6 +1923,21 @@ static inline __be64 nla_get_be64(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_get_be64_default - return payload of be64 attribute or default
+ * @nla: __be64 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __be64 nla_get_be64_default(const struct nlattr *nla,
+					  __be64 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_be64(nla);
+}
+
 /**
  * nla_get_le64 - return payload of __le64 attribute
  * @nla: __le64 netlink attribute
@@ -1795,6 +1947,21 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
 	return *(__le64 *) nla_data(nla);
 }
 
+/**
+ * nla_get_le64_default - return payload of le64 attribute or default
+ * @nla: __le64 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __le64 nla_get_le64_default(const struct nlattr *nla,
+					  __le64 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_le64(nla);
+}
+
 /**
  * nla_get_s32 - return payload of s32 attribute
  * @nla: s32 netlink attribute
@@ -1804,6 +1971,21 @@ static inline s32 nla_get_s32(const struct nlattr *nla)
 	return *(s32 *) nla_data(nla);
 }
 
+/**
+ * nla_get_s32_default - return payload of s32 attribute or default
+ * @nla: s32 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline s32 nla_get_s32_default(const struct nlattr *nla,
+				      s32 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_s32(nla);
+}
+
 /**
  * nla_get_s16 - return payload of s16 attribute
  * @nla: s16 netlink attribute
@@ -1813,6 +1995,21 @@ static inline s16 nla_get_s16(const struct nlattr *nla)
 	return *(s16 *) nla_data(nla);
 }
 
+/**
+ * nla_get_s16_default - return payload of s16 attribute or default
+ * @nla: s16 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline s16 nla_get_s16_default(const struct nlattr *nla,
+				      s16 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_s16(nla);
+}
+
 /**
  * nla_get_s8 - return payload of s8 attribute
  * @nla: s8 netlink attribute
@@ -1822,6 +2019,21 @@ static inline s8 nla_get_s8(const struct nlattr *nla)
 	return *(s8 *) nla_data(nla);
 }
 
+/**
+ * nla_get_s8_default - return payload of s8 attribute or default
+ * @nla: s8 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline s8 nla_get_s8_default(const struct nlattr *nla,
+				    s8 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_s8(nla);
+}
+
 /**
  * nla_get_s64 - return payload of s64 attribute
  * @nla: s64 netlink attribute
@@ -1835,6 +2047,21 @@ static inline s64 nla_get_s64(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_get_s64_default - return payload of s64 attribute or default
+ * @nla: s64 netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline s64 nla_get_s64_default(const struct nlattr *nla,
+				      s64 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_s64(nla);
+}
+
 /**
  * nla_get_sint - return payload of uint attribute
  * @nla: uint netlink attribute
@@ -1846,6 +2073,21 @@ static inline s64 nla_get_sint(const struct nlattr *nla)
 	return nla_get_s64(nla);
 }
 
+/**
+ * nla_get_sint_default - return payload of sint attribute or default
+ * @nla: sint netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline s64 nla_get_sint_default(const struct nlattr *nla,
+				       s64 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_sint(nla);
+}
+
 /**
  * nla_get_flag - return payload of flag attribute
  * @nla: flag netlink attribute
@@ -1868,6 +2110,22 @@ static inline unsigned long nla_get_msecs(const struct nlattr *nla)
 	return msecs_to_jiffies((unsigned long) msecs);
 }
 
+
+/**
+ * nla_get_msecs_default - return payload of msecs attribute or default
+ * @nla: msecs netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline unsigned long nla_get_msecs_default(const struct nlattr *nla,
+						  unsigned long defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_msecs(nla);
+}
+
 /**
  * nla_get_in_addr - return payload of IPv4 address attribute
  * @nla: IPv4 address netlink attribute
@@ -1877,6 +2135,21 @@ static inline __be32 nla_get_in_addr(const struct nlattr *nla)
 	return *(__be32 *) nla_data(nla);
 }
 
+/**
+ * nla_get_in_addr_default - return payload of be32 attribute or default
+ * @nla: IPv4 address netlink attribute, may be %NULL
+ * @defvalue: default value to use if @nla is %NULL
+ *
+ * Return: the value of the attribute, or the default value if not present
+ */
+static inline __be32 nla_get_in_addr_default(const struct nlattr *nla,
+					     __be32 defvalue)
+{
+	if (!nla)
+		return defvalue;
+	return nla_get_in_addr(nla);
+}
+
 /**
  * nla_get_in6_addr - return payload of IPv6 address attribute
  * @nla: IPv6 address netlink attribute
-- 
2.47.0


