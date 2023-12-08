Return-Path: <linux-wireless+bounces-579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421280A697
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 16:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56C81C209D4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C07208D5;
	Fri,  8 Dec 2023 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7RZkBxi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9FE10DE
	for <linux-wireless@vger.kernel.org>; Fri,  8 Dec 2023 07:07:47 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1fa37df6da8so1272423fac.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 Dec 2023 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048066; x=1702652866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/5sf7YXHl59eaNcPPevpGlaZPuPIosZsE/gU2DlAFg=;
        b=E7RZkBxiYrQvV48hibVRStrxdhESoWqOCvGF5Mq3uJCb8+WWAp2t/+5gctftSltLP/
         DR2WEomDZb27jkWy4Fbq9JpoL+ZkxrwcF1Qixz/AmpF1U/4Lv8Y41iy2iBufaSmL7Lcj
         Yy12j5d6jc27jEljD5DUdOvTIzUZDvZcwgS6Ygkd+Ylnp7iX5/J2J9zg3h/v7w7X4yKo
         +XaSW/t8vK/qhq+Qmn/t8wtRPYKWwL5N8IQQ8L31yB7HRcwAOfIgP3Aqh9nk8jQNvtqk
         5UuCRW1oFWFPCK5wLOoifpfzagA01pyPVIQJpbbv0Ue1XDFPAtSwBd1nM1ihAnr8mBtS
         wyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048066; x=1702652866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/5sf7YXHl59eaNcPPevpGlaZPuPIosZsE/gU2DlAFg=;
        b=nYSL1efO7XgDW9QOsT9S5jI2Oi8SMpBkGIaZfi1MrYdX3SKYRbVonZQMuvShVb1XAf
         KC9j+bdo7r6Kl9m68dRwtz704VBNeraNoOPU1u96Du6BdomxBQaB+YUjPoOC2eab5fDF
         ECL3NPlzjDINzdlSrkp59vn3wrfIP2xWH4U+VOYklvJKhzkKe07p+Zx2q5vk1xGoE1LA
         rRtG7zzwMUxCYuQF03/VNzIgKyLXXR93FAs4ykL1ZEJ5PxytK5FYSfDcrPtjBvOeFX7c
         nay9Z6N8AWIVzLhkCssU0E7rThiXUSdDE86ZtuTEAveqZ+wk9HrRnQR0Kpo2u0FYdKWr
         WDGA==
X-Gm-Message-State: AOJu0YyrB+3Lk5DrPy0rr6mnLn1Uj0ahfrstPOLkvcp9YUAl1dwlhTwn
	kvmB2FzGTHhPB6PZfHUF3BB7BzGb2pc=
X-Google-Smtp-Source: AGHT+IGvSNLI0aeJvIZGZwpycO3tWJIekTHhd9WvcrKAphJBoStbR2q1LXMfgKL9EwAiLGSdsTRF6w==
X-Received: by 2002:a05:6870:7b48:b0:1ff:a89:58a6 with SMTP id ji8-20020a0568707b4800b001ff0a8958a6mr239240oab.75.1702048066269;
        Fri, 08 Dec 2023 07:07:46 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id yl13-20020a05687c218d00b001fb17559927sm425636oab.48.2023.12.08.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:07:46 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	pkshih@realtek.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] wifi: rtw88: Use random MAC when efuse MAC invalid
Date: Fri,  8 Dec 2023 09:07:39 -0600
Message-Id: <20231208150739.129753-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

When the MAC address read from the efuse data is invalid, warn the
user and use a random MAC address instead.

On a device I am currently using (Anbernic RG-ARC) with a rtw8821cs
the efuse appears to be incompletely/improperly programmed. The MAC
address reads as ff:ff:ff:ff:ff:ff. When networkmanager attempts to
initiate a connection (and I haven't hard-coded a MAC address or
set it to random) it fails to establish a connection.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 4a33d2e47f33..6d22628129d0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2008,6 +2008,11 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
 	efuse->ext_pa_5g = efuse->pa_type_5g & BIT(0) ? 1 : 0;
 	efuse->ext_lna_2g = efuse->lna_type_5g & BIT(3) ? 1 : 0;
 
+	if (!is_valid_ether_addr(efuse->addr)) {
+		eth_random_addr(efuse->addr);
+		dev_warn(rtwdev->dev, "efuse MAC invalid, using random\n");
+	}
+
 out_disable:
 	rtw_chip_efuse_disable(rtwdev);
 
-- 
2.34.1


