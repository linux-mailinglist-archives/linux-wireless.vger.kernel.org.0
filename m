Return-Path: <linux-wireless+bounces-31305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLlBGqMYe2lCBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:21:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB00AD717
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D8EE3068179
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43037BE7A;
	Thu, 29 Jan 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZGEqU+E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A937C104
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674737; cv=none; b=eF/yRCRPhiN7JrJS4NwTWdHnlDJRd+Uzy8CpNTBkeJTUTmC+FR8jzzHYwojev+wMaFkuQBoyrkwNmQLTp2xUMG7Lm46+NuD+73E0RKA4tZOuNC4cpBweoWSSLsXcZWwnOnxI4ujOdKpnP5v/+oSyHMKmfjvcb1vBs3XOnYcdJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674737; c=relaxed/simple;
	bh=yQMWxOQ7To8SqJpkDZDwLnRGe4qHkGxdoilEnftC3Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUCn9OGYsYJMYcMhkPJxrPLguGGP+DM8qWE22BTQ3KeNSBXsaC4+N8kRYKwsvXGed5TpH0NTZwbt0sSPNLUjIAQzZlz4XpB7l862kkycE2rzcQ3uCuvktHxX1hMJOjz9b8dIZ1F3E6Oi1HXeje4aYyQFjaWrHpIaPFtbWIv8zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZGEqU+E; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12336c0a8b6so1318213c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674735; x=1770279535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q14ebJgYOBwi4oXp2H6aUXb34czVGi/YpKLXXPgCXl0=;
        b=lZGEqU+EpMijB5ztHUWucWTfWblCOHKDx1XR8U951t9p78rPD/AzH9qUJ2WuHcdFF/
         5KVdCxH1nIWXINXGh2KoJuqXSqLyu/hokYWD3kilCtA7KvNEoo61ALn4iqe1HfBstsH/
         F9J7nB3c1ZzblWIb9EAooLDggLJUD71nUSgR41JJ82QASLbsDkpi76ymRq1jq2zCpct/
         iIYVo6cNRpvfCSdXP940wQwnS85pViMgOvZSKt/mUCZ/0DGDwPzGUs05521UOMY5X2Cp
         3NbykRSUxe4SA5GcIPwVJBzvDO3flx+So7iEDBuyMVBR9PgygQMiRjxt3yQbwIlGjUCI
         xO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674735; x=1770279535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q14ebJgYOBwi4oXp2H6aUXb34czVGi/YpKLXXPgCXl0=;
        b=GNTYd8cENacBPis4bOLNxyUE1nJvC0wFWu1Wp6r47t9QfQEFL83O0HNu/TlHo4SdzO
         cp6qFTr3OW+wjMYwytvYPssPjzv/KLPIXS6hW2hs1KYsyXz4TJjWdeowIwlyvtr8BHW0
         fYc6VUI5EaR71qWKoQetYVNABKK9U2LvnNiuurQHo7pfnrla5RkzTAS5bzwYG80EyOqR
         sLAumPdM6Ijro8xZpY0gFcvy8aasBjkaBe338ch/npms53YAOhT2rtz87EYWLO/+UTJ0
         s9Pk8yn1doOpfJkNiqgo6/El+O8acEWKqEk44HI0wAglS4UxPIYWr3M3BPokgtuhTzzX
         y5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWReo/XiKFEghRxkN5OvwowHasy5b6x0HYteE90yGcO32G0zN1nPmsegTmcmsWmKA0MKsTYnm+lwblL2rtgNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNdxGUjrhDirdy41wGOaS+t4EcnEF/WLEA8WbOOtbPIL8csEe
	cOL3zs37Pu4dUn5bANls6rL29Df2L2gTcPvMV8nYNoAqEjBtbOmtLnrV
