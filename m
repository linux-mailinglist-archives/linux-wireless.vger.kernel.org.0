Return-Path: <linux-wireless+bounces-35660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O0TIK/j8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:07:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D402D49D836
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57016309B6D1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41A369997;
	Thu, 30 Apr 2026 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="IPs2jkpH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842242C2346
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525067; cv=none; b=l8S/1Kkv4UvG8bOOS9K+cPRgJJ8B0YTbMaYc0u2SJyeqMfQLhngjy4egccfMlG7iZ034hWMK3250Rdo/g3WMfYisnPc8a7RrEnriN9eNo2SmXwTyZ4BXWNZ/QAtKsTy/yUq04Sx7gM7EVyiA6estD4HHXskqaLwneEmSwT9LUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525067; c=relaxed/simple;
	bh=utmOcp/mUECBVuqOHLylIc+rNnV0qT6rbUGBQdu9Rao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoJU6z15iZq4Pya988y7q5pGxdChChHpFcN2I8Jxic8CqG0nQvejqd7lRyjKEndq78d79RjUXCCYMtSBcV7SF4LoGg8EDqUROm4GyPngmYzdHmADY7Q/sgcw/flVZEelmScT5Uu+hyhE8iotQpJDHNdU/TaPZt7L6Fz+EmXm6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=IPs2jkpH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f8b60e485so226692b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525066; x=1778129866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbTKXZy+oEE4jTZqOvVwk6YQ7Ypi8QSPqu8VJUA+WJc=;
        b=IPs2jkpH5oZXqFC1OMvxSKOZUQG5eIIJIJ71pmYOo2xfrRIawnmRYUiuJvNPLL8PTN
         fiWjoAlzpsrip+T0/yqC6GK7eFFVvVYSh+w+3O9rs/3+nzYsdquRZLdk3Ddfj6rRwT8n
         2n7GbYQeQC9AlrtWi6CTy2PzaViDk6QsyNzjB58LEJlHKIYBJI9ITlesr/Alk4UhQEEB
         gZn3B3FmRmFaOwAaxOEAPs7KRW2Ey6MP5oqobRTy9OWBNys/Zo2teIjlbyxxb4RWYTOj
         NLTA2i/CLAEAsaSdmmiXp0v3tl3TXPgf82l3kXoSjepDbUlJLJhE+CinoDCTgFsUn4Ii
         OITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525066; x=1778129866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbTKXZy+oEE4jTZqOvVwk6YQ7Ypi8QSPqu8VJUA+WJc=;
        b=gLSjsOrmUSb5kuLHRsVnOquwJhJwQDECB8Uly/PZYYcYqlrd56A+7422/JIE19zBC/
         Rm3vYR8oNZDIEjQj4p9K4nf4p4nJJllpqpvFAKBmjrQvUssGmS473H4r3L/uLu6rpisy
         pdOc5Yrq0ORWkvOPGtWoxlUzZDYFgfYVW6ryiZddMozpJjyWvgqZPVkwZwl68NsfwvRp
         a9BQmprGgLTq+ywbWNHLdJWAQUhvrfEJTDfweGSUQ/2/zqofrF01dGQWfUX5cWaJtjqh
         DFIuRZkK3uFnuSBxhLe9GmBB5EcMU+z3D34xdvAWsoH4AayRIXgeE2bLbHwZbpN18Pj8
         DANw==
X-Forwarded-Encrypted: i=1; AFNElJ8ClVJBBLj3UmG11O2sKq9JVw8Rn7kshDtGleiFJtadswBkuKAE+dEQgPge7YV6fNdRCsTkBllHU3opN14m4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHEJUPpLBo6cjp+7QgIhB7+bmlefUhOHfGZZ6QYDYX0hxi2vA
	cAuY52u4qbi9cuGyFOaoJIIVYMlfwwZ3gn8r4J7V61gjkE1xEaU7nWJ9wO7r61+59uA=
