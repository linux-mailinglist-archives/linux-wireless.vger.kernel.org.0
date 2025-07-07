Return-Path: <linux-wireless+bounces-24885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40481AFBBAF
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C35424F6F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19B266B6F;
	Mon,  7 Jul 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="sbAk4lX8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191EB224B0E
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916538; cv=none; b=CYz78oNWk4ljzArGyYsfcfx+Ap5IFOCsXf06AWaR4yatj/6l5kqWN0yxlgnMeTAwRFADLuqNQxuq6fiHbmM4iJFMHdZGv0alS/IgMex03gJpjwCrAMrqcmwB8XXnW244JyB6BujtAcNJlBgL64/E6/xVF267UGT0yickt7g5emk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916538; c=relaxed/simple;
	bh=nDiEpdt8gKWfY9wSVMpBNMw24DdtoSxpYy+XSRJreEA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=KF3XOw0EZjF5WAXsgYEBRQ7DDFuY/nFB0QXvnG1zI80baWkcBkeUz0wnAFfi8WZhxqtW9/WSmt5a8GeIA81w3UFO1t6n2tAlbf/NeFyAdnpKs0O4vVi0NRKbka7QU22KXlsFFgS52G6BfgMD9QtV98Qyhabe9wLMhwPowreb0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=sbAk4lX8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8XbnuTh2NND+SBWxffck8Ue72UbjDN/+mCNbYgX7ErU=; b=sbAk4lX8KshpFDatm5hg3iLI6A
	Z76PfNCcc4yvwv9IvK1IekA1RsDaKvzlz9/NXZvraVAaenA8z2qPUg4pXilRSOlv7wqoeOekwKHEo
	WtTBgMFN6RsMtLZ8rcB8a9C5678gIx0Fk0U89kyLjsew4vZhmwBEsabn0XKnTKdzOzrU=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uYrWI-0083sL-07;
	Mon, 07 Jul 2025 21:28:54 +0200
Message-ID: <2890ea02-d19e-422f-bd80-72a3a1d0ff91@nbd.name>
Date: Mon, 7 Jul 2025 21:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2025-07-07
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

Here's my first mt76 pull request for 6.17

- Felix

The following changes since commit 28aa52b6189f1cc409f96910c63fa1b99370b99e:

   Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 10:40:50 -0700)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2025-07-07

for you to fetch changes up to e553ac0d7616d6bcd06ed0c5f6126ce83097b31a:

   wifi: mt76: mt7921s: Introduce SDIO WiFi/BT combo module card reset (2025-07-07 18:10:32 +0200)

----------------------------------------------------------------
mt76 patches for 6.17

- firmware recovery improvements for mt7915
- mlo improvements
- fixes

----------------------------------------------------------------
Dan Carpenter (1):
       wifi: mt76: mt7925: fix off by one in mt7925_mcu_hw_scan()

David Bauer (3):
       wifi: mt76: mt7915: mcu: increase eeprom command timeout
       wifi: mt76: mt7915: mcu: lower default timeout
       wifi: mt76: mt7915: mcu: re-init MCU before loading FW patch

Felix Fietkau (1):
       wifi: mt76: fix vif link allocation

Leon Yen (1):
       wifi: mt76: mt7921s: Introduce SDIO WiFi/BT combo module card reset

Lorenzo Bianconi (9):
       wifi: mt76: mt7996: Fix secondary link lookup in mt7996_mcu_sta_mld_setup_tlv()
       wifi: mt76: mt7996: Rely on for_each_sta_active_link() in mt7996_mcu_sta_mld_setup_tlv()
       wifi: mt76: mt7996: Do not set wcid.sta to 1 in mt7996_mac_sta_event()
       wifi: mt76: mt7996: Fix mlink lookup in mt7996_tx_prepare_skb
       wifi: mt76: mt7996: Fix possible OOB access in mt7996_tx()
       wifi: mt76: mt7996: Fix valid_links bitmask in mt7996_mac_sta_{add,remove}
       wifi: mt76: mt7996: Add MLO support to mt7996_tx_check_aggr()
       wifi: mt76: mt7996: Move num_sta accounting in mt7996_mac_sta_{add,remove}_links
       wifi: mt76: Get rid of dma_sync_single_for_device() for MMIO devices

Ming Yen Hsieh (1):
       wifi: mt76: mt792x: improve monitor interface handling

  drivers/net/wireless/mediatek/mt76/channel.c         |  4 ++--
  drivers/net/wireless/mediatek/mt76/dma.c             | 11 +++--------
  drivers/net/wireless/mediatek/mt76/mcu.c             |  4 ++++
  drivers/net/wireless/mediatek/mt76/mt76.h            |  7 ++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 30 ++++++++++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  2 ++
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |  2 ++
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  4 ++--
  drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  1 +
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c      | 48 +++++++++++++++++++++++-------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c     | 80 ++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 17 ++++++++---------
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c       |  6 ++++--
  drivers/net/wireless/mediatek/mt76/wed.c             |  6 +-----
  15 files changed, 182 insertions(+), 98 deletions(-)

