Return-Path: <linux-wireless+bounces-37777-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxlFChLfLWpqlwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37777-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:52:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 896CD67FF79
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:52:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37777-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37777-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C694300AC21
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F808282F01;
	Sat, 13 Jun 2026 22:51:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EED3A8732
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:51:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391118; cv=none; b=HjgRZupOUZBom38RNozgUD0sAE5DxZseiyjBjdEpYZa4/it33hc61mIHNf4kEMMocNW/sdDhgCyZNxmTJwTkZ4r9gQ7qb2xBoSeXkL5yx7vYAspShtdP4ngfky87YQgESe06EGO4V7QHqkvIn+n3L2WgnKUqX9hvGzH5Y9/k+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391118; c=relaxed/simple;
	bh=GqW+L0R6OrxIkm/DS5LKn4gEZ42vFHsPMFDN7BWczBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQNfX9WDO09cbqQeWb/h8bvTugY6Rz1uUbewJXFTWLnxcmIH5puL4WcOq6ipX/KurOF/Q9Wg9S7Kbos1jQ7T4yACbm5MUAXr48cVnLxEisnbQl3zMwTZ/ERL8Jhz1k1GnaKS/HDxeWKyZKGkogb5FdE6IHQMQtsidhYubWLKzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36b8d414666so1318435a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781391115; x=1781995915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDBvXF2yuCDUwoxTRJn9WiANQ6TvXDN+2ABteU7sgK8=;
        b=NAcpQu+ev4yLgxmJGxkFwm/qnuMkDY3rCVyeCiuLe8COL/8N5a1Q3j78eEwf1Gmflb
         iohomzG1Qy3ayiE6oNJVMBwQ7Ub5S0EA2XraXAtQCWVJjxNm5MATEBWaIRQIVM+rY9iD
         hVck37HEvzp7HMklSYGYnuscoyipmHrpO5LHHTa8SE3K6ENanlasCtIONKfqygySkKI2
         OtYAQTLIy5EnCFRtFnZ5IWGadjG2xSSuR/YUquxwAxxL5sFC1mJTCxJBwWM8t1kGDlWW
         YqOngR+LoZ9Lce7n/DpZevSYihAZ4+WmgLHc7WmhhZNDnHzpM54hwiMR9KwtgFMizHi7
         tI+A==
X-Gm-Message-State: AOJu0YwNhOz9vanruGfwZYeLkPgsv59vTmSBR/n/9ru4fdAipm2gLKqm
	3a3y1DYyjmEQ62RQKgI2eQwSonXxdBTiRA8SfgMcnCzGgdmm2UrN9Tlk
X-Gm-Gg: Acq92OFIBWvcmlj7vXuqfDHVB55O7WHv0jpNbH88pAlPXKNDlExkY4DODurey1mnARX
	QBtE9FjtbfQF1dgZOft014yTdJLP5bpgObYe+mbswv3XDyMXMPaf8oo8RM8pntwtvbD3Hb/ISQZ
	y6JM/sHEh8zbX5kTWCwLiPNAmxKsVPYHlowbUzid38GoT+XLyDM1BAFSSltAg6+6stR2b5Fk/2J
	s4obFFTOinrDgVS9t/jcSEeZwufdzkXZ1We7LGC9D7QWXMZSDXTX+9qfSMX2WEMwlcaytGePU1l
	Afc7Gz3Pzb8LhcKWCcAelhW63nceBo0eIbVmFnxUpwEnWsQaPf7lOawGORxgluxqkokNtHK8JSU
	XiwQzbAlste9hjrI56F3qFPqgrsYyF6ZRXnGP7TbwyxI9DA2sIT3Gfk9OiWiDNrSKHSFyus60ZB
	2wC4tpBm9QyMvN5HaRa3iHUyDjAv0r8pbCNKJWQhSHAhmoV56XnPxEUvgNXel6AGn/qNSwuJZx0
	HZVHgYGGUz6dJ9F4+XG/C+joFl48YeLdzIYjWfC
X-Received: by 2002:a17:90b:570b:b0:368:d839:28d5 with SMTP id 98e67ed59e1d1-37a040ad487mr8921781a91.18.1781391115156;
        Sat, 13 Jun 2026 15:51:55 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379c333c43asm4215770a91.0.2026.06.13.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:51:54 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7927: set band index for sniffer mode
Date: Sat, 13 Jun 2026 17:51:43 -0500
Message-ID: <20260613225144.2414283-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37777-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 896CD67FF79

From: Sean Wang <sean.wang@mediatek.com>

Use the active channel context to select the SNIFFER command band index on
MT7927, and fall back to the PHY chandef when no channel context is
available.

Also pass the same band index to the sniffer channel configuration. This
keeps monitor setup on the correct band, especially when multiple PHY band
contexts are present.

Fixes: 35a5dcc71735 ("wifi: mt76: mt7925: add MT7927 PCIe support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e94fa544ff20..17bc7204f02a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2174,6 +2174,8 @@ int mt7925_get_txpwr_info(struct mt792x_dev *dev, u8 band_idx, struct mt7925_txp
 int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 			   bool enable)
 {
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct ieee80211_chanctx_conf *ctx = mvif->bss_conf.mt76.ctx;
 	struct {
 		struct {
 			u8 band_idx;
@@ -2196,6 +2198,15 @@ int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		},
 	};
 
+	if (is_mt7927(&dev->mt76)) {
+		struct ieee80211_channel *chan;
+
+		chan = ctx ? ctx->def.chan : mvif->phy->mt76->chandef.chan;
+
+		if (chan)
+			req.hdr.band_idx = mt7927_band_idx(chan->band);
+	}
+
 	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(SNIFFER), &req, sizeof(req),
 				 true);
 }
@@ -2255,6 +2266,9 @@ int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
 		},
 	};
 
+	if (is_mt7927(mphy->dev))
+		req.hdr.band_idx = mt7927_band_idx(chandef->chan->band);
+
 	if (chandef->chan->band < ARRAY_SIZE(ch_band))
 		req.tlv.ch_band = ch_band[chandef->chan->band];
 	if (chandef->width < ARRAY_SIZE(ch_width))
-- 
2.43.0


