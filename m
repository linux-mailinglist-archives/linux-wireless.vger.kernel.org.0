Return-Path: <linux-wireless+bounces-27409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 599C8B7E005
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593B01C07475
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785271F460B;
	Tue, 16 Sep 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Hc6aQFeB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056517BEBF
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061851; cv=none; b=NCJqOZUO1H6JjzxsSPLHJv39h6RUQciBTYC4lU6vhjn7Anet5wWkgdvTGh3dR282MvxUh3mCirvf4h3kWX/CTq8TdlgguFP/b8LbwfFiNKTC5IF7qD7k/7RFVfXM2uGolYWIAnRc25pGoav0v44EdISUcSJmhC5Izx7Vtxof408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061851; c=relaxed/simple;
	bh=rwLlzImAOLygQ1PKlAqqnmff8boB8pMApd9kOP7tTqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYKHAUlp9iLW/+KzHmzXQXQENCDV14TjgcuTHxI3u/lxlPObgQg4sN/J2gTE0v9ZeNxqG+ACyew9i2wc2cXZyizArGPSI0UAJIPXLuG5wrAMYHqL4SputPiTFg26k6pmAvcDZDKk8XKF2m/v2HHgzqJcPvxZwxGv3loI4VRy/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Hc6aQFeB; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061849; x=1789597849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwLlzImAOLygQ1PKlAqqnmff8boB8pMApd9kOP7tTqk=;
  b=Hc6aQFeBum/wVBS3+GDrFy1DTGtYEVz/mAjLnX0/HNiQ5u/GpOZLVeiy
   vTivLutv9aSfFp08N8xhkqKAO05X/mXIYsqYtX5+m4fgJVYz8288i0OEs
   bFqySgY6zgOvx51s5r5EtUaQkJxVPvMUOszNgTw65YGyyvKElkHHTtFLC
   g=;
X-CSE-ConnectionGUID: hlbUKc7sQvWLEEd3gN/ByQ==
X-CSE-MsgGUID: 9puWreEySDmqZx/+Izv/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294381"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294381"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:30:47 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:30:46 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:30:43 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 54/57] wifi: inffmac: add chanspec.c/h
Date: Wed, 17 Sep 2025 03:48:14 +0530
Message-ID: <20250916221821.4387-60-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE821.infineon.com (172.23.29.47) To
 MUCSE827.infineon.com (172.23.29.20)

Common definitions of the wifi chanspec specific structures and MACROs.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/chanspec.c  | 260 +++++++++++++
 .../net/wireless/infineon/inffmac/chanspec.h  | 357 ++++++++++++++++++
 2 files changed, 617 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chanspec.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chanspec.h

