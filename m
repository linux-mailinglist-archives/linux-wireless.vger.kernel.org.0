Return-Path: <linux-wireless+bounces-23300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8F4AC0A0F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD6E4A7693
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE171F09B3;
	Thu, 22 May 2025 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="VCPmR7tl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F61EF387
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910812; cv=none; b=nU+GJdofsnMB9CpMi9gIWyLnPQuREU701Aj+oNjxFzBY6jytkhFcw2tmH38hjdHUSBsgXFXgLygAbKZLNJdREF3P10GZyXjeTU0blDg4z13FlfmcHCzkDX+B5bkJ/Hye/ojyxe1lqa9WRfE8T1c1Gx8REbFzx0V/qZza2uAwRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910812; c=relaxed/simple;
	bh=+dhVFLFXkjk/C4bYNNgGu52T3+8/R4p1u2fUfkVf3rM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=VwGk3ecNRyAUg2eb3P+5Bmdv3+W+wR9LNngR0Ppu3yvdU6ZupReZt4wqVe9S58eq19Qc7oXrV10JePyetKKLexjOwF/XPDlxj++k9N6FbpjWOZCyFMFGXgeKmJwzmdawL8hXB9xXHfjqDjLdFChSi8nv0o9SDAEKmix0BWttFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=VCPmR7tl; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GGOU0eucgtGYxVzkr8gSFoysqZHLPO/CwEYwq4FLJ+k=; b=VCPmR7tlo/4B+7weHGUs9Rhyhf
	497VbuXaK2DlX9Q0YmSx8lpMDlrRV34bjojnApLfCQxozD9EqkTws/j75EoPaq01IGz7kVRjM6CmV
	1mTAvrbxAHDfwnK5W3mz8uSp2PRNmcllPWmoDhL/VyGdy4XGPq0qsAJNVs/xkHnpDVc0=;
