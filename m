Return-Path: <linux-wireless+bounces-25143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA4AFF4C8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 00:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2D7BDA0B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6A248F52;
	Wed,  9 Jul 2025 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLmg00W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEA25393C;
	Wed,  9 Jul 2025 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100552; cv=none; b=dhU59rZDqqlTWiAAE8ZPmnKCSUQJm0g3oC5+923OnXY1e89Yh7kcEJq2A79wNOUgtQt3F+y/trw6zhoae4uK7+lCf9xt7ErxZTAPXfEwc0qJAzbMfWUq6UW+8lq7u18QKJfXiwaxYtWFpU1izZDmGJeiuAIrnDWbWTuSpvdm1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100552; c=relaxed/simple;
	bh=NuAKWBJztT0Lv2dro0HNgXgH3Fn/s08lZdbUWNzKk8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtC+DLtkD8vddDyy3hbjHiBkK3VSbfvDLQ/jJZ93kCf1dXoQ3fg0FfDlHECBUxN2lh7hHK4GNTuXZ01rdO1t8o3yTUF3aacLB3UBvy39Rk+5zpQOel8izY4PmqeGQ0DKafEnapzJHLib2yCytoUeQBhJOe++9cW2vr7PR9f92ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbLmg00W; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so270698e87.1;
        Wed, 09 Jul 2025 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100549; x=1752705349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l9R8puC87zBx7GlN0c3QVlLRK1+6Ilh2p8dNod1NDQ=;
        b=cbLmg00WChjLGeovHsDx/P8Av92bNYLz3drOlDfkCxYRr+wAB9jbt9fjG3s9H+NK1M
         OQUnsM2A5aCeaVWE1cpsduAh8bRCXnyaIpEE7MbDaI5hUy7irymgdpk5NjN/q2AjCeCQ
         v9KXB4cNXABxB78jXbhLL/UC9ja4AymmHOBHAndZCNqVwJqbZbchkd6NuFporzPBrCPy
         Aiq/PTj2J/HyC1RTcjj4D/bEYZbnpVhLfkW8PbvgNm0Q99saKvGkgv0tDve4AEIaa94B
         FuyqVqc8ZJ79oO4FgAFrqWm3gF1RcOhL3vQR5Ix6Tz4MLGGwQLF0cLKrMp+I8pysRwuy
         aSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100549; x=1752705349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l9R8puC87zBx7GlN0c3QVlLRK1+6Ilh2p8dNod1NDQ=;
        b=mF147YTxP0ZHVCbIsglQRtOONfkCCiopqHzWZaGZ0PMDlKPBAYcrtzkJrT0dikJOtC
         xr98JkGxpVPSpVpXl6sz7+WwwfizyR8XwmWb7SYbZjpZWhG/9dzOo8WDrHWYxk4LY4NS
         t1rRPKiI3O0QUGZxwSEBe4jw34FqecbKJTYcup8lqezEyE1ZahwGvXv55a26FDuYtxrD
         Uvpa9iDZk1QmXqO1g4tQt5mWewPKzLaXKG85ftwyzK7I5zpvlh5lj9yAQmOsEA5rCJV3
         VLrLB6DKKQBNltz+Px0oKhmNfOKHhzls5BTmj6WmhJLBMgicPCMTu5s2M03rRGv6pyh+
         jMig==
X-Forwarded-Encrypted: i=1; AJvYcCWasLg3pYp7NK1gRLa6PZDkQV1yQ55hRu3elHLr5FYMlASzs42shssYLCRlq6VTD01oj4gsYTNjMOcIMLeA6yE=@vger.kernel.org, AJvYcCXwRewQbJ5k7Y96LIGVywya8MttMV+MQRCGas7en3Sw4IPStWI/p9cFmuprlaoq0NJD3zgMaCNvxknjBJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DyY/7LP4q6esEOSl8IZlp9h+ncI8iduXGbZRxqjqHPEeYKiD
	Jgy+JTpJb4AEU1wXTTJ74G+Gy41ptVDHkcVE2/jNAKLxHKH83Homkjn3
