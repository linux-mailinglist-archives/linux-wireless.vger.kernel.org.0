Return-Path: <linux-wireless+bounces-12593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156BF96EEF9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332811C21E5D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F959B71;
	Fri,  6 Sep 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="iqMnE/AF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F197156641
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614171; cv=none; b=M6VGlS7vkAKkmKkHQtcezKIaTPVYioPMIR0tBTjEvbZmvCy1Rvsv+70m/+748LGdS4s5yfityJzgUbsGV0b/h8KdwtmP5GUzcYQ1F3sCMechlBC64j2O5OcMH0/dAeYDglXW9NNinMFkaYTlt/jldHSRnmO3CZqsE4/rUl8FUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614171; c=relaxed/simple;
	bh=MtEpUzLgAbWzX67v/bndPzoj6l0bd6TRSULmyIyirwc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=s/JQB1IszeHdcBomL+byhgNO2OxIFrUtGuye7XLg+z/rYCdgQkAiqk7DzzDC9lpxei3TqBNG+20FY6AltBOzaTzkw025LOJSci0wGzoif+4ayjN1fYIqU9K8gxe0An5PgZ3+TDBOkhU1bTwHnRaEZjwJzwaX3pWl3avdMlEyax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=iqMnE/AF; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bWU8RlEphljmXW/WckkIFqXzo9VbBG3hiAFakrcKHz0=; b=iqMnE/AFQ3RruCORcc8GatmntJ
	PzwUN2LkyUp/REjvCUEUqu0aiNDJO4AitZjceQbFtKOmHKBI++iMY7+Xq7iBLXZaQVl+/r4vhZ+S/
	ooNtN1swlcd50yTFOoFQkTA1qn5rxrc59fgLSDhwDJb0QrsmKQh+rheoNa7kjJInieGY=;
Received: from p4ff1376f.dip0.t-ipconnect.de ([79.241.55.111] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1smV4X-009cO9-0H;
	Fri, 06 Sep 2024 11:16:05 +0200
Message-ID: <8d4189d9-b1ff-45ce-85f4-3c92858cb7be@nbd.name>
Date: Fri, 6 Sep 2024 11:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2024-09-06
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
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
Content-Transfer-Encoding: 8bit

Hi Kalle,

Here's my pull request for 6.12

- Felix

The following changes since commit 43b7724487109368363bb5cda034b3f600278d14:

   Merge tag 'wireless-next-2024-09-04' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-09-04 17:20:14 -0700)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-09-06

for you to fetch changes up to fec8d12a0011d49ab4df9c869db49198336de89e:

   wifi: mt76: mt7925: replace chan config with extend txpower config for clc (2024-09-06 11:14:45 +0200)

----------------------------------------------------------------
mt76 patches for 6.12

- fixes
- mt7915 .sta_state support
- mt7915 hardware restart improvements

----------------------------------------------------------------
Benjamin Lin (3):
       wifi: mt76: connac: add IEEE 802.11 fragmentation support for mt7996
       wifi: mt76: connac: add support for IEEE 802.11 fragmentation
       wifi: mt76: mt7915: add dummy HW offload of IEEE 802.11 fragmentation

Bjørn Mork (1):
       wifi: mt76: mt7915: fix oops on non-dbdc mt7986

Chen Ni (1):
       wifi: mt76: mt7925: convert comma to semicolon

Felix Fietkau (21):
       wifi: mt76: mt7603: fix mixed declarations and code
       wifi: mt76: mt7603: fix reading target power from eeprom
       wifi: mt76: mt7603: initialize chainmask
       wifi: mt76: fix mt76_get_rate
       wifi: mt76: partially move channel change code to core
       wifi: mt76: add separate tx scheduling queue for off-channel tx
       wifi: mt76: mt7915: disable tx worker during tx BA session enable/disable
       wifi: mt76: mt7915: allocate vif wcid in the same range as stations
       wifi: mt76: connac: add support for passing connection state directly
       wifi: mt76: change .sta_assoc callback to .sta_event
       wifi: mt76: mt7915: use mac80211 .sta_state op
       wifi: mt76: mt7915: set MT76_MCU_RESET early in mt7915_mac_full_reset
       wifi: mt76: mt7915: retry mcu messages
       wifi: mt76: mt7915: reset the device after MCU timeout
       wifi: mt76: mt7915: hold dev->mt76.mutex while disabling tx worker
       wifi: mt76: connac: move mt7615_mcu_del_wtbl_all to connac
       wifi: mt76: mt7915: improve hardware restart reliability
       wifi: mt76: shrink mt76_queue_buf
       wifi: mt76: mt7915: always query station rx rate from firmware
       wifi: mt76: mt7996: fix uninitialized TLV data
       wifi: mt76: mt7915: avoid long MCU command timeouts during SER

