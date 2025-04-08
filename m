Return-Path: <linux-wireless+bounces-21275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2992A8143A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA1A448651
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1161DE4C8;
	Tue,  8 Apr 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJqyP4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69836216396;
	Tue,  8 Apr 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135495; cv=none; b=AS4tKqiuiOZlrvvRm6EbA71m+azIxN2mLCUtGDNSmWDvoRzzNS4D4yyB5w54Llv73hGOS27+r9ffzdE9crAi9llZPBfa0DJqaUyZmsXCWRYjG5YgS/Qw6fWlZg6PyZF/23jCrv4Jg5nTsvrcBFg61DFfTQy1JY8ghnGQoWFLBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135495; c=relaxed/simple;
	bh=WkJ8XS18rE5C0eRyAl8hfeBNNEHeDURwT6xhMR8HWTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+4E0togY3Xp1oFH9+Tw6QxuiOeyf5PGkCMnJoeZmNhclyRfgLdX7MceI8o9GAAmt/YgFCygb/4dIlN3n54zQ93hcanR8hL6c2yGsR/6C1/eH8UALb/756yUamySpGCwafwmXWVB9dwau/0yyNjqzy4vyDC6xiSlKp9H9jwuISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwJqyP4F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf680d351so40924065e9.0;
        Tue, 08 Apr 2025 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744135492; x=1744740292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcOUVWVG1AAUU/kF4IJvSl+9zDVrwqBtFVUW2rq0rjY=;
        b=NwJqyP4F5/KKlbsNQq5uw7Nb4vpPvyz7ZWTFa+FblNBsJEbLyTmZEBmgrKbfFzuyGo
         t5f8Dix8agpo74a23wKYnZMrgyc8GgsLiWHRqmjpRvdbhVGWYVsaYCyFiJMwP6UPIbU4
         VwAq4s21LlR7+0ijkfNTvZ3U1cFYF8e6fUtXO6HfZ4Ere1znpt5srk9V8dd9cvbqL9X8
         jerMfo1LvwHS7Lu9nBV7DtMK3yBm8MZ9aesN3SprjAdVAV+JxzNUJsnbS2NvlJ2RASdQ
         BtAlckBbYSJ+McSV4Vvc7HTs8DDXH+EjmOa4n48rAlhxbyteYkI/YPAs07OIr3eHKkAA
         Laww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744135492; x=1744740292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcOUVWVG1AAUU/kF4IJvSl+9zDVrwqBtFVUW2rq0rjY=;
        b=vRFM4ocGzCqEyA3b4iN4dw3Cs3P939eotUhCsk7iV8RqZk4lQ2DUxzte54X8cU31VL
         cGCasOeZT1XUifhHqcMCjDEfeFp2mi7+pyDvAPenmqVCySrkFKStykgUpmtx12Gtg5Ej
         B8cf7Ml5sH4EdqGsQIIAtGVoAH/9uHkdOIrzLj6vp3JF0+xvQdkJ+vOS/1hIaQfp39lW
         cM93THJ/IXYgIeRmy/Qg/o3ipqM5z9O8ajeJUP1MgpjKeD2NmpiPm1XL6oC9JfRfleUc
         FWCjZaFPdFjPjpBi2A7GinVowLNUGkhhH7D0j2oojRKNGD4VH82jD2sm8e1dfAz+6fT1
         MdLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrbRCWs7q+l1tAu9bXG8cFi1JzRWaCQHLTYwk7qabEsIoscXVFavkH9IUawyOdtgg4oG1M0381cPFnh08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgPZBKVF2TVh3wIoSbKW8RQV792L+9IYsGZHmbcys9hyW3F/A
	kIXiJ7zP5FXr/PZY3nNKwO2NU0LHfBabukGTI4wdfQgJhVUhtDHK
X-Gm-Gg: ASbGnctIUfedsfgc6xEolN8vVlbkZAAY7SDX2qzE9R97zUvlt3ZA0fq8xwnlHETKvbf
	RSfBSQI3lVmnEsvrvSfUNxU29ujtbZU7gWmAcDs0yG2oVmu7koQY0eX/6ylxPQI4ENC4ivOZ5YN
	iK6rmE8TCIkfEcoBK8/qigo6aEcdDtlW09aJK0NK27Az6TZXiZi7CZ5LvfsLIuSJZwKcGBRCHW9
	2TbfiHCH8Sp96QX1QgPgWWhWHzE6WVJxhyc3UNaYyqmJomMJHoa3jGM3BEx0lpSThqndZ1tf0mj
	j5ALS85XzHRRKM7Q+RiuLHji9F5aP+lgxGF/hBZ97phD1g==
X-Google-Smtp-Source: AGHT+IFW4ID2IVLIJJSO6AIqnzG5sx6n8ibzh5IQ9vxzEszMDqEO1Q5l1iqmcRSrWTuGE6wSfEs9sg==
X-Received: by 2002:a05:6000:2289:b0:39c:30f7:a599 with SMTP id ffacd0b85a97d-39d820f7f4emr4042317f8f.18.1744135491468;
        Tue, 08 Apr 2025 11:04:51 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:5b45:5642:beb0:688f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec147c9dbsm176684525e9.0.2025.04.08.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:04:51 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com,
	Bo.Jiao@mediatek.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND] wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()
Date: Tue,  8 Apr 2025 19:04:48 +0100
Message-Id: <20250408180448.19274-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mt7996_stop_phy() the mt7996_phy structure is 
dereferenced before the null sanity check which could 
lead to a null deref.

Fix by moving the dereference operation after the 
sanity check.

Fixes: 69d54ce7491d ("wifi: mt76: mt7996: switch to single multi-radio wiphy")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 66575698aef1..88e013577c0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -68,11 +68,13 @@ static int mt7996_start(struct ieee80211_hw *hw)
 
 static void mt7996_stop_phy(struct mt7996_phy *phy)
 {
-	struct mt7996_dev *dev = phy->dev;
+	struct mt7996_dev *dev;
 
 	if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
 		return;
 
+	dev = phy->dev;
+
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
-- 
2.39.5


