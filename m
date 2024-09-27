Return-Path: <linux-wireless+bounces-13247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91286987C9C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 03:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3128C1F23B66
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE4D53C;
	Fri, 27 Sep 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uNOHzsvS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D379C8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400955; cv=none; b=LLFjvHh32tKFK3Ohd+W0FRFS+icllwa8F8e5/RhWvWA2z25kkLhK8H6OGRPPqf5ovVYiC3iCI5MmGgmGLrXC5S2Xr4s9OaydYeQOLdDin8BfdWIPjFQ1VVPmFL7bnVq53GdHX3Sf3GMADqUli2zC+Omo6dnDHeohlq5uMlyv6e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400955; c=relaxed/simple;
	bh=+cNeGKXCiogHP3LzLZYhAeUbYrtn3+L1gHJN04IWpXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lBRKSqfxNptoskTyUPwXmYrkeDgwIrV3K3LN4MHhHLBp0e2i0TCTcfBGrtSwm2OeiTZjhpaswBVp6af+dHw3tGqIa4d4Rvao3gwsb0Zl+tYw/Pe54h5dTnbBWQY/YD/n8v3Rn5t3kwjJ7fu+aGHE60AAYOb/j+Qe9Bo/CGrUmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uNOHzsvS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48R1Zp8V22827274, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727400951; bh=+cNeGKXCiogHP3LzLZYhAeUbYrtn3+L1gHJN04IWpXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=uNOHzsvSL3XyhcJOH4h51NHZcBnTSjrIngnM+rRuc9cwMWKpKuh34BmF6NGmWFzTD
	 liUw+iXtwi+h2c9SSH4dA2iAW81ZrMYOxOlt4Fo+FEhR2M0be0ioMhW4yL2O6KoWf/
	 gLagigoeDlNezGvUH2d1/PRbx+JI41H9N/HlZ/natef8P521Jw9u+GAlBb35msrfFv
	 jXfPh+G/NAJ2+a5mM+LEElrCH48ad6tr04B2OV40FHwj7o+GgORa2mEOfFZHwGNOuw
	 TSL1YV56gYbVS3hdoqp+naKkNKN8Rt6bZV1dbgNtLSKWKuy6iJqDBWs/xSZ+VYqNVM
	 2y4sKJR9CtXqA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48R1Zp8V22827274
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 09:35:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 09:35:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 27 Sep
 2024 09:35:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: debug: add beacon RSSI for debugging
Date: Fri, 27 Sep 2024 09:35:12 +0800
Message-ID: <20240927013512.7106-1-pkshih@realtek.com>
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

In range test, the RSSI is helpful to check attenuation of cable and align
difference between environments. Since data packets can be transmitted with
different rate and power, the RSSI of all packets can be variant.
Oppositely beacon is transmitted with the same rate and power, so beacon
RSSI will be relatively invariant, and more helpful to diagnose problems.

The output of beacon RSSI in unit of dBm looks like:

  Beacon: 19 (-33 dBm), TF: 0

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 3 +++
 drivers/net/wireless/realtek/rtw89/core.h  | 1 +
 drivers/net/wireless/realtek/rtw89/debug.c | 7 +++++--
 drivers/net/wireless/realtek/rtw89/phy.c   | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5b8e65f6de6a..5d08c39a5bbb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2109,6 +2109,9 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 			rtw89_fw_h2c_rssi_offload(rtwdev, phy_ppdu);
 		}
 		pkt_stat->beacon_nr++;
+
+		if (phy_ppdu)
+			ewma_rssi_add(&rtwdev->phystat.bcn_rssi, phy_ppdu->rssi_avg);
 	}
 
 	if (!ether_addr_equal(bss_conf->addr, hdr->addr1))
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ac9f9d33436c..8e4b8964e912 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4747,6 +4747,7 @@ DECLARE_EWMA(thermal, 4, 4);
 
 struct rtw89_phy_stat {
 	struct ewma_thermal avg_thermal[RF_PATH_MAX];
+	struct ewma_rssi bcn_rssi;
 	struct rtw89_pkt_stat cur_pkt_stat;
 	struct rtw89_pkt_stat last_pkt_stat;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 7391f131229a..74b0c722a5b8 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3673,13 +3673,16 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rx_rate_cnt_info *info;
 	enum rtw89_hw_rate first_rate;
+	u8 rssi;
 	int i;
 
+	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
+
 	seq_printf(m, "TP TX: %u [%u] Mbps (lv: %d), RX: %u [%u] Mbps (lv: %d)\n",
 		   stats->tx_throughput, stats->tx_throughput_raw, stats->tx_tfc_lv,
 		   stats->rx_throughput, stats->rx_throughput_raw, stats->rx_tfc_lv);
-	seq_printf(m, "Beacon: %u, TF: %u\n", pkt_stat->beacon_nr,
-		   stats->rx_tf_periodic);
+	seq_printf(m, "Beacon: %u (%d dBm), TF: %u\n", pkt_stat->beacon_nr,
+		   RTW89_RSSI_RAW_TO_DBM(rssi), stats->rx_tf_periodic);
 	seq_printf(m, "Avg packet length: TX=%u, RX=%u\n", stats->tx_avg_len,
 		   stats->rx_avg_len);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 1527b08e0c92..1505dce2b313 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4894,6 +4894,8 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 
 	memset(&phystat->cur_pkt_stat, 0, sizeof(phystat->cur_pkt_stat));
 	memset(&phystat->last_pkt_stat, 0, sizeof(phystat->last_pkt_stat));
+
+	ewma_rssi_init(&phystat->bcn_rssi);
 }
 
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
-- 
2.25.1