X-Gm-Gg: AZuq6aIQAmzS/hXvGv3JVkCsUPQQYcnngOW1jjva1e+iIWQqWQzMKf9b0sbIvFx4CXJ
	+w1XeUFJT/BPbQyHoVfHLd9n8I7tLl+YiiAD1GVweWkyw3rUMYATQbTdmsFGHlilSebpviTmLxQ
	0Z4/89HCw1kSpbw+6RSo3luLwiK2cMD97D0uTbnIRxzlxve4NjqqvzHE0jCVNAReZstBRqOS6WS
	Dak4hGIpmsTAylmXenjH0loGsQJXMUBB61JouA0QBEEA+xDAHBsIjCDPsRSiLioKOoetWjN8CUU
	QFgRNhbEOwF1R2KFzeQm0PwsBeSJYZUWNVFw2NUfuwe5kROJqo/oVO4w7Arx9vUj0fPuRlnf2cV
	gaw3SbvTKv1qvmypxM+cbww4bF6YgVjRQLvDYNKyl7LGgeKUk/B97TShPsgBmJFnHYWzdx9Ke4C
	zvPi/oEDYi5Ho2ZiKE7pb/wbuv+OJpFuhbiHw8QqZj9yYl8Q4V1vr9qPxdN98z
X-Received: by 2002:a05:7300:7307:b0:2b0:5012:734a with SMTP id 5a478bee46e88-2b78d9f0bc0mr4601976eec.34.1769674735088;
        Thu, 29 Jan 2026 00:18:55 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:54 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 6/6] wifi: mt76: mt7925: fix MLO ROC setup error handling
Date: Thu, 29 Jan 2026 00:18:39 -0800
Message-ID: <20260129081839.179709-7-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
 <20260129081839.179709-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31305-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:mid,zacbowling.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCB00AD717
X-Rspamd-Action: no action

Replace noisy WARN_ON_ONCE checks with silent returns in
mt7925_mcu_set_mlo_roc(). During MLO setup, links may not be fully
configured when ROC is requested. The WARN_ON_ONCE statements were
triggering unnecessary kernel warnings during normal operation.

Changes:
- Replace WARN_ON_ONCE(!link_conf) with silent if (!link_conf)
- Replace WARN_ON_ONCE(!links[i].chan) with silent check
- Add explicit mconf NULL check before use
- Use -ENOLINK error code to indicate link not ready
- Replace continue with return to fail fast on invalid links

The -ENOLINK error code properly indicates that the link is not yet
ready for ROC, allowing upper layers to retry later without generating
spurious kernel warnings.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 2ed4af282120..5ca2106b1ce0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1341,15 +1341,23 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		links[i].id = i ? __ffs(~BIT(mconf->link_id) & sel_links) :
 				 mconf->link_id;
+
 		link_conf = mt792x_vif_to_bss_conf(vif, links[i].id);
-		if (WARN_ON_ONCE(!link_conf))
-			return -EPERM;
+		if (!link_conf)
+			return -ENOLINK;
 
 		links[i].chan = link_conf->chanreq.oper.chan;
-		if (WARN_ON_ONCE(!links[i].chan))
-			return -EPERM;
+		if (!links[i].chan)
+			/* Channel not configured yet - this can happen during
+			 * MLO AP setup when links are being added sequentially.
+			 * Return -ENOLINK to indicate link not ready.
+			 */
+			return -ENOLINK;
 
 		links[i].mconf = mt792x_vif_to_link(mvif, links[i].id);
+		if (!links[i].mconf)
+			return -ENOLINK;
+
 		links[i].tag = links[i].id == mconf->link_id ?
 			       UNI_ROC_ACQUIRE : UNI_ROC_SUB_LINK;
 
@@ -1364,8 +1372,8 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf
 		type = MT7925_ROC_REQ_JOIN;
 
 	for (i = 0; i < ARRAY_SIZE(links) && i < hweight16(vif->active_links); i++) {
-		if (WARN_ON_ONCE(!links[i].mconf || !links[i].chan))
-			continue;
+		if (!links[i].mconf || !links[i].chan)
+			return -ENOLINK;
 
 		chan = links[i].chan;
 		center_ch = ieee80211_frequency_to_channel(chan->center_freq);
-- 
2.52.0


