Return-Path: <linux-wireless+bounces-3904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 190BB85F3BF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 10:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70290B235E2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5779EA;
	Thu, 22 Feb 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qp3Vu7db"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185F2261F
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592432; cv=none; b=BA3kgIIwYdjdg3xpzgxaRIHxsiDy99OKgWZQZ/ogKjVGju00IaHSlvtOHYIOvCFSN7718sjYbd30+2hntMdiNHpTJ34YVBKyC79md2g3oJym2Umo2F8emkzMobpS5gMRqPnz/Vi0uHdtLjKVKZ6HPUJmr9qeS8gM3QXtYfwBYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592432; c=relaxed/simple;
	bh=oMJRfUYEHBB3hgli/uDD3FBDAcOkECVby5aJRADyEYU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=CGFM/69neNljDpWkZymIv8aZ3nZLgn8EXE+lNeCD6nDJIqH15sPg2QaKXpr1cFahuyDnq1xIUQlA5BQyyz9zodu7iSzKlF3Svw004uipO6FzDjOI3NKj/JsbCTJjfFqEvFAhpVx7txLiUa3ut/4+i+JhYJh33t4YVNRTCl+Lbp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=qp3Vu7db; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3CqEMc5ofdkWfMGJBc+WrGAxA1OyLeKTw59y2mH6rOE=; b=qp3Vu7db5Jjy9Xgzv8wZr+Aic4
	GsruEj5Aj2+YhF29gMXba/2vA0W4hR6FMS2vqT/LMDOfXWhEAJC99LmgU9gcE18a1NPaHAcNUcePS
	3L78dKzdS9iGM0gLCziFG9SufrCMIZs6CDx4U863Rcmyl0vjDZx8+xXDfKtNQTqrv3gA=;
