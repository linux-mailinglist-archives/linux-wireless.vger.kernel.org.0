Return-Path: <linux-wireless+bounces-36766-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNjDDlc7D2qZIAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36766-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 19:05:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C85A9D7B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8F835A6B52
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5195730B508;
	Thu, 21 May 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C2wTQ8dw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2C2DC79A;
	Thu, 21 May 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377729; cv=none; b=hZZJWLjhN4UMvHuUIpEzp0p7F8VSL3+VWA90BkhiKqcMMf6reyD5pUb4UqUfZRnDV3Zj2B+5uMdO6fBuyCyl/KutZG7zOIqdG4BNMOKX6VvSWQAtENmuLjSB0P4l5Ywp5cl8Co6kWHHluSsoZy2r45rcx1C5vAhokhVnsWpjRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377729; c=relaxed/simple;
	bh=hAUkly468AWRI/7CgdtEVIMENOcJpCc6kG7C4EPEaSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXSIoVEJOigXspdILabkJCKqKqd1T4WB1CP34RIa1GVsIKNUj93ES1sRfuMa/PlcS8qGluNcmEK5cMlbPq/PNlVqxi1IFF8huxlbbAGf9fs3sqov3RYTxkZBf0ViovLrUYf+hdK4Skd4HpjOzthLfWbd05ds6hcead3eTpYouT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C2wTQ8dw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XdRokCzNV5ZuuttIV0+NR6JuOvOxi7zH8GQjAXfoeI4=; t=1779377727; x=1780587327; 
	b=C2wTQ8dwCuFlSTtbA0H7Xb9OSKAHJtjRqKsAxni+x0b/aly0ClP6tKALMQHdd1wc/WxiDo1UqOW
	OSWYkplsY9WAsxW5tm3e0p++kf6u7dtqmAqhfCUaAiqPviv1QTFtyz1GQLJHzaLl8/OGn109JhuGs
	JhVAzFCF1OpLVwNMhlzijqbzqtNsusHcRgFBQavjEXHaP8P7ZC2siLeL8C5DZg7GaKGWjxapcnbyR
	1+Old0qC+q5SU0Wx7CAOM7TFA6r484KS6z4LXuVkRBRFkWsWN4sWjEByGg70OxVY9T8WeGYqcLGz7
	arBB5UzQcO+BFSxmxghmDaqmcF+AI6LCKl2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wQ5Qi-0000000ChVU-2AKh;
	Thu, 21 May 2026 17:35:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2026-05-21
Date: Thu, 21 May 2026 17:34:34 +0200
Message-ID: <20260521153519.380276-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-36766-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A95C85A9D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

OK this one's pretty sparse, but I'll send it anyway so we
can sync up with wireless content etc. later. I guess I'll
get more driver pull requests for -next as we get to later
RCs.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 878492af7d503f4b093ea903173500be00e9cbe7:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-14 10:08:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2026-05-21

for you to fetch changes up to 1d174fec87850e1005db9b106f84bbbb19cb59b9:

  ARM: dts: omap2: add stlc4560 spi-wireless node (2026-05-20 12:05:04 +0200)

----------------------------------------------------------------
Not much going on here right now:
 - mac80211/hwsim:
   - some NAN related things
   - MCS/NSS rate issues with S1G
 - p54: port SPI version to device-tree
 - (a few other random things)

----------------------------------------------------------------
Arnd Bergmann (3):
      dt-bindings: net: add st,stlc4560/p54spi binding
      p54spi: convert to devicetree
      ARM: dts: omap2: add stlc4560 spi-wireless node

Daniel Gabay (1):
      wifi: mac80211: allow cipher change on NAN_DATA interfaces

Deepanshu Kartikey (1):
      wifi: mac80211_hwsim: reject NAN on multi-radio wiphys

Ilan Peer (2):
      wifi: mac80211: Allow per station GTK for NAN Data interfaces
      wifi: mac80211_hwsim: Do not declare NAN support for Extended Key ID

Johannes Berg (3):
      wifi: mac80211: check stations are removed before MLD change
      wifi: mac80211_hwsim: advertise NPCA capability
      wifi: cfg80211: add a function to parse UHR DBE

Lachlan Hodges (2):
      wifi: mac80211: skip NSS and BW init for S1G sta
      wifi: mac80211: don't recalc min def for S1G chan ctx

Miri Korenblit (1):
      wifi: mac80211: don't call ieee80211_handle_reconfig_failure when not needed

Rosen Penev (2):
      wifi: rt2x00: allocate anchor with rt2x00dev
      wifi: plfxlc: use module_usb_driver() macro

 .../bindings/net/wireless/st,stlc4560.yaml         |  61 +++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/ti/omap/omap2.dtsi               |   4 +
 .../arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi |  12 ++
 arch/arm/mach-omap2/board-n8x0.c                   |  18 --
 drivers/net/wireless/intersil/p54/p54spi.c         |  67 +++----
 drivers/net/wireless/intersil/p54/p54spi.h         |   3 +
 drivers/net/wireless/purelifi/plfxlc/usb.c         |  25 +--
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |   3 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c     |  11 +-
 drivers/net/wireless/virtual/mac80211_hwsim_main.c |  31 +++-
 include/net/cfg80211.h                             |  10 ++
 net/mac80211/chan.c                                |  10 +-
 net/mac80211/key.c                                 |  22 ++-
 net/mac80211/link.c                                |   5 +-
 net/mac80211/sta_info.c                            |  17 ++
 net/mac80211/util.c                                |   6 +-
 net/wireless/chan.c                                | 130 ++++++++++++++
 net/wireless/tests/chan.c                          | 192 ++++++++++++++++++++-
 19 files changed, 508 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/st,stlc4560.yaml

