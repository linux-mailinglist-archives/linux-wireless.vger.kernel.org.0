Return-Path: <linux-wireless+bounces-38060-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DfUMGgB0PGqroAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38060-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE666C1F3D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:19:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38060-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38060-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61E77300BCA6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36A757EA;
	Thu, 25 Jun 2026 00:19:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DA1F192E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 00:19:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346746; cv=none; b=PGfSoiaehr5l45/8ityeltAUUgai8A7UCeyRZOXKiZy174AHI/vSZEbDvjHeoiUfzwNYR+Z+eyBEaSHytdhAuMT6BP9AkDF3ko2ihR5eh+YYeU+8WWGfjzsooEfvjD/gDINJ7YxSqKxgbYNCVPYS/Gq//558oeP4HAesLHwtP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346746; c=relaxed/simple;
	bh=k6vbv4St8c9nutb8oiRVPJe4UMxAZhPf+jHw4NBrYqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCAPMCFTsMgSIUcrZ2vzaezR5vLj1OBV8bXV1ENzY2XIvz/NA50BZpcclCtmEQP4dAx94K8ID2t4VLAKuE7DMjg+nsQQfvQMLPocivOP4DfwZ9zOODJ83tCuJVrdebvhefCe5vmfhfJI14fHRt/7PyhT4Iv5uS14pflg2JByToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8584e80d59so705482a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 17:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346744; x=1782951544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfTLVu81fDyPQcXHERPJcN3IrtYpcc9/vrGzAGCrhXc=;
        b=GTHXVcZirrxX4FrsEo8Tmm1uLdgLM8DRdBcLD9F2UwLfW7Avb/BRo6UYjN6oFfDATo
         SgWrrpzIXx3QSmqJuDrLiokxqyBw2fqwNXJWaO6cXFT16mEzJjx6MAxHlw1HcG30SgOo
         8c5wIU5yU4lbBOd86C1xN1Jo16Waon2UIkqx0IjjTX6ywAmtRrefkJfSs3Vr/nEmyeQe
         FJqPwb0qO/QVLI7ur5g0eOWKO+nFExYerKv0nOLYgZIZGK02PgGLzJRf6WuuQHtFxogU
         QC/YqugwYIubmluFxKZz7AH/0eBzc9hAnjvCGB1Bhoiv99HjkJ6j0wicQTxhS1HsXVVe
         M9JQ==
X-Forwarded-Encrypted: i=1; AFNElJ81+gY8y7eOhSD0FQBoW4/5QDyxcAPWE+e9GHEiRDbX2NRpw+xzVnau8moz0VLj6C1vWEBFKAYJsLBiXDGMqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4uouiWokFPnZ06tmHJC0ttkyV1+96VIVMV8Oxcavty5+2NsJ
	Br/nGP9ei4dSN5cG1Xl3SKOmysCyNy8DR5qkd4/KlD/kdiXwMiEzUN+J
X-Gm-Gg: AfdE7cnAv7VA1vfoVaVbUUsM2dNma5um4oJZ7iC2mNA+055od/y8m4ESQgd2vlc+y2d
	lsY6sVhclCJ9c+fye+m2r0haAzL2jy5oWiSeNOJ7wuVV/H9Gm/XV+gkJwBE8OuvhZbbUCECl0tt
	4Z5Uun6UAaSfcD490AkP7TvtNFwI8OI2ql6+zk3zx4Wl63aSK4XpcNZk7P5JosesIHcSmDxIsR4
	A2OdPZ9/hkBSj77EadUWDvVIbA6sFdYO/OrBF7nvY7tREpm/3dwyZQx3ICmJEs3Tn3r8zqv66VT
	gBRHwV3OwOSD2+ogSZ/ujuUvzsx2HyxotlMLrYCAgWN11AvvGv93O2Td5o4zMsowqYkTPv1Scjm
	dqxb7p59YDnzmVvBIUzkLOX6jiygIZbbXu3ty1hJnzkowubqcPwqNzVO3VBv3pmJtPpTpzzal7+
	VtZFPXGrELPe/VkmLpkdaLQuRHbhSEJAjXyONZGtVy5OBuI3+vccI6EhsRc6kKJxUVOxTWDItHK
	8LsbKyZUh5xKtW92d7x2tsAL4X3Ng==
X-Received: by 2002:a05:6a21:1644:b0:3bd:3536:928c with SMTP id adf61e73a8af0-3bd4aec597bmr295275637.25.1782346744094;
        Wed, 24 Jun 2026 17:19:04 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0d10sm586839a12.21.2026.06.24.17.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:19:03 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: chengwei.yu@mediatek.com,
	yu-ching.liu@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/9] wifi: mt76: mt792x: advertise mgmt frame registration
Date: Wed, 24 Jun 2026 19:18:26 -0500
Message-ID: <20260625001834.475094-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625001834.475094-1-sean.wang@kernel.org>
References: <20260625001834.475094-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38060-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:chengwei.yu@mediatek.com,m:yu-ching.liu@mediatek.com,m:jenhao.yang@mediatek.com,m:posh.sun@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AE666C1F3D

From: Sean Wang <sean.wang@mediatek.com>

Advertise multicast management frame registration support so userspace
can subscribe to multicast management and action frames.

This capability is required for NAN discovery and related operations.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Co-developed-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Jeremy Yu <chengwei.yu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index b50825eccdaf..a0db815c27bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -719,6 +719,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-- 
2.43.0


