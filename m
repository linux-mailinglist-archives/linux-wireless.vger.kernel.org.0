Return-Path: <linux-wireless+bounces-30861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD4D29819
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30D830B602C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043E315793;
	Fri, 16 Jan 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk5HIebQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25F3148B6
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525535; cv=none; b=kssQ+FW9EtLm+AySydW/yjzqmQCJk5dBfhG2bVTV4ITjr3Fgr2VS8jawilrkzVdtR9DtKOXzFTDoiaezYbcwxRqw/5KJ+SH6MLP7+eyx5vyhz30Tn2f4u7JbGxVTV/CTH2k5wIcKv7+9I4tykD/rye1zEDVtJUuOXVw3wWFartQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525535; c=relaxed/simple;
	bh=bTIw3jO9OrGp1Jt+Zshd1N+f6Fcp97wlvVOjLk0G0yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siwDwUxrfmGTjDBy9UgwEXoUx27eS9bDLokgY10LS0A5ug9PXJc0G7xUQXjn3BIqzgSIUzBaOVyU8z/OAi09YEWhMxSnxJbfAglSYlcNZ7NJqHSomciWA1eOs72kLLDcnoWC5rFIR26cCSr0miV5SpXTSc3DZRkBBaVg1fUDngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk5HIebQ; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b1981ca515so1731830eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525531; x=1769130331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyvHxTD9jYvJ1aFDphS8iH5fAIcPW7RDWbIxYHLNdZg=;
        b=Mk5HIebQ1Sbc/KZAZV+5cA+izf6L6MG6b7DzbrZP/2v3ymefRE6KMHz4m6nWCZ7FbA
         7HMo7u+3RUQjEc4SW6IVKvBEkRnWoAV8ETIzoaTMJXasWAUogcEo8Y57XyVomwk3PipB
         QmAzL3IcpzyhVJQE0pvXE8z1ENeUAf65aQ1Kx/+SZ1b/LSn+5VD0m8CiYItOU/xI0kmG
         t/Dn3uNim6wRBwZHKjpEYsqkuTw1YgN7SxN+XQn7Pu0Q3ZGJeLVtCdluHjgEhoiWK+RN
         T+On2SzOp3tSB+Hy5svYHmava1AS8ebdSIxEwv49+GcCEI+U9bFUtGcee+bNKkw8k7DQ
         bKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525531; x=1769130331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyvHxTD9jYvJ1aFDphS8iH5fAIcPW7RDWbIxYHLNdZg=;
        b=KGT++I1+8nc5meESPV1vgl5aBxlB+NgMJSK9X30YBFMFk/gNR8KRAQ49yf/coW9xxx
         CaPejWPO6aUF0IfQFadYuqtiEARt/yPpwxDPtzhKBU9n5YCvsVUopqmAryVJdevfE6b8
         GV2AADxbqsZpOdJjeetygdQxjWlUQlTtACrCnw76uMHrtA3Baw5OTkKbgdw/HTjGz3gq
         9gsA+Kbzj+oGjStlrgYnXGkXLAbYvFrUcoxQSr6j4El302a2hi+Y4wzDwy3763vovJOv
         HwBRIxC5ommW6NA3+rtPX3yrBPBXsXOqK3nY06Mkfm3ydYa8lgeYWDtAQ5GWmYwDDGPd
         zOTA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJOzN2T09hr6VW3WZefT66JaeHaldSxh4RWvefPiL+WhBtzGkrP5LnTwplIUPoBW6cqRtZ+Dwj3YWaSFIbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEftgHNjqYQk4Q92bJB+aRdspi2w/mwLE6ZLFPBkZtaWAwm7l
	wiqjxywvOuYim/aKlQ8UHqRYeRDWmkAly8jsuRHfvXJg+0nAxNUU0NJ1LX8KsPrT
X-Gm-Gg: AY/fxX6IqRu98Mb1i2RT6KYxPsdjQXOVjKOQEGj48ogKEX5HqNzO28u5dac60ysxqI7
	pbIny46T/QbbGi8/jmI85MYcb5lom0tpzhJ9G0YYVniqXRzQuoVubYc6dS47jmaI+PqMS8VipgJ
	+07H7h0CnZ6vI9JSllGRwpfTrUpyh1B/BQ/rRMfvdtbe9lV74uTU6zsa5UWoznspcvJractFdGA
	WNUgIDwRP1yosds/M+0cSPMyrgz48nTAcsk1/oe1XymFshQ9WwzoPE/dEL+B/+XT8mNMlTpFLXW
	211u6nK3QdK2QShZmhKPlsT2WvKudbk3I8PK2Zwksz9cL5s1ynawCfDZlQu/kwSOv4EMvTThcM1
	6YlGX4rmEOzCDS4Rky2ihD9m7pKNKYpDFQ4p6L9KcdjHjPYpkD+9FB8lFxONo+DJxVVVWs7bTS/
	Ht+LKd6ttLbG9meH2ifib+vZJGoNHFcoZwJ8i9dxI6JLogem7cR6gbNle3/oo5WQ==
X-Received: by 2002:a05:7301:3f07:b0:2ae:60f7:7f42 with SMTP id 5a478bee46e88-2b6b3f05f0fmr774432eec.11.1768525529188;
        Thu, 15 Jan 2026 17:05:29 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f1d2:502c:a6ff:5556])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm1019884eec.32.2026.01.15.17.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:05:28 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	linux@frame.work,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	Zac Bowling <zbowling@gmail.com>,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH v4 04/21] wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
Date: Thu, 15 Jan 2026 17:05:02 -0800
Message-ID: <20260116010519.37001-5-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116010519.37001-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260116010519.37001-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zbowling@gmail.com>

Add NULL pointer checks for link_conf and mconf in:
- mt7925_mcu_sta_phy_tlv(): builds PHY capability TLV for station record
- mt7925_mcu_sta_rate_ctrl_tlv(): builds rate control TLV for station record

Both functions call mt792x_vif_to_bss_conf() and mt792x_vif_to_link()
which can return NULL during MLO link state transitions when the link
configuration in mac80211 is not yet synchronized with the driver's
link tracking.

Without these checks, the driver will crash with a NULL pointer
dereference when accessing link_conf->chanreq.oper or link_conf->basic_rates.

Found through static analysis (clang-tidy pattern matching for unchecked
return values from functions known to return NULL).

Reported-by: Zac Bowling <zac@zacbowling.com>
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45c..d61a7fbda7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1773,6 +1773,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 
@@ -1851,6 +1855,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 	band = chandef->chan->band;
-- 
2.52.0


