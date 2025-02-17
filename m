Return-Path: <linux-wireless+bounces-19078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8FA38FA1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0481118894FC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A511A5B83;
	Mon, 17 Feb 2025 23:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDqiJIhD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076FB15666D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835027; cv=none; b=EH0h2LHnidwnQ+exRTkkGMOHG5V4rszP+dAIAz4Wmg8pYn+eXlN+irPFvfhUekX3AGtqTl66F/wDMQGKQ85NX1zouPa3P5I9UBoG6mbPw4CiLdPtfGpfqrfHA4CTSCnfCanwbYS74oiNe/Lyf0eAnZPqGDuCd1uwQYmDpmtAZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835027; c=relaxed/simple;
	bh=L7s/xVzWav7A+A4+SC5tb/GuohHsIa0GQMI4T3FxcyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IJ9vaKsmAJhVRBoXl067oM9/b/+YmIlk3tTaG7/U1A4rqcKxolbMzyBdPc7iC/7JmVhZKEz+fqQ6m0zF+ySzBk4G9AzyeiSQGHtzN8k3KvvvdL+ClosGwdGD1HM2fTFKP5JO6GPUZ797rJxW8Kq55MDKAvRHkNRzEOtUko70HJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDqiJIhD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb86beea8cso382811266b.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739835024; x=1740439824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OeWGgBgHpSFhRZt2LzxzC17j6aq9n9QClPuevSZwi1I=;
        b=KDqiJIhDyJMKmxlFlWJCj1G9jbVmjg0+8oP16U5U6IVDLNJOsN+szZzflwqaTXTeC8
         ZGhkZP5/k9w5eItstJRvRmscWyQH037QSyyK+9F7LgNNoHyre+DURCwz3yMksCMKuxjy
         vqXxhCpnec67J3hJ+xJKgVv9KrUaHcW+TZZY/pvOTYINE/hZ2qEd8FcSF7WeEwqiwoVk
         vusbZzua+7iDp/x3MixMmuLmxsKTYJzAuTavonMNEsLAjRn63A6ThhQmp2QmX07uSPW+
         OsxcUANPRgvpnpcetPIyiuoPIuRaKJk5/IS+eLgoLd4V93rfplu6+5jSai6BV1Th8DOx
         qsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835024; x=1740439824;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeWGgBgHpSFhRZt2LzxzC17j6aq9n9QClPuevSZwi1I=;
        b=b3ftb76oFtC8lxvAHuOJKfs5OK8KJjs6eU1EqBpeoM3KYuhRLclbPJqzvX7Vg++GZI
         RJMH/fYNkcVHz+r5hqGo9WrqQjsuRqZII74XbxNQ/ApvCanU4EDQe3zhpl4rbbySxvba
         L3avwO+hkOUXDrgOch6cgkaK/1yEXkrngH5pVzWnpfpzTOP0d7A+3tKHNPWLkkLaRXJ7
         l2j3KbXsvRsHfrIWRGeB6AXUQdBS/ndFJPHLJhSmxWVbB91PdMdSs7fCD2TASNicOL0U
         mqbVzmEHrIahJ1oUZxnBTOCjOphxqStH+vWCTGAyAw43roADF+087QYXoENlTUyXimyR
         K9sQ==
X-Gm-Message-State: AOJu0YwPkhYF7wjsoAH47x6rDGBF49Emk4VRb7shVxZ/5lAw2SjrI1rw
	kAekHv8U3tV0rRhgVQ83y/ER8bNwq5UqGKjK6MdV2PhcPq4sd8XtLIEhDQ==
X-Gm-Gg: ASbGncvDlCNtH2irVHH3nH0y+trdluYxDcUJ7+evq41R93nOyCLn6uLki26jveinrcc
	ox39UvKzWqCN/3GRKpXFXJjZhPKDO9KhNDMiTS8WPmSUJzxNW47Q5Fm8HsgNorxE3mnix/zB+XY
	+vjUXrx4oInRhhvrOJxY7cIsCoxN1li2/eaJM6ToBhNwr0/oDBzBhYECXQzysVtmUnwu9jH8PAA
	QMdaGz7cPa1hic83ZT5fqU9Ew9a+VIk5ersq28R7EKYES6rtYPNSzu9WIkfzWtQUW7F4agySm/l
	52ZpE0Cg908iKJPz4gtEmztg
X-Google-Smtp-Source: AGHT+IEX7O9wbD5BtBl9jCMP33goBEbbNIT/UuJ8cImTauo/A9BKztvAxPY7TuC9WIHrpivG+j+Jvw==
X-Received: by 2002:a17:906:2651:b0:abb:b0f1:2e40 with SMTP id a640c23a62f3a-abbb0f1487fmr203041966b.9.1739835024139;
        Mon, 17 Feb 2025 15:30:24 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9e44b7fasm241299266b.120.2025.02.17.15.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:30:23 -0800 (PST)
Message-ID: <4e786f50-ed1c-4387-8b28-e6ff00e35e81@gmail.com>
Date: Tue, 18 Feb 2025 01:30:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/8] wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Set the RX mask and the highest RX rate according to the number of
spatial streams the chip can receive. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e4f9b744f24d..3319bb5044c3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1565,6 +1565,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1584,17 +1585,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (efuse->hw_cap.nss > 1) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(300);
-	} else {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(150);
-	}
+
+	for (i = 0; i < efuse->hw_cap.nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
-- 
2.48.1


