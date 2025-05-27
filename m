Return-Path: <linux-wireless+bounces-23430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C17AC47E4
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 07:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7993B9D92
	for <lists+linux-wireless@lfdr.de>; Tue, 27 May 2025 05:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA37483;
	Tue, 27 May 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ref2N4pB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53831E1E12
	for <linux-wireless@vger.kernel.org>; Tue, 27 May 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748325345; cv=none; b=d8A/qD2HakpacJmeC1OBtSWOjKCNSnnXrhhgvX2JZhTnyVTqrn4NduFCrlYiLRPLhdrgqbepMNzzsMLZXvZ9sLDlVUc5vRoJJK5XFmCRfWswGDtY73DZ4Iz2PCkEk26puBN4d4A7tn2/CsWXLiNgFGjpI8YclLSbH9U5pKzX0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748325345; c=relaxed/simple;
	bh=xLVy8X8HnHvYCsIOMkpIYqzz4Og+J+/aGg17JBINL/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qGKQanPWITUoXxNoC7EbEkldPc5ozhjDsPafhRI0pvy+RZtqsU4JbYVyCUrHvkIP9VuR2ZJzGEiQ03Y/MKL5QD1FTGC9Ig65vjCWa+UYS2t21+GFaEfkJD4SX9PvWZBf69wthr0KxyHEBJtvlwS+02yKwz8eG0yZzx0qfCkTOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ref2N4pB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso105738a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748325342; x=1748930142; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b95ydlmvcuSBT0t2+Bg2nsz8TCc7xZGDZD7y4UeqVe8=;
        b=ref2N4pB4CB6osMPiMaWpw5mgU8Ymoy+df1hJJmenzwfaOcNz23D4OYrhojyr/U2HF
         QXb7gw6z+90GduDJeCBAtvYHW2D5P7DYc/TVDpyZbvFafYAZ2RC1c9SKL/n7Wvo4LlIn
         lrxQ6bdDOiPijky43/RBCwLmqSSaZjSMQrgWaA1UrDM+6k0AWCXBuikUGj0OILsutzbM
         flZ8s/y0oBrXni+RXIsBTHT0AKvlDOz5WFLDK7WEUlZvYZo+c9B+ocWIUEyKOkhUVYqZ
         ILXyJnEwXW3zWTI/uzt6qgcFtnTR7AStGAAgvwiic1PR0gTy0Hd0H2MBGHUbzVV8hlrU
         xTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748325342; x=1748930142;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b95ydlmvcuSBT0t2+Bg2nsz8TCc7xZGDZD7y4UeqVe8=;
        b=DxRJBtfcwJ3da4IkWiEA8LYMTSQRUPQaZ1V0zHCa6e7SxcbTZWOSf80wAmBJghL2Hq
         SA3nRBdMPIQbY43U728YBQ7hwX93m3FBUiMlYgexyswFhr9bL0pjSj5EYghGMoklGyds
         /p9vSVDLUaqTpbE+pHU4HT+y6twhnwlA96/bXA4474z6e97ft0KHOBbzhFvsVZduKzmo
         fOlL1rr/PDsqawAcXFE5UviqGayXjbASTf2VgAyJf8gbpWa6w6P/B3kvd5gNTwr/fFKD
         WL6zXD7tqneShRE8ZrI43SXiF4KP0ZsuetOQx3L8IEfpoRraA+vQZte/By2Ne1zw7y8L
         GyWA==
X-Forwarded-Encrypted: i=1; AJvYcCVlotoBf69qv860c35cnfMAHJ6GoK1bXJAeyyZrlVrPBe58A9tYTn+OlSBTT0v116BbTxvZjab7cm7jfbEG5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+o5cKJXuuuvk66ChZ2yHWZF5JQ9vt6F2Zt+5WcbeJIoO7pJZs
	b6SvOdJsxbHQJVTe+uaq7BwBMTcVbW629KgfuiM4jIh/2ZjFJGNlJ8gfdRFMfd57+SY=
X-Gm-Gg: ASbGncuTLklOxFn6s5+HXQ+a1/yoyEkNMyIbjcG9H6V6shzf30Ap/ezG7Tvnm3qPPSe
	mfhbioljh3p3vJqlZinn9nuAN4RKTWgLwKjfm8isjucKW0eFEpbRTyGgT3o5hV+i8RFMsDl4yWv
	c21RhTWuKW82oTqUZIZdo0HgOhSngoShQ8OknXqIQVsOWdZt7OjZmiN++PytEHZFqrJgYk2VMiQ
	j80qLDbsi3cg3e1sqVs0L+R0siBShmzPewwev5woMWMBmOwYz02d6W8te1OKlhMze8X65/CKBC3
	dTWg33FAxnyZ2p7xx99YxKWgkl/3iGo9GcF2G0+gPKAankzfGemhOowYTC3o+wiELbCcRVmoXM8
	=
X-Google-Smtp-Source: AGHT+IHqcQBdt4pdotySeS2C++hBmaCY98bm7d0B72bKSBSdU4rDUN6+enuY0scFyUJE6OpWFCvJpg==
X-Received: by 2002:a17:907:f818:b0:ad4:d32e:b571 with SMTP id a640c23a62f3a-ad85b1bf8d5mr961844066b.24.1748325342055;
        Mon, 26 May 2025 22:55:42 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d06e098sm1818489666b.59.2025.05.26.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:55:41 -0700 (PDT)
Date: Tue, 27 May 2025 08:55:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>,
	Allan Wang <allan.wang@mediatek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: mt76: mt7925: fix off by one in
 mt7925_mcu_hw_scan()
Message-ID: <aDVT2tPhG_8T0Qla@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ssid->ssids[] and sreq->ssids[] arrays have MT7925_RNR_SCAN_MAX_BSSIDS
elements so this >= needs to be > to prevent an out of bounds access.

Fixes: 8284815ca161 ("wifi: mt76: mt7925: add RNR scan support for 6GHz")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Please review this one carefully.  I'm less sure about the second chunk.
Also maybe we should just delete this condition or check sreq->n_ssids
instead?

 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b8542be0d945..16f3cc58a192 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2866,7 +2866,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	for (i = 0; i < sreq->n_ssids; i++) {
 		if (!sreq->ssids[i].ssid_len)
 			continue;
-		if (i > MT7925_RNR_SCAN_MAX_BSSIDS)
+		if (i >= MT7925_RNR_SCAN_MAX_BSSIDS)
 			break;
 
 		ssid->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
@@ -2883,7 +2883,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		mt76_connac_mcu_build_rnr_scan_param(mdev, sreq);
 
 		for (j = 0; j < mdev->rnr.bssid_num; j++) {
-			if (j > MT7925_RNR_SCAN_MAX_BSSIDS)
+			if (j >= MT7925_RNR_SCAN_MAX_BSSIDS)
 				break;
 
 			tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID,
-- 
2.47.2


