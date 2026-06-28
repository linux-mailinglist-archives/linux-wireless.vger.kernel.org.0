Return-Path: <linux-wireless+bounces-38222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4jfvFhrvQGp2jgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:53:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57B6D3896
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 11:53:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DjSAuYB2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38222-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38222-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C3323010EF2
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DEB3546D6;
	Sun, 28 Jun 2026 09:53:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10335200F
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 09:53:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782640402; cv=none; b=s64Mv/Rd29//b3IiH7ALXRR1/eLhaQ3ILRw0zhLQ0mDG/crEh21QYCD9rt39p5YO6OCiWTRYttZtEM3a7qVprjv+epwuXTKL1xM+dX4oIvTQ1AbDNalJZiTtJkxWo8kPKEfnP+5aSlbBgLpr975hCN3hnGybnvmu/7l3QUD3KtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782640402; c=relaxed/simple;
	bh=vxeNwNjyxP4NFYQarE28gPQNW4bl4FYY9NhLFEhHPxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEDPKFh0m1dxNWjcnvF2hZ2R2gYv/wFjGqN4A/8H6zovBALup8gLIe1dhE8rlOCeOnSbfnh+/grYP0w755KmL4C4EnSplIjKqU2JXaH0I5PEA+LOWwVZmr96quul8JmgorTGa4Yp8ABahL2YilKGcJoGI3cUc3hpITFtrvxhecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjSAuYB2; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4926f8e02e8so12911165e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 02:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782640399; x=1783245199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBDMwG9/ky6ssL+TbdSqxt4N2oK3lmPKFilDE6MIEWE=;
        b=DjSAuYB26spKPpUuZGRyZXpGcFf4b6+szErjpxcUMbxL7ELx8vA2zg9+zAzIXuX1EO
         wNKKXTy/A4SV6XRdN8JO2JdEBrgjZ6UniHPiSkXCmMiVEfiFQaiwis9S8QOZHBXF6LHf
         8RTsWUbvf+8e6/9JZmHk2lI4qg+C4jpi0JPuK3SojdtyK+NrE8jToVCnlLmiqT/sSOBH
         Jv8IEgRAX9gthwEobnwJ3IOge05Kr6tjWw8+8Jf03ZMRnv5Qhr7orhwST6OsCRHG61B1
         ro4BxH0FO8ABWrN5g99KIx5pXJL7B+EbbgjJLXpFGt1zSxk1wRlOQzqeM57EBiv0AGo6
         LXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782640399; x=1783245199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cBDMwG9/ky6ssL+TbdSqxt4N2oK3lmPKFilDE6MIEWE=;
        b=pHL6+6BvyG5PyE1mhPUCMW8cJmsvvAcBQSX4HcqD7fZzQ9216+mH3opyLcLYIDiVph
         EyVTR3Xn1PV+Jc4XK0Hg1RIOgcl6cfC4rsnFOdqn83YDKhkFbLZVpbL9an8nxBX/9sW5
         mOkN99M99gUg5D7TZl0YnCBjrDbuBJXJa8ha3Xh2PsgVn80VUuSmBOBj4zE7twQbHp8R
         GTEen7VCwfRCttolknFQbpjKSCx3ipcxot4B/JDrWwNFZIZdk/p7iQyFTdy7nAyg88iO
         RbQjLHpcBsJZXJ8PuJSRPHyzw4mk6ECNyVL7/lYViOYBL2jQBuWNk5+9R6hflcuQirmx
         xDCg==
X-Forwarded-Encrypted: i=1; AFNElJ86O/27fIrxi4f9dkXEW2g3qTzmJmBUwxJcOEb8RrKQ8NjXzfFEK8a64z2DMM2bPyPglyJb8Y+lCboS7ysb+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SD5phJB1XIWFtgqwjtuwZdrC6cyrsNCTU9kncAURP4Hc8IuO
	6dLhDvuJBVnWOtrtVCxGrxWFVtkpvsuYQsF0gi5lPprFnSjrdp5MlcUp
