Return-Path: <linux-wireless+bounces-29847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E95CC9775
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 21:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21CC5303212B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32EE303C87;
	Wed, 17 Dec 2025 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wtngo0LO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F673002DC;
	Wed, 17 Dec 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766002488; cv=none; b=SN0X6mWReX6eJOQneWr343mDnRNRdJXIBEleCO7tohsJWj9YAb1MMLyWwVdrCkaPqkB1XJRo4qf4hW3CiwbcOyo85bFWqwPtJbHikRH1tllLSSjpVcKdsGyNRq41wvyN6JsrIIpVJp8yx1X2318+DKHD5DNh5cNm0IXMmdE1qlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766002488; c=relaxed/simple;
	bh=cQ08mY9z2Gemqbief5bingl5ACj337jaMdct73LU3NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hLybHUrP4+DbHsVGXT5DzQNIslsPRrdBVTXd2aEzDVP63OBP0dQsEwIIXCar7AVgvW8H/sTXRYcfKLVbP0/5sBTmVYyq+vNKLsaWCx9pOzOt/jHyBzrNmLw8XN+A4L5Cxqr2BiOb9ctF/2WlU6noezFoa8PoJdwCtGuVcB7eA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wtngo0LO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=DXEzkvJjySPMsSzjfUcca6+8ktMG185qSDMZrNC4W7s=; t=1766002486; x=1767212086; 
	b=wtngo0LOyXTlcYlDvUgz3P0sh5RsKAcCCBx0CNZZNQZ+6pPd1vb5cXHVtfoK0JKpF1yIDnMxqQH
	ofRwthOPwpR2Uk54v4cdfWInar54Il2TQNHT4SPa6+iiBmtSCSYCvIgcD90tDyODihPoDllXT1W3n
	yrmQPqpxK68JnVWMhR+virQrgyBHcvu+RYCvLS+skt2NEut60yKAoHb6jnjVwO9pPjGrHg9xZKnFW
	iiyVmku9Dl+yxEcZnNe+1W4JfA2RU8851akzmAwlOhwDBG/vKkX1Gq7oEg528mf0foXqrM+kwUrVG
	Lp5fvW+39Cc59Z2hdzOLq6qKG5pxzZ/5rijg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVxv2-0000000CDwn-00u2;
	Wed, 17 Dec 2025 21:14:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-12-17
Date: Wed, 17 Dec 2025 21:12:20 +0100
Message-ID: <20251217201441.59876-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

First set of changes for -rc, and then I'm pretty much ready
to sign off for vacations for a bit, I hope nothing critical
comes up.

The tag message is almost bigger than the code changes which
I'd say isn't a bad sign :)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-12-17

for you to fetch changes up to 81d90d93d22ca4f61833cba921dce9a0bd82218f:

  wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP (2025-12-16 18:52:58 +0100)

----------------------------------------------------------------
Various fixes all over, most are recent regressions but
also some long-standing issues:

 - cfg80211:
    - fix an issue with overly long SSIDs

 - mac80211:
    - long-standing beacon protection issue on some devices
    - for for a multi-BSSID AP-side issue
    - fix a syzbot warning on OCB (not really used in practice)
    - remove WARN on connections using disabled channels,
      as that can happen due to changes in the disable flag
    - fix monitor mode list iteration

 - iwlwifi:
    - fix firmware loading on certain (really old) devices
    - add settime64 to PTP clock to avoid a warning and clock
      registration failure, but it's not actually supported

 - rtw88:
    - remove WQ_UNBOUND since it broke USB adapters
      (because it can't be used with WQ_BH)
    - fix SDIO issues with certain devices

 - rtl8192cu: fix TID array out-of-bounds (since 6.9)

 - wlcore (TI): add missing skb push headroom increase

----------------------------------------------------------------
Aloka Dixit (1):
      wifi: mac80211: do not use old MBSSID elements

Bitterblue Smith (1):
      Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"

Dan Carpenter (1):
      wifi: cfg80211: sme: store capped length in __cfg80211_connect_result()

Dmitry Antipov (1):
      wifi: mac80211: fix list iteration in ieee80211_add_virtual_monitor()

Johannes Berg (2):
      Merge tag 'rtw-2025-12-15' of https://github.com/pkshih/rtw
      wifi: mac80211: don't WARN for connections on invalid channels

Jouni Malinen (1):
      wifi: mac80211: Discard Beacon frames to non-broadcast address

Moon Hee Lee (1):
      wifi: mac80211: ocb: skip rx_no_sta when interface is not joined

Morning Star (1):
      wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

Peter Åstrand (1):
      wifi: wlcore: ensure skb headroom before skb_push

Ping-Ke Shih (1):
      wifi: rtw88: limit indirect IO under powered off for RTL8822CS

Ville Syrjälä (1):
      wifi: iwlwifi: Fix firmware version handling

Yao Zi (1):
      wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP

 drivers/net/wireless/intel/iwlwifi/iwl-drv.c         |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c         |  7 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c         |  7 +++++++
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/sdio.c            |  4 +++-
 drivers/net/wireless/realtek/rtw88/usb.c             |  3 +--
 drivers/net/wireless/ti/wlcore/tx.c                  |  5 +++++
 net/mac80211/cfg.c                                   | 10 ----------
 net/mac80211/iface.c                                 |  2 +-
 net/mac80211/mlme.c                                  |  5 ++++-
 net/mac80211/ocb.c                                   |  3 +++
 net/mac80211/rx.c                                    |  5 +++++
 net/wireless/sme.c                                   |  2 +-
 13 files changed, 41 insertions(+), 19 deletions(-)

