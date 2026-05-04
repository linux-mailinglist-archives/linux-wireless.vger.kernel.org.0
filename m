Return-Path: <linux-wireless+bounces-35800-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xKdBLR0l+GmnqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35800-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:48:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8E4B85E3
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3A5B300903F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 04:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52B23EAAF;
	Mon,  4 May 2026 04:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpkVXXWA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49B1DED63
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777870105; cv=none; b=VKcTXmQEFmchmnNh9LYbe9xJGewenEUbKvZqzv2JE3MjOQX4vCcOuADsOHlUkfUrC1VUgora6E6XaVUMy7vXrWdAWUdlIczjnQXXXcsGXIHhrnlKA0IAnYJSiILZCZTIl2ehxUqRj3QiMy9EkSiOs6jzsc+73yFZAAd584TgOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777870105; c=relaxed/simple;
	bh=s3WhqhXjuZ+LPwclF/jOAVr+w5A3pvBA9bFElK3EFSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVpRWSuoBzklamlVkASfJEMhnDNm0P/V14jZXiCIos6dnKbGkYHU88AhxN6L7bt9SSvO0FlNjxVH/CJzdGHAlDwZNV1M3/jTkDjc4BWUT+ugbUsw9DQbzIZitThl1KPjL3RcyIEcPdEoUod0p4mt7E8Hd2Wv4dABhwNrqW5rceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpkVXXWA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so33884385e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 21:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777870101; x=1778474901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpE3liCiVco3QsgqxX7JGIWO38lwctbvubdKkyGwciQ=;
        b=mpkVXXWAt8TgLXON+jLBa4wmFhgvh13M/Qll7X/xSEag8nxzGFlyt7H+lBtdNub8nt
         I2bQ/boikyQG9hiWiUnNYt1OPsjciqTPNnxQ45aNexPFOxlkwqFpNhK/6rZqhL0pNj7L
         I+kUOXjiwp2ynN1pd4D+YIPgnoewu/jyRxrDgCFFwRWZ073D5BHr2Rtk0DSZ7iTzuGah
         dKo2SbHjusfDNnsbfWoSX8ZVFaARrTMCLOe7SMuT4uUzOZfoIjniezlzQlYgfxh7G2cJ
         fJj1/k6f8brFDitf4+XTW373bYGqJW77FWA/KRLM2ncZHfQwVeKabXILCdk83OMYJw0W
         cnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777870101; x=1778474901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpE3liCiVco3QsgqxX7JGIWO38lwctbvubdKkyGwciQ=;
        b=Yd6z1YQgHJFP3HCEBxpTt4S+Wq2ZI1CMMtnUrdBeR7MJkBkBcYWn/Y5r1/PRU38i5T
         QzJaUacChuY9uYeLvgOptgf6/pdfbccJTbSAtV7VPENdUGesGXr2oiDPdiGDsbJlLx5g
         lWMdWWXkl8mI1NQMKg0d+qRS+181NNk+6b0y6Lbk4reWgt0unOHhuKQHn1oIQky4DVWY
         Iym2eE9e0lLPXM4jrpg/tS+/Pv0yxji3qyudB/eaX6f3XJVWTobBFllGpS43fX//YZDJ
         rRY88v/L3JQSg0cN0mZ9XZFDJk3O2DKJUtkC3prPGkuW//gZHysr3q8QDXzwjlpW/nb6
         UZhA==
X-Gm-Message-State: AOJu0YwiHSa+PAvmqyakX+ZqaL5PTBHRF0RdRA+ZxNPFW4HFxgjmxbVA
	XNkN8VEjbJbK8CZ/7aXuFaqy8Kz+gzJ4ldn1NwCrfpCcd03cUxKqUN0r