Received: from [2a01:599:108:beb2:c898:ce5a:2747:57ad] (helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rd4wM-00Fktl-SW; Thu, 22 Feb 2024 10:00:27 +0100
Message-ID: <d70f8729-9f84-4fe6-9291-3dd50fe4321c@nbd.name>
Date: Thu, 22 Feb 2024 10:00:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2024-02-22
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

here's my first request for 6.9

- Felix

The following changes since commit f3ec643947634bed41b97bd56b248f7c78498eab:

   wifi: wilc1000: revert reset line logic flip (2024-02-21 20:56:45 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2024-02-22

for you to fetch changes up to 8fa556045696fffd78fe5c3386c6e77d5a368098:

   dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981 (2024-02-22 09:55:19 +0100)

----------------------------------------------------------------
mt76 patches for 6.9

* fixes
* support for newer chips in the mt7915 driver
* mt7996 improvements
* page pool performance improvement

----------------------------------------------------------------
Benjamin Lin (3):
       wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
       wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands
       wifi: mt76: mt7996: fix HIF_TXD_V2_1 value

Colin Ian King (1):
       wifi: mt76: Remove redundant assignment to variable tidno

Dacio Romero (1):
       wifi: mt76: mt76x2u: add netgear wdna3100v3 to device table

Deren Wu (5):
       wifi: mt76: mt792xu: enable dmashdl support
       wifi: mt76: mt7925: update PCIe DMA settings
       wifi: mt76: mt7925: support temperature sensor
       wifi: mt76: mt7921e: fix use-after-free in free_irq()
       wifi: mt76: mt7925e: fix use-after-free in free_irq()

Felix Fietkau (1):
       wifi: mt76: mt7915: fix error recovery with WED enabled

Gen Xu (1):
       wifi: mt76: mt792x: fix ethtool warning

Hao Zhang (1):
       wifi: mt76: mt7925: fix mcu query command fail

Howard Hsu (1):
       wifi: mt76: mt7996: fix HE beamformer phy cap for station vif

Leon Yen (1):
       wifi: mt76: mt7921: fix a potential association failure upon resuming

Lorenzo Bianconi (5):
       wifi: mt76: mt7996: fix fw loading timeout
       wifi: mt76: usb: create a dedicated queue for psd traffic
       wifi: mt76: usb: store usb endpoint in mt76_queue
       wifi: mt76: move wed common utilities in wed.c
       wifi: mt76: set page_pool napi pointer for mmio devices

Michael Lo (1):
       wifi: mt76: mt7921: fix suspend issue on MediaTek COB platform

Michael-CY Lee (1):
       wifi: mt76: mt7996: mark GCMP IGTK unsupported

Ming Yen Hsieh (13):
       wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
       wifi: mt76: mt7925: fix wmm queue mapping
       wifi: mt76: mt7925: fix fw download fail
       wifi: mt76: mt7925: fix WoW failed in encrypted mode
       wifi: mt76: mt7925: fix the wrong header translation config
       wifi: mt76: mt7925: add support to set ifs time by mcu command
       wifi: mt76: mt7925: fix the wrong data type for scan command
       wifi: mt76: mt792x: add the illegal value check for mtcl table of acpi
       wifi: mt76: mt7921: fix incorrect type conversion for CLC command
       wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz channel config from ACPI
       wifi: mt76: mt792x: update the country list of EU for ACPI SAR
       wifi: mt76: mt7921: fix the unfinished command of regd_notifier before suspend
       wifi: mt76: fix the issue of missing txpwr settings from ch153 to ch177

Peter Chiu (8):
       wifi: mt76: disable HW AMSDU when using fixed rate
       wifi: mt76: check txs format before getting skb by pid
       wifi: mt76: mt7915: update mt798x_wmac_adie_patch_7976
       dt-bindings: net: wireless: mt76: add interrupts description for MT7986
       wifi: mt76: mt7996: check txs format before getting skb by pid
       wifi: mt76: mt7996: fix TWT issues
       wifi: mt76: mt7996: disable AMSDU for non-data frames
       wifi: mt76: mt7996: remove TXS queue setting

Quan Zhou (1):
       wifi: mt76: mt7925: add flow to avoid chip bt function fail

Rafał Miłecki (1):
       dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981

Shayne Chen (3):
       wifi: mt76: mt7915: add locking for accessing mapped registers
       wifi: mt76: mt7996: add locking for accessing mapped registers
       wifi: mt76: connac: set correct muar_idx for mt799x chipsets

StanleyYP Wang (1):
       wifi: mt76: mt7996: fix efuse reading issue

rong.yan (1):
       wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band

  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |  33 ++++++++--
  drivers/net/wireless/mediatek/mt76/Makefile                       |   2 +-
  drivers/net/wireless/mediatek/mt76/agg-rx.c                       |   2 +-
  drivers/net/wireless/mediatek/mt76/dma.c                          | 106 ++----------------------------
  drivers/net/wireless/mediatek/mt76/dma.h                          |   9 ++-
  drivers/net/wireless/mediatek/mt76/mac80211.c                     |  26 +++-----
  drivers/net/wireless/mediatek/mt76/mmio.c                         | 107 ------------------------------
  drivers/net/wireless/mediatek/mt76/mt76.h                         |  61 +++++++++++------
  drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |   5 ++
  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h             |   5 ++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |   7 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |   7 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |   4 ++
  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c             |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                   |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |   9 +--
  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |  55 +++++++++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c                   |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |   6 ++
  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  13 ++++
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |   1 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  13 ++++
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |   2 +
  drivers/net/wireless/mediatek/mt76/mt7925/init.c                  |  56 ++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7925/main.c                  |  26 +++++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c                   | 212 +++++++++++++++++++++++++++++++++++++++--------------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h                   |  94 ++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h                |   1 +
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c                   |   3 +
  drivers/net/wireless/mediatek/mt76/mt792x.h                       |   2 +
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c              |  38 ++++++-----
  drivers/net/wireless/mediatek/mt76/mt792x_core.c                  |   1 +
  drivers/net/wireless/mediatek/mt76/mt792x_dma.c                   |  15 ++++-
  drivers/net/wireless/mediatek/mt76/mt792x_regs.h                  |   8 +++
  drivers/net/wireless/mediatek/mt76/mt792x_usb.c                   |  74 ++++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c                   |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7996/init.c                  |  12 ++--
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c                   |  81 +++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c                  |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                   |  32 +++++----
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                   |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c                  |  74 +++++++++++++--------
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                |   6 +-
  drivers/net/wireless/mediatek/mt76/usb.c                          |  52 ++++++++-------
  drivers/net/wireless/mediatek/mt76/wed.c                          | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  49 files changed, 977 insertions(+), 527 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/wed.c

