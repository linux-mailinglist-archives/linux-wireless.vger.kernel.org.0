Return-Path: <linux-wireless+bounces-14457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E69AE3A1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CB71C22924
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B31CBA08;
	Thu, 24 Oct 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NWg9/jo+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F431CBA01;
	Thu, 24 Oct 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768698; cv=none; b=qf1mxiOKZARYAZvCWtSg1C2rfKVX+gYWnV8MFhVYFtCJKqNJrP9er7IxRF9Edpe9EV8ctj14MSYylXpU5uan8wRi8J3AXUffzJzJNU3mygp7ZzcCbJxmVpWAs0HOtQyBk8Rb2Gmnjn7Uw5BF1ohK7vlpBW04h76C5HjUuFK2Sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768698; c=relaxed/simple;
	bh=59jHo68Y6SScJHLi3K2HIU9q5D4tmFms/qpVNyiNu94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkHVjGWuL//H+NO8qRwHUPNgX5VmQemdVNcMwyfW47v8ALY/YTCPKuduaWTfMxOXX4OvEd7CBjQ+Y4kQ0sS2Bz541VFPq7J8PAp0MXWyy63wQBFP+mWs1K6TZPV/XKDGUuEqjVMVjG1UnmU4YtQ3Zl7Inz20lnt7l7khopt4uOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NWg9/jo+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=P29q5KJfDcxk3PgYOr8w6GLSS5HSQNSBPFbyVcSvwW0=; t=1729768696; x=1730978296; 
	b=NWg9/jo+1tk96Hk4bGsYj/qh3guMxXyudcrIAt/YHW+Mxlkd4kVEDYWqG3dkbvrbOaGcAu0srjt
	0wzvtCmXVwvOg9ThXtuwPcQEe78ulnTnVZyWDNFAxbpkU+7WouI34QX9TcYUs8tk+1jJptQonsLoD
	7UKXk/AyFfWjpkw5kkr+gv2URz569uSWiULiBt/1F42khFBJc7WnrMCQTKBZBut3lEjpRZycdE2Xg
	2bF+5TwkIpD48aa24X9Ba5e7VMpd7rKnNzcCuxweMHb6HKETASj1M9u5klCYk+f5pGjGyHxt1cmfY
	xsH8xqIN+VF24h2w9EclrRrutYLmnhvCdorA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3vr0-00000003bsi-1cE2;
	Thu, 24 Oct 2024 13:18:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/2] net: netlink: add nla_get_*_default() accessors
Date: Thu, 24 Oct 2024 13:18:06 +0200
Message-ID: <20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are quite a number of places that use patterns
such as

  if (attr)
     val = nla_get_u16(attr);
  else
     val = DEFAULT;

Add nla_get_u16_default() and friends like that to
not have to type this out all the time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/netlink.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index db6af207287c..b15bd0437945 100644
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
@@ -1867,6 +1869,31 @@ static inline unsigned long nla_get_msecs(const struct nlattr *nla)
 	return msecs_to_jiffies((unsigned long) msecs);
 }
 
+#define MAKE_NLA_GET_DEFAULT(tp, fn)			\
+static inline tp fn##_default(const struct nlattr *nla,	\
+			      tp defvalue)		\
+{							\
+	if (!nla)					\
+		return defvalue;			\
+	return n(nla);					\
+}
+
+MAKE_NLA_GET_DEFAULT(u8, nla_get_u8);
+MAKE_NLA_GET_DEFAULT(u16, nla_get_u16);
+MAKE_NLA_GET_DEFAULT(u32, nla_get_u32);
+MAKE_NLA_GET_DEFAULT(u64, nla_get_u64);
+MAKE_NLA_GET_DEFAULT(unsigned long, nla_get_msecs);
+MAKE_NLA_GET_DEFAULT(s8, nla_get_s8);
+MAKE_NLA_GET_DEFAULT(s16, nla_get_s16);
+MAKE_NLA_GET_DEFAULT(s32, nla_get_s32);
+MAKE_NLA_GET_DEFAULT(s64, nla_get_s64);
+MAKE_NLA_GET_DEFAULT(s16, nla_get_le16);
+MAKE_NLA_GET_DEFAULT(s32, nla_get_le32);
+MAKE_NLA_GET_DEFAULT(s64, nla_get_le64);
+MAKE_NLA_GET_DEFAULT(s16, nla_get_be16);
+MAKE_NLA_GET_DEFAULT(s32, nla_get_be32);
+MAKE_NLA_GET_DEFAULT(s64, nla_get_be64);
+
 /**
  * nla_get_in_addr - return payload of IPv4 address attribute
  * @nla: IPv4 address netlink attribute
-- 
2.47.0