X-Gm-Gg: AfdE7cnSNy9iXP2QOvV+HVBAKmgIwsXiinHqk0xaxWIBYcFbwS5VFo+d9Jtbks/8bve
	WM5O4sZcTx03rtdlVNA0d31PLYHfsaaM6C+airAJf2hU9lOzS9dQCohn/DGM2dn1eG8I/jNOhG1
	ANIVE7KH5F8cRqiQ54EmSESTAfX5/BYbF19gPN70AAFvsZUXCsnIlE5tlBDsmRuCJUQZ/a2SQGU
	1Weife7XW/vxXs5wwSt5bwypNo5GDCo4ieJRIFU2jhw0UGPGEq4L0Bbie7dp9NGMTPN40zKr9cM
	qJxGaDq/nuLdt0bRi6O4gjptd7a7TgSNCAxo3nk8uvw6GWzNxg3Q9U8VV4JvWeLQxDhmoWa1YRn
	Jp1RQGJ6wufi6aXrX3/u08dmYFVNf5R6PFDzM7asQFT9QIOjUAlpy1x+szsAEubXaT8vdepPhiy
	++/14YiBOFIl1433U/orZqaR/m0lmCUsOfFDjiHu5+LGrCSBaBwzjlHFWHEG3qfMx81/8SgBDck
	fqm2qs=
X-Received: by 2002:a05:600c:8b18:b0:492:37b7:6090 with SMTP id 5b1f17b1804b1-4926683b257mr194454165e9.5.1782640399331;
        Sun, 28 Jun 2026 02:53:19 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm189602075e9.2.2026.06.28.02.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:53:18 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH 2/2] wifi: mt76: mt7996: register a LED classdev for every band
Date: Sun, 28 Jun 2026 11:53:13 +0200
Message-ID: <20260628095313.7790-3-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260628095313.7790-1-petr.wozniak@gmail.com>
References: <20260628095313.7790-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38222-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D57B6D3896

The per-band LED callbacks (brightness_set/blink_set) were only assigned
to the primary PHY (dev->mphy) in mt7996_init_wiphy(). The 5/6 GHz bands
are brought up later through mt7996_register_phy() ->
mt7996_init_wiphy_band(), which never set those callbacks, so
mt76_led_init() bailed out early for them and only the 2.4 GHz LED was
ever registered.

The hardware path is already per band: mt7996_led_set_config() indexes
MT_LED_EN()/MT_LED_CTRL()/MT_LED_TX_BLINK() by mphy->band_idx, so per-band
hardware TX-blink works as soon as the classdev exists.

Move the callback assignment into mt7996_init_wiphy_band(), which runs for
every band, so a LED classdev is registered for each band.

Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
 .../net/wireless/mediatek/mt76/mt7996/init.c   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index d6f9aa1ab..b77b85654 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -472,6 +472,18 @@ mt7996_init_wiphy_band(struct ieee80211_hw *hw, struct mt7996_phy *phy)
 	mt7996_set_stream_vht_txbf_caps(phy);
 	mt7996_set_stream_he_eht_caps(phy);
 	mt7996_init_txpower(phy);
+
+	/* Register a LED classdev for every band, not just the primary one.
+	 * Under single-wiphy MLO the 5/6 GHz bands are brought up through
+	 * mt7996_register_phy(); without these callbacks mt76_led_init() skips
+	 * them and only the 2.4 GHz LED is exposed. The hardware TX-blink path
+	 * is already indexed by band_idx, so per-band blink works once the
+	 * classdev exists.
+	 */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		phy->mt76->leds.cdev.brightness_set = mt7996_led_set_brightness;
+		phy->mt76->leds.cdev.blink_set = mt7996_led_set_blink;
+	}
 }
 
 static void
@@ -542,12 +554,6 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	hw->max_tx_fragments = 4;
 	wiphy->txq_memory_limit = 32 << 20; /* 32 MiB */
 
-	/* init led callbacks */
-	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mphy.leds.cdev.brightness_set = mt7996_led_set_brightness;
-		dev->mphy.leds.cdev.blink_set = mt7996_led_set_blink;
-	}
-
 	wiphy->max_scan_ssids = 4;
 	wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 
-- 
2.51.0


