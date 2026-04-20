Return-Path: <linux-wireless+bounces-34993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEBTKlyg5WkqmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-34993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044B42691A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C2893004DFF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891953112BD;
	Mon, 20 Apr 2026 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Euuoq3hv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC72FD1B1
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656474; cv=none; b=XDGZE9ejSFQ1HcWJG4Fgpu+TgwmwpIHGlHAi5DlWcBhY3xm2y+p1loz6ZtB0GRH//wHNeBgYCAf4qp+KvNQmuT5UrhYrExNvPUzApMjA9wLfzWxprNdzKfJUHkR7/q0kMIcntA2Rx+G7FensuxjdVaP4j1EK/fnBPrybsIDQn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656474; c=relaxed/simple;
	bh=iFizv/zbh3I+BvJJNVEUwNmGd5rXKOR/N3Z7hX609Eg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tP+VYg8HEc157zBhlM2SeqpxH+eBgSkE9cHdxlBtGMz9Hs/sUOdHjoqacd2OUxFICRKTksomZyEpfn4kxfCK9r66ayPVpJSnVbRQgUHtRvR2sZKnorLtceggvar2b2F7NR81+V3u1byBFC7FI+DLVNFUQjdIfey6VjXs2hCGs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Euuoq3hv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3f9LX1426475, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656469; bh=KR4MIBXuNooudm17sxnCdtRTNsVt7MjGzB3TwmAmg4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Euuoq3hvdSUJx5tbdlBXKQzPkx6nQAVZ/Cb5mcz3pIuZ6iO+8eSgiK6FsuRlrRiQO
	 8VnH1v506t0ioHhjfPBZR+iRjyM2t+MyNo3H9uHdyaZp/6bt3HZGSpxE/u3WeuDzQV
	 vnAywKux8YIZrDhQJby+16lNWwdaMnRZTuGObaUamPd0LiPEBMZcIG9cCAhGYs4PvT
	 ihSBa6NFaYjOTPmoyRPWXr8ycO4PN6tfvlCE4lHP7U99h/1c13zq9OLB4tpaSiMFTf
	 sLIoUg5PnbYI1f0EaXSPJsPBC4Xd67twEtgW8j9UNprgMwaAO2piBRVz+HgpBLj9Hj
	 eS+pu5PdQaZaw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3f9LX1426475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:41:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:41:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:41:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 00/16] wifi: rtw89: add USB IO offload and some refactors
Date: Mon, 20 Apr 2026 11:40:35 +0800
Message-ID: <20260420034051.17666-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-34993-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4044B42691A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

First patch is to correct typo which was missed because of two patchset
were submitted at the same time; patch 7 is similar. The second one is to
improve user experience on realtime applications, such as remote desktop.

The patches 3-5 are to add switches by debugfs to control the functions for
latency-sensitive scenario.

Patch 6 is to fix data type to prevent overflow for 6GHz RNR scan.

Patches 8-10 are to add USB IO offload, which packs IO into a H2C command
and firmware does all IO in one go. This is to improve overall IO
performance.

Patch 11 is trivial to add a USB device.

Patch 12-14 are to fix issues rarely found by MCC test. Address them and
fix.

Patch 15-16 are to support RTL8922D's new design, which hardware does
backup RF calibration data on two PHY with the same channel to support
runtime switch channels without doing calibration again, for example eMLSR
that should change to 5GHz or 6GHz channel quickly.

Chia-Yuan Li (2):
  wifi: rtw89: add IO offload support via firmware
  wifi: rtw89: offload DMAC and CMAC init IO to firmware

Chih-Kang Chang (3):
  wifi: rtw89: use struct to fill C2H recv ack
  wifi: rtw89: check scan C2H event recv ack instead of C2H event done
    ack
  wifi: rtw89: suspend DIG when remain-on-channel

Eric Huang (2):
  wifi: rtw89: phy: support static PD level setting
  wifi: rtw89: use firmware offload for PHY and RF batch register writes

Johnson Tsai (3):
  wifi: rtw89: debug: disable hw_scan for latency-sensitive scenarios
  wifi: rtw89: debug: disable inactive power save to reduce bus overhead
  wifi: rtw89: 8832cu: Add ID 2c7c:8206 for RTL8832CU

Ping-Ke Shih (1):
  wifi: rtw89: 8922d: fix typo rx_freq_frome_ie

Po-Hao Huang (1):
  wifi: rtw89: 8852a: refine power save to lower latency

Shin-Yi Lin (1):
  wifi: rtw89: Correct data type for scan index to avoid infinite loop

Zong-Zhe Yang (3):
  wifi: rtw89: 8852bt: configure support_noise field explicitly
  wifi: rtw89: chan: introduce new helper to get entity current
    configuration
  wifi: rtw89: 8922d: update RF calibration flow for MLD

 drivers/net/wireless/realtek/rtw89/chan.c     |  90 +++--
 drivers/net/wireless/realtek/rtw89/chan.h     |  21 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 111 +++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  97 ++++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  96 +++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 349 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  75 +++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  89 ++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   7 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  57 ++-
 drivers/net/wireless/realtek/rtw89/phy.c      |  94 +++--
 drivers/net/wireless/realtek/rtw89/phy.h      |  30 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c   |   8 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |   6 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   2 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852cu.c    |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  18 +-
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |  22 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  40 +-
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c |  92 +++--
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h |   1 +
 28 files changed, 1130 insertions(+), 197 deletions(-)


base-commit: fa489a77e3267e05df95db96ba98e141ec07cbd9
-- 
2.25.1


