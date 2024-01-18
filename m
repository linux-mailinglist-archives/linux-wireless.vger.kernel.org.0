Return-Path: <linux-wireless+bounces-2190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EC831BF3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADDA71C23173
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB1224B40;
	Thu, 18 Jan 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nHXYz2pl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E224B32
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590358; cv=none; b=tpz7Fv9RXYDzfjN3Vgd+NkesC4Or25F3xzTV10+053iRf2UsBhoAHZYhrCBTs0YbWhdbJriKjwQJmtmo4ZmvFA8IVX2B7wnpgRXmweleKksleeQMIzwHnCOFjvgV0QwEDIJ8vFprP/NaSEMSW8vvHv9PDiNx05fDSRrHVhLKYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590358; c=relaxed/simple;
	bh=wlg+32wkP/mxkl2TgNvs3eOPyg85YtOlXAs+J1AfJqU=;
	h=Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=Ll+3AJXLwnNmI+FjG3EpFNbJx6t84lzGNrXaXdZBaDe9lvhBYTZL0RwWbzXOfWjn5ITAg+EEQOXwYqbMNVQilwwknWfLwnPrAcXWZP1pzyrDsN5YGLsbHDQhKe6673ZMGorDHe+wK/hMl0egeI2TmBoDMai10O7QI5Oa8OUl7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nHXYz2pl; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id BDBA7647BB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 17:59:02 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1f91:0:640:de02:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTP id EE23660AE9;
	Thu, 18 Jan 2024 17:58:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rwOuU2f7a0U0-oSPw3MUa;
	Thu, 18 Jan 2024 17:58:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1705589934; bh=JHYltYrNm0LSrPtFLfYTp9VB0V+HBMgt8p9V+fPk66o=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nHXYz2pl9qtT7hePXTvgIUn1s4bApxjR3nV6BWY2RTa96/oWmtzBg3trFzfp59p9+
	 XTCRDs5rUo8uIvXjNzCrSWaHWTFd1FJe9aBpTUvlAR19o/n4wbsFJCWZcJDarZHMNN
	 efWX3VurzCMQjB9kkPoUYX7zYXNcPdrrwxd5WXdI=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Brian Norris <briannorris@chromium.org>
Cc: David Lin <yu-hao.lin@nxp.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mwifiex: cleanup SSID-related data types
Date: Thu, 18 Jan 2024 17:57:12 +0300
Message-ID: <20240118145715.475513-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop unused 'struct mwifiex_ssid_bssid' and replace custom
'struct mwifiex_802_11_ssid' with generic 'struct cfg80211_ssid'
as a member of 'struct mwifiex_uap_bss_param'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/marvell/mwifiex/decl.h  | 5 -----
 drivers/net/wireless/marvell/mwifiex/ioctl.h | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 326ffb05d791..ac23fa0ae0e7 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -161,11 +161,6 @@ struct mwifiex_fw_image {
 	u32 fw_len;
 };
 
-struct mwifiex_802_11_ssid {
-	u32 ssid_len;
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-};
-
 struct mwifiex_wait_queue {
 	wait_queue_head_t wait;
 	int status;
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index e8825f302de8..3ce41dafd515 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -37,11 +37,6 @@ struct mwifiex_chan_freq {
 	u32 freq;
 };
 
-struct mwifiex_ssid_bssid {
-	struct cfg80211_ssid ssid;
-	u8 bssid[ETH_ALEN];
-};
-
 enum {
 	BAND_B = 1,
 	BAND_G = 2,
@@ -88,7 +83,7 @@ struct mwifiex_uap_bss_param {
 	u16 rts_threshold;
 	u16 frag_threshold;
 	u8 retry_limit;
-	struct mwifiex_802_11_ssid ssid;
+	struct cfg80211_ssid ssid;
 	u8 bcast_ssid_ctl;
 	u8 radio_ctl;
 	u8 dtim_period;
-- 
2.43.0


