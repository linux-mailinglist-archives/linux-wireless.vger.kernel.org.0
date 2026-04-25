Return-Path: <linux-wireless+bounces-35297-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ibqFEwAb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35297-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB644678D8
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F469300D6B7
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310C303C83;
	Sat, 25 Apr 2026 19:50:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099B303A0D
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146621; cv=none; b=HWhQ7k6jg1CiI2QMvJg1jJWu5+mw2MLkUh/OwamafQ0NzyhKSotFIovLX20ILdqcg9abfa9ymP132gp2gvZ8DwAA5s8zcHgVbb6/+0yzEYw14Px8iuT2O9/zb4iunBU4BFg5eVpOJBvI7NPFW4LOe4EwINhET5XIky8OuysbgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146621; c=relaxed/simple;
	bh=RriKTDuG9OutLtocI8R/hW0tJFPEeDS4E97A45sh1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IIJtOmq1l1ubbZkskz6fCFUsn5CDLUraUy42YgUymHrn8s2LRqqCmiJxaihoITA/6dcLFcTnRIoRJsDUZ/vHoU4gTeb+TR/vhtEPFcmnAaNuPFo+bi0mZIDUJ1WSd+mlGzk9zf6zUxLhRdS10M+bm9UhISxqsFLHmgRALsJBlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbca22dbfeso3852059a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146619; x=1777751419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZigS9vjftMF0VQjxlX5PZ83w4DOdKz05NDo5rQAbe4=;
        b=ZUv1FWRJBu1SVm/JidsdwYjXWcE4nO40KUJ4iyrVPmizskN7Up+X4Xd/CD53WfFBSF
         T2OdLLIqhHTW6ArYOeFYPsqQicBUjAViSYfN1htndvpQ83oNpk31cn61fMy8WuKBwnjN
         6BE2Vbn2kybyo3KbvLvlLXryZ7ejaPIiY0mNh7XeG3gQEfTWAKV0beO6F26OHaRyJsxt
         +VLsM7p79PK0bTtUA3ChvZswwvRenPaISbpYqirLm0uNC27m1OnBF2dQFRoFZhmjQ0yD
         +UVn8IX+/PxH3TfE4m8lmvfecPN8AeIeJtGqgCe276qtza9PAtu8lqHp6wy+UejdvMyi
         efjg==
X-Gm-Message-State: AOJu0Yxyxpj1lpIc0waHMgj2jBr695u8APcSJdlDqU6PW6MIcL4G3VE8
	FCCRj8VD42DIFVBbra4wUny1bY45uM1ESjbN0v5FLYrP+HgMYyqa67ZK
X-Gm-Gg: AeBDiesp2bThBMbMBwFZ8YmoRQJM6y3OInhyCmPm9AAb3VE70FqrYrj3eLmY3UQsnin
	W8chJ0wV/EJltzZZ3/4jxCjmQXVxDugYPTPgW2E0JKcOAqZuLnte1UOf2sJxohfgEc1UDnJmip2
	fFDi6k83+TBMksJMajKlGfLUPY2BUAR1+MdksIZb8zmudaY//C7BJdw1jq/iJxbipYqgo81lHIL
	RUP7MTn24cgqOcDNjcL8PVMTXEKH1kj/RJJJTlpQUoVKwwaVfGJAjnY8OM/f7qtPkdRCUG3htcj
	lQYRg01a/eGuE4KkvlhNgIDrkEuzpaCiktC2Beuny6uANUDDZ7nim9hiUFiGZ3nqzdPMWPlSeFo
	0ZM2GPq6qf8CoF+xYReA6M1VyJpXzjOUCcuTK1/s1AJyZaRjNVtMJwREO1DY2BtG4krf9/YzwA3
	H+l1bP46a9imE/PgsIwKaNlcpyd9l3Y40u29u7pvFU37w6Wp4unk6JIxEIKI/jCDgyKpAvv4Bez
	g==