X-Gm-Gg: AeBDietOZ6jhlrUGMwy3cDHuFlF/5xf+mosZMqEaN70BXk0FQvQIj7Q4QqFLcUt3+0J
	Tn2ZO1tH6C1llzwK175as6ubmPbfb3K6HEDKDpX8sbVOLvE+6U4B6VzB1h43SJxHcuQkkPGrLN8
	6UCJTlZsGtEtljbOojnazzcW2DFGQ+PM1sberxSEEYoQLU2secnjHBNQAtkWVRpIPadETmkGlEB
	lQf3c758dH0sfdzyX+4zoOBwCxxdMkAAOd4noPmoWFuXMAXl8dhzaF/KOiGvPIiLEMUn/r4/BBM
	NLaxYqq2+A9aqB8E4Ew++OtsWI0F1pXenOgl8FUdzQbguYEVC72M4VRoorsZ60nOfiEL/7vyLJm
	4oSn6KkcQeAsrubU2BrsafR5iVrxi1+YXwfwQ5y1/H6n+prpguCxo1DR5ysWpLzHsfKM7Lm1Jtm
	0D9bOU+/BI2sG1CfZzpsi6PlyTLMiN1UUZElR/fgUJxwEmOT4iKS7EEbV0WKk55oboew5avD429
	sKA7cdqddXU81n7xi8Eq50LQNJwi+DsBYo8x+m8FA==
X-Received: by 2002:a05:6a00:1f14:b0:82f:4a53:a95b with SMTP id d2e1a72fcca58-834fe233ebcmr1477514b3a.37.1777525065804;
        Wed, 29 Apr 2026 21:57:45 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:45 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 13/31] wifi: mm81x: add mac.h
Date: Thu, 30 Apr 2026 14:55:39 +1000
Message-ID: <20260430045615.334669-14-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D402D49D836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35660-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/mac.h | 69 +++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/mac.h b/drivers/net/wireless/morsemicro/mm81x/mac.h
new file mode 100644
index 000000000000..7d0fc2e5229b
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/mac.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_MAC_H_
+#define _MM81X_MAC_H_
+
+#include "core.h"
+#include "command.h"
+
+struct mm81x_queue_params {
+	u8 uapsd;
+	u8 aci;
+	u8 aifs;
+	u16 cw_min;
+	u16 cw_max;
+	u32 txop;
+};
+
+static inline bool mm81x_mac_is_sta_vif_associated(struct ieee80211_vif *vif)
+{
+	return vif->cfg.assoc;
+}
+
+static inline u32 mm81x_vif_generate_cssid(struct ieee80211_vif *vif)
+{
+	return mm81x_generate_cssid(vif->cfg.ssid, vif->cfg.ssid_len);
+}
+
+static inline u16 mm81x_mac_sta_aid(struct ieee80211_vif *vif)
+{
+	return vif->cfg.aid;
+}
+
+static inline __le32 mac2leuint32(const unsigned char *addr)
+{
+	return cpu_to_le32(((u32)(addr[2]) << 24) | ((u32)(addr[3]) << 16) |
+			   ((u32)(addr[4]) << 8) | ((u32)(addr[5])));
+}
+
+static inline struct ieee80211_vif *
+mm81x_rcu_dereference_vif_id(struct mm81x *mors, u8 vif_id, bool rcu)
+{
+	if (WARN_ON(vif_id >= ARRAY_SIZE(mors->vifs)))
+		return NULL;
+
+	if (rcu)
+		return rcu_dereference(mors->vifs[vif_id]);
+
+	return rcu_dereference_protected(mors->vifs[vif_id],
+					 lockdep_is_held(&mors->hw->wiphy->mtx));
+}
+
+int mm81x_tx_h_get_attempts(struct mm81x *mors,
+			    struct mm81x_skb_tx_status *tx_sts);
+struct mm81x *mm81x_mac_alloc(size_t priv_size, struct device *dev);
+int mm81x_mac_register(struct mm81x *mors);
+void mm81x_mac_free(struct mm81x *mors);
+void mm81x_mac_unregister(struct mm81x *mors);
+int mm81x_mac_event_recv(struct mm81x *mors, struct sk_buff *skb);
+void mm81x_mac_rx_skb(struct mm81x *mors, struct sk_buff *skb,
+		      struct mm81x_skb_rx_status *hdr_rx_status);
+void mm81x_mac_beacon_irq_handle(struct mm81x *mors, u32 status);
+
+u8 *mm81x_hw_scan_h_insert_tlvs(struct mm81x_hw_scan_params *params, u8 *buf);
+size_t mm81x_hw_scan_h_get_cmd_size(struct mm81x_hw_scan_params *params);
+void mm81x_tx_h_check_aggr(struct ieee80211_sta *pubsta, struct sk_buff *skb);
+#endif /* !_MM81X_MAC_H_ */
-- 
2.43.0


