Return-Path: <linux-wireless+bounces-30096-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CC0CDAD50
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Dec 2025 00:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 767C3300311A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9EA289378;
	Tue, 23 Dec 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsTpOFHb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9227FD71
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532267; cv=none; b=bqK/gLibJuQayIjKf/3kx8iW42GJHp5FOqAjjgFR9lb0vAiOIqRwPpOIZWwgT/O91p5LcfttYgk68fSgg887l8cpi5iPAVM0Nxo4YJm0yUR9FYy8afpCQi5lj5Emah9oZ6IMi3hzssNAbXSIBksWbbs3+T/1BNwRkiP0/q1w9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532267; c=relaxed/simple;
	bh=AuWd0lXIW+r/Sfsr2qruwgk72ybI/4aqRzk7t0XMqgk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FGKQ8OejaVApk2hwd7zgrYfyKnvhRFYGHRRLPCMvkxJsRXnjd/NGmHspyPyb39yW1fmMRijpjAbmsQqvxOAmiS5SSzkIWG7KnY7/6i/dwF4VzT+GyF3Bl0/fqcnibUy50YyB93CvHbKN6iXjo6iLg3OfpSpeuwNp8FC8h6w+Q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsTpOFHb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so3040547f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766532264; x=1767137064; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NOpltuiyIT/aBjWF0Mb3Ps8hMyzPaNqWNFEqeTtdug=;
        b=NsTpOFHbhlivWsvVqN501cVv6Xv4C004MBs0Ii4MkIBaKF45vMaHGefP3AbBwN4yyG
         wznJMSNR1AfNVxGNg2xqTr2+ZtiGCoKVpl56XqWcZVRfSTrKgGajUTeRCCfbjrJPneRp
         LBcvLcAilKMkDWleKBpI/qhM0hOcIwxB+h4qSKpC+Sko+xM+L9jcriCOWkNgN0CxmQWW
         50Q+PnHxQvubOxhy7be099InN3OJ8nG3Il8XdT+C2EEN+Hc05HEmMOm6a9GjFyxqJRG0
         OcsmqkuPZnSdGj2elGtBLN5t6VUu/TOebxgamNI7JXDRiUsabC2So1jaYAbPXsHsQbIE
         eYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532264; x=1767137064;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NOpltuiyIT/aBjWF0Mb3Ps8hMyzPaNqWNFEqeTtdug=;
        b=v96GFSblQC9IMKrrEdb1/72s5iIZV2BUhdPEd+zriOTJY5OeHnyJSXzDpOlC1GPrpV
         EZ4UKymDNrTtv1AmXLmYi39ezHgO0VxeNTLN80jGS0lYsVhnn5rD6q+fG1b3wohysVf9
         R4kuz7LMZMnV68WF0Kb1NsJ6TxEfVFGJnRvNEDC51MpBbm2LeboFrXWsJobM3+M3Ln2u
         SBfla0804uMLuvjVgEjB+Y1QjZqKiAx/j/9tq4WEC1YinkHgcsLkjH9kurlXAOi11C6G
         TJg/ZL3Kme4RWKWZb2JdUlkCu+GAuWnoOcW0d5ujEoHidU/wa6Xy34MwP4ImmB1+c3cr
         Qacw==
X-Gm-Message-State: AOJu0Yx/5/BmDF7hagqTH0MQrmb5JnmIhTCkGBvfG51EJRUOa0xR2wC4
	Jgs6Zkcz8yehP89q8UOxxEIzQ3XKh8qOhzRuCECkQUzdCTRd2gZ41aJxJEvjnw==
X-Gm-Gg: AY/fxX7F3iqr4RaIgCeZO0rXy3N7515kDOr/QH07iH+bT7nS9RP/mP61VFr9NouErBR
	7aut1kZabEKjadzXFpFYAHzVtnAraERzI2S8PJ0iW8Pdw2TpyyZTPPQW913lkWDxEF+834pT5U/
	qg5vs5IFRAy/dp3VTViJxZmFb/eRyKHOdJvRZ2l2nPtlUAmCpEJGeNmUwQQKoctpTPhgpR2WXea
	AkH2vRYpY38I5f1Yp+BVKov9vN47KF20bZT76W0uask+smxLqMqioGjkqhhdnn9xAegbUiRJgy6
	BNeW+DwBaTDQzrnzHpEiwLS9T6aHsBNc2Dpd7ay3ZI8IjmtFlfKqZYgIDHwCjOHkQ1dvv/qAZei
	Ugr1QRie9tHfB3yPnlD7eIe+jJjLyi1bWWT6t/VloIKBL6UHzizAp7yhfL7WyQlLgdZ8wB6aH6W
	86RKZiw1TMxWweq+bvckuy
