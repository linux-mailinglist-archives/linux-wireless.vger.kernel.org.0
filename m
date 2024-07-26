Return-Path: <linux-wireless+bounces-10547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B079293D2EB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27101C20BF7
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4A17839D;
	Fri, 26 Jul 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LZsW3FEr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADCE57E;
	Fri, 26 Jul 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996806; cv=none; b=X2rxPor9DmckYOFfZuClGnhXFV+0jjLzeQrpX/yxNXKGBeQfAqWRXznyBgZiOqRh2Tgse2tRhLM3gsjg56VLU5mfWvaFBch1kJokAR/yZgzjfFSK4gCAwFi/vG8WEXSqG5Y5aTdfhe7LevjnKKA6gc0s9dymZ7ZN3Y48ghT71fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996806; c=relaxed/simple;
	bh=xj3qE1f9sSLs9EsaCqzFX9EJ7PB5/mR2BkcE4A5NZyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BKk4hKxi2dcG95hNvUgFA9ZoHboN2KJCc7C0Cw+V+oUYly4b4K6x54CHBznpYkB4qLRhaSRzx5XVSozVavMWfMDnE0AXoIoiHWtnFhOAffZPMtj2sVq9aki38rm1d6EHnfFJtjbi0G7VLZJXUVmX1omdScLu/X+uwWN6y/Wmrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LZsW3FEr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=YuKRgDBUsBRgeKTMGAxFVNivIhewPmu67YjS6PFuHcY=; t=1721996804; x=1723206404; 
	b=LZsW3FEruNqCw/U+Dy8BwMAPTh8/lQIkdgOJK3fAbYFU4MafpDwkvF2Y8ar8gTWnWqQfkHQ63va
	/VuEaXzHIxd0peLV/NwDHbv52q4h3whV4fe9vijzLUSJd9sCWvpSvMAxK1ecwimo45tHN7FvrRc/n
	67Q7Fhj9d3W/c28IJ1T1HiqTm4WZ6v2RIhEieLtLcHXZfPcg5Tseanbxqvwh+WWAr4Rl5DIhsPKok
	TJ1alfoySmG7sP6g7Tk2u7AVyauWEVYm/tMunXuqq9QRu5MMBF4OiDLslRSmWC0Yoqpm8d+L856L2
	xuJLGZdwjtF2I5CTo5q7RVukvX3OarfgQXMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sXK1w-00000000RDP-2Zh2;
	Fri, 26 Jul 2024 14:26:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-07-26
Date: Fri, 26 Jul 2024 14:24:39 +0200
Message-ID: <20240726122638.942420-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So, given netdevconf last week, and vacations etc., I'm sending
now a couple of more urgent/obvious fixes. Next week Kalle will
be around again I think, so he'll probably have more fixes for
drivers then, but I figured I'd get a few obvious ones out.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 1722389b0d863056d78287a120a1d6cadb8d4f7b:

  Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-07-25 13:32:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-07-26

for you to fetch changes up to a47f3320bb4ba6714abe8dddb36399367b491358:

  wifi: ath12k: fix soft lockup on suspend (2024-07-26 12:38:10 +0200)

----------------------------------------------------------------
Couple of more urgent fixes:
 * ath12k: wowlan loop iteration issue
 * ath12k: fix soft lockup on suspend in certain scenarios
 * mt76: fix crash when removing an interface
 * mac80211: fix injection crash with some drivers that
   don't want monitor vif
 * cfg80211: fix S1G beacon parsing in scan
 * cfg80211: fix MLO link status reporting on connect

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: fix reusing outside iterator in ath12k_wow_vif_set_wakeups()

Johan Hovold (1):
      wifi: ath12k: fix soft lockup on suspend

Johannes Berg (2):
      wifi: mac80211: use monitor sdata with driver only if desired
      wifi: cfg80211: correct S1G beacon length calculation

Sean Wang (1):
      wifi: mt76: mt7921: fix null pointer access in mt792x_mac_link_bss_remove

Veerendranath Jakkam (1):
      wifi: cfg80211: fix reporting failed MLO links status with cfg80211_connect_done

 drivers/net/wireless/ath/ath12k/pci.c            |  3 ++-
 drivers/net/wireless/ath/ath12k/wow.c            |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  1 +
 net/mac80211/cfg.c                               |  7 +++++--
 net/mac80211/tx.c                                |  5 +++--
 net/mac80211/util.c                              |  2 +-
 net/wireless/scan.c                              | 11 ++++++++---
 net/wireless/sme.c                               |  1 +
 8 files changed, 25 insertions(+), 13 deletions(-)

