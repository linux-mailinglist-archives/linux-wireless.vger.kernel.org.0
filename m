Return-Path: <linux-wireless+bounces-28386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB8DC1CE4B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 20:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C41888DD4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36635BDA8;
	Wed, 29 Oct 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ZFQNmgMV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C614359FB7;
	Wed, 29 Oct 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764589; cv=none; b=Rok9a1LH5pIPyLqIdbq8igVTXbYe8AFgaRp+wQ2zdx8310oi4AohHGaCv1snn9k4wFxmW428QrxcT2aIPOIiqpImFUgdO4LQOz0WycgUGf+pDnhG6Pj5jxGHmaj/3CjzZqFMfNiRQT5i/RH0GG6OZGLdmNtMTkCdBL+jsCh4GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764589; c=relaxed/simple;
	bh=8dIjjojbITvqNbsg3XwjMkl/uvpHaxTiczOpOe5mnTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjIjdDoOD6Sw5jNZ4Q4dogBh+OgMMq9v3PQ6bYY3kARYEvifQnVLedRWsQ22Q3VIKt1XsXl4B62lOhggPA5mP/1RtUuL7XFZi5g8Voq2mPJFrZKOS6r0fioJtVjnuWvL3ZsOyMAxsuSDxmUNN1U4FO5QGcD7vjQLpCVEkjUUJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ZFQNmgMV; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id 0CFF740777B7;
	Wed, 29 Oct 2025 19:03:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0CFF740777B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761764582;
	bh=BWZ2dTTCVzN7XXif7Kg6X0B6A96hrFAgIhH5o4emZ7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFQNmgMVjP9By+1F07/iUYMl6nMsfN3sniibjMVt1tdNnDhk7wQmvtQUemMYGGJgt
	 bMxhG0njH0L3UVfME78bOBhWR31OMZaqi3GPm0a+dvAorF2JV/X4BTYIenVvi22zyt
	 S0cz+mqOiCMKbSIic6nGPW8zfHoiW6DhmMcExt8Y=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v4 09/10] wifi: rtw89: provide TX reports for management frames
Date: Wed, 29 Oct 2025 22:02:37 +0300
Message-ID: <20251029190241.1023856-10-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029190241.1023856-1-pchelkin@ispras.ru>
References: <20251029190241.1023856-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to provide TX reports for the management queue rtw89 should
configure the firmware.  Do this with SET_CMC_TBL_MGQ_RPT_EN() for the
WiFi6 chips and with CCTLINFO_G7_W0_MGQ_RPT_EN flag for the WiFi7 ones.

Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cb431c8a65ac..96f0463e66d6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3165,6 +3165,7 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 		SET_CMC_TBL_ANTSEL_C(skb->data, 0);
 		SET_CMC_TBL_ANTSEL_D(skb->data, 0);
 	}
+	SET_CMC_TBL_MGQ_RPT_EN(skb->data, rtwdev->hci.tx_rpt_enabled);
 	SET_CMC_TBL_DOPPLER_CTRL(skb->data, 0);
 	SET_CMC_TBL_TXPWR_TOLERENCE(skb->data, 0);
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE)
@@ -3210,7 +3211,8 @@ int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 	h2c->c0 = le32_encode_bits(mac_id, CCTLINFO_G7_C0_MACID) |
 		  le32_encode_bits(1, CCTLINFO_G7_C0_OP);
 
-	h2c->w0 = le32_encode_bits(4, CCTLINFO_G7_W0_DATARATE);
+	h2c->w0 = le32_encode_bits(4, CCTLINFO_G7_W0_DATARATE) |
+		  le32_encode_bits(rtwdev->hci.tx_rpt_enabled, CCTLINFO_G7_W0_MGQ_RPT_EN);
 	h2c->m0 = cpu_to_le32(CCTLINFO_G7_W0_ALL);
 
 	h2c->w1 = le32_encode_bits(4, CCTLINFO_G7_W1_DATA_RTY_LOWEST_RATE) |
-- 
2.51.0


