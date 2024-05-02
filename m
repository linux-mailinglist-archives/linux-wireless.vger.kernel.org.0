Return-Path: <linux-wireless+bounces-7114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366588B9983
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5885B1C20E10
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25E5E091;
	Thu,  2 May 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="gRn+03ME"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD656B7B
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647485; cv=none; b=psqki7l92mSzWIsaaT1wOQ7Htb3rxqMK8lml0kpgn7d8tI0tppoa2w7PFXNe4H3n27qa3V8E0f0u3rdh9Q2P5XKLg8x5Kib03R8KRzJq1wvpzrgIBlK/2DWosHDkTOyA0m7fKOKAATv0IOjY62HIjruIxX+cxBJzJXAaYAH878A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647485; c=relaxed/simple;
	bh=ia8hPV2IbcGwlS4CeYAYNXH8fOLMwQynPYih8l0/Ud8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=MmgIjP1Zii4PmzlMML4II25PJo6nxHTRM0OnJDpffaMC5ZEoxiFzxBub9Mq4cla1wqM0pCllUy4BUkjv5UM09ccxIxqRFJlCOE+sP/2dinquukNuMVgzXrSVCCSK5OO9I2dVym9WHNeDikbm0c47XPQV97GwhHskPlp9O1SzSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=gRn+03ME; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qAPaIam6WStPPZ7XWEQGe4rMeNMhsDXupHNAZnJSlY4=; b=gRn+03MEMkOWydusipQL1xo44L
	lK0M3cR93Wwmyk2bBwlosyInXnnwBA9ZCLpPQ+UvOvwPVrW2M8X2WGBFetewTaFbacwNC5e4Gzz4q
	ROV8sQ6rvH75V4nlYhUcY+cvXPHw3lzUAwmfeChS9CQpeWCrMNrveBAnjlsLddz801Ss=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1s2U8W-00BNjR-0F;
	Thu, 02 May 2024 12:58:00 +0200
Message-ID: <cca7fa77-17d0-46ff-98e3-db8b7cd8505c@nbd.name>
Date: Thu, 2 May 2024 12:57:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2024-05-02
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
Content-Transfer-Encoding: 7bit

Hi Kalle,

here's my first request for 6.10

- Felix

The following changes since commit 8886b6d681f28d838cb30ace8ce73f8b96bc927d:

   wifi: qtnfmac: Remove generic .ndo_get_stats64 (2024-05-02 10:20:04 +0300)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-05-02

for you to fetch changes up to 59f4c57306bae62f66356556cfbdd40444683c09:

   wifi: mt76: enable spectrum management (2024-05-02 12:47:05 +0200)

----------------------------------------------------------------
mt76 patches for 6.10

- fixes
- mt7603 stability improvements
- mt7921 LED control
- mt7925 EHT radiotap support

----------------------------------------------------------------
Andy Shevchenko (1):
       wifi: mt76: mt7915: Remove unused of_gpio.h

Ben Greear (1):
       wifi: mt76: mt7915: add missing chanctx ops

Bo Jiao (1):
       wifi: mt76: mt7915: only set MT76_MCU_RESET for the main phy

Chad Monroe (1):
       wifi: mt76: mt7996: fix size of txpower MCU command

Deren Wu (2):
       wifi: mt76: mt7921: introduce mt7920 PCIe support
       wifi: mt76: mt7925: add EHT radiotap support in monitor mode

Felix Fietkau (10):
       wifi: mt76: mt7915: initialize rssi on adding stations
       wifi: mt76: replace skb_put with skb_put_zero
       wifi: mt76: fix tx packet loss when scanning on DBDC
       wifi: mt76: mt7996: only set MT76_MCU_RESET for the main phy
       wifi: mt76: mt7915: add fallback in case of missing precal data
       wifi: mt76: mt7603: fix tx queue of loopback packets
       wifi: mt76: mt7603: add wpdma tx eof flag for PSE client reset
       wifi: mt76: connac: use muar idx 0xe for non-mt799x as well
       wifi: mt76: make const arrays in functions static
       wifi: mt76: enable spectrum management

Hao Zhang (1):
       wifi: mt76: mt7921e: add LED control support

Henry Yen (2):
       wifi: mt76: mt7915: fix bogus Tx/Rx airtime duration values
       wifi: mt76: mt7996: fix non-main BSS no beacon issue for MBSS scenario

Howard Hsu (4):
       wifi: mt76: mt7915: fix HE PHY capabilities IE for station mode
       wifi: mt76: connac: enable HW CSO module for mt7996
       wifi: mt76: mt7996: fix potential memory leakage when reading chip temperature
       wifi: mt76: connac: enable critical packet mode support for mt7992

Leon Yen (1):
       wifi: mt76: mt7921s: fix potential hung tasks during chip recovery

Lorenzo Bianconi (2):
       wifi: mt76: mt7996: fix uninitialized variable in mt7996_irq_tasklet()
       wifi: mt76: sdio: move mcu queue size check inside critical section

MeiChia Chiu (1):
       wifi: mt76: mt7915: add support for disabling in-band discovery

Michael-CY Lee (1):
       wifi: mt76: mt7996: let upper layer handle MGMT frame protection

Ming Yen Hsieh (1):
       wifi: mt76: mt7925: ensure 4-byte alignment for suspend & wow command

Muhammad Usama Anjum (1):
       wifi: mt76: connac: check for null before dereferencing

Peter Chiu (3):
       wifi: mt76: mt7915: fix mcu command format for mt7915 tx stats
       wifi: mt76: mt7915: add mt7986, mt7916 and mt7981 pre-calibration
       wifi: mt76: mt7996: set RCPI value in rate control command

Rong Yan (1):
       wifi: mt76: mt7921: cqm rssi low/high event notify

Shayne Chen (2):
       wifi: mt76: mt7996: disable rx header translation for BMC entry
       wifi: mt76: connac: use peer address for station BMC entry

StanleyYP Wang (1):
       wifi: mt76: mt7996: add sanity checks for background radar trigger

  drivers/net/wireless/mediatek/mt76/dma.c              |   5 +++--
  drivers/net/wireless/mediatek/mt76/mac80211.c         |   1 +
  drivers/net/wireless/mediatek/mt76/mt76.h             |   4 ++--
  drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |  46 ++++++++++++++++++++++++++++-------------
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   1 +
  drivers/net/wireless/mediatek/mt76/mt76_connac.h      |  10 ++++++++-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c |  85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h |  22 ++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  22 +++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  15 ++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  29 ++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |  47 +++++++++++++++++++++++++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  10 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  15 +++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  10 ++++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   4 ++++
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c       |   1 -
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c       |   2 ++
  drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  32 ++++++++++++++++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       |  79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |   6 ++++++
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  19 ++++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c   |   2 --
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c  |   2 --
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c       |  15 ++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c       |   4 ++--
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h       |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x.h           |   7 +++++++
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c   |   5 +++++
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c       |   8 ++------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c      |  34 ++++++++++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c       |  69 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h    |   4 +++-
  drivers/net/wireless/mediatek/mt76/sdio.c             |  17 ++++++++++------
  drivers/net/wireless/mediatek/mt76/testmode.c         |   2 +-
  drivers/net/wireless/mediatek/mt76/tx.c               |   2 +-
  drivers/net/wireless/mediatek/mt76/usb.c              |   3 ++-
  39 files changed, 656 insertions(+), 145 deletions(-)