Received: from p5b206e31.dip0.t-ipconnect.de ([91.32.110.49] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uI3Rm-0085Pc-19;
	Thu, 22 May 2025 12:46:46 +0200
Message-ID: <d4796c00-6bee-46a9-a794-1d79bf5680a3@nbd.name>
Date: Thu, 22 May 2025 12:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2025-05-21 v2
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here's an updated version of my mt76 pull request for 6.16

- Felix

The following changes since commit 0b0ff976af94fc2437b62e3798f11aacc3798613:

   wifi: mac80211: accept probe response on link address as well (2025-05-21 09:26:28 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2025-05-21

for you to fetch changes up to a8afb17f44a320c1a039c2c5db633245f1479214:

   wifi: mt76: mt7925: add rfkill_poll for hardware rfkill (2025-05-22 12:44:10 +0200)

----------------------------------------------------------------
mt76 patches for 6.16

- fixes
- EHT improvements
- new device ids

----------------------------------------------------------------
Allan Wang (2):
       wifi: mt76: mt7925: add EHT preamble puncturing
       wifi: mt76: mt7925: add rfkill_poll for hardware rfkill

Benjamin Lin (1):
       wifi: mt76: mt7996: drop fragments with multicast or broadcast RA

Charles Han (1):
       wifi: mt76: mt7996: Add NULL check in mt7996_thermal_init

Christophe JAILLET (1):
       wifi: mt76: Remove an unneeded local variable in mt76x02_dma_init()

Dan Carpenter (2):
       wifi: mt76: mt7925: Fix logical vs bitwise typo
       wifi: mt76: mt7996: remove duplicate check in mt7996_mcu_sta_mld_setup_tlv()

Feng Jiang (1):
       wifi: mt76: scan: Fix 'mlink' dereferenced before IS_ERR_OR_NULL check

Henk Vergonet (1):
       wifi: mt76: mt76x2: Add support for LiteOn WN4516R,WN4519R

Henry Martin (2):
       wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
       wifi: mt76: mt7915: Fix null-ptr-deref in mt7915_mmio_wed_init()

Howard Hsu (2):
       wifi: mt76: remove capability of partial bandwidth UL MU-MIMO
       wifi: mt76: mt7996: fix beamformee SS field

Leon Yen (1):
       wifi: mt76: mt7925: introduce thermal protection

Lorenzo Bianconi (1):
       Revert "wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()"

Michael Lo (4):
       wifi: mt76: mt7925: fix host interrupt register initialization
       wifi: mt76: mt7925: ensure all MCU commands wait for response
       wifi: mt76: mt7925: extend MCU support for testmode
       wifi: mt76: mt7925: add test mode support

Ming Yen Hsieh (4):
       wifi: mt76: add mt76_connac_mcu_build_rnr_scan_param routine
       wifi: mt76: mt7925: add RNR scan support for 6GHz
       wifi: mt76: mt7925: prevent multiple scan commands
       wifi: mt76: mt7925: refine the sniffer commnad

Peter Chiu (7):
       wifi: mt76: mt7996: rework WA mcu command for mt7990
       wifi: mt76: mt7996: rework DMA configuration for mt7990
       wifi: mt76: mt7996: adjust HW capabilities for mt7990
       wifi: mt76: mt7996: add PCI device id for mt7990
       wifi: mt76: mt7996: set EHT max ampdu length capability
       wifi: mt76: mt7996: fix invalid NSS setting when TX path differs from NSS
       wifi: mt76: mt7996: change max beacon size

Qasim Ijaz (3):
       wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
       wifi: mt76: mt7996: avoid NULL pointer dereference in mt7996_set_monitor()
       wifi: mt76: mt7996: avoid null deref in mt7996_stop_phy()

Samuel Williams (1):
       wifi: mt76: mt7921: add 160 MHz AP for mt7922 device

Shayne Chen (6):
       wifi: mt76: mt7996: add macros for pci device ids
       wifi: mt76: connac: rework TX descriptor and TX free for mt7990
       Revert "wifi: mt76: mt7996: fill txd by host driver"
       wifi: mt76: mt7996: fix RX buffer size of MCU event
       wifi: mt76: fix available_antennas setting
       wifi: mt76: support power delta calculation for 5 TX paths

StanleyYP Wang (7):
       wifi: mt76: connac: add support to load firmware for mt7990
       wifi: mt76: mt7996: rework register mapping for mt7990
       wifi: mt76: mt7996: add eeprom support for mt7990
       wifi: mt76: mt7996: rework background radar check for mt7990
       wifi: mt76: mt7915: set correct background radar capability
       wifi: mt76: mt7915: rework radar HWRDD idx
       wifi: mt76: mt7996: rework radar HWRDD idx

sunliming (1):
       wifi: mt76: mt7996: fix uninitialized symbol warning

  drivers/net/wireless/mediatek/mt76/channel.c          |   4 ++-
  drivers/net/wireless/mediatek/mt76/mac80211.c         |  10 ++++---
  drivers/net/wireless/mediatek/mt76/mt76.h             |  20 +++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7615/init.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |   6 ++---
  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |   7 ++++-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |   1 +
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  43 +++++++++++++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  14 ++++++++++
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   1 -
  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   2 ++
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c  |  13 ++++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |  28 +++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  33 ++++++++++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  14 +++++-----
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  60 +++++++++++++++---------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  50 +++++++++++++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      |   6 +++++
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  25 +++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |   5 ++++
  drivers/net/wireless/mediatek/mt76/mt7925/Makefile    |   1 +
  drivers/net/wireless/mediatek/mt76/mt7925/init.c      |   8 +++++-
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      |  28 ++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |  82 +++++++++++++++++++++++++++++++++++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |   6 +++++
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |   7 ++---
  drivers/net/wireless/mediatek/mt76/mt7925/regs.h      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/testmode.c  | 201 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/coredump.c  |   4 +--
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   |  17 +++++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c       | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c    |  42 +++++++++++++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/init.c      |  41 ++++++++++++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  29 ++++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h       |  12 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |  82 ++++++++++++++++++++++++++++++++++++---------------------
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c       |  21 ++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h      |  51 +++++++++++++++++++++++++++---------
  44 files changed, 1384 insertions(+), 380 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c

