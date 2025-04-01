Return-Path: <linux-wireless+bounces-21037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC9A7832F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 22:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30D73ACCD4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308520E6E2;
	Tue,  1 Apr 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd9T75p1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412E211282
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538394; cv=none; b=blvX9onucb+nqGP0CVW0H0AKsCnFPDf/wMAUCbugw2GLT18/Lu6sfc7Tp9y/3axLWbdHPLRyYS1g36djlMdQTmCbo5iZxmRNI4FWbtYXvnfdmWdLLM25rPIGdA4drFAu+0G2AFYJB5JdRNVTe8ymCnb94gHtXaYQCo6cPyJFlcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538394; c=relaxed/simple;
	bh=n4YKCY9CVB1XRKXU+xcg+F9wnm2QrE2HIh/CHt1X5P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmYypEiaOTCD1pYGSZ7fgRbnBg9oELA9mZng7inzR7/8bT8am65jWna0NzNUSM602JZ6UK2ogReFQ2WZiSuRZZ4ooR5UC5wBgyTQJ+sRRnYJ3ym4HNoJ0jaULoO5UBYgatUtLPS9MFvz8i3i7ahhRV7T3OLatb1vW4OtXPCDZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd9T75p1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso338474a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 13:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743538390; x=1744143190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiKGDpao1r1B5y26fL4e1GIfbPfIT5cu94qv2R3mhIM=;
        b=Gd9T75p1b/3t35ytlAT7L5c6E5NksYezwFfKWJb1RmhVlaDuA/egAA9CAmOOoLLEi5
         Uuf7ZIqEQPFZSHGwLOY4Rfot3rK1earjFXm26s6/qV3wYwdaMNgO1sCChBsERUFyiWfT
         8p2EyxF1cjZu3hWQRZiaarRL8HgGk9AJagHi74WKwrSua/6PCfxZ/DpgumWdy6suTGO2
         o/NSaDqvRA9GvY7rBy2Ar+sc9uBzTCrEt0pM1AFBrR2/zXTrxQE5CyWAJuQ9/QN4/gsG
         RtiEET1scHYQYqeNDMOMOnOnfDeoj+m7gaBVF96sp6kuCuzc+i6xl17TJEDEV+WDUr9/
         c1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743538390; x=1744143190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiKGDpao1r1B5y26fL4e1GIfbPfIT5cu94qv2R3mhIM=;
        b=Kyc9HT2SHr4udVziKSXNAite6PAY0cp2m5oDiOMPJL1AV2s8M3rnx3b2eDGAVOyO8Q
         qE2OQDysB26LQ7QBcPwakgunKdF+xejag05l7JARGdbQoTcxzpgT59U9RQmmG9AsU8+R
         rr0ddlgu2KgRqIrMvvMmdUeA9ai/rp0njHQ34fOAmH6Ij6X4fILjYEqe1g3av1t1XWiU
         6j4xzLy89TqFDcwfVx0Q89t5hFnggs7ejc6SyaEU0p+hdFBA6w7aLcKYgPOTZ18RnqD4
         aqnPAn5H0PP4s39M4YGBgSiGnC7dtVm/9ydtp87a00jGs4ZybO5qun/URtzke31zXE9f
         Vl+A==
X-Gm-Message-State: AOJu0YyuYS8yQ6iIO+jLe6KkgambDCssPf84kV6EVxTVMa79tCIIU/GT
	LulSaXUFzLxOBZSfI2JCUAMX4OmP05m/uBCOygQrAtB8OSm54NHzsTKG6bf6
X-Gm-Gg: ASbGncue0pephPJ5SW5cocQG6A1aBKVka5Osrkz7Jvp0Kd2JXn7MSkQBeJZiyEV85Rf
	8Y0deXujiudGqcCuEacJH3h8lZu3gtAapC8TcaXycd4In9Rv1SF7ElEXsPlYKc4lpDHj0m9s8O1
	dPThiH8ztGBN4ZzSP+RXStztqylRdrSzh1KePz9dJBF3+jSZFmEWYaHzjRelvso18AT9m7Qb1NQ
	FBVYrZljOxT9ClEgSvImv0lChql5O9gnE1BMQ0uYBztu8DgyWV18FcKrpdXmhc0+DHjgxbcTFg3
	tStCExEuQTUDeotfDQNB9oOtd64+pZvSWphHrxbTYUokFba6D6Mb9wZDyAgFIXjPUCeYWTEih45
	7693o5cNP4VeXcEuO9c7Xw6uOvdmh+H+7aB0JzlfEqL32asj1vzYAWyBKUXmC
