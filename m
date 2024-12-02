Return-Path: <linux-wireless+bounces-15814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124579DF975
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 04:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8132EB21BBF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 03:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D72B2D7;
	Mon,  2 Dec 2024 03:20:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EB22EED;
	Mon,  2 Dec 2024 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109610; cv=none; b=oO1wnJ3nmQtZiVkr9HVrMrH8lCvGxLO6+2Vf2uu/4zlczTPFpb6dVM+hjVKik4986kCJ/vNjONLqcjxQna0uvmZho/c5RweFrWaGVAnvDZhqy96pc3YdOEVe5bg6BW96WWgCDjj+mwXZgLGlYoTV71hQhH5B+lBNDrLoXuk+o48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109610; c=relaxed/simple;
	bh=AjrFy7cB+gFSVEX8oiD8J1a7UEL1dWiZDBP73ip2qdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=as6+an93meoGzUKZrZMk9m0MJwR3FxfZuCk86nDPVELAldc6KtQvMShp4qQogLVaH2x+sVP274mv1oxJjg2o5vow6wDQEN8x57PUM1Ak4enNSmE74Ep22BtKx+9m0J1HVfRDJHXVyrmaafbJsJGn7JZwQTXWjYLItQ1Zqustm08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso2416947a91.2;
        Sun, 01 Dec 2024 19:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109608; x=1733714408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTsDv6X/TDHosGjWCj6G12vDDaZPM/8Azm3atM3kxEg=;
        b=DYu890YPhTA1CwOS9k4H0C52pvcakOz1eNoDJozzApx1hdd9LFJQFxg5I8zQUwNEj0
         FnYOOyrQ3QqD5nhMht8TQe2dhTPNdOFNC86JCBv6H4eH+Ht5yfS2mKT8OpaiR7/MQ9Om
         x7AussZTY6sM34016Yk/df/jS+9QMLhKW81cUBuHdxZXoMOTah8UAsPVbUscs5hV+F/I
         teQ1bjNNAzQuqZNZXpET8W94WWJlKyMkRIcgKu4rrMGPpMoToFYiPo31XjxDjecCDo+l
         Y9qk1ni14pGtYqQKF5Ud6ES1jwbDWxAYeYixW3FQ0F41HXjyECCyTHAgWBvWD4abfMCz
         GnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgC4E45jStaZV9KNVGt4SSVDsS0oGYOVpBNu2S919GulTYzldEGI115qN17p0WiExQEmmnps2BEKf3zIz6h5k=@vger.kernel.org, AJvYcCV20imhE/YuO31YT8jxss+9fosF49qLYmJ0EtzP1U/1paYKsNllsOBH0GyVu8kiTXkHIszU2lQvLChqrVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0gcUVoD62rQPT7fPN/YazYVE7wfOlqiUgjh0X9rgWdFyZi6L
	hlCm8v7sMeUWmPbVZRRQcO2JSdRvSnIbrF9Nl5tEW619lTqEfzat
X-Gm-Gg: ASbGnct02bklPvCSy6tEBhKSWU2Lm4rMJ7dZqIImUWSE+i7xEhgtuuwZzGzYLfrsno8
	B7poegyOsIDGOMlsaOeCfoVry4wU/7OQnzgh5gZAGaC+EmGw8CdlMjTfUkxq/cKAKCniFkVvv1F
	yCjz+yw9FtVxblln1UzLab8zMXX1eRDJw+N1d1KoUOS02RuBWklHQutdlQ1U30MR49oZK2u8RGs
	cWJIM6jmOn64JoP/KgvU7pZbUrYeKjrKI4vBhu3ls4NmVU8sZ05qi6PrLXXcwp3it07a1hSvw==
X-Google-Smtp-Source: AGHT+IEZfu+l1o1hoQ1rEHsHEhSrUCQ+IgltJe4rj/iDVEpIiZTQOzNjgMefNIoGfMKiTtnF13E2Dg==
X-Received: by 2002:a17:90b:180f:b0:2ee:d024:e4f7 with SMTP id 98e67ed59e1d1-2eed024e5d9mr3157086a91.0.1733109607587;
        Sun, 01 Dec 2024 19:20:07 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eed19aa971sm540723a91.1.2024.12.01.19.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:20:07 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: howard-yh.hsu@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	Bo.Jiao@mediatek.com,
	sujuan.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	make24@iscas.ac.cn,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next 2/2] mt76: mt7915: fix overflows seen when writing limit attributes
Date: Mon,  2 Dec 2024 11:19:17 +0800
Message-Id: <20241202031917.23741-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202031917.23741-1-luoxueqin@kylinos.cn>
References: <20241202031917.23741-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
number such as 18446744073709551615 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.
This commit was inspired by commit: 57ee12b6c514.

Fixes: 02ee68b95d81 ("mt76: mt7915: add control knobs for thermal throttling")
Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6bef96e3d2a3..77d82ccd7307 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -82,7 +82,7 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&phy->dev->mt76.mutex);
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 60, 130);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 60 * 1000, 130 * 1000), 1000);
 
 	if ((i - 1 == MT7915_CRIT_TEMP_IDX &&
 	     val > phy->throttle_temp[MT7915_MAX_TEMP_IDX]) ||
-- 
2.34.1


