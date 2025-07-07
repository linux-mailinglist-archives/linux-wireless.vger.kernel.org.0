Return-Path: <linux-wireless+bounces-24886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAFAFBC78
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BEB7A1A7B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F921C190;
	Mon,  7 Jul 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JeWPaLRJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1872214A6A
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751919928; cv=none; b=is3K2dlVkinluCQc/Ee/6qiLcmx6yJACkrog5K1TU+33lUxvzzB4pajG7JDh/NKeqmm0SOo0tmA5TWKSliMPRHJzFvBaalilmUNKERxhR/oI0BVIVYwca1Sy9tI++v1fh4biI8vjJIWvupCsLlnyoPWDbTtXlCllPVsqva7u7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751919928; c=relaxed/simple;
	bh=LJTnbmhTL1DMZhV+UXqfmZeJ6dx5zLKM290oh1VcSvY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nMbTet832jd07M+9wr5NUGIX2jeINAmiJJiOvJrNrNz8dPQWk28Lx0cmCECUcprMb12qR2S8dr/mn4FOVRfxqkNCQewJRkC/iL8DStaAvU1rA0vowu1o9YFm5hHX7J84Zy86NLf/FdFpIyVLgd6Vk7+RImo+qCJslGAlueTT41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JeWPaLRJ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZEYsJsgfj2jz5OT+u+0dYUIC3FRzPhCqYcly7kwyEbY=; b=JeWPaLRJ1CE0vlVrJn4V5tyZiR
	q9082baVLgeKQFzr9TB56kVZvr9eF2oFH0LS1d+TjEM6BvcQjhMIfXtQxiSWWmtgXMW6byaSKrl6e
	Ii23MDawsYLgIkrmwU/Z0KbfIu8YczhxW1jw+hLSHpdKc15raETCTk1LkJwf3Hs8Ufbg=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uYsOy-0084Mk-0m;
	Mon, 07 Jul 2025 22:25:24 +0200
Message-ID: <8cbd9e22-f1f3-4b67-bc3b-676d6f68b044@nbd.name>
Date: Mon, 7 Jul 2025 22:25:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-fixes 2025-07-07
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

Here's my mt76-fixes pull request for 6.16

- Felix

The following changes since commit 737bb912ebbe4571195c56eba557c4d7315b26fb:

   wifi: prevent A-MSDU attacks in mesh networks (2025-07-07 10:54:13 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-fixes-2025-07-07

for you to fetch changes up to eb8352ee2d1e70f916fac02094dca2b435076fa4:

   wifi: mt76: mt792x: Limit the concurrent STA and SoftAP to operate on the same channel (2025-07-07 18:07:43 +0200)

----------------------------------------------------------------
mt76 fixes for 6.16

----------------------------------------------------------------
Deren Wu (2):
       wifi: mt76: mt7925: prevent NULL pointer dereference in mt7925_sta_set_decap_offload()
       wifi: mt76: mt7921: prevent decap offload config before STA initialization

Felix Fietkau (2):
       wifi: mt76: add a wrapper for wcid access with validation
       wifi: mt76: fix queue assignment for deauth packets

Henry Martin (1):
       wifi: mt76: mt7925: Fix null-ptr-deref in mt7925_thermal_init()

Leon Yen (1):
       wifi: mt76: mt792x: Limit the concurrent STA and SoftAP to operate on the same channel

Lorenzo Bianconi (5):
       wifi: mt76: Assume __mt76_connac_mcu_alloc_sta_req runs in atomic context
       wifi: mt76: Move RCU section in mt7996_mcu_set_fixed_field()
       wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()
       wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl()
       wifi: mt76: Remove RCU section in mt7996_mac_sta_rc_work()

Michael Lo (1):
       wifi: mt76: mt7925: fix invalid array index in ssid assignment during hw scan

Ming Yen Hsieh (2):
       wifi: mt76: mt7925: fix the wrong config for tx interrupt
       wifi: mt76: mt7925: fix incorrect scan probe IE handling for hw_scan

  drivers/net/wireless/mediatek/mt76/mt76.h            |  10 +++++++
  drivers/net/wireless/mediatek/mt76/mt7603/dma.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |  10 ++-----
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |   7 ++---
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |   6 ++---
  drivers/net/wireless/mediatek/mt76/mt76x02.h         |   5 +---
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |   4 +--
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  12 +++------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |   5 +---
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |   6 ++---
  drivers/net/wireless/mediatek/mt76/mt7921/main.c     |   3 +++
  drivers/net/wireless/mediatek/mt76/mt7925/init.c     |   2 ++
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |   6 ++---
  drivers/net/wireless/mediatek/mt76/mt7925/main.c     |   8 +++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  79 ++++++++++++++++++++++++++++++++++++++++++-------------
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      |   5 ++--
  drivers/net/wireless/mediatek/mt76/mt7925/regs.h     |   2 +-
  drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  32 +++++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c      |   5 +---
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c      |  52 +++++++------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c     |   5 ++--
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h   |  16 ++++--------
  drivers/net/wireless/mediatek/mt76/tx.c              |  11 ++++----
  drivers/net/wireless/mediatek/mt76/util.c            |   2 +-
  27 files changed, 301 insertions(+), 197 deletions(-)