X-Gm-Gg: ASbGncuqHMwnOstoCkTHZsEZP94urnOjpDvZCP9T09V3f9mtCBE3ED/zdY+NA6lBhXK
	7G6KfMBo6LDVeI2IbnGdTmXuBKjs4ux9naewiXpWVkkvaQA2yr7+zdVpcHCfoA1tWCJmA4EUy+p
	e0sS51NyJdyRh5NSzXUE7i6PJjKaj2wcMi2kD8hZwSbJPAOi8QLuEpDE5fPAfmMoFxBcUsu2QAV
	uUITirkZe28aQOaUxhJqi3j6pv46nIQjQJOvZizYl3/uG5iS5VokV4WF1AYS62EsK2P7I3KVlF3
	iQTIpkk5HRPv9EOTpMPB63DzGITRG/lGhZ7pTcIp4F1IGZOXfBzz8gHi85h5SgQrurRrt/rAkPK
	MxjApyHQpEFrwnswNDg==
X-Google-Smtp-Source: AGHT+IEpdFzT7v+ZJ4M/mMZfNK/rD6Y9am5QWgYEI6D3YX1Ew3d4U3OEB2MxssRktnSUbmuXWyMxqA==
X-Received: by 2002:a05:6512:2252:b0:553:341f:12a3 with SMTP id 2adb3069b0e04-55935b358d9mr128203e87.39.1752100548716;
        Wed, 09 Jul 2025 15:35:48 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b74335sm54149e87.215.2025.07.09.15.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:35:48 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 1/2] wifi: rtw88: introduce callback to override phy parameters from tables
Date: Thu, 10 Jul 2025 01:31:58 +0300
Message-ID: <20250709223159.2787192-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
References: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tables with register values for phy parameters initialization are
copied from vendor driver usually. Sometimes these parameters has to
be modified. When table will be regenerated, manual modifications to
it may be lost. To avoid regressions in this case new callback
mac_postinit is introduced, that is called after parameters from table
are set.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c  | 11 +++++++++++
 drivers/net/wireless/realtek/rtw88/mac.h  |  1 +
 drivers/net/wireless/realtek/rtw88/main.c |  6 ++++++
 drivers/net/wireless/realtek/rtw88/main.h |  1 +
 4 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 011b81c82f3ba..e05d06678050d 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1409,3 +1409,14 @@ int rtw_mac_init(struct rtw_dev *rtwdev)
 
 	return 0;
 }
+
+int rtw_mac_postinit(struct rtw_dev *rtwdev)
+{
+	const struct rtw_chip_info *chip = rtwdev->chip;
+	int ret = 0;
+
+	if (chip->ops->mac_postinit)
+		ret = chip->ops->mac_postinit(rtwdev);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index e92b1483728d5..b73af90ee1d7f 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -38,6 +38,7 @@ void rtw_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
 			     const u8 *data, u32 size);
 int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw);
 int rtw_mac_init(struct rtw_dev *rtwdev);
+int rtw_mac_postinit(struct rtw_dev *rtwdev);
 void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop);
 int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev);
 int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 97756bdf57b27..b706c5a21a6c5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1412,6 +1412,12 @@ int rtw_power_on(struct rtw_dev *rtwdev)
 
 	chip->ops->phy_set_param(rtwdev);
 
+	ret = rtw_mac_postinit(rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to configure mac in postinit\n");
+		goto err_off;
+	}
+
 	ret = rtw_hci_start(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to start hci\n");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b42538cce3598..43ed6d6b42919 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -858,6 +858,7 @@ struct rtw_chip_ops {
 	int (*power_on)(struct rtw_dev *rtwdev);
 	void (*power_off)(struct rtw_dev *rtwdev);
 	int (*mac_init)(struct rtw_dev *rtwdev);
+	int (*mac_postinit)(struct rtw_dev *rtwdev);
 	int (*dump_fw_crash)(struct rtw_dev *rtwdev);
 	void (*shutdown)(struct rtw_dev *rtwdev);
 	int (*read_efuse)(struct rtw_dev *rtwdev, u8 *map);
-- 
2.47.2