X-Received: by 2002:a05:6830:3149:b0:7d9:f50f:968a with SMTP id 46e09a7af769-7dc951177a9mr22041763a34.5.1777146619095;
        Sat, 25 Apr 2026 12:50:19 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:50:18 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH v5 00/21] wifi: mt76: mt7925: MT7927 (Filogic 380) support
Date: Sat, 25 Apr 2026 14:49:50 -0500
Message-ID: <20260425195011.790265-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9FB644678D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35297-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]

This series adds support for MediaTek MT7927 (Filogic 380), a combo
WiFi 7 + BT 5.4 device, in the mt7925 driver.

Patches 1-5 add generic 320MHz EHT support without MT7927-specific
references.

Patches 6-9 add the initial MT7927 enablement pieces, including chip ID
helpers, firmware paths, per-chip IRQ map handling, and disabling ASPM
and runtime PM for MT7927.

Patches 10-21 add the remaining MT7927 support needed to make the device
usable, including connac3 helper cleanup, non-MLD link removal handling,
inactive BSS deactivation tolerance, WFSYS reset support, common DMA queue
helper refactoring, MT7927 PCIe DMA configuration, BSS band assignment
sync, MBMC event handling, CNM ops enablement, and PCIe/USB device support.

The follow-up MT7927 support patches are folded into this version so users
and testers can apply one complete series for MT7927 enablement.

Tested hardware:
- ASUS ROG Crosshair X870E Hero (BT 0489:e13a, WiFi 14c3:6639)
- ASUS ProArt X870E-Creator WiFi (BT 0489:e13a / 13d3:3588, WiFi 14c3:6639)
- ASUS ROG Strix X870-I (WiFi 14c3:7927)
- ASUS ROG Strix X870-F Gaming WiFi (BT 0489:e13a, WiFi 14c3:7927)
- ASUS ROG Strix X870E-E (BT 13d3:3588, WiFi 14c3:7927)
- ASUS ROG STRIX B850-E GAMING WIFI (BT 0489:e13a, WiFi 14c3:7927)
- Gigabyte X870E Aorus Master X3D (BT 0489:e10f, WiFi 14c3:7927)
- Gigabyte Z790 AORUS MASTER X (BT 0489:e10f, WiFi 14c3:7927)
- Gigabyte Z790 AORUS ELITE X WiFi7 (BT 0489:e10f, WiFi 14c3:7927)
- MSI MEG X870E ACE MAX (BT 0489:e110, WiFi 14c3:7927)
- Lenovo Legion Pro 7 16ARX9 (BT 0489:e0fa, WiFi 14c3:7927)
- Lenovo Legion Pro 7 16AFR10H (BT 0489:e0fa, WiFi 14c3:7927)
- TP-Link Archer TBE550E PCIe (BT 0489:e116, WiFi 14c3:7927)
- EDUP EP-MT7927BE M.2 card (WiFi 14c3:7927)
- Foxconn/Azurewave M.2 modules (WiFi 14c3:6639)
- AMD RZ738 reference design (WiFi 14c3:0738)

Tested on Arch Linux, CachyOS, EndeavourOS, Fedora (Bazzite), NixOS,
openSUSE Tumbleweed, and Ubuntu across kernels 6.13-6.19.

Changes since v4:
- Add Reviewed-by tags to patches 1-9.
- Add MT7927 follow-up support:
  - replace is_mt7925() with is_connac3()
  - use link-specific removal for non-MLD STA
  - tolerate inactive BSS deactivation
  - add MT7927 WFSYS reset support
  - factor out common DMA queue allocation
  - switch mt7925 DMA init to common mt792x queue helpers
  - add MT7927-specific PCIe DMA support
  - sync MT7927 BSS band assignment
  - add MBMC event handling
  - enable CNM ops for MT7927
  - add MT7927 PCIe support
  - add MT7927 USB support

