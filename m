Return-Path: <linux-wireless+bounces-12875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A5979AC8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78A01F22C87
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 05:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386028FA;
	Mon, 16 Sep 2024 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CGcdTNGs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569E282FA
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464767; cv=none; b=OS29DbqF0wWn8rJw3iId8ytiuD5k3TvtzWLoonTenHZzONLg2A++YRJ/vz4c+4Qjk/UPd0hE01zOUSc/zqXNV+PWb7zpxvDiBgxMKRS9oLoAlxXUSLNGeDBGfrN5p6e5gj92/2T41bHGQiaG51tbjKHaefrZcdBAIwtv4TkpktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464767; c=relaxed/simple;
	bh=CYdJExQ70Xz4uzNvwZ+Tp26QJtqiu1OdgY9gcB8tnJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DG9WRVC5Na5eS1LqBjPCpUYsob6ogS2rJhMfk/FyBDnacIMwi8mQB20b4YI+/MMt6A9h7KQ0rnWwrWvU8Ywb3PR/dNlkjqAIBcPH3G4mK5lAyjDeIkJmnbDcxOqegWnPmbtIAkgCPE531TmK8dK7WO4Tc0Rc55Gm8Yq6dAXmF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CGcdTNGs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G5Wf3J22631555, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726464761; bh=CYdJExQ70Xz4uzNvwZ+Tp26QJtqiu1OdgY9gcB8tnJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CGcdTNGsk7B8BhpFBg1ymVSDoEemYM+GnOkFwK+bnp5UwaJ0fzY4WkH50gfNSv/v3
	 pkGGmb3ubTjNVO0EICY2GqYtcfFsuxWTzqos07XXjtXh52J4WNfloohI2Ksobr3pgu
	 Ep/S+nIs2cHNH+TlEE9oNqhVRmUnX5NeQWIou0kxZdUTbPUjKhGAB0tDedhKV9ivvC
	 aYeA2MDujPCP8znY5VrYUAhYD1zsARklhnq2tz34+pAKy/zikdLjQps0MWs2Fx7bV+
	 HdCWlyfeQi13X5RBw8XYTgv1IkGSbQz7aEcQbeV8pnXmbVuecUvz7ZGFE5yr2JnFEF
	 mkwam/CVg+H4A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G5Wf3J22631555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:32:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 13:32:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Sep
 2024 13:32:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/7] wifi: rtw89: separate rtw89_{vif,sta}_link from rtw89_{vif,sta} for MLO
Date: Mon, 16 Sep 2024 13:31:51 +0800
Message-ID: <20240916053158.47350-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

To support MLO, this step is to separate link's info from vif/sta. 

Since most fields are belong to link, first two patches are to just rename
rtw89_{vif,sta} to rtw89_{vif,sta}_link (add suffix _link only), but the
naming is not all look correct at this point. However, we can quickly
review these two patches because don't change logic at all, 

The patches 3/7 and 4/7 are to dereference vif/sta by link_id dynamically
instead of default link or bss.

To configure a set of settings along with link, consolidate link related
stuffs into functions by patches 5/7 and 6/7.

The last patch adds rtw89_{vif,sta} back and correct the placements of
sturct fields that are not belong to link but trivially renamed by first
two patches, and also correct the use of rtw89_{vif,sta}. Then the naming
becomes normal.

After this patchset, MLO is still not enabled. More coming refactors like
power-save, multi-links support for TX/RX path, hardware configure for
multi-links, and etc are preparing.

Zong-Zhe Yang (7):
  wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
  wifi: rtw89: rename rtw89_sta to rtw89_sta_link ahead for MLO
  wifi: rtw89: read bss_conf corresponding to the link
  wifi: rtw89: read link_sta corresponding to the link
  wifi: rtw89: refactor VIF related func ahead for MLO
  wifi: rtw89: refactor STA related func ahead for MLO
  wifi: rtw89: tweak driver architecture for impending MLO support

 drivers/net/wireless/realtek/rtw89/cam.c      | 259 +++--
 drivers/net/wireless/realtek/rtw89/cam.h      |  24 +-
 drivers/net/wireless/realtek/rtw89/chan.c     | 215 +++--
 drivers/net/wireless/realtek/rtw89/chan.h     |   4 +-
 drivers/net/wireless/realtek/rtw89/coex.c     | 153 +--
 drivers/net/wireless/realtek/rtw89/coex.h     |   6 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 887 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/core.h     | 421 ++++++---
 drivers/net/wireless/realtek/rtw89/debug.c    | 127 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 633 +++++++------
 drivers/net/wireless/realtek/rtw89/fw.h       | 192 ++--
 drivers/net/wireless/realtek/rtw89/mac.c      | 700 ++++++++------
 drivers/net/wireless/realtek/rtw89/mac.h      |  98 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 652 ++++++++++---
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  69 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 399 +++++---
 drivers/net/wireless/realtek/rtw89/phy.h      |   7 +-
 drivers/net/wireless/realtek/rtw89/ps.c       | 109 ++-
 drivers/net/wireless/realtek/rtw89/ps.h       |  14 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |  79 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  13 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  10 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |  37 +-
 drivers/net/wireless/realtek/rtw89/wow.c      | 217 +++--
 drivers/net/wireless/realtek/rtw89/wow.h      |  10 +-
 29 files changed, 3518 insertions(+), 1867 deletions(-)

-- 
2.25.1


