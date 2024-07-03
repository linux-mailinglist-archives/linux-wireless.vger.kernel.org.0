Return-Path: <linux-wireless+bounces-9939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C299269FA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CF41C217C6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474CA191F67;
	Wed,  3 Jul 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="SgwMLzSP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB8910A1F;
	Wed,  3 Jul 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040813; cv=none; b=c/OgXtBt/9u1FHmAQTfjGhochSaEUKshhJszTUJ3w5spaTi2MTJ8M9B43FPUiMmleAVU8B6cAGbM7RO832V4JyC4Ou8D8+UW0mNWm6DbAALdlcHW7juMIBrFPrWZzI/RC0aTtPcKZaGrhVTDaFDo7xTLC50Ss/TQSrImNC2xC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040813; c=relaxed/simple;
	bh=aBMF9TJOLqRgEZNLiLN6FqrIxcoLArQSHFHOYMLW184=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nunLS2c2qEJYGLZ8sca2H7WrwU/GMxy3QR1XaxBj+9sNHuXjkEt9ZinqNUXBag/4GbT21YiSWInX/JKrzZsybZH3zbrYfZNc8cmaSqlHqhak2E0rJ3ufAzkOKHymUUBYYrMl4M2cA8gJLaBRo0CTbFzwloDy+Ve/zOpRNTU/X6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=SgwMLzSP; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 25397100004;
	Thu,  4 Jul 2024 00:06:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720040786; bh=9NdbJlOR9wA4uPP318E3ElFRE/DKjRVXR3x3igjbmGE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=SgwMLzSPVxTIgczuT3Ui7ZxN/pIeCfGv89e7dfcGDwv8b2DIDJ1CJ93vc5aOpdguP
	 qoqhQG0njnxQj1Vq8wdUdkEzP/Bcy6GQQxvc/mjmXXWNZN5iaXxJJqSODSKCgIJ0gT
	 Dx3kJ1H0Pz96yRn/wsCTFLySviHvdb1sIgpHM2TIiKCWdn0ecaKxT4Ld3syEPl6l7h
	 n7zBWVMZUOnp+VUwY/C4iHEoGbRvOf+kW63nxjEvfXJ/VS+6gnIR2qbhz1O1Kyy/yT
	 EIH5kz0hJLrSGVvp94DZcGL43Z8W1qGiKWDAWz8Ac3dTA7dBI5R7KElOHmyobLNyal
	 bjbIiYjZVQvKw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Thu,  4 Jul 2024 00:05:52 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 4 Jul 2024
 00:05:32 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Kalle Valo <kvalo@kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()
Date: Thu, 4 Jul 2024 00:05:10 +0300
Message-ID: <20240703210510.11089-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186316 [Jul 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/03 19:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/03 19:54:00 #25833822
X-KSMG-AntiVirus-Status: Clean, skipped

In rtw89_sta_info_get_iter() 'status->he_gi' is compared to array size.
But then 'rate->he_gi' is used as array index instead of 'status->he_gi'.
This can lead to go beyond array boundaries in case of 'rate->he_gi' is
not equal to 'status->he_gi' and is bigger than array size. Looks like
"copy-paste" mistake.

Fix this mistake by replacing 'rate->he_gi' with 'status->he_gi'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index affffc4092ba..5b4077c9fd28 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3531,7 +3531,7 @@ static void rtw89_sta_info_get_iter(void *data, struct ieee80211_sta *sta)
 	case RX_ENC_HE:
 		seq_printf(m, "HE %dSS MCS-%d GI:%s", status->nss, status->rate_idx,
 			   status->he_gi <= NL80211_RATE_INFO_HE_GI_3_2 ?
-			   he_gi_str[rate->he_gi] : "N/A");
+			   he_gi_str[status->he_gi] : "N/A");
 		break;
 	case RX_ENC_EHT:
 		seq_printf(m, "EHT %dSS MCS-%d GI:%s", status->nss, status->rate_idx,
-- 
2.30.2


