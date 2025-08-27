Return-Path: <linux-wireless+bounces-26692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBFB37EEF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7BE1BA4745
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777102FE045;
	Wed, 27 Aug 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Hk0RKfZ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5AD279324
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287331; cv=none; b=FFNslPGVKiN4Lt/GhIeYiUwiHdbGf1XNz9gGWXwG1e5KVNjqvg5EQn2RAcxzWXspZnQPTFM6BA0Wirco8tCdYQ41K4/E4aIXO4kkcryR77MYZdsrxoZ+ANrMbCI8kI3U/M9ZBSJtERrRgPuGgYNJLTHqjnRP1AqLmsRgrF0KDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287331; c=relaxed/simple;
	bh=S8nZ3htfzU43CyIrQCMrWtXjaO7WOwDi9s2ubwak7Wc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=CLB6G4o+0xuXrPb2GnyuibSsoLrAsyisCKxlTvNZjIJbSG8wHB1Uuh2rWznKVITwg9KILiL8hkWnlKoYCIv1QYQbvnsVCR+qNrl2H4Y+AvlLeOmC/X8Xgt8Cd7Iba6SquVewvqRMuuSqs23F8t06HEEXfXCtAndKgb5kBSYDHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Hk0RKfZ8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cntDFRZB1hJzk98b1mcycz4sGo5xylc6X8gowbVsaxM=; b=Hk0RKfZ8SPhqy8WRfoTCT82inp
	711vHuDPNNwm8ao6Q1lrGy5201ODzVbPgnHlzHhzsEJElGpMv/dQiQq/6tIpFCDNY1PWbpoqYamp9
	p6C57ULiHZs9Uimki176R9FroAFhH56+jBP2OhUQiUhjQt3hXqGhl9DZLasg0vAE1pmk=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urCYx-00Fncz-1u;
	Wed, 27 Aug 2025 11:35:27 +0200
Message-ID: <c545b939-183e-4f28-9f79-6cfcf0c24c3d@nbd.name>
Date: Wed, 27 Aug 2025 11:35:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-fixes 2025-08-27
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

Here's my mt76-fixes pull request for 6.17

- Felix

The following changes since commit 7e2f3213e85eba00acb4cfe6d71647892d63c3a1:

   wifi: mac80211: increase scan_ies_len for S1G (2025-08-26 13:47:21 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-fixes-2025-08-27

for you to fetch changes up to 49fba87205bec14a0f6bd997635bf3968408161e:

   wifi: mt76: fix linked list corruption (2025-08-27 11:27:57 +0200)

----------------------------------------------------------------
mt76 fixes for 6.17

- fix regressions from mt7996 MLO support rework
- fix offchannel handling issues on mt7996
- mt792x fixes
- fix multiple wcid linked list corruption issues

----------------------------------------------------------------
Chad Monroe (1):
       wifi: mt76: mt7996: use the correct vif link for scanning/roc

Felix Fietkau (8):
       wifi: mt76: prevent non-offchannel mgmt tx during scan/roc
       wifi: mt76: mt7996: disable beacons when going offchannel
       wifi: mt76: mt7996: fix crash on some tx status reports
       wifi: mt76: do not add non-sta wcid entries to the poll list
       wifi: mt76: mt7996: add missing check for rx wcid entries
       wifi: mt76: mt7915: fix list corruption after hardware restart
       wifi: mt76: free pending offchannel tx frames on wcid cleanup
       wifi: mt76: fix linked list corruption

Harshit Mogalapalli (1):
       wifi: mt76: mt7925: fix locking in mt7925_change_vif_links()

Janusz Dziedzic (1):
       wifi: mt76: mt7921: don't disconnect when CSA to DFS chan

Ming Yen Hsieh (3):
       wifi: mt76: mt7925: fix the wrong bss cleanup for SAP
       wifi: mt76: mt7925u: use connac3 tx aggr check in tx complete
       wifi: mt76: mt7925: skip EHT MLD TLV on non-MLD and pass conn_state for sta_cmd

Nathan Chancellor (1):
       wifi: mt76: mt7996: Initialize hdr before passing to skb_put_data()

  drivers/net/wireless/mediatek/mt76/mac80211.c      | 43 ++++++++++++++++++++++++++++++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt76.h          |  1 +
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 12 +++++-------
  drivers/net/wireless/mediatek/mt76/mt7921/main.c   |  5 +----
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  2 +-
  drivers/net/wireless/mediatek/mt76/mt7925/main.c   |  7 ++++++-
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 12 ++++++++----
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 60 ++++++++++++++++++++++++++++++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  5 +++++
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 15 ++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
  drivers/net/wireless/mediatek/mt76/tx.c            | 12 ++++++------
  12 files changed, 124 insertions(+), 51 deletions(-)

