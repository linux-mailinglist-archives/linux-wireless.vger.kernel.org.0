Return-Path: <linux-wireless+bounces-12529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC196D7D9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C8A1F223B5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FDF199EA2;
	Thu,  5 Sep 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="ANa+UOff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693D1991B0
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537931; cv=none; b=GS3NZpai56i1M0guOSzSwoVwWu2Mcc2lsn71YzwJq0yoNQ9Urh/5PcwpPLP9HbLxNQKfEjMRunR7dxLPDyIy0qmzNlwopSpNE3yKmdW7Kr/Wuq7JFYmVZ1H0kBZUZsHblXZX+T2tL6naepKmDoH1Z8jstHpaIJ5DCaHkJe8ZIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537931; c=relaxed/simple;
	bh=OT6rQ4ajoJhbQLwuHd0zXwykg9wjWRnN6xyDbWW7zUI=;
	h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type; b=Q5op7frAOA4jdDMHfGsJ/TaM8CjR3p48vjamNoaSqHz3U7L0HCMxJOg3ilkicbVpDknNysuo5z5CMD99TjyV7CxmBUU/PybTLlEAsm+3OeDdp/bi26dguavLajQq9PCD/vWuDYQT/0/hN1idAnKXos7SjCqFQsvFNUSroLXfWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=ANa+UOff; arc=none smtp.client-ip=77.75.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-7df5484c66-k4bzx
	(smtpc-mxe-7df5484c66-k4bzx [2a02:598:64:8a00::1000:ad2])
	id 76a754988853e6327629da80;
	Thu, 05 Sep 2024 14:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1725537925;
	bh=2Gu2NyeDCYj06j54dTeLW+R2cmUPtkfhps4/Gm0KUr8=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=ANa+UOffxyhHplIrYttAPAHBrHS7j9wentL5+8ZbGZ0PytDdLHDdq0HeIi8ISFNYo
	 HNcLDqgtDKP2LriifMVaxqIJ/96THV5RMab7e1X/B1E0Lr7Urn0xVZBHGYL0HcbO0J
	 wl6kgpcNJbhcyNm3cC4l7xLIKprpHzHjyqyw6PiAQ1ryyDJX06WlKB8ShhxUqVtoaO
	 LTDjPw6XESAD9NaEra6qjKyFzfpCdFQ3YNCUoo1wBE0PrdyviI1X8EJcruRLdvulLv
	 gZLhVaCQH7JsGKPhEQ8ssgLfpAffrYrHfpkyWvtdHCpnIpwxs1o+i9guOsdrnNC9VD
	 qdPKUnkvNcoaA==
Received: from 215-143.ktuo.cz (215-143.ktuo.cz [82.144.143.215])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Thu, 05 Sep 2024 14:03:35 +0200 (CEST)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <ath10k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: ath10k: add hw_params for Atheros QCA9377-7 
Date: Thu, 05 Sep 2024 14:03:35 +0200 (CEST)
Message-Id: <5b0.ZbQt.6HOR0C2EfXi.1csPuN@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add hw_params for modules based on Atheros QCA9377-7 chipset like
8devices BLUE bean or SparkLAN WUBQ-159ACN.

Tested-on: QCA9377 hw1.1 USB 0.0.0.111

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/wireless/ath/ath10k/core.c | 42 +++++++++++++++++++++++++++++=
+++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless=
/ath/ath10k/core.c
index b329428..e2ababf 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -629,6 +629,48 @@ static const struct ath10k_hw_params ath10k_hw_params=
_list[] =3D {
 	},
 	{
 		.id =3D QCA9377_HW_1_1_DEV_VERSION,
+		.dev_id =3D 0x9378,
+		.bus =3D ATH10K_BUS_USB,
+		.name =3D "qca9377 hw1.1 usb",
+		.patch_load_addr =3D QCA9377_HW_1_0_PATCH_LOAD_ADDR,
+		.uart_pin =3D 6,
+		.otp_exe_param =3D 0,
+		.channel_counters_freq_hz =3D 88000,
+		.max_probe_resp_desc_thres =3D 0,
+		.cal_data_len =3D 8124,
+		.fw =3D {
+			.dir =3D QCA9377_HW_1_0_FW_DIR,
+			.board_size =3D QCA9377_BOARD_DATA_SZ,
+			.board_ext_size =3D QCA9377_BOARD_EXT_DATA_SZ,
+		},
+		.rx_desc_ops =3D &qca988x_rx_desc_ops,
+		.hw_ops =3D &qca6174_ops,
+		.hw_clk =3D qca6174_clk,
+		.target_cpu_freq =3D 176000000,
+		.decap_align_bytes =3D 4,
+		.spectral_bin_discard =3D 0,
+		.spectral_bin_offset =3D 0,
+		.vht160_mcs_rx_highest =3D 0,
+		.vht160_mcs_tx_highest =3D 0,
+		.n_cipher_suites =3D 8,
+		.ast_skid_limit =3D 0x10,
+		.num_wds_entries =3D 0x20,
+		.target_64bit =3D false,
+		.rx_ring_fill_level =3D HTT_RX_RING_FILL_LEVEL,
+		.shadow_reg_support =3D false,
+		.rri_on_ddr =3D false,
+		.hw_filter_reset_required =3D true,
+		.fw_diag_ce_download =3D false,
+		.credit_size_workaround =3D false,
+		.tx_stats_over_pktlog =3D false,
+		.dynamic_sar_support =3D false,
+		.hw_restart_disconnect =3D false,
+		.use_fw_tx_credits =3D true,
+		.delay_unmap_buffer =3D false,
+		.mcast_frame_registration =3D false,
+	},
+	{
+		.id =3D QCA9377_HW_1_1_DEV_VERSION,
 		.dev_id =3D QCA9377_1_0_DEVICE_ID,
 		.bus =3D ATH10K_BUS_SDIO,
 		.name =3D "qca9377 hw1.1 sdio",
-- 
2.7.4
 

