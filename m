Return-Path: <linux-wireless+bounces-14446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F4C9ADBB3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 07:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B031C20DCC
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 05:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA3172BCC;
	Thu, 24 Oct 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b2pR0Rcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07A16E863
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749334; cv=none; b=Cnnu8f9v/EJjDpDvMfWaHPD41K6lBrjjlDAmC5wO/xjlCnDkHfmGEEIGZ/3AaCwN4mZSjvNzUqz5skVW9bLi+/d20Qp67NqeyOBTNO3hpYM4esgV95A08ORvxzd4CU/IssG3yCCj4FDVGZr0/m2hSYeTSq4bpgQ6XZ8OeaEQicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749334; c=relaxed/simple;
	bh=CCBRDFXutuev2qInNUYfI/JeR+PjGsz8CmqCAoEjrsg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bc/fviH1CehwRC2oguuibYwOzXqymsBXM/kEvXN+YOjAXV0jRxqYfdkBf7/PyqGiJbxfERCaVyE8CUQx+zY3gy0gKm/dC9JZoPmWL2SYDk0JcQmvkryrIVk9F8e5zmrLzRzFi/7SjWygDknuQJ5LhWvhs+unBvO8TWh0bpZQSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b2pR0Rcu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49O5tRlaD2704397, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729749327; bh=CCBRDFXutuev2qInNUYfI/JeR+PjGsz8CmqCAoEjrsg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=b2pR0RcuKlzeiYtfUHmfaL5OLMNQzl9voD+kFUgk/9n/toeDMIFsDEFlnKcyXSoyc
	 OfMotDvKWfhk112REwwgMrpyHLRr/oFR2eSYpP+3hNcAbuhPpdkqYz90tdZbEqW8R/
	 kTI1a0hufvkSv6VS4dCr/LcgN6WGsX9Hng3KOGIKJuMi8GkVAtVJ/HX0c62eEgXbk4
	 HHdiGiwHGJG5NKAykrXo1AtqcjuS9h8aZ9cNvowVylrkjI11qqh1svdoosUYfYEge5
	 kBFlhtARIPJY1kj++dmaCeG2BsOM/ox43qXQ9ZA6sS1xvLK/gizHtg3nTpnlBOFYhy
	 2fcM5n2+J2/LQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49O5tRlaD2704397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 13:55:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 13:55:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 24 Oct
 2024 13:55:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH] wifi: rtw89: don't check done-ack for entering PS
Date: Thu, 24 Oct 2024 13:55:09 +0800
Message-ID: <20241024055509.8000-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

In WoWLAN mode, driver will disable interrupt after calling H2C command
for entering PS mode, but it may lead to failing to enter deep PS mode by
firmware because the done-ack of the H2C from firmware is not handled by
driver. In fact, the done-ack for entering PS is not necessary for driver
to check, so remove it.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 744a8d277cfc..96ec2672f765 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2508,7 +2508,7 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_PS,
-			      H2C_FUNC_MAC_LPS_PARM, 0, 1,
+			      H2C_FUNC_MAC_LPS_PARM, 0, !lps_param->psmode,
 			      H2C_LPS_PARM_LEN);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
-- 
2.25.1


