Return-Path: <linux-wireless+bounces-28027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DEBE7F32
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 12:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77216203DA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5BB3148B5;
	Fri, 17 Oct 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="o5cPJA9S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3CD3128D4;
	Fri, 17 Oct 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695639; cv=none; b=I2n2WFtnb/qsekSRfLnPgtIze/FyDfsfSXc3cLZHS1tO0+iV6wePTUJc0zyOSKA299JQ86uOpZoHiBlm9nA4aW2W+fA7RN/v0mdzMTplXweo4fOqZS1k3I+y0ckasOBiFIONPziVCJNUvfFrYN6KHN+UwK/+iMzyskOeLihlm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695639; c=relaxed/simple;
	bh=vUn97d2g8RzAVqqHZDuoX7eYiMpWWzSFICqEMcJvMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjkqGOrgC6y7EGhr7+kemRe24IZn5bmSUAnqwr0dVc3uY0RYyDzqcqBe2s7v5Wk2Ws8lHwsZ28JE4IN581Xm4omb+Cab38chS39OSRB1SPpruAYdRXWzxY+4WbzJu/YFjgSq2gGWy7GEuYnGho1uB0ipVnc/IjNURbmZfVyDb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=o5cPJA9S; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9828940769AC;
	Fri, 17 Oct 2025 10:07:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9828940769AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760695634;
	bh=cLwC6KEdZVjQ1j3MLbv6y+97lIVyoQ7PmgfY9MHkmbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5cPJA9SV3zyP+Ti8Ekwg+PpBgJR47c3h7yCHBOuM5e3dck8CADVT6MkJpcB6ur54
	 E/p8JBY0noTJ1Jvz0kpswL+E5SKaFAcLGEaoLHOHQprjGL6v2riMytSqVeyhC1jJ5W
	 j5VmJhc6R3lW8B3HikiRnrSxRfBxlBjoFy0GjHgo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v3 8/9] wifi: rtw89: provide TX reports for management frames
Date: Fri, 17 Oct 2025 13:03:10 +0300
Message-ID: <20251017100658.66581-9-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017100658.66581-1-pchelkin@ispras.ru>
References: <20251017100658.66581-1-pchelkin@ispras.ru>
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
---
 drivers/net/wireless/realtek/rtw89/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ab904a7def1b..0d4438bf8dcc 100644
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


