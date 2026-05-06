Return-Path: <linux-wireless+bounces-36010-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC7yELA9+2nUXwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36010-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6C44DABBF
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94162300828A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931D3ED5D8;
	Wed,  6 May 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="G2W5il9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E623D7FF
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073004; cv=none; b=IC+4BKy+q2ZDMoeWs9eyFSVstSzGXfpFEfU4xsR8Ll0LJT2PgI01c2yHenzmP6DH1LPixyoOROvPWQBN7rlNKXKLdPty3jSUBcLVlX5stPDqT9qjd+Af0qxxmvBkIm4Q1PLV3eG2U4H4phna2VT9/ijOGvlCAk3A3LcuthBxoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073004; c=relaxed/simple;
	bh=TM+5R3prQDWrnKjAKpyUBJ9Jq12EBpvTYaZi1vGnXbY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MiMB0m3Ol95+GQv32R/aaUhF1UHK1mGQwRUQfQ+zg1RUdXIwCqEXPEWbQYPlI7f+CXukJrzjP4DLM2WGtSjevZCK0wXlGTCFJclvx7FgMlIEuIvmmwxU6ccPVhJNR3Gf4L0T1UKIexd2jIcLaVYobrkma/LNIqypaDDZo9d7etg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=G2W5il9+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DA0lE41986792, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073000; bh=+b9ImRn4QVnErFGrb4pe1r9zgZmGZu4U9VxjWJ8SmPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=G2W5il9+RxryHUDAylcvUH2/GpJgFKkSGpRHz3pKW1TTFpGM2jYSzylZQpAnVCD2e
	 3bcMKQ/6ktXiN2uRkKGa8OA+SRhu1a+BNY+AQdpuh0bBxlz+8h2Ms22YNb8xNlwIDJ
	 orr9Z8dQpuOyBczPDtC6g3dbPv9P7203AdYjN4YC64IztLIJNZbYXImS6i6EN5ZpwI
	 4EqpNOX5GeWMIYpC6GBOMke11MzoU5Uh18q9CWuzDP6pMENQY4oC0UfZq7S77hI87D
	 ex/5MzadX7ztISKVQztC047C2O+lmuYoQrPJ7pq8+oMrngyhEtC71kjCHCWgNjiXgn
	 Csm3qKUb2C9Bw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DA0lE41986792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 6 May 2026 21:10:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:00 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 21:10:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 00/14] wifi: rtw89: improve radiotap especially HE SIG-A/SIG-B
Date: Wed, 6 May 2026 21:09:46 +0800
Message-ID: <20260506131000.1706298-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: AF6C44DABBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36010-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

The rtw89 has supported monitor mode already, but only basic channel,
bandwidth and data rate. This patchset introduces SIG-A/SIG-B from
PHY status IE-09/IE-10 to fill VHT and HE-SU/HE-TB/HE-MU/HE-EXT_SU
radiotap.

Hardware captures HE-MU packets by target BSS color and AID, so add a
debugfs to fill the target values.

Ping-Ke Shih (14):
  wifi: rtw89: add AMPDU to radiotap
  wifi: rtw89: add VHT beamformed to radiotap
  wifi: rtw89: SNIFFER_MODE bit along IEEE80211_CONF_MONITOR
  wifi: rtw89: phy: define PHY status IE length for generations
  wifi: rtw89: phy: enable IE-09/IE-10 PHY status report for monitor
    mode
  wifi: rtw89: move HE radiotap to an individual function
  wifi: rtw89: fill VHT radiotap
  wifi: rtw89: fill HE-SU/HE-TB/HE-MU/HE-EXT_SU radiotap
  wifi: rtw89: debug: make implementation of beacon_info entry in order
  wifi: rtw89: add debugfs entry of monitor mode options to capture
    HE-MU packets
  wifi: rtw89: phy: check length before parsing PHY status IE
  wifi: rtw89: phy: skip trailing 8-byte zeros of PHY status IE for
    RTL8922D
  wifi: rtw89: phy: support PHY status IE-09 GEN2 for RTL8922D
  wifi: rtw89: check skb headroom before adding radiotap

 drivers/net/wireless/realtek/rtw89/core.c     | 615 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  29 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 165 +++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |   8 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  44 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   8 +
 drivers/net/wireless/realtek/rtw89/phy_be.c   |   8 +
 drivers/net/wireless/realtek/rtw89/txrx.h     | 108 +++
 8 files changed, 879 insertions(+), 106 deletions(-)


base-commit: c1ed02655f9134d6af6a01a58b734329c2f4f22c
-- 
2.25.1


