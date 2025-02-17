Return-Path: <linux-wireless+bounces-19047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D4A37BA4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3703A79D1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848B18F2C3;
	Mon, 17 Feb 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qfBbk76o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00A18DB3A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774654; cv=none; b=eV5coaw7SBnmOzPVNNP2mcEH5KgvNnaX5Az5/bGZytBD70szvRfzWPT3iS6cIpjhO3Opo4sNIjECRpSznnI3RF5rhzTQ/mdRyE4B0h5ivbDhe7pY3WDJ8sNe5MJXpAjcAB3Bf18hGignz896uxzeGyBGfwjRIwVtS/SPkwZgcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774654; c=relaxed/simple;
	bh=AK6yU/v+ak5QYi8qA1gg9We545yBpYD6ZFfM15pMCk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BL39ZRsgmAa9HjaOfek/2LXNJwmybPl3jJwV59OiiwpV785ttPyXlfoTuOd/FxtV2ltGekl6ScBcluLrcAhXepTai5VOAIYuNpY6bg7a5tfOZqDWQmSsPz7zNT5gMm5xlX1/TCjmPb8JT/jUiErXT7GDo1NTB0/Nfnl5QZVLItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qfBbk76o; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6iAvT52646847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739774650; bh=AK6yU/v+ak5QYi8qA1gg9We545yBpYD6ZFfM15pMCk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qfBbk76omhkJ64fGiKdEE0Ui+BFGhLIGW/jb1ABaoQX6NS77I9EeVfDIwsOFTmjK2
	 IVp3q3xVLv2uC1C/CLCQBI4k5vVhmc7DJoioYVjig7BMWQzlGuZs6JnO9mX4n8uF4R
	 1qRBYq+TTKa2v6LnOn4kdQyj3bleDusB3oHM1QHYp9BfuRaNHoq5H0dYM8xs0ENXHI
	 dbaHM6YEigKvO8FjRpMeGdALuESv9hd5A//Pj3Uftq9FAlHMPlNxx8w/pYeHrCIuIB
	 OjAa3kJqzTHYtHvHteX4kLLWdU1KWlu85MZ/5B+Sd7nvSWBuFTuqy4NLtUj/CE2UnZ
	 ChQe0GACXwWLQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6iAvT52646847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:44:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:44:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:44:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: fw: add debug message for unexpected secure firmware
Date: Mon, 17 Feb 2025 14:43:07 +0800
Message-ID: <20250217064308.43559-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217064308.43559-1-pkshih@realtek.com>
References: <20250217064308.43559-1-pkshih@realtek.com>
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

If failed to load a non-secure firmware with a secure chip, it only throws
a unclear message:

   rtw89_8922ae 0000:03:00.0: parse fw header fail

To address this case simpler, add a message to point out this.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d9efe14fc687..abbf406a202d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -414,8 +414,11 @@ static int __parse_security_section(struct rtw89_dev *rtwdev,
 			*mssc_len += section_info->mssc * FWDL_SECURITY_CHKSUM_LEN;
 
 		if (sec->secure_boot) {
-			if (sec->mss_idx >= section_info->mssc)
+			if (sec->mss_idx >= section_info->mssc) {
+				rtw89_err(rtwdev, "unexpected MSS %d >= %d\n",
+					  sec->mss_idx, section_info->mssc);
 				return -EFAULT;
+			}
 			section_info->key_addr = content + section_info->len +
 						 sec->mss_idx * FWDL_SECURITY_SIGLEN;
 			section_info->key_len = FWDL_SECURITY_SIGLEN;
-- 
2.25.1


