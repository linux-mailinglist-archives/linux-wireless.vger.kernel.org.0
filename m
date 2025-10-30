Return-Path: <linux-wireless+bounces-28404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90443C1FA7C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 11:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D81664E3B75
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830834DB57;
	Thu, 30 Oct 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iGkZal15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702272F6912;
	Thu, 30 Oct 2025 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821642; cv=none; b=mnIAfhtFaZZokf+Xtakd7u0CG3XcvQ3lNeZh2LdJMZcQBg6r8JYIHZlxwXrkqWmeMxra+QJ6/waKrMTNzC2pMRxzzxeL1F+KWUVauyjxRsP9vsW7pZDi4MxMG3Y1YxcWwZ+Vk6lxAhBaom2rVZAHWNmZS37ccfQfTjuFtrKmjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821642; c=relaxed/simple;
	bh=VWjj/kRcxHvsndhq0mi1/7NOzkYH341Lx2nCqr9teK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5itDCa2GveZxfVOzsTNzEK3vvJ1im6Jc/NitfLnaBiE3yMqURb4dKJIPzPbfTWc5G6xcoJfV5h2lKj2txCPhw09B56F3oRPz/9lGZdBwjBN0kv80vq4ws5bOVFoKZIRtk4hDr7b64hRD50xV4m1s4oOGXEnQmSQOEkd/o4CIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iGkZal15; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jhu3gs226fwk1OFheCkwnwl4FEvtNxJJBGkYol5O01c=; t=1761821640; x=1763031240; 
	b=iGkZal15XPmlyZj+zPbi0JCRBS6u/t4gSUjVH8cbOyrzNVPHIwcOAdmtDR7EBmcCFam3iv14hKg
	HzYTWoIOF+3P4cUKmz2WiTsigfLT3FV45x5BoYsa8qYqENTkQu7172rABB2CxoE2FTJGm5QVn9GDY
	hYTHUC3gJlr7C93rP4JhO4eo42bYszThI7itdG4ni0NQAMbruq2lHmetxnRNecTav1h/Obym39XTI
	L9DePhhjkGsx4YVR7/uWN4l6W99F5MK4jss0fXjwu2SL8pYcQ5hV+88QAWVsJdaRNHg9yfvICmi/o
	4TYQJHWEgSNzzJLg9PSaJK5kyuehQzTuegDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vEQI2-0000000GM5j-0qzT;
	Thu, 30 Oct 2025 11:53:58 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-10-30
Date: Thu, 30 Oct 2025 11:53:26 +0100
Message-ID: <20251030105355.13216-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And for -next, nothing really interesting right now,
I expect I'll get a lot more content from the drivers
still in the future.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 55db64ddd6a12c5157a61419a11a18fc727e8286:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-16 11:06:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-10-30

for you to fetch changes up to 508dfc1f2ccdc480893332aaeb5e8d076769f7c3:

  wifi: mac80211: Allow HT Action frame processing on 6 GHz when HE is supported (2025-10-30 08:40:47 +0100)

----------------------------------------------------------------
Not that many changes this time:
 - mac80211:
   - improved VHT radiotap reporting
   - S1G improvements
   - multi-radio monitor improvements
   - HT action frame handling on 6 GHz
   - mesh rate tracking improvements
   - CSA handling improvements
 - cfg80211: multi-radio debugfs
 - rt2x00: improvements for embedded platforms

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211_hwsim: advertise puncturing feature support

Benjamin Berg (1):
      wifi: mac80211: add RX flag to report radiotap VHT information

Johannes Berg (1):
      wifi: mac80211: reset CRC valid after CSA

Lachlan Hodges (2):
      wifi: mac80211: get probe response chan via ieee80211_get_channel_khz
      wifi: cfg80211: default S1G chandef width to 1MHz

Roopni Devanathan (2):
      wifi: cfg80211: Add debugfs support for multi-radio wiphy
      wifi: cfg80211: Add parameters to radio-specific debugfs directories

Rosen Penev (2):
      wifi: rt2x00: check retval for of_get_mac_address
      wifi: rt2x00: add nvmem eeprom support

Ryder Lee (1):
      wifi: cfg80211/mac80211: validate radio frequency range for monitor mode

Sakari Ailus (1):
      net: wireless: Remove redundant pm_runtime_mark_last_busy() calls

Sarika Sharma (1):
      wifi: mac80211: fix missing RX bitrate update for mesh forwarding path

Thomas Wu (1):
      wifi: mac80211: Allow HT Action frame processing on 6 GHz when HE is supported

 drivers/net/wireless/ath/wil6210/pm.c          |   1 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c |  35 ++++-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.h |   2 +
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c |   6 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00.h    |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c |  10 +-
 drivers/net/wireless/ti/wl18xx/debugfs.c       |   3 -
 drivers/net/wireless/ti/wlcore/cmd.c           |   1 -
 drivers/net/wireless/ti/wlcore/debugfs.c       |  11 --
 drivers/net/wireless/ti/wlcore/main.c          |  36 ------
 drivers/net/wireless/ti/wlcore/scan.c          |   1 -
 drivers/net/wireless/ti/wlcore/sysfs.c         |   1 -
 drivers/net/wireless/ti/wlcore/testmode.c      |   2 -
 drivers/net/wireless/ti/wlcore/tx.c            |   1 -
 drivers/net/wireless/ti/wlcore/vendor_cmd.c    |   3 -
 drivers/net/wireless/virtual/mac80211_hwsim.c  |   1 +
 include/net/cfg80211.h                         |  18 +++
 include/net/ieee80211_radiotap.h               |  20 ++-
 include/net/mac80211.h                         |   2 +
 net/mac80211/mlme.c                            |  14 +-
 net/mac80211/rx.c                              | 172 ++++++++++++++++++-------
 net/wireless/core.c                            |  15 +++
 net/wireless/debugfs.c                         |  33 +++++
 net/wireless/nl80211.c                         |   3 +
 net/wireless/util.c                            |   6 +-
 26 files changed, 288 insertions(+), 114 deletions(-)

