Return-Path: <linux-wireless+bounces-19083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9FAA38FA6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C4516717A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1821A5B83;
	Mon, 17 Feb 2025 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0Ry838z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFF15666D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835175; cv=none; b=a48elyaeGkQ42kAqblhvRRqXPwTCKiEjGGJffodF09m1uZLbARgyKHP12UNdKTrdojngFAjuuJKqAbIJmoQa/Am3mo7GTyppHVqtPJS4L5CNv6pLafPpHadP5QYVNeTB/Vkc17I7cJmwT19tDjwXQeW22hp1Wmlh3AvmmBRA8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835175; c=relaxed/simple;
	bh=lB0c1W1JU23BHHUYdYSSLG1Hi6OxB24fHCmNRz8XMy4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cgHUpG4B2TIxVzGE+kHeJU7WZxTU6bYgsdB4lc82dxCKapfIRhql6yLRGhKViOIlQL7xTs+/AelgV6A61Fg7LE+tkplf6IU/++dU9qMdI4r8BOvdWZ5FoXK0kQLDOOpYDBZK/+FkU4SGyDFKVxUZ49tA+BXPKDmJkn/ezROYpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0Ry838z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso356323966b.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739835172; x=1740439972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nQk+fHekPzTN5pyREc7BNKcXMbKg0FM3oukANhwhDtE=;
        b=e0Ry838zHKmERud9K2dceXYjDdwzSsoPg14VW6TolSh677ayI2T8BsG6Xe23If7DVd
         rh2RLsfQjJ3bmlQACE+cq6w9V1MSaIzBH9pRpXJIvKzcCkm710hNFWrKvu5X8KJ3XGxv
         CVOSXRuvX/iWuggrWg5GmFBV7YjBGFhhfdSl0SCLlieR7JZZ3U9by4TN0QhHNUR63v2x
         nnznuyuJsjKzMlRO5YZsdL/4GvMHii+qUk4C5uYyWrE2SgWZX+rZuEzW9GakO43cs+Eb
         9YyhuFXwTzmVC1JDDEgkbTxCRenPd6U3Tu8xr4/K2FEIk+f7U10R001YGrS+gPbI1wuM
         z54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835172; x=1740439972;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQk+fHekPzTN5pyREc7BNKcXMbKg0FM3oukANhwhDtE=;
        b=ZLgZfGVajKjZzNVy9aXaxweD6X67P/cv1NxVgHsa2P8E8vX/V3UKMlHTlBuysHhaCt
         7paWWVfO0w1dxrfdM2dtQvb9OsokrKF01Wy42RJ5bajm2l/nZJciu7VLI4eihFxrqKvX
         gB+6mIqhe2Kw9Gx0j5ybg+7xkp3RUObUXOHWJD64qa2bkGyuczk1hBLzzrmIuS2aKDEx
         Iq93jjaNQZRSPhEa5oHQub0qq4mqOMMJ7K+EC76Jm+S4MueX+rNQWGL/K0YtbcZZl8bX
         YKBseuJUQUb5/RRemBa+LLpiWBs29nA5WvB6h9lkkAVbrwgPEdTz0FHvGV0ZLwhP7Chz
         LOcQ==
X-Gm-Message-State: AOJu0YzoCyU0Plk3+sPJdmUsUXwy3NaWZ2h+lt7s0/HGcQBYQklJ7N6D
	u9N9RcE3wEOeQGYnzzUYFdUu5rFGv1rMS9+QH1SupO+RtCq3w/M25OcEVw==
X-Gm-Gg: ASbGncve0vA/8MN1zKzBNwmG6s0tE5swZlZSDWgFQ9B2a6idVtTGCs07fc5PQcEBJy8
	5cvCbE0iCOL/mqxcWe3vWaFDMR5RWamqidktcWOLIk8OvIRNwrwGoIa2UuCwtNBqIPEK4XVBUP5
	fBr08fwpTURScHJDxuNikOHGxh6dsN4CX40RYtzPxkTty7s6F6urGlSKUOA4eGnXcr5QnANBhL7
	NNKDpUJTvkKWj+7EZALwt37fonxHfBbDf6a6cRX496+b8tsSZS6bYLrLeEShaByjbqDfrUA0Tfx
	2FEGVLWywu0Sh1j6F0FqunSA
X-Google-Smtp-Source: AGHT+IEixf5kS0fWf1d82oVYg4oR7UvYjFDbI6CZXjTkwxiUtu+6AV03Zuhh05EtD0hr/4lrZ8M48A==
X-Received: by 2002:a17:907:1b12:b0:ab7:bfb1:99c3 with SMTP id a640c23a62f3a-abb70e323cdmr1302123066b.53.1739835172232;
        Mon, 17 Feb 2025 15:32:52 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbbc841eb0sm4050166b.128.2025.02.17.15.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:32:51 -0800 (PST)
Message-ID: <ea65a978-a735-4c97-af82-d7fe26f95da1@gmail.com>
Date: Tue, 18 Feb 2025 01:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make it print the TX power details for all RF paths, not just A and B,
and for all the rates supported by the chip, not just 1SS and 2SS
rates.

Also skip the RF paths and rates not supported by the chip.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Print only information about the RF paths and spatial streams the
   chip actually has.

v3:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/debug.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 1adb03d1210a..b67d69b01f87 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -692,9 +692,11 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_power_params pwr_param = {0};
 	struct rtw_hal *hal = &rtwdev->hal;
+	u8 nss = rtwdev->efuse.hw_cap.nss;
 	u8 path, rate, bw, ch, regd;
-	struct rtw_power_params pwr_param = {0};
+	u8 max_ht_rate, max_rate;
 
 	mutex_lock(&rtwdev->mutex);
 	bw = hal->current_band_width;
@@ -707,19 +709,23 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	seq_printf(m, "%-4s %-10s %-9s %-9s (%-4s %-4s %-4s) %-4s\n",
 		   "path", "rate", "pwr", "base", "byr", "lmt", "sar", "rem");
 
+	max_ht_rate = DESC_RATEMCS0 + nss * 8 - 1;
+
+	if (rtwdev->chip->vht_supported)
+		max_rate = DESC_RATEVHT1SS_MCS0 + nss * 10 - 1;
+	else
+		max_rate = max_ht_rate;
+
 	mutex_lock(&hal->tx_power_mutex);
-	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+	for (path = RF_PATH_A; path < hal->rf_path_num; path++) {
 		/* there is no CCK rates used in 5G */
 		if (hal->current_band_type == RTW_BAND_5G)
 			rate = DESC_RATE6M;
 		else
 			rate = DESC_RATE1M;
 
-		/* now, not support vht 3ss and vht 4ss*/
-		for (; rate <= DESC_RATEVHT2SS_MCS9; rate++) {
-			/* now, not support ht 3ss and ht 4ss*/
-			if (rate > DESC_RATEMCS15 &&
-			    rate < DESC_RATEVHT1SS_MCS0)
+		for (; rate <= max_rate; rate++) {
+			if (rate > max_ht_rate && rate <= DESC_RATEMCS31)
 				continue;
 
 			rtw_get_tx_power_params(rtwdev, path, rate, bw,
-- 
2.48.1