Gustavo A. R. Silva (1):
       wifi: mt76: Avoid multiple -Wflex-array-member-not-at-end warnings

Howard Hsu (5):
       wifi: mt76: mt7996: fix HE and EHT beamforming capabilities
       wifi: mt76: mt7996: set correct beamformee SS capability
       wifi: mt76: mt7996: fix EHT beamforming capability check
       wifi: mt76: mt7996: set correct value in beamforming mcu command for mt7992
       wifi: mt76: mt7915: fix rx filter setting for bfee functionality

Ma Ke (4):
       wifi: mt76: mt7996: fix NULL pointer dereference in mt7996_mcu_sta_bfer_he
       wifi: mt76: mt7915: check devm_kasprintf() returned value
       wifi: mt76: mt7921: Check devm_kasprintf() returned value
       wifi: mt76: mt7615: check devm_kasprintf() returned value

Michael Lo (1):
       wifi: mt76: mt7925: fix a potential association failure upon resuming

Michael-CY Lee (1):
       wifi: mt76: mt7996: set IEEE80211_KEY_FLAG_GENERATE_MMIE for other ciphers

Ming Yen Hsieh (3):
       wifi: mt76: mt7921: fix wrong UNII-4 freq range check for the channel usage
       wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc
       wifi: mt76: mt7925: replace chan config with extend txpower config for clc

Peter Chiu (5):
       wifi: mt76: mt7996: use hweight16 to get correct tx antenna
       wifi: mt76: mt7996: fix traffic delay when switching back to working channel
       wifi: mt76: mt7996: fix wmm set of station interface to 3
       wifi: mt76: mt7996: advertize beacon_int_min_gcd
       wifi: mt76: connac: fix checksum offload fields of connac3 RXD

Rex Lu (1):
       wifi: mt76: mt7996: fix handling mbss enable/disable

  drivers/net/wireless/mediatek/mt76/mac80211.c         |  66 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
  drivers/net/wireless/mediatek/mt76/mcu.c              |  20 +++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76.h             |  25 ++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   4 ++--
  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c    |   1 +
  drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   9 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  41 ++++++++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   5 +++--
  drivers/net/wireless/mediatek/mt76/mt7615/init.c      |   5 ++++-
  drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  27 +++++++------------------
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |  16 ++++-----------
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |   3 +--
  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h |   7 +++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |  11 +++++++++--
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  10 +++++++++-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  30 ++++++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  28 +++++++++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt76x0/main.c      |  21 +++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h    |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   5 +----
  drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h    |   2 ++
  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c  |  25 +++++++----------------
  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  |  25 +++++------------------
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |   3 +++
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  37 +++++++++++++++++++++-------------
  drivers/net/wireless/mediatek/mt76/mt7915/main.c      | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  54 +++++++++++++++++++++++++++++++-------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   8 ++++----
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      |   2 ++
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   6 ++++--
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c  |   6 ++++--
  drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   4 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  34 ++++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   5 +++--
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |   3 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |   3 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |   3 ++-
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |   5 ++---
  drivers/net/wireless/mediatek/mt76/mt7925/main.c      |  36 ++++++++++++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |  20 ++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h    |   5 +++--
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c       |   4 +++-
  drivers/net/wireless/mediatek/mt76/mt7925/usb.c       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x.h           |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/init.c      |  89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |  17 ++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  37 ++++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       |  26 ++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |   2 +-
  drivers/net/wireless/mediatek/mt76/tx.c               |  62 ++++++++++++++++++++++++++++++++++++---------------------
  62 files changed, 624 insertions(+), 408 deletions(-)