X-Gm-Gg: AeBDiesB7hXzvbmAxQQ0TxrseAYgqKGdPETs7wq0Jm783k2MmT1Ug6PvkAJ5UCkkHPV
	O3UqU6GaCC3iJ+qriwiZAWpQd7clG2Yu5WfMdwzs3D/CV6r9uusoud8/YfhYZNTiTZlgM4nRYDl
	/k51kdK8TJdMfdj8NmNpEiYHCBKl32rmHu/Nhhu8j1XQeYkfnk2zxyvDkfFfKDtwOhrOIxrZEn4
	JtYEVgd2oVdmky+1bd7/mC9UWasRlhb+CirnMzRk6FEGGLmpAHKnzxLG7hvYayfGRWN/PA6DyPH
	AASSKQ7OSgCrTOLmRqkJxJTcdVEEvcSMussm6LDQixCcfipd681L3QlT2mPx9a+ZPrTBNI297fQ
	Kc5XL8kNpLJidpY/otdor6s0BoDKHKsIfDucONhMRfYA4jZTTXcAWWYV0gKy6HNNPLx8UPKrqbA
	lTOF0QsY7BHOzaOMdwV5d7P1BRDxaYEquRV5g6eHPQIhzwZTI9g0IadijIuQ==
X-Received: by 2002:a05:600d:84ca:20b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48d035e84femr40379005e9.6.1777870101062;
        Sun, 03 May 2026 21:48:21 -0700 (PDT)
