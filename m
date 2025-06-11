Return-Path: <linux-wireless+bounces-23989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915BAD57AA
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 15:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667D73A5EAC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918A28B7C6;
	Wed, 11 Jun 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz5vG7H+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E528937E;
	Wed, 11 Jun 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650142; cv=none; b=HBUz2q+wbUe0++Rm80o9ETvzebJyeOJfLmjgwsEqKXu7kWzggJUKusmxCQYgqhkrBtT/fXWthHvTxgqlH7ISVaKM2a9I46K04vMzha8QDJUX5dQsSKhryR5rO5olCXwwUvq0DAyKeK853gWCM3lXSWQuJmgb9ZnrfKruihFO5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650142; c=relaxed/simple;
	bh=IifNnRPlQTOlLPQoP4l2aK06ak5l7AOOpGK/E93CQEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LAXjk4iXVxsIq6MBWKxMO/oaHWfZ5TcQEJ+LmLtOVAh+3HdHvaYsYCHnodwQau8LIewXZXsiQ+xVWxfAvncM8jB4KX8zraw1S2oWXZO8HJQK3UGGLYiQwgpsgrnvwMt2sIPEQblunFmIrGRNS24vZPBpXmp7apn3Q0HEbPPdauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz5vG7H+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so39622105e9.2;
        Wed, 11 Jun 2025 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749650139; x=1750254939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwI5P3Q3ihOeLowm5FSpCJuMLkzkYQo2YbGk0t9yYTo=;
        b=lz5vG7H+aHyV7HafRBRfQj5ZYRKXR1GW/0pA2upUlPqgCxaq5HOQ/U+x1tR/NSjLLD
         YAUctI2vySqtdX+p8N3dhRgbbSoaFLLr8FD/5UgpWBM/yrKxOnYATCJyXLV+IstYK7GU
         Pe8jJRN39rYrRysbWWrSdVOSkhdDYC8C1u4uhAsYS1pOaKFyyOPLtx8ZQ30+oO56M5Tg
         Xx7f1Lz/oYs0dYxnU/+SIg/my1uB1ePMpdjlWRBgdtGpMz/4lkLZNB08+lxpohPVvgjl
         MlreAX+aZdxM+HNGEh1m+JHp3ip/WxLdtFsnmjSpCnoJwtUGn8mIi8EMM2vE5zTklTXP
         GSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650139; x=1750254939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwI5P3Q3ihOeLowm5FSpCJuMLkzkYQo2YbGk0t9yYTo=;
        b=wB7ptbSJdDH3LwKc08hIPU6uE7628XBalhDVtcVcusqdn810ps28f4CM/7vuPACt4F
         +XKvPcwJmlrsD/+j5ywCMEwBcXrrJ4wHEEtyVLyXizksb23bjYu5zblF+mCZ3idVBewb
         OYInIhj3n/+JJL+Ha8N7brBARM4uxtJ3d0WpgC84LbilpR6tmK3xDmAabnsk7UPpnHw4
         ivjEJ97Zl435UopZS6X40qmQKvvPMkBLIQEcxpBkSFBYwBKzzBDszFjLw3XmXv1oMQNO
         ULJQPYbcN+6teuWUbfTdrjFG9GXbf8tKFauHaqM/xr3BJ4/TbURJ5yfcCwHFYKfKtSQV
         nSXg==
X-Forwarded-Encrypted: i=1; AJvYcCUjnwRpArldy94gdA4AeKy3XHiqEb+9fvd6NxI8joX0UOAAVKRqGl+OcUMHCFWoJw0rOd49bIlN9ErqqBM=@vger.kernel.org, AJvYcCVnarL05G2L7+ek+f633YBu7URLO3HWe7/yI3wF85myNCce8SBSXuDNQHN4aWljFBlHRUutBWx92eUF4WRoPXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1VsseLl8lbWmfiBKYW/7oO9Q/FiQNN6c38pXMgfj2kXQIhAY
	Zo7GqeyZAPNlet7eye6zaYarVnz1E44UnePThX2dxxc5fCSNujDCTcMoZSDh5MSWlYc=
X-Gm-Gg: ASbGncsEGKKJjkeAmAtXFDNlslgIZ9XuHcxpUPDtoiJ8YxlIp/KouScY4A++SJYNRVH
	4l1fkTlo4hXsuQ0KMkMxY52i8qDKHqaxsU2uJE6nHRdEHtezCpamsKZ5PN76ACvVYDkq/zuVF6R
	x9X6/DgWyqRc0oo+Nq3FE8yGQsg5BHu/YJqJIv+P4uPen0bwB/Tpm93Ip7pbz0+rBQhBOZHHCmd
	/RH6qujkERaauy58tzZahbYdIz1PoJnj6/W13XCnTjfzH/pprMbQmJa9a3TGEuNzXouTICgiaos
	WSTotnN0EjU3+DoU2VEYH9BCtBiggKs0optiqkeP8KP2V5bZU1kEvDrMBNyh
X-Google-Smtp-Source: AGHT+IGc2bG2Zj3o3WugCbZzNyfbrrgGT+HOzwOj9wWXwjW4xvK6DyhvCSnSahj1aZEAAbVLsrMn1w==
X-Received: by 2002:a05:600c:3489:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-453248dc848mr35536005e9.30.1749650138776;
        Wed, 11 Jun 2025 06:55:38 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532522a543sm23383005e9.40.2025.06.11.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:55:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] wifi: rtlwifi: rtl8821ae: make the read-only array params static const
Date: Wed, 11 Jun 2025 14:55:21 +0100
Message-ID: <20250611135521.172521-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array params on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index f4b232f038a9..14bd64ff3f88 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -3064,10 +3064,12 @@ static void _rtl8821ae_read_adapter_info(struct ieee80211_hw *hw, bool b_pseudo_
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
-	int params[] = {RTL_EEPROM_ID, EEPROM_VID, EEPROM_DID,
-			EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR,
-			EEPROM_CHANNELPLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
-			COUNTRY_CODE_WORLD_WIDE_13};
+	static const int params[] = {
+		RTL_EEPROM_ID, EEPROM_VID, EEPROM_DID,
+		EEPROM_SVID, EEPROM_SMID, EEPROM_MAC_ADDR,
+		EEPROM_CHANNELPLAN, EEPROM_VERSION, EEPROM_CUSTOMER_ID,
+		COUNTRY_CODE_WORLD_WIDE_13
+	};
 	u8 *hwinfo;
 
 	if (b_pseudo_test) {
-- 
2.49.0


