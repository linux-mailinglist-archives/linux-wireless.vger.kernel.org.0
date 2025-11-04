Return-Path: <linux-wireless+bounces-28544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7091C315C2
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 15:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9FF3A53C8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52D32E746;
	Tue,  4 Nov 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="i0GiTl4G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938032D44A;
	Tue,  4 Nov 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264678; cv=none; b=q/IYooqCwZvVD0Mk8b1f9/ZocX4HQ4FPgxjkAmXVnXZE1O4oFM7ZB/ZQDboLJ/EIP0PVDLR8VZXYprG78pwU3gbjlVoVtwn3qv7eqMr9gm/fk7R3LwO/LzgiwOo48wge8lyTdKMzvzjhTfm6szDzzepRuMvyRgjlxdzhSvfr6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264678; c=relaxed/simple;
	bh=qp17x1MPqZ0wxlNvNe6T5FJxPuQqe8fHCO5RMRZzptg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibqg17jZxiirwcPYrgA5/R0vMug8Upv+NbudXNggDD+7hQDVrE9DVkn9zVsIplFQIgNsbFpX6+/DnurWaOsE4PuZ5u+EYV4lw38U2SwPZUod50P6gxNnZlfmZnOa0+WMOaZ3+8QjexsZRpivkEElxddR19T0L7KO9jstN40PUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=i0GiTl4G; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 18A5B40777C4;
	Tue,  4 Nov 2025 13:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 18A5B40777C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1762264667;
	bh=V4Vuj+zJPtAWkvwEPqdg75ZMEdwyOAKWEUHk1Aeh8pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0GiTl4GQP1BGqVjDYk3LxEkJZ++tPIljWbiqcKjwRmkYj+Ca4XMkFhlTYpHNcLD7
	 9RtcBdp8SMOgR+NulEkT9+KH910GgOlu78t/5jVcHV8CQx8zKDr5JS1U2xQ6h4RR8s
	 ojbdE82dWi+9tdCXLagHBC4sjS/1wh9S4aWuwlWg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v5 09/10] wifi: rtw89: provide TX reports for management frames
Date: Tue,  4 Nov 2025 16:57:16 +0300
Message-ID: <20251104135720.321110-10-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104135720.321110-1-pchelkin@ispras.ru>
References: <20251104135720.321110-1-pchelkin@ispras.ru>
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
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


