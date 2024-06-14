Return-Path: <linux-wireless+bounces-9012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B4908B56
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B5A1C2278A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF441836C8;
	Fri, 14 Jun 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz0UkZEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46012F5A0
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367237; cv=none; b=V/grGouN5NMV2IQmNbCNFcKcQH+wcqH77+3lYbskAkLDPgOOoQYqb0AtX3X4Uh5S89Y0adArIVoUS9ZPSdxqAq6MhjIBcsSwHfTavdy9LHD+CWeTYo2FtbXXHDVeyueeCKv0aPzQig7URDDok90n/w+kSE3Ohj4xDb1traDNMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367237; c=relaxed/simple;
	bh=EgjL7f+WcmL3rvz6SxMiM/Fjq88MHORkR+nK3CX7NKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czGmFqumr3T1fNUYEkwpeQiIYZaoRXi2+5f0Z9thNEYZ1+I6uWBfmi3HyxskjwJt+XebKyei7fq0xreqAUvRyFjqHRw0Y0054uiYviE3gUIPw2WAbF/iHIU93F8PGEOPsR1qlopz3rzA7HfgttzVfwi6igNO2plV+UnNzbJQcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz0UkZEG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a62ef52e837so282688266b.3
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718367234; x=1718972034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8jOqvuOp3Ub8AxENtZkxqbTwSEAq6A0UXQqbY0ftHo=;
        b=Iz0UkZEGq1l1nQ4zNvp3J/5RZY4g8SiUYCY5/8YUqu3NDf8YFDJY1q9XVqEnv3gJq+
         07v6F1IIwNc5+3AHIUZxsUDFwqBmD7jW1InVBEPT4K9sAHbrjorTAByqWy2dZUb5zKPL
         VjGD1l63RI8XdnZzghIikqxq4r0r1dWBoEQzzY46435kgUfVlwDn9qzqPyF5/9Qy2Nw3
         Cl/ETqv0VMvJrGINIUf8n4FJwWkzri74t0rQZihdoK6mgATeFViXrSYRsIo/ihphAwSU
         0NiNgI8B4LGfd+MFNAbngisX1qRKUxb02C1g1B5weyvPGGdsuh4A2u22khPiss1T4esZ
         z+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367234; x=1718972034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8jOqvuOp3Ub8AxENtZkxqbTwSEAq6A0UXQqbY0ftHo=;
        b=eMUe4MzrrlSRvZ1hlaC50FtInfgRZUQrmRQ5CPtzTK94a2f5OKle4iBa+9+DMXxSsv
         Yc7kheWNrk7jqWqGCZUkm+XdTu7mx18KOE1aiBodGzGCPqwAk9VJUUaSrjDG/F9Frp0L
         Kz8y5VDStgYO7evYqNapfhQMpGH8nDPdbKYCyAP2NDkIjN6wdlsCacjXPaXkWlmxZnhR
         Pj6EJT2eabsk97QK3Cso5YJg6emRV6puy8PHV3wYExlV8dJMt69iRAKCjXw6uwLOPvfA
         Up7TsgmvYXgfDPvjhDa1x3fYQ99TA56hLZxVA+y6kdN7oGU5t2yKNMkzePdOcG7+Uvzo
         /FFg==
X-Gm-Message-State: AOJu0YxrVEO+TPnzv6mOT3aPa+sIhjKIq+x5xwhgxi2cRzr75Z6sTLaX
	ihachOJ9mEEHtdM7oqOYXzfSLFPwmz/6m53EuVdqnU/1ZSLD+KDvz9fnaw==
