Return-Path: <linux-wireless+bounces-20791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF92A6E867
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DE03A9ED1
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67D5170A26;
	Tue, 25 Mar 2025 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QRewel25"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C714F90
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742871276; cv=none; b=bgmLTbmDvW/+ek67i4toYUoNYzfMDV4NWllNuwKM+GkEjfV83hGKp558Grg2J9NnroWfQjhuTVgoVsJI5dSJz81sNg1aZ2eoinuzErV6cdG90NVoH5dW1lMh7C2xBF8ZwZVZIjmQsG93a49kMW18CnCmxS3K9vUiuSEkv66+U2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742871276; c=relaxed/simple;
	bh=dYfFv9f1eAUkl3TGuen+y22IAyvAeU2XPE3UQzMTYBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FmEjWOzvtHu0yk9upExVpoKp83ZiWI2ae5BHEHKHu9Q/pF7kp5SqpfLHB+3LmQThuC6E9Whc4JjRoxentCgoz+n4yiu0KxfkFNIzZ9Aretyqt+TmisJ24rK32s80YVxAA73JtjKoCn0TFoJlLxmmaRAY88NEsjXEN4LzD79KcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QRewel25; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52P2sU0713582060, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742871270; bh=dYfFv9f1eAUkl3TGuen+y22IAyvAeU2XPE3UQzMTYBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QRewel25jiuspwLd6ysvHw4g7JR5JeJC8wL0cjxSneyg3W4tV10OMpMvlFLLLndPZ
	 yM+yr4p8uCegCnUXTqFZPP4bSESOFH1qsKBaf62Nf+z3leFNsWsDsr3kIMWGo03cRY
	 yBLtUx6Tsn/uglGzS/Kv/OAzF8GRN+9NjENoGP2HIKYx+spijueS132U9khBkLvZyY
	 AX/HopEO1WQmakfdyBEIDSsSlKHe8GFFqcp63aBD5FS+HWELrDePHi9LBRLURdpZug
	 lsx3tAzgcPSC7Vz7JUSPNRamgM6VqpAQrh44qT1UdZyh6IRnLDHUghWVggPICqYq78
	 WsZSAYzxgeTmA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52P2sU0713582060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 10:54:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Mar 2025 10:54:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 25 Mar
 2025 10:54:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next] wifi: rtw89: fw: cast mfw_hdr pointer from address of zeroth byte of firmware->data
Date: Tue, 25 Mar 2025 10:54:24 +0800
Message-ID: <20250325025424.14079-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The firmware->size is validated before using firmware->data, but Coverity
still reports:
  Downcasting "firmware->data" from "u8 const *" to "struct rtw89_mfw_hdr"
  implies that the data that this pointer points to is tainted."

Using &firmware->data[0] to avoid the warning. No change logic at all.

Addresses-Coverity-ID: 1494046 ("Untrusted loop bound")
Addresses-Coverity-ID: 1544385 ("Untrusted array index read")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8643b17866f8..c1d1e9ec08db 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -554,7 +554,7 @@ const struct rtw89_mfw_hdr *rtw89_mfw_get_hdr_ptr(struct rtw89_dev *rtwdev,
 	if (sizeof(*mfw_hdr) > firmware->size)
 		return NULL;
 
-	mfw_hdr = (const struct rtw89_mfw_hdr *)firmware->data;
+	mfw_hdr = (const struct rtw89_mfw_hdr *)&firmware->data[0];
 
 	if (mfw_hdr->sig != RTW89_MFW_SIG)
 		return NULL;
-- 
2.25.1


