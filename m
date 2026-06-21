Return-Path: <linux-wireless+bounces-37950-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id br2BHl/mN2qIVQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37950-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:25:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E356AAE17
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 15:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZMXaQN2d;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37950-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37950-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2288F30055D4
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C032459FE;
	Sun, 21 Jun 2026 13:25:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD41DF73A
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 13:25:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048341; cv=none; b=pmmgOYoIaf5+mTmAhYFoJ3FIiZOIOr8p0hvXGgGW7XZ/yRk3BIofsu8Xe9cX8dSbD8ZGkdShjlbIR1CAgxksLHOXMRTpaMddfMzbjAlpV62Or03zwkhm3Zsk8AGsBVt6uP+lUJKHROBs3k6F0cMsXoeIsBhx/5rVtNqhmwBKiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048341; c=relaxed/simple;
	bh=7vP6pW3muH208Ga0bMDoiASj2cKyemkJsHp8qtMdAnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPzDGPHxT8sVUZ2ufoI2oLFVP6zI6DLklWn7sLV7A2XkzlLfbTei4GjOCBGq2MO72g4jGPGfTNQVAPf2Ch+Gfql30h7lIWDb5bckBlMefG62ZBYCD7cZVZxFGs42HWFkCGS9KhTxcJLNIYhZ8j11zmtnwjirg5sP3Q459uJGg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMXaQN2d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272791F00A3D;
	Sun, 21 Jun 2026 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048340;
	bh=QJYJxNZ3l7dAEjRU1s4OBPkLV9TjpFhDdBuOa9bTN04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZMXaQN2dbi27JvvLcAfjDv8uZqzMMt8+KieoLxoK53NNLJRFbk2YBk3/hfqp2LIkP
	 1qQ182aLy2t6KzkfkBob1QAJcMFg67DcM0TqT8n8nwuTzGtaOsiCRasr9PG+1dN8EN
	 RuHrefLWQ2A88wY/+Q0nhU6CMwgoB2mlzxQUlbk3pdONyJLka68sh/Mp9x3kE75N4/
	 FDtu95pKd3LPSp9iBPcw/NxX92cqSIDTljW/0KJs3dd39ZKvknfdkrFSW04OPoaSMB
	 ksL8oNqUlP1DEeADAmVlp/rysSieJ6aZLLhSp6ijHvIu7WiPBIp4rCag6Vv85Pxg7c
	 1Cj6GUw/XDd9g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 21 Jun 2026 15:25:00 +0200
Subject: [PATCH 2/4] wifi: mt76: mt7925: fix possible NULL-pointer deref in
 mt7925_mcu_bss_he_tlv()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-mt76_connac_get_he_phy_cap-fix-v1-2-ed4ccf7a0363@kernel.org>
References: <20260621-mt76_connac_get_he_phy_cap-fix-v1-0-ed4ccf7a0363@kernel.org>
In-Reply-To: <20260621-mt76_connac_get_he_phy_cap-fix-v1-0-ed4ccf7a0363@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Leon Yen <leon.yen@mediatek.com>, Hao Zhang <hao.zhang@mediatek.com>, 
 Nelson Yu <nelson.yu@mediatek.com>, Rong Yan <rong.yan@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Quan Zhou <quan.zhou@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>, MeiChia Chiu <meichia.chiu@mediatek.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37950-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:leon.yen@mediatek.com,m:hao.zhang@mediatek.com,m:nelson.yu@mediatek.com,m:rong.yan@mediatek.com,m:Money.Wang@mediatek.com,m:Bo.Jiao@mediatek.com,m:StanleyYP.Wang@mediatek.com,m:howard-yh.hsu@mediatek.com,m:evelyn.tsai@mediatek.com,m:lorenzo@kernel.org,m:mingyen.hsieh@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:quan.zhou@mediatek.com,m:deren.wu@mediatek.com,m:meichia.chiu@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67E356AAE17

mt76_connac_get_he_phy_cap routine can theoretically return NULL so
check cap pointer before dereferencing it.

Fixes: c948b5da6bbec ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e94fa544ff20..cb265a6fc7ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2773,6 +2773,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 	struct tlv *tlv;
 
 	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
+	if (!cap)
+		return;
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 

-- 
2.54.0


