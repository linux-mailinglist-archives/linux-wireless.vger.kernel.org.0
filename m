Return-Path: <linux-wireless+bounces-35335-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xb46CBLy7mmL1gAAu9opvQ
	(envelope-from <linux-wireless+bounces-35335-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:20:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A02D46D2CA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5183035D7A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 05:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E509358372;
	Mon, 27 Apr 2026 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6Ef3LmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8335AC01
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267086; cv=none; b=lYP5Nsv5nsKAaHZhBrZ5ngBHO9kW+ab3uIYBdeHGG9O0YXeN5tTlm+SCjZfdZWbSfG3kUwaX/Zg/g/xXEHIFZqhJ4pRQJWvjF2PVqifEXeDA8AKdUyP2e4uOy57/4syueSfpKTIS5lGaxYp+rfuYAFsPKiDnTrbPJzvypS2uaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267086; c=relaxed/simple;
	bh=yvsZGawuR5i884zL2LrTm97G/B5H5OPRkSYc7gehuDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5LepoQvFRTcwuu67CqyUn73Q6Iw71yYl+NXiHYvgHN0yUGgoxOolJl1mi0b4GnnDinEcTkewDJLfwls2aRGRUc02Od+KjTWJFohuSkWUp3JtuoO3l91IU1l8CeQvpfC22Wy+g6sCXEhfyehfE37K6XRQy6poo3le4OGxIwvh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6Ef3LmK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so5991551a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777267083; x=1777871883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IrWP5CDvZT0EW03kM+B3gbb16k7M4gE4dJ/XgHLlCEY=;
        b=N6Ef3LmKBw5Wh1ZqCeAw8J5to+NnDdnKAmf6TovOtYNIwR6wrZrH2kCeONDbIY/NSy
         ziUmn/0LNCvIAzVPdZbP+xb8cv5GZisKZcZnPQtqzBCV/V2H5R29xhYZfo7gXSY8FaeH
         qWFHqVeT44MGwX9HQ4nbXkYRNrmXWtfRhfMkcHP91MBHjskjCvpQYh04ZM9O4Zx7yzTJ
         E/jy0PVG2zP6LJe8S5fr/CMgBdNq+i7VpKyCTdFh0Z3oWNFiY9WIASHTUByJ9q0uLLrV
         uOq7MX02FTxyW8CSw2z4zxJAK49vWsBtgQiZmehQRfZpTpEgrobUPQPX5i2luVbIo5ph
         Pg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777267083; x=1777871883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrWP5CDvZT0EW03kM+B3gbb16k7M4gE4dJ/XgHLlCEY=;
        b=daf65o8uEKmzic8y6S8gNrlDb0isMBore5rL0xoxHYnjQ6ZB+BTnkU7iV0vEs7HlJG
         4L3/+359dc2R3ggNdbOS70F6ED4c0ny9D/QZPahQayXBXXFsMWEycC5o/EofjCkOrfWw
         phGecE8uk4dlCsDdlomYfl8DFjBJ5m55rFL2w7aegpiP4ALe9hIHO3Fcdu25T4x/S5Hp
         Ts88vXC/7XslmhPRZt57pfdw0T1Us/74EDGoXeYa9/Za5o3kGjkGp28B+4VEaPd9EMNP
         e06Yb++Uqnm+GoK3O4/u2WNIlgEXxnGbSTAxANbdim6BYfAFjTUQe2FiIuYXVv5kiwI9
         nILw==
X-Gm-Message-State: AOJu0YxTue3Ys6oMQeYxyutVwomqGY3E2o9IzW/BHfjiCrPsBRCGiXSk
	/P6PHiVvlXa1cqNeN2ck03j1dtd0okksujZJ0c2bHsB+rGSU/hrtNY3cDtgIPA==
X-Gm-Gg: AeBDies1Ew4bS6PV++pdyC/ML1wba8ZcHDgbdblMsZVXqYg6x0MnID7KtSgRS5Gh8LR
	Jh9eThAp9DfbB/8Gxsh872kGX3hNUJQwNkq6nIyoj/dCye8uCrKnQ6a4UkHFt6qNFYbq2bTphMN
	G18lzu9AuhcTcQf6nWhS/RXDzubBynyxlTMMQDNJhIorTBLQKCGiT5Rb1SlT1LZD1B4fTxssJrc
	NvuElYEd0jTRMzRZMvCJFX6EoArR7dHOD/tgWH3pm33IbN31f1VLCUbuLqfpgg8pkZrD8U6ZK6N
	b7gvgZTlraw5hZHuu75iXspyuqusN2h4DU4L7SS4JFU56ZZ5Vpl8sUWxc5+yMlNvi2kw64dhaAd
	B9QcPZpQiYoa7N1ytjwQeeUd7E4Gdsn6IWMdOdDPMB33sP4WuE/f9yy2AJbCDDUJu+tq7VQREO8
	NlBbYM1/hRq0hL9zGEoYvYaI1OK1g4crEE/VjE8gNj9xNmChcJ4os6OccphQttHPm4Og/VMEOVw
	OH4bLcCqdyNCbJNfk8gbmJXlg==
X-Received: by 2002:a17:90a:e7ca:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-3614048a21bmr43367074a91.18.1777267083487;
        Sun, 26 Apr 2026 22:18:03 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab2112csm280636685ad.62.2026.04.26.22.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:18:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH wireless-next] wifi: mt76: fix of_get_mac_address error handling
Date: Sun, 26 Apr 2026 22:17:46 -0700
Message-ID: <20260427051746.954704-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A02D46D2CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35335-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Check return value instead of is_valid_ether_addr. The latter is handled
by the former.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 93d91264687f..0f6ccf6ed53d 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -93,7 +93,7 @@ mt76_eeprom_override(struct mt76_phy *phy)
 	if (err == -EPROBE_DEFER)
 		return err;
 
-	if (!is_valid_ether_addr(phy->macaddr)) {
+	if (err) {
 		eth_random_addr(phy->macaddr);
 		dev_info(dev->dev,
 			 "Invalid MAC address, using random address %pM\n",
-- 
2.54.0