diff --git a/drivers/net/wireless/infineon/inffmac/chanspec.c b/drivers/net/wireless/infineon/inffmac/chanspec.c
new file mode 100644
index 000000000000..7bf5a09c2530
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chanspec.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/module.h>
+
+#include "utils.h"
+#include "chanspec.h"
+
+static u16 d11n_sb(enum inff_chan_sb sb)
+{
+	switch (sb) {
+	case INFF_CHAN_SB_NONE:
+		return INFF_CHSPEC_D11N_SB_N;
+	case INFF_CHAN_SB_L:
+		return INFF_CHSPEC_D11N_SB_L;
+	case INFF_CHAN_SB_U:
+		return INFF_CHSPEC_D11N_SB_U;
+	default:
+		WARN_ON(1);
+	}
+	return 0;
+}
+
+static u16 d11n_bw(enum inff_chan_bw bw)
+{
+	switch (bw) {
+	case INFF_CHAN_BW_20:
+		return INFF_CHSPEC_D11N_BW_20;
+	case INFF_CHAN_BW_40:
+		return INFF_CHSPEC_D11N_BW_40;
+	default:
+		WARN_ON(1);
+	}
+	return 0;
+}
+
+static void inff_d11n_encchspec(struct inff_chan *ch)
+{
+	if (ch->bw == INFF_CHAN_BW_20)
+		ch->sb = INFF_CHAN_SB_NONE;
+
+	ch->chspec = 0;
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_CH_MASK,
+		       INFF_CHSPEC_CH_SHIFT, ch->chnum);
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_D11N_SB_MASK,
+		       0, d11n_sb(ch->sb));
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_D11N_BW_MASK,
+		       0, d11n_bw(ch->bw));
+
+	if (ch->chnum <= CH_MAX_2G_CHANNEL)
+		ch->chspec |= INFF_CHSPEC_D11N_BND_2G;
+	else
+		ch->chspec |= INFF_CHSPEC_D11N_BND_5G;
+}
+
+static u16 d11ac_bw(enum inff_chan_bw bw)
+{
+	switch (bw) {
+	case INFF_CHAN_BW_20:
+		return INFF_CHSPEC_D11AC_BW_20;
+	case INFF_CHAN_BW_40:
+		return INFF_CHSPEC_D11AC_BW_40;
+	case INFF_CHAN_BW_80:
+		return INFF_CHSPEC_D11AC_BW_80;
+	case INFF_CHAN_BW_160:
+		return INFF_CHSPEC_D11AC_BW_160;
+	default:
+		WARN_ON(1);
+	}
+	return 0;
+}
+
+static void inff_d11ac_encchspec(struct inff_chan *ch)
+{
+	if (ch->bw == INFF_CHAN_BW_20 || ch->sb == INFF_CHAN_SB_NONE)
+		ch->sb = INFF_CHAN_SB_L;
+
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_CH_MASK,
+		       INFF_CHSPEC_CH_SHIFT, ch->chnum);
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_D11AC_SB_MASK,
+		       INFF_CHSPEC_D11AC_SB_SHIFT, ch->sb);
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_D11AC_BW_MASK,
+		       0, d11ac_bw(ch->bw));
+
+	ch->chspec &= ~INFF_CHSPEC_D11AC_BND_MASK;
+	switch (ch->band) {
+	case INFF_CHAN_BAND_6G:
+		ch->chspec |= INFF_CHSPEC_D11AC_BND_6G;
+		break;
+	case INFF_CHAN_BAND_5G:
+		ch->chspec |= INFF_CHSPEC_D11AC_BND_5G;
+		break;
+	case INFF_CHAN_BAND_2G:
+		ch->chspec |= INFF_CHSPEC_D11AC_BND_2G;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid band 0x%04x\n", ch->band);
+		break;
+	}
+}
+
+static void inff_d11n_decchspec(struct inff_chan *ch)
+{
+	u16 val;
+
+	ch->chnum = (u8)(ch->chspec & INFF_CHSPEC_CH_MASK);
+	ch->control_ch_num = ch->chnum;
+
+	switch (ch->chspec & INFF_CHSPEC_D11N_BW_MASK) {
+	case INFF_CHSPEC_D11N_BW_20:
+		ch->bw = INFF_CHAN_BW_20;
+		ch->sb = INFF_CHAN_SB_NONE;
+		break;
+	case INFF_CHSPEC_D11N_BW_40:
+		ch->bw = INFF_CHAN_BW_40;
+		val = ch->chspec & INFF_CHSPEC_D11N_SB_MASK;
+		if (val == INFF_CHSPEC_D11N_SB_L) {
+			ch->sb = INFF_CHAN_SB_L;
+			ch->control_ch_num -= CH_10MHZ_APART;
+		} else {
+			ch->sb = INFF_CHAN_SB_U;
+			ch->control_ch_num += CH_10MHZ_APART;
+		}
+		break;
+	default:
+		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		break;
+	}
+
+	switch (ch->chspec & INFF_CHSPEC_D11N_BND_MASK) {
+	case INFF_CHSPEC_D11N_BND_5G:
+		ch->band = INFF_CHAN_BAND_5G;
+		break;
+	case INFF_CHSPEC_D11N_BND_2G:
+		ch->band = INFF_CHAN_BAND_2G;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		break;
+	}
+}
+
+static void inff_d11ac_decchspec(struct inff_chan *ch)
+{
+	u16 val;
+
+	ch->chnum = (u8)(ch->chspec & INFF_CHSPEC_CH_MASK);
+	ch->control_ch_num = ch->chnum;
+
+	switch (ch->chspec & INFF_CHSPEC_D11AC_BW_MASK) {
+	case INFF_CHSPEC_D11AC_BW_20:
+		ch->bw = INFF_CHAN_BW_20;
+		ch->sb = INFF_CHAN_SB_NONE;
+		break;
+	case INFF_CHSPEC_D11AC_BW_40:
+		ch->bw = INFF_CHAN_BW_40;
+		val = ch->chspec & INFF_CHSPEC_D11AC_SB_MASK;
+		if (val == INFF_CHSPEC_D11AC_SB_L) {
+			ch->sb = INFF_CHAN_SB_L;
+			ch->control_ch_num -= CH_10MHZ_APART;
+		} else if (val == INFF_CHSPEC_D11AC_SB_U) {
+			ch->sb = INFF_CHAN_SB_U;
+			ch->control_ch_num += CH_10MHZ_APART;
+		} else {
+			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		}
+		break;
+	case INFF_CHSPEC_D11AC_BW_80:
+		ch->bw = INFF_CHAN_BW_80;
+		ch->sb = inff_maskget16(ch->chspec, INFF_CHSPEC_D11AC_SB_MASK,
+					INFF_CHSPEC_D11AC_SB_SHIFT);
+		switch (ch->sb) {
+		case INFF_CHAN_SB_LL:
+			ch->control_ch_num -= CH_30MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LU:
+			ch->control_ch_num -= CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UL:
+			ch->control_ch_num += CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UU:
+			ch->control_ch_num += CH_30MHZ_APART;
+			break;
+		default:
+			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+			break;
+		}
+		break;
+	case INFF_CHSPEC_D11AC_BW_160:
+		ch->bw = INFF_CHAN_BW_160;
+		ch->sb = inff_maskget16(ch->chspec, INFF_CHSPEC_D11AC_SB_MASK,
+					INFF_CHSPEC_D11AC_SB_SHIFT);
+		switch (ch->sb) {
+		case INFF_CHAN_SB_LLL:
+			ch->control_ch_num -= CH_70MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LLU:
+			ch->control_ch_num -= CH_50MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LUL:
+			ch->control_ch_num -= CH_30MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LUU:
+			ch->control_ch_num -= CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_ULL:
+			ch->control_ch_num += CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_ULU:
+			ch->control_ch_num += CH_30MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UUL:
+			ch->control_ch_num += CH_50MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UUU:
+			ch->control_ch_num += CH_70MHZ_APART;
+			break;
+		default:
+			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+			break;
+		}
+		break;
+	case INFF_CHSPEC_D11AC_BW_8080:
+	default:
+		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		break;
+	}
+
+	switch (ch->chspec & INFF_CHSPEC_D11AC_BND_MASK) {
+	case INFF_CHSPEC_D11AC_BND_6G:
+		ch->band = INFF_CHAN_BAND_6G;
+		break;
+	case INFF_CHSPEC_D11AC_BND_5G:
+		ch->band = INFF_CHAN_BAND_5G;
+		break;
+	case INFF_CHSPEC_D11AC_BND_2G:
+		ch->band = INFF_CHAN_BAND_2G;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		break;
+	}
+}
+
+void inff_d11_attach(struct inff_d11inf *d11inf)
+{
+	if (d11inf->io_type == INFF_D11N_IOTYPE) {
+		d11inf->encchspec = inff_d11n_encchspec;
+		d11inf->decchspec = inff_d11n_decchspec;
+	} else {
+		d11inf->encchspec = inff_d11ac_encchspec;
+		d11inf->decchspec = inff_d11ac_decchspec;
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/chanspec.h b/drivers/net/wireless/infineon/inffmac/chanspec.h
new file mode 100644
index 000000000000..3d62f21cc9ed
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chanspec.h
@@ -0,0 +1,357 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_WIFI_H
+#define	INFF_WIFI_H
+
+#include <linux/if_ether.h>		/* for ETH_ALEN */
+#include <linux/ieee80211.h>		/* for WLAN_PMKID_LEN */
+
+/*
+ * A chanspec (u16) holds the channel number, band, bandwidth and control
+ * sideband
+ */
+
+/* channel defines */
+#define CH_UPPER_SB			0x01
+#define CH_LOWER_SB			0x02
+#define CH_EWA_VALID			0x04
+#define CH_70MHZ_APART			14
+#define CH_50MHZ_APART			10
+#define CH_30MHZ_APART			6
+#define CH_20MHZ_APART			4
+#define CH_10MHZ_APART			2
+#define CH_5MHZ_APART			1 /* 2G band channels are 5 Mhz apart */
+#define CH_MIN_2G_CHANNEL		1
+#define CH_MAX_2G_CHANNEL		14	/* Max channel in 2G band */
+#define CH_MIN_5G_CHANNEL		34
+
+/* bandstate array indices */
+#define BAND_2G_INDEX		0	/* wlc->bandstate[x] index */
+#define BAND_5G_INDEX		1	/* wlc->bandstate[x] index */
+
+/*
+ * max # supported channels. The max channel no is 216, this is that + 1
+ * rounded up to a multiple of NBBY (8). DO NOT MAKE it > 255: channels are
+ * u8's all over
+ */
+#define	MAXCHANNEL		224
+
+#define WL_CHANSPEC_CHAN_MASK		0x00ff
+#define WL_CHANSPEC_CHAN_SHIFT		0
+
+#define WL_CHANSPEC_CTL_SB_MASK		0x0300
+#define WL_CHANSPEC_CTL_SB_SHIFT	     8
+#define WL_CHANSPEC_CTL_SB_LOWER	0x0100
+#define WL_CHANSPEC_CTL_SB_UPPER	0x0200
+#define WL_CHANSPEC_CTL_SB_NONE		0x0300
+
+#define WL_CHANSPEC_BW_MASK		0x0C00
+#define WL_CHANSPEC_BW_SHIFT		    10
+#define WL_CHANSPEC_BW_10		0x0400
+#define WL_CHANSPEC_BW_20		0x0800
+#define WL_CHANSPEC_BW_40		0x0C00
+#define WL_CHANSPEC_BW_80		0x2000
+
+#define WL_CHANSPEC_BAND_MASK		0xf000
+#define WL_CHANSPEC_BAND_SHIFT		12
+#define WL_CHANSPEC_BAND_5G		0x1000
+#define WL_CHANSPEC_BAND_2G		0x2000
+#define INVCHANSPEC			255
+
+#define WL_CHAN_VALID_HW		BIT(0) /* valid with current HW */
+#define WL_CHAN_VALID_SW		BIT(1) /* valid with country sett. */
+#define WL_CHAN_BAND_5G			BIT(2) /* 5GHz-band channel */
+#define WL_CHAN_RADAR			BIT(3) /* radar sensitive  channel */
+#define WL_CHAN_INACTIVE		BIT(4) /* inactive due to radar */
+#define WL_CHAN_PASSIVE			BIT(5) /* channel in passive mode */
+#define WL_CHAN_RESTRICTED		BIT(6) /* restricted use channel */
+
+/* values for band specific 40MHz capabilities  */
+#define WLC_N_BW_20ALL			0
+#define WLC_N_BW_40ALL			1
+#define WLC_N_BW_20IN2G_40IN5G		2
+
+#define WLC_BW_20MHZ_BIT		BIT(0)
+#define WLC_BW_40MHZ_BIT		BIT(1)
+#define WLC_BW_80MHZ_BIT		BIT(2)
+#define WLC_BW_160MHZ_BIT		BIT(3)
+
+/* Bandwidth capabilities */
+#define WLC_BW_CAP_20MHZ		(WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_40MHZ		(WLC_BW_40MHZ_BIT | WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_80MHZ		(WLC_BW_80MHZ_BIT | WLC_BW_40MHZ_BIT | \
+					 WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_160MHZ		(WLC_BW_160MHZ_BIT | WLC_BW_80MHZ_BIT | \
+					 WLC_BW_40MHZ_BIT | WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_UNRESTRICTED		0xFF
+
+/* band types */
+#define	WLC_BAND_AUTO			0	/* auto-select */
+#define	WLC_BAND_5G			1	/* 5 Ghz */
+#define	WLC_BAND_2G			2	/* 2.4 Ghz */
+#define	WLC_BAND_6G			3	/* 6 Ghz */
+#define	WLC_BAND_ALL			4	/* all bands */
+
+#define CHSPEC_CHANNEL(chspec)	((u8)((chspec) & WL_CHANSPEC_CHAN_MASK))
+#define CHSPEC_BAND(chspec)	((chspec) & WL_CHANSPEC_BAND_MASK)
+
+#define CHSPEC_CTL_SB(chspec)	((chspec) & WL_CHANSPEC_CTL_SB_MASK)
+#define CHSPEC_BW(chspec)	((chspec) & WL_CHANSPEC_BW_MASK)
+
+#define CHSPEC_IS10(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_10)
+
+#define CHSPEC_IS20(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_20)
+
+#define CHSPEC_IS40(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_40)
+
+#define CHSPEC_IS80(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_80)
+
+#define CHSPEC_IS5G(chspec) \
+	(((chspec) & WL_CHANSPEC_BAND_MASK) == WL_CHANSPEC_BAND_5G)
+
+#define CHSPEC_IS2G(chspec) \
+	(((chspec) & WL_CHANSPEC_BAND_MASK) == WL_CHANSPEC_BAND_2G)
+
+#define CHSPEC_SB_NONE(chspec) \
+	(((chspec) & WL_CHANSPEC_CTL_SB_MASK) == WL_CHANSPEC_CTL_SB_NONE)
+
+#define CHSPEC_SB_UPPER(chspec) \
+	(((chspec) & WL_CHANSPEC_CTL_SB_MASK) == WL_CHANSPEC_CTL_SB_UPPER)
+
+#define CHSPEC_SB_LOWER(chspec) \
+	(((chspec) & WL_CHANSPEC_CTL_SB_MASK) == WL_CHANSPEC_CTL_SB_LOWER)
+
+#define CHSPEC_CTL_CHAN(chspec) {\
+	typeof(i) _chspec = (chspec); \
+	((CHSPEC_SB_LOWER(_chspec)) ? \
+	(lower_20_sb((_chspec & WL_CHANSPEC_CHAN_MASK))) : \
+	(upper_20_sb((_chspec & WL_CHANSPEC_CHAN_MASK)))); \
+	}
+
+/* band types */
+#define INF_BAND_AUTO           0       /* auto-select */
+#define INF_BAND_5G             1       /* 5 Ghz */
+#define INF_BAND_2G             2       /* 2.4 Ghz */
+#define INF_BAND_ALL            3       /* all bands */
+
+#define CHSPEC2BAND(chspec) (CHSPEC_IS5G(chspec) ? INF_BAND_5G : INF_BAND_2G)
+
+#define CHANSPEC_STR_LEN    8
+
+static inline int lower_20_sb(int channel)
+{
+	return channel > CH_10MHZ_APART ? (channel - CH_10MHZ_APART) : 0;
+}
+
+static inline int upper_20_sb(int channel)
+{
+	return (channel < (MAXCHANNEL - CH_10MHZ_APART)) ?
+	       channel + CH_10MHZ_APART : 0;
+}
+
+static inline int chspec_bandunit(u16 chspec)
+{
+	return CHSPEC_IS5G(chspec) ? BAND_5G_INDEX : BAND_2G_INDEX;
+}
+
+static inline u16 ch20mhz_chspec(int channel)
+{
+	u16 rc = channel <= CH_MAX_2G_CHANNEL ?
+		 WL_CHANSPEC_BAND_2G : WL_CHANSPEC_BAND_5G;
+
+	return	(u16)((u16)channel | WL_CHANSPEC_BW_20 |
+		      WL_CHANSPEC_CTL_SB_NONE | rc);
+}
+
+static inline int next_20mhz_chan(int channel)
+{
+	return channel < (MAXCHANNEL - CH_20MHZ_APART) ?
+	       channel + CH_20MHZ_APART : 0;
+}
+
+/* defined rate in 500kbps */
+#define INF_MAXRATE	108	/* in 500kbps units */
+#define INF_RATE_1M	2	/* in 500kbps units */
+#define INF_RATE_2M	4	/* in 500kbps units */
+#define INF_RATE_5M5	11	/* in 500kbps units */
+#define INF_RATE_11M	22	/* in 500kbps units */
+#define INF_RATE_6M	12	/* in 500kbps units */
+#define INF_RATE_9M	18	/* in 500kbps units */
+#define INF_RATE_12M	24	/* in 500kbps units */
+#define INF_RATE_18M	36	/* in 500kbps units */
+#define INF_RATE_24M	48	/* in 500kbps units */
+#define INF_RATE_36M	72	/* in 500kbps units */
+#define INF_RATE_48M	96	/* in 500kbps units */
+#define INF_RATE_54M	108	/* in 500kbps units */
+
+#define INF_2G_25MHZ_OFFSET		5	/* 2.4GHz band channel offset */
+
+#define MCSSET_LEN	16
+
+static inline bool ac_bitmap_tst(u8 bitmap, int prec)
+{
+	return (bitmap & (1 << (prec))) != 0;
+}
+
+/* d11 io type */
+#define INFF_D11N_IOTYPE		1
+#define INFF_D11AC_IOTYPE		2
+
+/* A chanspec (channel specification) holds the channel number, band,
+ * bandwidth and control sideband
+ */
+
+/* chanspec binary format */
+
+#define INFF_CHSPEC_INVALID		255
+/* bit 0~7 channel number
+ * for 80+80 channels: bit 0~3 low channel id, bit 4~7 high channel id
+ */
+#define INFF_CHSPEC_CH_MASK		0x00ff
+#define INFF_CHSPEC_CH_SHIFT		0
+#define INFF_CHSPEC_CHL_MASK		0x000f
+#define INFF_CHSPEC_CHL_SHIFT		0
+#define INFF_CHSPEC_CHH_MASK		0x00f0
+#define INFF_CHSPEC_CHH_SHIFT		4
+
+/* bit 8~16 for dot 11n IO types
+ * bit 8~9 sideband
+ * bit 10~11 bandwidth
+ * bit 12~13 spectral band
+ * bit 14~15 not used
+ */
+#define INFF_CHSPEC_D11N_SB_MASK	0x0300
+#define INFF_CHSPEC_D11N_SB_SHIFT	8
+#define  INFF_CHSPEC_D11N_SB_L		0x0100	/* control lower */
+#define  INFF_CHSPEC_D11N_SB_U		0x0200	/* control upper */
+#define  INFF_CHSPEC_D11N_SB_N		0x0300	/* none */
+#define INFF_CHSPEC_D11N_BW_MASK	0x0c00
+#define INFF_CHSPEC_D11N_BW_SHIFT	10
+#define  INFF_CHSPEC_D11N_BW_10	0x0400
+#define  INFF_CHSPEC_D11N_BW_20	0x0800
+#define  INFF_CHSPEC_D11N_BW_40	0x0c00
+#define INFF_CHSPEC_D11N_BND_MASK	0x3000
+#define INFF_CHSPEC_D11N_BND_SHIFT	12
+#define  INFF_CHSPEC_D11N_BND_5G	0x1000
+#define  INFF_CHSPEC_D11N_BND_2G	0x2000
+
+/* bit 8~16 for dot 11ac IO types
+ * bit 8~10 sideband
+ * bit 11~13 bandwidth
+ * bit 14~15 spectral band
+ */
+#define INFF_CHSPEC_D11AC_SB_MASK	0x0700
+#define INFF_CHSPEC_D11AC_SB_SHIFT	8
+#define  INFF_CHSPEC_D11AC_SB_LLL	0x0000
+#define  INFF_CHSPEC_D11AC_SB_LLU	0x0100
+#define  INFF_CHSPEC_D11AC_SB_LUL	0x0200
+#define  INFF_CHSPEC_D11AC_SB_LUU	0x0300
+#define  INFF_CHSPEC_D11AC_SB_ULL	0x0400
+#define  INFF_CHSPEC_D11AC_SB_ULU	0x0500
+#define  INFF_CHSPEC_D11AC_SB_UUL	0x0600
+#define  INFF_CHSPEC_D11AC_SB_UUU	0x0700
+#define  INFF_CHSPEC_D11AC_SB_LL	INFF_CHSPEC_D11AC_SB_LLL
+#define  INFF_CHSPEC_D11AC_SB_LU	INFF_CHSPEC_D11AC_SB_LLU
+#define  INFF_CHSPEC_D11AC_SB_UL	INFF_CHSPEC_D11AC_SB_LUL
+#define  INFF_CHSPEC_D11AC_SB_UU	INFF_CHSPEC_D11AC_SB_LUU
+#define  INFF_CHSPEC_D11AC_SB_L	INFF_CHSPEC_D11AC_SB_LLL
+#define  INFF_CHSPEC_D11AC_SB_U	INFF_CHSPEC_D11AC_SB_LLU
+#define INFF_CHSPEC_D11AC_BW_MASK	0x3800
+#define INFF_CHSPEC_D11AC_BW_SHIFT	11
+#define  INFF_CHSPEC_D11AC_BW_5	0x0000
+#define  INFF_CHSPEC_D11AC_BW_10	0x0800
+#define  INFF_CHSPEC_D11AC_BW_20	0x1000
+#define  INFF_CHSPEC_D11AC_BW_40	0x1800
+#define  INFF_CHSPEC_D11AC_BW_80	0x2000
+#define  INFF_CHSPEC_D11AC_BW_160	0x2800
+#define  INFF_CHSPEC_D11AC_BW_8080	0x3000
+#define INFF_CHSPEC_D11AC_BND_MASK	0xc000
+#define INFF_CHSPEC_D11AC_BND_SHIFT	14
+#define  INFF_CHSPEC_D11AC_BND_2G	0x0000
+#define  INFF_CHSPEC_D11AC_BND_3G	0x4000
+#define  INFF_CHSPEC_D11AC_BND_6G	0x8000
+#define  INFF_CHSPEC_D11AC_BND_5G	0xc000
+#define INFF_CHSPEC_IS5G(chspec) \
+	(((chspec) & INFF_CHSPEC_D11AC_BND_MASK) == INFF_CHSPEC_D11AC_BND_5G)
+#define INFF_CHSPEC_IS6G(chspec) \
+	(((chspec) & INFF_CHSPEC_D11AC_BND_MASK) == INFF_CHSPEC_D11AC_BND_6G)
+#define INFF_CHAN_BAND_2G		1
+#define INFF_CHAN_BAND_5G		2
+#define INFF_CHAN_BAND_6G		3
+
+enum inff_chan_bw {
+	INFF_CHAN_BW_20,
+	INFF_CHAN_BW_40,
+	INFF_CHAN_BW_80,
+	INFF_CHAN_BW_80P80,
+	INFF_CHAN_BW_160,
+};
+
+enum inff_chan_sb {
+	INFF_CHAN_SB_NONE = -1,
+	INFF_CHAN_SB_LLL,
+	INFF_CHAN_SB_LLU,
+	INFF_CHAN_SB_LUL,
+	INFF_CHAN_SB_LUU,
+	INFF_CHAN_SB_ULL,
+	INFF_CHAN_SB_ULU,
+	INFF_CHAN_SB_UUL,
+	INFF_CHAN_SB_UUU,
+	INFF_CHAN_SB_L = INFF_CHAN_SB_LLL,
+	INFF_CHAN_SB_U = INFF_CHAN_SB_LLU,
+	INFF_CHAN_SB_LL = INFF_CHAN_SB_LLL,
+	INFF_CHAN_SB_LU = INFF_CHAN_SB_LLU,
+	INFF_CHAN_SB_UL = INFF_CHAN_SB_LUL,
+	INFF_CHAN_SB_UU = INFF_CHAN_SB_LUU,
+};
+
+/**
+ * struct inff_chan - stores channel formats
+ *
+ * This structure can be used with functions translating chanspec into generic
+ * channel info and the other way.
+ *
+ * @chspec: firmware specific format
+ * @chnum: center channel number
+ * @control_ch_num: control channel number
+ * @band: frequency band
+ * @bw: channel width
+ * @sb: control sideband (location of control channel against the center one)
+ */
+struct inff_chan {
+	u16 chspec;
+	u8 chnum;
+	u8 control_ch_num;
+	u8 band;
+	enum inff_chan_bw bw;
+	enum inff_chan_sb sb;
+};
+
+/**
+ * struct inff_d11inf - provides functions translating channel format
+ *
+ * @io_type: determines version of channel format used by firmware
+ * @encchspec: encodes channel info into a chanspec, requires center channel
+ *	number, ignores control one
+ * @decchspec: decodes chanspec into generic info
+ */
+struct inff_d11inf {
+	u8 io_type;
+
+	void (*encchspec)(struct inff_chan *ch);
+	void (*decchspec)(struct inff_chan *ch);
+};
+
+void inff_d11_attach(struct inff_d11inf *d11inf);
+
+#endif /* INFF_WIFI_H */
-- 
2.25.1


