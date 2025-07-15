Return-Path: <linux-wireless+bounces-25498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBEB06728
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 21:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E254E7AEE
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51323D2B1;
	Tue, 15 Jul 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuUvQVl/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401851487F4
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752608692; cv=none; b=fWGCRHA3hNth+HqfrkfYEQXhouMYU9/cwoi8J7H3M/aLLx2oEGQYibWGaWfdiWg6i2BKWcUtxJH+SlO8SUHRKCNSuxYKhAHFBBsPi1GnPWxruKXejG3HBYFc/Dxvh1JAG1KgD0HiiwLZJJzyFEnLC82o8bKalOOJtwKXNzwAEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752608692; c=relaxed/simple;
	bh=SMbWcLIN0z9UZ0WNfuaSdAhKxw1fzg6rBx0VN1lijLs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=stgWcOWysSKjXo/LOSneHy4xFGa6vBUeJTf9ScG1TGB70S8gGaeIOuWGHi2Zu4inqdxTEvTzxwH8tKay6AOlcwFCCdepKojQ4J0DHq8/4xeo+deF/hCY+jwp6VIDMnUYHxaCZUJkwAjK4RAounULLA9m7aV/sNvqT1Y66WLSH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuUvQVl/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so827851166b.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752608689; x=1753213489; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euFvsUUkMHourkiEFFGrU7mM7SniFpn3pr9Pa2rUq8s=;
        b=EuUvQVl/82C3u3cQvZmMsOpVyOItxBeVgQE7xQ5b2fIS/2RA702PR+2SNFma2uJbGY
         qPC0SbF+N6l1cyTBJTmA9++YabHclr6junN7WjTyvqyZpNIqyZZSLG6mwJrB3ZxKJl88
         r113LEPuUgWYeeK2JwQdRrmI9xSenA1RMnETkhsN9cxWwaK4dJd7mo6KbXihsNh4pQND
         IuAPdOvc6RmMp/p7wa8jllj+Odl28DsYk2JfqCulhmiajPXGWU6xCCUgDIM58cISfPOC
         QDr9anGOZuDlo6ZB9PWcxN0eMcQ9i9RJtLHPKNWdg/I33dh0shVooyL0lC2Lm0e3vK7X
         7zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752608689; x=1753213489;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=euFvsUUkMHourkiEFFGrU7mM7SniFpn3pr9Pa2rUq8s=;
        b=mtWa9ADTM2IhsetZ/w11gzbn3bUVsUwGtmO80KV0bVw9mKZZ5kO/rJxi/u5w/q6X6Y
         lYA+SapOvuK2tHrF7lHX/PsXmUHLkM+ix6S69PkzZFEgX/GbHPC3LcPQVjZ1Fu+CFv8j
         mVDzVC26d/+yDF+F7yEQVkxy9t9HRuSENJ07SNVjce7XpKlIgbUPcqGTjMdySANwlDdB
         bIktgYPEc1smGyXD8FRs+6dv8X1DpXVzzANYkyv/xWuwwHB6b4VLgsPHu920Wn0pZZAY
         skZ+Qd/kGiTtS652PVazerFyZJmuk9nQDLIy8K9nkVvF78zSO5qLUaDP6vond2LIXYv3
         qong==
X-Gm-Message-State: AOJu0YwlfOyq4NQLEo8ZWHRpLpMcV+sizgFWmE88Bud/V4BCrbZcRq0X
	pER5lalEH2ch2Gc0P81Cv4qhvHxDxtAbZsmZiTqUpdcvR6R8FbhqR9XwdEwqQA==
X-Gm-Gg: ASbGncsWjxpjBmhEtGwuvGr7i4J9UZZeFsIzIkFMI74SVlWSIueLUW+TPyohApxPGeo
	Wo8jvLKa/uEZejjL8MbK+sjlJ4/h8UlBojz6UaNXxMrwjXE9d3KKzGJ6MQHNXqEibKmbBTvH+tr
	aaoNn8uHONd4QZaUwp0x8WZ1GwbbiNFTRCvHrEYIv2vQNfCkdikEKmE9nDVMwU3zajz2nKCtRA3
	E7/4fJ28FT7K/ElXHze6w971AMVd3XtyQ6qR4WZUVtRfDG6ZKpPsjbp2llEZx6F6usaB8tKAgP5
	lRgh+sedd4OcTthu2yKmNHE4EhgE08wuvyzvXFEvOb5SOgTTRQq9jn+bu59/ym2I5Ho43jxTrKz
	bZWLioXqIIDnbuE0RzEsNL+c7h1jwmg==
X-Google-Smtp-Source: AGHT+IGBUqgi6QQhqq5YObqUbXD7H+iuEFIs/g/xx3Z24CMuV8YNpWQnifhEeM+7GhcRmedw3QQKew==
X-Received: by 2002:a17:906:7308:b0:ae0:67b4:991d with SMTP id a640c23a62f3a-ae9c9b1fccbmr67204066b.35.1752608689267;
        Tue, 15 Jul 2025 12:44:49 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8266992sm1036496166b.82.2025.07.15.12.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 12:44:48 -0700 (PDT)
Message-ID: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
Date: Tue, 15 Jul 2025 22:44:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in
 rtw89_fw_read_c2h_reg() for USB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
1000000 µs can take ~250 seconds in the worst case because sending a
USB control message takes ~250 µs.

Lower the timeout to 4000 for USB in order to reduce the maximum polling
time to ~1 second.

This problem was observed with RTL8851BU while suspending to RAM with
WOWLAN enabled. The computer sat for 4 minutes with a black screen
before suspending.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Lower the timeout for USB instead of increasing the delay.
---
 drivers/net/wireless/realtek/rtw89/fw.c | 9 +++++++--
 drivers/net/wireless/realtek/rtw89/fw.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 73a4ec988d16..b774a329e7c7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6755,13 +6755,18 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const u32 *c2h_reg = chip->c2h_regs;
-	u32 ret;
+	u32 ret, timeout;
 	u8 i, val;
 
 	info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
 
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		timeout = RTW89_C2H_TIMEOUT_USB;
+	else
+		timeout = RTW89_C2H_TIMEOUT;
+
 	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
-				       RTW89_C2H_TIMEOUT, false, rtwdev,
+				       timeout, false, rtwdev,
 				       chip->c2h_ctrl_reg);
 	if (ret) {
 		rtw89_warn(rtwdev, "c2h reg timeout\n");
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 98be7e72c685..a731c242f389 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -115,6 +115,8 @@ struct rtw89_h2creg_sch_tx_en {
 #define RTW89_C2HREG_HDR_LEN 2
 #define RTW89_H2CREG_HDR_LEN 2
 #define RTW89_C2H_TIMEOUT 1000000
+#define RTW89_C2H_TIMEOUT_USB 4000
+
 struct rtw89_mac_c2h_info {
 	u8 id;
 	u8 content_len;
-- 
2.50.0