Changes since v3:
- Dropped patches 9-13 (DMA, HW init, band_idx, PCI IDs). Sean Wang
  will submit these as part of a generic layer refactor. The CNM quirk
  (v3 patch 13 feedback) will be folded into mt792x_get_mac80211_ops()
  as part of that work.
- Fixed is_320mhz_supported() to use mt76_chip() directly instead of
  is_mt7927() which was not yet defined at that point (patch 5).
- Trimmed verbose inline comments in ASPM/PM patch per review feedback.
  Detail kept in commit message (patch 9).
- Added tested hardware: ASUS ROG STRIX B850-E GAMING WIFI.

Changes since v2 (suggested by Sean Wang):
- Fixed is_320mhz_supported() to check for MT7927 only, not the
  entire mt7925 family. MT7925 does not support 320MHz (patch 5).
- Dropped phy_cap_info[7] 320MHz additions (NON_OFDMA_UL_MU_MIMO
  and MU_BEAMFORMER) to keep capabilities conservative (patch 5).
- Disabled runtime PM for MT7927 (patch 9). The combo chip shares a
  CONNINFRA power domain between WiFi and BT; SET_OWN/CLR_OWN
  transitions crash BT firmware. Discovered via user reports of BT
  lockups after enabling power_save=1 (Reported-by: Nitin Gurram).

Changes since v1 (suggested by Sean Wang):
- Reorganized from 18 patches into 13 across 8 logical groups
- Common 320MHz patches first, chip-specific changes later
- Introduced mt792x_dma_config struct to reuse mt7925_dma_init()
- Replaced is_mt7927() with is_320mhz_supported() in common patches

Link to v4: https://lore.kernel.org/linux-wireless/20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me/
Link to v3: https://lore.kernel.org/linux-wireless/20260325-mt7927-wifi-support-v2-v3-0-826feb8fef8e@jetm.me/
Link to v2: https://lore.kernel.org/linux-wireless/20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me/
Link to v1: https://lore.kernel.org/linux-wireless/20260306-mt7927-wifi-support-v1-0-c77e7445511d@jetm.me/

Javier Tia (9):
  wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
  wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
  wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
  wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
  wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
  wifi: mt76: mt7925: add MT7927 chip ID helpers
  wifi: mt76: mt7925: add MT7927 firmware paths
  wifi: mt76: mt7925: use irq_map for chip-specific interrupt handling
  wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927

Sean Wang (12):
  wifi: mt76: connac: replace is_mt7925() with is_connac3()
  wifi: mt76: mt7925: use link-specific removal for non-MLD STA
  wifi: mt76: connac: tolerate inactive BSS deactivation
  wifi: mt76: mt792x: add MT7927 WFSYS reset support
  wifi: mt76: mt792x: factor out common DMA queue allocation
  wifi: mt76: mt7925: switch DMA init to common mt792x queue helpers
  wifi: mt76: mt792x: add MT7927-specific PCIe DMA support
  wifi: mt76: mt7925: sync MT7927 BSS band assignment
  wifi: mt76: mt7925: add MBMC event handling
  wifi: mt76: mt792x: enable CNM ops for MT7927
  wifi: mt76: mt7925: add MT7927 PCIe support
  wifi: mt76: mt7925: add MT7927 USB support

 .../net/wireless/mediatek/mt76/mt76_connac.h  |  16 ++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  13 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  26 ++-
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  12 +-
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |   9 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  80 ++++++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  43 +++-
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |   3 +-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  25 +++
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 133 +++++++++---
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  12 +-
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |  15 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  25 +++
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  11 +
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 198 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt792x_regs.h  |  23 ++
 .../net/wireless/mediatek/mt76/mt792x_usb.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      |   1 +
 19 files changed, 578 insertions(+), 73 deletions(-)


base-commit: e8c819df02436f2c2379766946735e1f06a7c923
-- 
2.43.0


