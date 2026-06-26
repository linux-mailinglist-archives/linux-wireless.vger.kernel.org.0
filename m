Return-Path: <linux-wireless+bounces-38126-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8DZDBfodPmoSAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38126-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:36:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7F6CAAE1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:36:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=dolZwzrY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38126-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38126-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2C423062C8F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABD3DB32E;
	Fri, 26 Jun 2026 06:32:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6A3B18A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455525; cv=none; b=bQnwHXbEn2pn9Gchjr44TI3TaxV5puGa4uuMlWkVie8RZfGlvMDP8Q8tQZvTxCqTnRlkmCwFb66a3VBOlS06oAt52cegK6CeusEkx2EMzmzjaiYfWb+cipELHfTIcA0xwA3655FKRmZnqooK2t+c7uLb8i8v9XfXmzAxtsFHmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455525; c=relaxed/simple;
	bh=AtvgtgrU9AhT1GXo8E3ry1laDRtt3WKW4ChoodhSG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERF5+jo65E8sLsBL4mIRHoSVLP28ubJ6l0M99iKaqXMRLfYFQyMzrTY7R/L9fSy1vPURjPWZtXZxfzzF0CSXcoUsh4dZa6/BvHhfHXl8I9r+M7k04jFnMxmH7HxXSgQ5A2XllALYX/LRl/AYXEDD7opoqulRTBD4p1aPdsBZjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=dolZwzrY; arc=none smtp.client-ip=74.125.82.50
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-13986d61b4fso906974c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455523; x=1783060323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcXMHk/5mb644KtgMEKd4Gs4cSqkCxlFtc3gws9nby0=;
        b=dolZwzrYqBEuCySqAPzTF9C932Av2JMCKujnehC9iMYvXOrbnVD+kOvNuwev+rrl7O
         jNZe7+64haxBvZPP1SsyXlUk4khzXzvNarjx5fVpXWnMloN5MxzdprZ0SIi3rSsl6wP+
         esp9z3SHhjYaW/HIElu+cQ0x5hZb4q8o8GXbID2+/fJ9VAhVykqsTOEcqkhIiVIH/9NE
         I+EYyVDmkhcQIp+laO2EP+Rfwk4JUTkkDkZf8rtKHdGismSDlMQ6VtHwSAaM/JwOYqpV
         g91x3yGx0xdnGPPbuceKR0h/0/c5/HEauVHVwE2vxCbTlpljgeJGaN0c3IXHwE2UR4ZM
         gq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455523; x=1783060323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcXMHk/5mb644KtgMEKd4Gs4cSqkCxlFtc3gws9nby0=;
        b=LT1j4q+KZWH8b3RJXwYGoTLCwTKOSnDqlrhUVuP8XwOPdVBqdbscQ8OOBPBMPWEidO
         Sk2tH70A/7gRTHvmIQaDSqFnzhdUBSc//Y1pcCwgNNQ2CAyZ448WuQb6WcGFKebPkjty
         VQPP1txKJ1UszMS1dI/kYGmlw9CaBrlIB25JSUwpaU2cfpwZIjJmo7Cm2Y1Y8WleLBeg
         HCoPvPa6CnxelWtFMr82II5oaFesAJVe5/qQW7hD2i1Yaw5hDJ73w5a6E8eYThOCF2Bt
         F9WgoMpOz/pPrq4OchdiV83z4+y3ZG8r616bwyTjxbd6XchU5BRFfq+uChCoalZLUo/C
         G1lw==
X-Forwarded-Encrypted: i=1; AFNElJ9LBiKuSR35x37LLvfdGiAYc4MXrwM39u1UTUquryRVOvQKwtuBuJ2m2TYyB7Dbbz1EhAgy7n+1RuSlzTLqZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL34lhQWUF4L8BGw7LoNi0weBAnq+RWv1fxKJFsuemUxOgSKPi
	nxRFiYDANEiSgrX+NKWMR8rsYw8g2O9ZEfJs1QBp5XTN3WeDMnJ5Xs8sR4VS+EuGQvc=
X-Gm-Gg: AfdE7cllx8gX8jBGDEAx9Wax0Lw3qbdm72FfcLKtZPe1chOWbUb8BZ4eUQWxotKgEPF
	NOb05HRF8fcHwM/QhKRpw+5d/WqWe6WGjFDcaG3aK2V1eapJn0JPozDYnP0ssN3pww+HmwSQ8dR
	iLzA5sMXjyORfOIOuVCZVIXYhNhmTZCLX5SQ3UjGUyhWxtgjOQVm51FfdvbiL+lcloIDLA+xTXf
	8jlE1Wl3HD2+7E8+dOTVgvBiyHsIObqI1oH/wJ1MKCmaLbFu3uIGuYI++HS/8E+xTUyFZNSnQCo
	bV9eZ3P3WFJph4+tDBd5lVWlTksDGv6bzxi3spmqa4QOtwHcab1+RjFbAE/pSIb4RCdxcwkyJTg
	lrGiFdQ5jx3yzNQJepFP0iUBGfrIL1jEjoIZsMzUzTBbqwBF3X6rnmkj+Khq8dlYRHB1TfpyWHS
	gFYUed84vUyvWva/EHFFpX7EvCdcyFenDTzGbSKdtKlVsw26wlyY9PGFBYBDGE227sRG4nemEfa
	uXLNt/NyziZ56yOT9uY
X-Received: by 2002:a05:7022:6726:b0:137:f4ec:29ff with SMTP id a92af1059eb24-139dbaa660amr4134838c88.22.1782455522747;
        Thu, 25 Jun 2026 23:32:02 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:02 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 15/33] wifi: mm81x: add mac.h
Date: Fri, 26 Jun 2026 16:29:11 +1000
Message-ID: <20260626063014.1275235-16-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38126-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,vger.kernel.org:from_smtp,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81A7F6CAAE1

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/mac.h | 63 +++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/mac.h b/drivers/net/wireless/morsemicro/mm81x/mac.h
new file mode 100644
index 000000000000..c540471f274e
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/mac.h
@@ -0,0 +1,63 @@
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
+static inline u32 mm81x_vif_generate_cssid(struct ieee80211_vif *vif)
+{
+	return mm81x_generate_cssid(vif->cfg.ssid, vif->cfg.ssid_len);
+}
+
+/*
+ * Build a little-endian word from the last four octets of a MAC address;
+ * the first two octets are dropped.
+ */
+static inline __le32 mac2le32(const unsigned char *addr)
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


