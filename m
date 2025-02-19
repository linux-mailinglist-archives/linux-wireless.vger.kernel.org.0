Return-Path: <linux-wireless+bounces-19141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F596A3C6C3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBB3188E2EF
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC161F61C;
	Wed, 19 Feb 2025 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="LPNTkBSM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DA2144C2
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987557; cv=none; b=fMfsd4VHlKgnTgfJplnJKwFsgLbye8qBzA5jYKRaDPg9Ox0hse0FH8YR9LnBbGe0JqRKbvHAkMV/qj3juSLjcEgRXbralzPgVl7vGC//tcCyTmAiNsbYzRK8SIqHT2O8Iq4cqZqrPQp2DqOBSCvQFSsKV6bIT+6KyKEfjXZzthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987557; c=relaxed/simple;
	bh=9jlL8FHPIH1N42D2mIsNAvjz9LKZdnGoCEB7pryW02g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7rZEM8AKPmpzJCeEVhCYTCta9kFyguwftPG+jJODcnPJMTUFltgEtihQjADATh6WlDKFjRqqdj6gv+lMvX/9c5NGIxvi0oCzF+mVEOTSDUsTgIpbMTPZxEmOfG7Jn3UMHCTp0N3yGd0atb5jOpEzxnjDF5rqNAX8i1l8bOsEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=LPNTkBSM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso125325e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739987554; x=1740592354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW9032whOdtI+Ha5IRd/YBfMaQPHihazNStVLJHmubE=;
        b=LPNTkBSMCGCL6iZmB3d88RZAkfxYcE8+o2xSPFDz1VOY8lcP4umdL6612ZVGtrnqlD
         8Al7zV1soxO2NjNQTe7c2+qneSsKEzU/6rC5HeSGdhb77obPBIov0wb5A2bRa1lJ1pWW
         ioJFpEiOBFrQW46HTJO/2hzDE3hbAUjqvmnBdU/qdT/Y1lFhJ7j/s5RNLv7nKWHFHxNa
         qRKudCUUQ2mB1YUa9/NLotHGPSBxpJdY2uXMmeygahzM0Fa//xltcH/RH0MvZvCOTbAq
         ysTAGt12xX+/MqfMFwBaBBqMxYRlDZBMKbPmpdP/dTXdBGIaQcScGVbRuUi1M2aNz/od
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987554; x=1740592354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW9032whOdtI+Ha5IRd/YBfMaQPHihazNStVLJHmubE=;
        b=YArOweo3YZoLOA3XIPS4WoOU09voURXVYjf6qwz+J5cnTGaNtCIlrsnUL9qSzTicN0
         Ec94G+nuPs3e1CGz5nN+CTecHT7TwSfps6vt0WNW3sPTgJ3QOi5y5CgwK3C7AqHC9smL
         I7rmBeKMa2QOixbA2eGP1vGKmnVu2y9K0/ymT2JLG59A5vtGe6om1QNTVJND3kFP6Ubt
         Z6RvLjuIARLYiu/hW/pGC381mWvoX+E3GtxgODIEL7xeH8bjNxfILFVi+wJxpBRIxxS2
         6eZ7hDf23G0RBlW8BS4/gpHK5imyQgT0/Zual69AST7D5WDTzF+ZPcLnesiTU+KTEouk
         whXw==
X-Gm-Message-State: AOJu0Yw1OdRIVzMmo2Q6xvoVcbTLJmsPS2qHkQG9TTMQlJR+4h9XjoIe
	SSOe7LOD+owx/tYl0hvRpuF+6leBMF2Qy6t6QhA+/HxKHnRGzRdZO6Uy2LejuOrOpDRnMQP4RYf
	h+o4=
X-Gm-Gg: ASbGnctu87QYoUiQIouxwm5bbRJ/HSFRkYFTpQIifeDsP/hVzEoI/mHYDM5AmPtg+JX
	I06Q+pHowZoCfjZ8I0RrKQMPID7v1NL851orTD4tDEBJQhGDtYABOkCSSlHRgaVNdmVgTyn6wSg
	84GEZTHP4tANOAly8d0Un8Q5u2p9J9zta/PmJG6gaWIIVxSl7TvLm5AXjr4bBoaIv149p+m7qep
	l/2ul4bj4VRwrIgMFU0E+O7wj2mJoNbAHd2x/lgnlxXLqKqGLstohWXLcAkmkCYoTkuLKFketZM
	W368TNL1VBAZ
X-Google-Smtp-Source: AGHT+IHNxtzm/tJWHM0XwQprsi7MIkTHrPoS45vtxdLA+gBrXN1vmKFsfTQFjWZ7/bGfhWRpc4lEnQ==
X-Received: by 2002:a05:600c:3501:b0:439:955d:7ad9 with SMTP id 5b1f17b1804b1-43999da89c7mr52150455e9.14.1739987554065;
        Wed, 19 Feb 2025 09:52:34 -0800 (PST)
Received: from fraxinus.easyland ([2001:1620:4675:0:25b:f7ee:9a39:7e51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43983264ef8sm99269695e9.4.2025.02.19.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:52:33 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Reto Schneider <reto.schneider@husqvarnagroup.com>,
	Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH v1 3/3] wifi: rtl8xxxu: Make sure TX rate is reported in AP mode
Date: Wed, 19 Feb 2025 18:52:28 +0100
Message-ID: <20250219175228.850583-4-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219175228.850583-1-ezra@easyb.ch>
References: <20250219175228.850583-1-ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

Without this change, e.g., "iw station dump" will show "tx bitrate:
(unknown)" when in AP mode.

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---
Note: The code was simply copied over from rtl8xxxu_bss_info_changed()
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 2fa22d3145a4..eb497301b625 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7576,6 +7576,12 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 	mutex_lock(&priv->sta_mutex);
 	ewma_rssi_init(&sta_info->avg_rssi);
 	if (vif->type == NL80211_IFTYPE_AP) {
+		struct rtl8xxxu_ra_report *rarpt = &priv->ra_report;
+		u32 ramask;
+		int sgi = 0;
+		u8 highest_rate;
+		u8 bw;
+
 		sta_info->rssi_level = RTL8XXXU_RATR_STA_INIT;
 		sta_info->macid = rtl8xxxu_acquire_macid(priv);
 		if (sta_info->macid >= RTL8XXXU_MAX_MAC_ID_NUM) {
@@ -7584,6 +7590,24 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 		}

 		rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
+
+		/* TODO: Set bits 28-31 for rate adaptive id */
+		ramask = (sta->deflink.supp_rates[0] & 0xfff) |
+			sta->deflink.ht_cap.mcs.rx_mask[0] << 12 |
+			sta->deflink.ht_cap.mcs.rx_mask[1] << 20;
+		if (sta->deflink.ht_cap.cap &
+		    (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20))
+			sgi = 1;
+
+		highest_rate = fls(ramask) - 1;
+		if (rtl8xxxu_ht40_2g &&
+		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
+			bw = RATE_INFO_BW_40;
+		else
+			bw = RATE_INFO_BW_20;
+
+		rtl8xxxu_update_ra_report(rarpt, highest_rate, sgi, bw);
+
 		priv->fops->report_connect(priv, sta_info->macid, H2C_MACID_ROLE_STA, true);
 	} else {
 		switch (rtlvif->port_num) {
--
2.43.0