Received: from localhost ([102.128.173.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f28sm500620095e9.13.2026.05.03.21.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 21:48:20 -0700 (PDT)
From: Louis Kotze <loukot@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Kotze <loukot@gmail.com>
Subject: [PATCH 0/4] wifi: rtw89: advertise WFA-certified EHT capabilities for 8922a
Date: Mon,  4 May 2026 06:48:13 +0200
Message-ID: <cover.1777832019.git.loukot@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17F8E4B85E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-35800-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loukot@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This series advances rtw89 EHT capability advertisement to match what
Realtek's own RTL8922AE silicon is certified for by the Wi-Fi Alliance
in WFA Cert WFA129313 (RTL8922AE 802.11be and Bluetooth combo module,
2024-05-23, FW 6102.24.109.0,
https://api.cert.wi-fi.org/api/certificate/download/public?variantId=129706).

The cert lists EMLSR, STR, Multi-RU, MCS 8-13, DL/UL MU-MIMO, UL OFDMA,
SU-MIMO, beamforming sounding, multi-link reconfiguration, advertised
TID-to-link mapping, BSS critical update, A-MPDU with A-MSDU, LDPC,
operating mode indication, EPCS priority access, and several other
features as certified for this chip. The driver currently advertises
some of these and hard-zeroes others. This series fills the gap for
four cap surfaces:

  Patch 1/4: EML Capabilities (EMLSR_SUPP + padding/transition delays)
             plus Restricted TWT (EHT MAC Cap0). EMLSR is explicitly
             listed in the WFA cert. R-TWT is silicon-supported per the
             chip's documented EHT MAC capabilities.
  Patch 2/4: Multi-RU OFDMA receive cap (CAP5_RX_LESS_242_TONE_RU_SUPP).
             Multi-RU is verbatim in the WFA cert.
  Patch 3/4: MLD operation caps — TID-to-link mapping (SAME) +
             Link Reconfiguration support. Both verbatim in the WFA
             cert. Uses FIELD_PREP_CONST() (already used in this driver
             at usb.c:784-787) and matches the bit pattern Intel uses
             for its Wi-Fi 7 STAs (IWL_MVM_MLD_CAPA_OPS in
             iwlwifi/mvm/mac80211.c). MAX_SIMUL_LINKS is left at 0
             (= 1 max simul link) consistent with the EMLSR-only
             operating mode the driver implements.
  Patch 4/4: EHT OM Control (MAC Cap0). "Operating mode indication" is
             verbatim in the WFA cert; mt7925 + iwlwifi mvm + hwsim
             precedent.

Industry context: this series advances rtw89 along the same axis every
in-tree Linux WiFi 7 driver currently occupies — MLSR/EMLSR fast-switch
on a single physical radio. True STR multi-radio aggregation is not
implemented by any in-tree driver as of v6.15+ (iwlwifi, mt7925, ath12k,
rtw89). The only known shipping consumer STR adapter on any OS is the
Ubiquiti UniFi AirWire (closed firmware, UniFi-AP-only). This series
does not attempt STR; it brings rtw89 EMLSR negotiation in line with
the other three drivers.

Testing: applied as a stack to the morrownr/rtw89 OOT clone on Linux
6.19.11 (Bazzite F44) running RTL8922AU USB; tested against TP-Link
Deco BE63 mesh (5-node) for 48h+ continuous association. Verified caps
appear in `iw phy` output (Restricted TWT, OM Control, "Rx 1024-QAM
And 4096-QAM < 242-tone RU"). active_links = 0x4 confirms expected
EMLSR mode. wifi-health-check sweep (11 checks: wpa override, rpm-ostree
state, rtw89 build, SELinux, NM dispatchers, regdomain, link state,
SELinux AVC rate, MLO link count) passes 11/11 throughout the soak.

A/B comparison patched vs unpatched, 3-NIC concurrent reverse-mode
iperf3, 5 reps patched + 3 reps unpatched per SSID, signal -10 to
-25 dBm: no measurable throughput delta (MLO patched mean 1128 Mbps
vs unpatched mean 1174 Mbps; 6 GHz patched mean 1099 Mbps vs unpatched
mean 1169 Mbps; deltas well within ±5% noise floor and dominated by
per-test MCS variation, not patch state). The patches enable correct
cap advertisement matching what RTL8922A silicon supports per the
WFA cert; they do not aim to deliver throughput improvement in
steady-state operation against this AP. Patches are about correctness
and standards-compliance, not throughput.

Tested only on RTL8922AU (USB variant); rtw89_init_eht_cap() and the
iftype-ext-cap struct are shared across the rtw89 chip family. Non-AU
variant testing from anyone with rtw89-supported hardware is welcome.

Note on EMLMR (EML Cap bit 7): the WFA cert does NOT list EMLMR for
this chip. RTL8922A has rf_path_num=2 (single 2T2R RF block shared
across bands), and the driver has no EMLMR enum, firmware H2C path,
or PHY register block. EMLSR is the architectural ceiling for this
silicon; this series does not advertise EMLMR.

Note on follow-up: a separate audit identified five further capability
fields hard-zeroed in rtw89_init_eht_cap() (EHT A-MPDU exponent,
partial-BW DL/UL MU-MIMO, MCS 14-15, sounding dimensions, 1024/4096-QAM
wider-BW DL-OFDMA). Some of these are likely silicon ceilings (MCS 14-15
is consistent with the cert topping out at MCS 12-13); others may be
driver-only gaps. I plan to send a small ASK email separately covering
those questions before any follow-up patch series.

Louis Kotze (4):
  wifi: rtw89: advertise EML Capabilities and Restricted TWT for 8922a
  wifi: rtw89: advertise Multi-RU OFDMA receive for 8922a per WFA cert
  wifi: rtw89: advertise MLD TID-to-link mapping and link reconfiguration
  wifi: rtw89: advertise EHT OM Control for 8922a per WFA cert

 drivers/net/wireless/realtek/rtw89/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Louis Kotze (4):
  wifi: rtw89: advertise EML Capabilities and Restricted TWT for 8922a
  wifi: rtw89: advertise Multi-RU OFDMA receive for 8922a per WFA cert
  wifi: rtw89: advertise MLD TID-to-link mapping and link
    reconfiguration
  wifi: rtw89: advertise EHT OM Control for 8922a per WFA cert

 drivers/net/wireless/realtek/rtw89/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)


base-commit: 7baf5857e15d722776898510a10546d6b2f18645
-- 
2.54.0