X-Google-Smtp-Source: AGHT+IHGUBisJ5rHO5Gb2/+cl7tSTEKxQOILLvvMLSSFpr3+gLiCZrp46THfrrSps9k1PEeJix89NQ==
X-Received: by 2002:a05:6000:2005:b0:430:2773:84d6 with SMTP id ffacd0b85a97d-4324e42eb06mr19352366f8f.24.1766532263551;
        Tue, 23 Dec 2025 15:24:23 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm30901676f8f.18.2025.12.23.15.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 15:24:23 -0800 (PST)
Message-ID: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
Date: Wed, 24 Dec 2025 01:24:21 +0200
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
Subject: [PATCH rtw-next 1/3] wifi: rtw88: Fix alignment fault in
 rtw_core_enable_beacon()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtw_core_enable_beacon() reads 4 bytes from an address that is not a
multiple of 4. This results in a crash on some systems.

Do 1 byte reads/writes instead.

Unable to handle kernel paging request at virtual address ffff8000827e0522
Mem abort info:
  ESR = 0x0000000096000021
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000005492000
[ffff8000827e0522] pgd=0000000000000000, p4d=10000001021d9403, pud=10000001021da403, pmd=100000011061c403, pte=00780000f3200f13
Internal error: Oops: 0000000096000021 [#1]  SMP
Modules linked in: [...] rtw88_8822ce rtw88_8822c rtw88_pci rtw88_core [...]
CPU: 0 UID: 0 PID: 73 Comm: kworker/u32:2 Tainted: G        W           6.17.9 #1-NixOS VOLUNTARY
Tainted: [W]=WARN
Hardware name: FriendlyElec NanoPC-T6 LTS (DT)
Workqueue: phy0 rtw_c2h_work [rtw88_core]
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : rtw_pci_read32+0x18/0x40 [rtw88_pci]
lr : rtw_core_enable_beacon+0xe0/0x148 [rtw88_core]
sp : ffff800080cc3ca0
x29: ffff800080cc3ca0 x28: ffff0001031fc240 x27: ffff000102100828
x26: ffffd2cb7c9b4088 x25: ffff0001031fc2c0 x24: ffff000112fdef00
x23: ffff000112fdef18 x22: ffff000111c29970 x21: 0000000000000001
x20: 0000000000000001 x19: ffff000111c22040 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffd2cb6507c090
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000007f10 x1 : 0000000000000522 x0 : ffff8000827e0522
Call trace:
 rtw_pci_read32+0x18/0x40 [rtw88_pci] (P)
 rtw_hw_scan_chan_switch+0x124/0x1a8 [rtw88_core]
 rtw_fw_c2h_cmd_handle+0x254/0x290 [rtw88_core]
 rtw_c2h_work+0x50/0x98 [rtw88_core]
 process_one_work+0x178/0x3f8
 worker_thread+0x208/0x418
 kthread+0x120/0x220
 ret_from_fork+0x10/0x20
Code: d28fe202 8b020000 f9524400 8b214000 (b9400000)
---[ end trace 0000000000000000 ]---

Fixes: ad6741b1e044 ("wifi: rtw88: Stop high queue during scan")
Cc: stable@vger.kernel.org
Closes: https://github.com/lwfinger/rtw88/issues/418
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index dbec7724d6af..9470042b12a8 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2447,10 +2447,10 @@ void rtw_core_enable_beacon(struct rtw_dev *rtwdev, bool enable)
 
 	if (enable) {
 		rtw_write32_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-		rtw_write32_clr(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
+		rtw_write8_clr(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
 	} else {
 		rtw_write32_clr(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-		rtw_write32_set(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
+		rtw_write8_set(rtwdev, REG_TXPAUSE, BIT_HIGH_QUEUE);
 	}
 }
 
-- 
2.51.1