X-Google-Smtp-Source: AGHT+IHASgStpePLTGeP4eL9Y1KVVsQoUy+aTWVW/mcRKkHolb18Mla+ixJ2IY4iWFQIprfvw8K0tw==
X-Received: by 2002:a17:906:16c8:b0:a6f:33a2:eaad with SMTP id a640c23a62f3a-a6f60de5e0emr187830666b.71.1718367233836;
        Fri, 14 Jun 2024 05:13:53 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (078088142095.jeleniagora.vectranet.pl. [78.88.142.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4136sm181082466b.36.2024.06.14.05.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:13:53 -0700 (PDT)
From: "=?UTF-8?q?Marcin=20=C5=9Alusarz?=" <marcin.slusarz@gmail.com>
X-Google-Original-From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	=?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Subject: [PATCH v2 1/2] wifi: rtw88: 8821cu: keep power on always for 8821CU
Date: Fri, 14 Jun 2024 14:13:38 +0200
Message-Id: <20240614121339.525935-1-mslusarz@renau.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
References: <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

This chip fails to reliably wake up from power off.

Change-Id: I295de3c71fe91af37e8cc39b70728a8ba7e94b2f
Reported-by: Marcin Ślusarz <marcin.slusarz@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no changes since v1
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw88/main.c     | 10 ++++++++--
 drivers/net/wireless/realtek/rtw88/main.h     |  2 ++
 drivers/net/wireless/realtek/rtw88/ps.c       |  5 ++++-
 drivers/net/wireless/realtek/rtw88/ps.h       |  2 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |  3 +++
 drivers/net/wireless/realtek/rtw88/wow.c      |  2 +-
 7 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 0acebbfa13c4..0302af2ebe5b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -98,7 +98,7 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
 	    (hw->conf.flags & IEEE80211_CONF_IDLE) &&
 	    !test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
-		rtw_enter_ips(rtwdev);
+		rtw_enter_ips(rtwdev, false);
 
 out:
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7ab7a988b123..a48e919adddb 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -302,7 +302,7 @@ static void rtw_ips_work(struct work_struct *work)
 
 	mutex_lock(&rtwdev->mutex);
 	if (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE)
-		rtw_enter_ips(rtwdev);
+		rtw_enter_ips(rtwdev, false);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -647,7 +647,7 @@ static void __fw_recovery_work(struct rtw_dev *rtwdev)
 	rtw_iterate_stas_atomic(rtwdev, rtw_reset_sta_iter, rtwdev);
 	rtw_iterate_vifs_atomic(rtwdev, rtw_reset_vif_iter, rtwdev);
 	bitmap_zero(rtwdev->hw_port, RTW_PORT_NUM);
-	rtw_enter_ips(rtwdev);
+	rtw_enter_ips(rtwdev, true);
 }
 
 static void rtw_fw_recovery_work(struct work_struct *work)
@@ -1356,6 +1356,9 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 	bool wifi_only;
 	int ret;
 
+	if (rtwdev->always_power_on && test_bit(RTW_FLAG_POWERON, rtwdev->flags))
+		return 0;
+
 	ret = rtw_hci_setup(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to setup hci\n");
@@ -1506,6 +1509,9 @@ int rtw_core_start(struct rtw_dev *rtwdev)
 
 static void rtw_power_off(struct rtw_dev *rtwdev)
 {
+	if (rtwdev->always_power_on)
+		return;
+
 	rtw_hci_stop(rtwdev);
 	rtw_coex_power_off_setting(rtwdev);
 	rtw_mac_power_off(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 49894331f7b4..a6125b5e7d53 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2049,6 +2049,8 @@ struct rtw_dev {
 	bool beacon_loss;
 	struct completion lps_leave_check;
 
+	bool always_power_on;
+
 	struct dentry *debugfs;
 
 	u8 sta_cnt;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index add5a20b8432..a4092d424eda 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -24,8 +24,11 @@ static int rtw_ips_pwr_up(struct rtw_dev *rtwdev)
 	return ret;
 }
 
-int rtw_enter_ips(struct rtw_dev *rtwdev)
+int rtw_enter_ips(struct rtw_dev *rtwdev, bool force)
 {
+	if (!force && rtwdev->always_power_on)
+		return 0;
+
 	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags))
 		return 0;
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 5ae83d2526cf..92057d01cbec 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -15,7 +15,7 @@
 #define LEAVE_LPS_TRY_CNT	5
 #define LEAVE_LPS_TIMEOUT	msecs_to_jiffies(100)
 
-int rtw_enter_ips(struct rtw_dev *rtwdev);
+int rtw_enter_ips(struct rtw_dev *rtwdev, bool force);
 int rtw_leave_ips(struct rtw_dev *rtwdev);
 
 void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter);
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 98f81e3ae13e..e1b66f339cca 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -859,6 +859,9 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	rtwdev->hci.ops = &rtw_usb_ops;
 	rtwdev->hci.type = RTW_HCI_TYPE_USB;
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821C)
+		rtwdev->always_power_on = true;
+
 	rtwusb = rtw_get_usb_priv(rtwdev);
 	rtwusb->rtwdev = rtwdev;
 
diff --git a/drivers/net/wireless/realtek/rtw88/wow.c b/drivers/net/wireless/realtek/rtw88/wow.c
index 16ddee577efe..a90c8b388944 100644
--- a/drivers/net/wireless/realtek/rtw88/wow.c
+++ b/drivers/net/wireless/realtek/rtw88/wow.c
@@ -620,7 +620,7 @@ static int rtw_wow_restore_ps(struct rtw_dev *rtwdev)
 	int ret = 0;
 
 	if (rtw_wow_no_link(rtwdev) && rtwdev->wow.ips_enabled)
-		ret = rtw_enter_ips(rtwdev);
+		ret = rtw_enter_ips(rtwdev, false);
 
 	return ret;
 }
-- 
2.25.1


