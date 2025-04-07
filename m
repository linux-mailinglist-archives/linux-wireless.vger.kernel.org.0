Return-Path: <linux-wireless+bounces-21194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3868A7DE57
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 14:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7DA18905E2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424AD23C8BB;
	Mon,  7 Apr 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="CYyuTdr6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.mt-integration.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F89235C1B;
	Mon,  7 Apr 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030621; cv=none; b=AwVCOYQj9lPyAcVZRdpgh9rZW9lfRiCvoitg9osA+XmqdM9/gmlNGv2ruB44Kp/iDcyNGPBSQR0mUofIBKGdKujcI3EdVVkEDjJJkPd9nL6iX4+6tJsuFUyRwSeIrTvha/G7PXXRj37OyHr1AS/cJDxVFN+mFx9tcCP48E57Mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030621; c=relaxed/simple;
	bh=Cn8y1roU4T2yyk1XBrxBzZJZDvINl/pglNbQ7A7CcLc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REyOucPPjmLavV/7n0ExVrJ61JSr2NFjXfgA2CkBzaf9OnAPS3WqCNIqJDCDPyXF4FThCEXORN4EhFqoXkRrvcUei6KDTMHm518fjXBTAlLBQhkRphFV57T2iz+C4gtMDCJ4nazMKImygG5nSxeR3a2yMJfyRXsJxV60f0LPvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=CYyuTdr6; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id C2EB8C002F;
	Mon,  7 Apr 2025 15:56:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru C2EB8C002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1744030613; bh=PmtzUcvDEqjG9thpbwcNwT9iIDmf3jCLNdj4AA+vM2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=CYyuTdr6Yww3LrG2sRk/FpHRjt+ps9AO8FAw7Uk/Ft+eEZA/uEl5ip2Rx2nwF4mtm
	 aStN7jl8IwukTP/PUtzRFO1awaIadsHS8S4D+xssu8fBjbeym/78G0FpMtpPWtO/1y
	 zPXf1xzzgHUz5rzV8ouoQFGbJPGH2K8t0h+M3Fg4tMuD1n/Fu/WWExNZGw3CmuNyaV
	 EIurFJJwIWS5ht/z0bKUnHpngkhTlStmGejtBgGQKRKGewKvMgi71Gu4AvRY3DEvOT
	 Yeq5Ca9mjnKYWv7/JUT9hcNemdLhEipBE5mZcWsg7F8gMX0xhHV7mnQHM/DL2Ik8zB
	 CK/Pz6fq4w99w==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon,  7 Apr 2025 15:56:53 +0300 (MSK)
Received: from db126-1-abramov-14-d-mosos.mti-lab.com (172.25.20.118) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 15:56:52 +0300
From: Ivan Abramov <i.abramov@mt-integration.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Ivan Abramov <i.abramov@mt-integration.ru>,
	<linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2 0/3] Avoid calling WARN_ON() on allocation failure in cfg80211_switch_netns()
Date: Mon, 7 Apr 2025 15:53:41 +0300
Message-ID: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch02.mt.ru (81.200.124.62) To
 mmail-p-exch01.mt.ru (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/04/07 11:03:00
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: i.abramov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 54 0.3.54 464169e973265e881193cca5ab7aa5055e5b7016, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;lore.kernel.org:7.1.1;ksmg01.maxima.ru:7.1.1;81.200.124.61:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192430 [Apr 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/07 08:57:00 #27861720
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/04/07 11:03:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

This series is inspired by similar series in ieee802154. As far as I know,
there were no WARN_ON triggers in this code so far, but since it's almost
identical to cfg802154_* counterparts, same changes are proposed.

Link to ieee802154 series: https://lore.kernel.org/netdev/20250403101935.991385-1-i.abramov@mt-integration.ru/T/

v2: Add 2 patches. Also make sure to commit against latest
netdev/net.

Ivan Abramov (3):
  cfg80211: Restore initial state on failed device_rename() in
    cfg80211_switch_netns()
  cfg80211: Avoid calling WARN_ON() on -ENOMEM in
    cfg80211_switch_netns()
  cfg80211: Remove WARN_ON() in cfg80211_pernet_exit()

 net/wireless/core.c | 53 +++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

-- 
2.39.5