X-Google-Smtp-Source: AGHT+IHD1KDJe3f4qVgJPvOY0jF/F/2smkBbWxFfcHyXoa9RDNb8cGnK19N8UB8XDzLGqRZO/cQlqA==
X-Received: by 2002:a17:907:7202:b0:ac7:2fbb:ba5 with SMTP id a640c23a62f3a-ac797af177bmr115192966b.7.1743538390185;
        Tue, 01 Apr 2025 13:13:10 -0700 (PDT)
Received: from hp.NAT.swidnica_mmp.vectranet.pl (178235177162.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196ddfebsm799078966b.164.2025.04.01.13.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:13:09 -0700 (PDT)
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	j@w1.fi,
	Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [RFC wireless-next 1/2] wifi: cfg80211: allow send/recv tagged EAPOL
Date: Tue,  1 Apr 2025 22:04:13 +0200
Message-ID: <20250401201259.50627-2-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
References: <20250401201259.50627-1-janusz.dziedzic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to setup 8021Q VLAN ID when handle control
port packets. When set for tx direction lower
layer should also add 8021Q header when send
control packet. For rx direction lower layer should
remove 8021Q header.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 include/net/cfg80211.h       |  3 ++-
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       | 11 ++++++++++-
 net/wireless/rdev-ops.h      |  5 +++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index efbd79c67be2..2324881afc76 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1290,6 +1290,7 @@ struct cfg80211_crypto_settings {
 	bool control_port_no_encrypt;
 	bool control_port_over_nl80211;
 	bool control_port_no_preauth;
+	u16 control_port_vlan_id;
 	const u8 *psk;
 	const u8 *sae_pwd;
 	u8 sae_pwd_len;
@@ -4963,7 +4964,7 @@ struct cfg80211_ops {
 				   const u8 *buf, size_t len,
 				   const u8 *dest, const __be16 proto,
 				   const bool noencrypt, int link_id,
-				   u64 *cookie);
+				   u64 *cookie, u16 vlan_id);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
 				struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ddcc4cda74af..ae6f199cb40c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2899,6 +2899,9 @@ enum nl80211_commands {
  *	APs Support". Drivers may set additional flags that they support
  *	in the kernel or device.
  *
+ * @NL80211_ATTR_CONTROL_PORT_VLAN_ID: 16-bit VLAN ID used for 8021Q when
+ *	we would like to receive/send tagged control protocol frames.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3456,6 +3459,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
 
+	NL80211_ATTR_CONTROL_PORT_VLAN_ID,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fe59ede23d81..1ccf9d817ab6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -851,6 +851,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 	[NL80211_ATTR_EPCS] = { .type = NLA_FLAG },
 	[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS] = { .type = NLA_U16 },
+	[NL80211_ATTR_CONTROL_PORT_VLAN_ID] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -11004,6 +11005,10 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 	} else
 		settings->control_port_ethertype = cpu_to_be16(ETH_P_PAE);
 
+	if (info->attrs[NL80211_ATTR_CONTROL_PORT_VLAN_ID])
+		settings->control_port_vlan_id = nla_get_u16(
+			info->attrs[NL80211_ATTR_CONTROL_PORT_VLAN_ID]);
+
 	if (info->attrs[NL80211_ATTR_CONTROL_PORT_OVER_NL80211]) {
 		int r = validate_pae_over_nl80211(rdev, info);
 
@@ -15795,6 +15800,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	u8 *dest;
 	u16 proto;
 	bool noencrypt;
+	u16 vlan_id = 0;
 	u64 cookie = 0;
 	int link_id;
 	int err;
@@ -15840,9 +15846,12 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 
 	link_id = nl80211_link_id_or_invalid(info->attrs);
 
+	if (info->attrs[NL80211_ATTR_CONTROL_PORT_VLAN_ID])
+		vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_CONTROL_PORT_VLAN_ID]);
+
 	err = rdev_tx_control_port(rdev, dev, buf, len,
 				   dest, cpu_to_be16(proto), noencrypt, link_id,
-				   dont_wait_for_ack ? NULL : &cookie);
+				   dont_wait_for_ack ? NULL : &cookie, vlan_id);
 	if (!err && !dont_wait_for_ack)
 		nl_set_extack_cookie_u64(info->extack, cookie);
 	return err;
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 9f4783c2354c..d24d02258fb1 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -769,13 +769,14 @@ static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				       const void *buf, size_t len,
 				       const u8 *dest, __be16 proto,
 				       const bool noencrypt, int link,
-				       u64 *cookie)
+				       u64 *cookie, u16 vlan_id)
 {
 	int ret;
 	trace_rdev_tx_control_port(&rdev->wiphy, dev, buf, len,
 				   dest, proto, noencrypt, link);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
-					 dest, proto, noencrypt, link, cookie);
+					 dest, proto, noencrypt, link,
+					 cookie, vlan_id);
 	if (cookie)
 		trace_rdev_return_int_cookie(&rdev->wiphy, ret, *cookie);
 	else
-- 
2.43.0


