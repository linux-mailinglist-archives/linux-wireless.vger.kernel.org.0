Return-Path: <linux-wireless+bounces-29344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A410C86789
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF007350097
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988832D443;
	Tue, 25 Nov 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbUTlnos"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91732D0C3
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094178; cv=none; b=FjGbKO6V/Xn9h3yrSgMv45nK0QPZAsExgVBEti5WeUcMNHz3XTHOHN+mxxf6Br/DCHTDVvTLefPHEN632f6+hsERyvPJaJ1Fvc8O+r3m03D2DcW8xfacF70UEF4lCoQUQ+OIrh3vijDnstXwAORYmByd0KMLpMQzOMSriqh4Z78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094178; c=relaxed/simple;
	bh=lHx3UQFhPP9cim5HUYiB+/IYyE+sAs63rZhbMyd/XOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCiHeNfGscKHCO7uPMMtePcch4/m1ZcDqnZjokW5JK1r0ml/uTsCpWpRzrodR95Y6gsBTT/XWd7i3VyTrPWWYQVbLUtfUgvCm/aSnAnd3WXH7Y0Hj510yAUV3w2YEtL4crAzER2Vk5HYvZ/MgFmUsLBabW6hZ/pkU7FO9Tv+FQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbUTlnos; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5945510fd7aso4895954e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764094174; x=1764698974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INu3UrEQb2Bcot39uzk7LHskwDg85xEgEpIDfdTPzjg=;
        b=UbUTlnossaGKBFy9+Qlz9lCrZMv3SmOl1ECQycreMceeOvbMFN+JAkYcVipojegArx
         ONuz0Mp3tzQdDEjdVHtmV6dgCZ1IHKGZB6q+tOR+WXUlAtY4nALFjtiCsg+T649JnQpW
         jXUsdnPgUJgiFij/NYMYvgVOTd75CvE+h2WgoQpCW3h5ET5H3QZI8Bj56HbGexRxdGcR
         YLlVRsz5bF3Qe4KUPYa940SajN5OsvaKS8iQxNOPwWb+Nxlsumu266RA36BHHBHQqydt
         i/8WpjzG3H2XlOwDwG5G6k8vz2siQT1H84Ok0YDoPFg/3bi1cbWgow77FKDyibHYAcZE
         WfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094174; x=1764698974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INu3UrEQb2Bcot39uzk7LHskwDg85xEgEpIDfdTPzjg=;
        b=nU8MXsibLDBDa5jpgwaU9GHDcZuJI2wLaNfdF0int5iBxbsILBrVJ5NPhMRUgqZHok
         ABOlWT8L1vBI6gM3TzSdpw0ftX6zYeiBY74ygfFgS6pCmK+30WwwdEDHkhsFX2UjeW3J
         6iwe+993ULtjyN/aJszNxd7QScIeCNQZByDFXdceu+FhH3RFddg0MdwKVdjmWO7kaDxQ
         8UsPFPKxhsOznXiJQETiyTt14En5DtOl7n75nsuAAglgQURKKtOo3qzYIxME59e2eGau
         Bt0SJuG5rQQnY0IRNx2qIp9BLNC7n2IJSepDfPE5v8HMShKfO7ihASti85Rp+w4dPAdn
         uRRQ==
X-Gm-Message-State: AOJu0YwYVR5/B8oZh6myY2LhLmlm6SvPhqWZVJAcTf0bLrTJIHI+/6RU
	ZlOBRpKuKCxr1EJvXh1AB+4KJJVeTPiP09RCOiDUI7u3lwDIEkOT1nWvdbilgt2T
X-Gm-Gg: ASbGnctIuqyi+vDrPFIZ6DAWGBsOqZhCabZ7E9Afv5cfVUIDZHf+lb2p53kUfXyjf9/
	lyID9tdqzaRiE86OAoj40NavowBXwFbKEzFTmQOO8SPcpvXov8od9wQK+VJbbwPGhbdpdy6bfiS
	yU25a1M+SU3tl1qAcZ612fj3nXAazcarXJRbFTTiYrJfhJ/9sjaqrLoIoxTuYq7fBz5+QPMx62a
	3Nijpu9G/fPuPW5xfIncrviXD8sJHCkEK7c1SX2SkB89CEAVoV4HecSihW1nkArP/wfm9EYo0vu
	7s/5+ajuMgr66nu3NzOX4GUNFOKLtgrJhbM/G1mW7/b4HU33KIBzi/h7NmcmMZ4GGll/cW7n7oa
	iYK/JluMnb7AHPDbvl2XMHchtweusjJsV3jykbyA+HrXDV5fb4XwcgE+fCSNOn26aWwMobLziKB
	97+UQsQTfv5RbZzh8UyoM4isjYGDAgW6g9apS/R/zmdLx6gA==
X-Google-Smtp-Source: AGHT+IHSz3NNpufiWvAx/PArKVDWPtQoG/0PO0/yrBeGHVtPy/WbwnM0aZj4iPAl8h3EbHjIB+8cog==
X-Received: by 2002:a05:6512:230d:b0:594:34b9:a7f4 with SMTP id 2adb3069b0e04-596b526ca56mr1452846e87.29.1764094173728;
        Tue, 25 Nov 2025 10:09:33 -0800 (PST)
Received: from depo-VirtualBox.cod.local ([88.204.19.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db81b35sm5237458e87.22.2025.11.25.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:09:33 -0800 (PST)
From: Roman Peshkichev <roman.peshkichev@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com
Subject: [PATCH] wifi: rtw88: fix DTIM period handling when conf->dtim_period is zero
Date: Tue, 25 Nov 2025 23:09:37 +0500
Message-Id: <20251125180937.22977-1-roman.peshkichev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtw_set_dtim_period() accepted an 'int' dtim_period parameter,
while mac80211 provides dtim_period as 'u8' in struct ieee80211_bss_conf.
In IBSS (ad-hoc) mode mac80211 may set dtim_period to 0.

The driver unconditionally wrote (dtim_period - 1) to REG_DTIM_COUNTER_ROOT,
which resulted in 0xFF when dtim_period was 0. This caused delays in
broadcast/multicast traffic processing and issues with ad-hoc operation.

Convert the function parameter to u8 to match ieee80211_bss_conf and avoid
the underflow by writing 0 when dtim_period is 0.

Link: https://github.com/lwfinger/rtw88/issues/406
Signed-off-by: Roman Peshkichev <roman.peshkichev@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/main.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index fa0ed39cb..361ce0d40 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -730,10 +730,10 @@ void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel)
 }
 EXPORT_SYMBOL(rtw_set_rx_freq_band);
 
-void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period)
+void rtw_set_dtim_period(struct rtw_dev *rtwdev, u8 dtim_period)
 {
 	rtw_write32_set(rtwdev, REG_TCR, BIT_TCR_UPDATE_TIMIE);
-	rtw_write8(rtwdev, REG_DTIM_COUNTER_ROOT, dtim_period - 1);
+	rtw_write8(rtwdev, REG_DTIM_COUNTER_ROOT, dtim_period ? dtim_period - 1 : 0);
 }
 
 void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 43ed6d6b4..1ab70214c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2226,7 +2226,7 @@ enum nl80211_band rtw_hw_to_nl80211_band(enum rtw_supported_band hw_band)
 }
 
 void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel);
-void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period);
+void rtw_set_dtim_period(struct rtw_dev *rtwdev, u8 dtim_period);
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
-- 
2.34.1


