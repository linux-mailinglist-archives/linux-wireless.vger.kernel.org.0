Return-Path: <linux-wireless+bounces-32225-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJHUL12doGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32225-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:22:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9811AE480
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3ADF303B7EB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C36839E6DD;
	Thu, 26 Feb 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODS1ZyA3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A0355F52
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133109; cv=none; b=ipTgEip5yQkOXySZLt0zZo2t/gQYHfA+j0p0PcseG267jsCXuKIMVQ0DdtdvcyVzVUJI6S9CNrZVMlMJjF3ndmAhyhLFciXaFcdhFhc9UGo+1lEkX82djbTrnb3OzVXelXEAfh+w+CazA5BFV7omlpq3OhCAjwOzr1VcRoEC5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133109; c=relaxed/simple;
	bh=lTVyJVB0aB+uUxxgnjTFm8CX4/aNy1Ar67t0XoIonss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fU8uLA1xxT0uEB4Ar5aSmK8uiXPEaahSTfdXqHM40QVzorXsR7greshv4pC8p93Rpd0Ln7Oclj0CrJnIoUl2u/OHWHAke0DWUTnl/hQ9Y35rjq0lTKkjUfCrbuyEZBV0OzxjtvahqQ1cXwFsQulTQ7pJODii9xmXDj64zmEzugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODS1ZyA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74011C19424;
	Thu, 26 Feb 2026 19:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772133108;
	bh=lTVyJVB0aB+uUxxgnjTFm8CX4/aNy1Ar67t0XoIonss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ODS1ZyA3OhWzSexAR/doIaElmBQzLPrjiQUrFHktBCxnFa65NWXzYQqrB61gtEaP7
	 U2VvHS/eSScJPBJhhdMx1XX6sroZ9WGxy/fvZAVs+N6b2rA+EBRdYhjs0lMCSLINwi
	 Ewyu0NoCNfZkORSuPMfTa0ZgSoSTbqA4/rh/61rq5CrKqoDG/zUhccDVMTSeMmQntV
	 88IPR7T1BS6eqggG2h+l7WwKCCS/H5Ck1N+zMvz11dIjhkLttBa63xTzop6UvsKKqV
	 13i5LwA2tyeCTjLYuI5ODKP382RQik/wRolAY6Jg7IyMPsxbicScyoQqEuoimGFyJ+
	 SdIrKtihaqN+A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 26 Feb 2026 20:11:15 +0100
Subject: [PATCH wireless 2/3] wifi: mt76: mt7925: Fix possible oob access
 in mt7925_mac_write_txwi_80211()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-mt76-addba-req-oob-access-v1-2-b0f6d1ad4850@kernel.org>
References: <20260226-mt76-addba-req-oob-access-v1-0-b0f6d1ad4850@kernel.org>
In-Reply-To: <20260226-mt76-addba-req-oob-access-v1-0-b0f6d1ad4850@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 MeiChia Chiu <meichia.chiu@mediatek.com>, Leon Yen <leon.yen@mediatek.com>, 
 Deren Wu <deren.wu@mediatek.com>, Quan Zhou <quan.zhou@mediatek.com>, 
 Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hao Zhang <hao.zhang@mediatek.com>, 
 Nelson Yu <nelson.yu@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32225-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE9811AE480
X-Rspamd-Action: no action

Check frame length before accessing the mgmt fields in
mt7925_mac_write_txwi_80211 in order to avoid a possible oob access.

Fixes: c948b5da6bbec ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 871b67101976a7d72ca10c9736ccfa59b0f21122..0d94359004233e94c11a2d09f67b1ae61ccf71ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -668,6 +668,7 @@ mt7925_mac_write_txwi_80211(struct mt76_dev *dev, __le32 *txwi,
 	u32 val;
 
 	if (ieee80211_is_action(fc) &&
+	    skb->len >= IEEE80211_MIN_ACTION_SIZE + 1 &&
 	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
 	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ)
 		tid = MT_TX_ADDBA;

-- 
2.53.0


