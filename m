Return-Path: <linux-wireless+bounces-26962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCBBB4175C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F5E7B4C89
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46DD2E172E;
	Wed,  3 Sep 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HAb1cpRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661932E0929;
	Wed,  3 Sep 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886174; cv=none; b=kqF0uPsGxKCd8zOUq7KFZ7klLKo65xWF94Z20lvADaNP7iPrgcFfs9ZB3VduZbsPs4KR/rr45IEMRoh92cK1dHwAn5Ave2qHkR5tWSCjeYLZW0ijHd2lNLjREMKOYQWCa+G5mxbWNSVo3fHgSgv6OIcbC+CZCmpIYI5vOJxlN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886174; c=relaxed/simple;
	bh=+lSzxg+n6/3CSlip3cxQ26uCo+SnAKN+vy41GDUA3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oT4p7Utv5WlrsiB0wnigk6KuHEA66zeFJtUmyNnquk+53nSXL1mxtuf5LRGuklOsCUd6V6XvTJ5+TbuwSei0zUJHBVZM1dNs6TvmPlTonvJg/4m7RwxR7QIuP4PQ/QySS1iIUZOfaDoc7/stdW4Xtk/ym8nC5AZfJTkumM2q304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HAb1cpRX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4BiwWrjrs/+t0ChYjzAOUJYugdaKad2zFR9O8blg5YM=; t=1756886172; x=1758095772; 
	b=HAb1cpRXpIljp0t/XLUTbwpnxKNYLZWfEnZcUjcBoy2WaV91ESqwfrSPrDMGq/XbJd7oxwK3okD
	1CHL57koMrtg0w9iQxmQ/GJjOtkeKeb5gWHU7wKUPfZ0TfDkZ0LJtsIngH7wGe3t9C4X4aVHeNYiO
	eiYAM4HbbhH0uuLVlgb29pzA2xOzM6AXaom875fy2/BwAdJQAaAcK19NlkYW/QPsuuUTZ6HnAIOK3
	wbyB6EOZJ6ycNr5zfvOOidVMubRw9wskEFRUl2ipCONaro8CuN58WEXUk/9D+axRcakjl6JQwAe1n
	gA1rwDqXd7qdppHfhFHoySHphYZMQmFjwFiQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1utiLg-0000000BUrQ-2Y7d;
	Wed, 03 Sep 2025 09:56:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-09-03
Date: Wed,  3 Sep 2025 09:55:25 +0200
Message-ID: <20250903075602.30263-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Just a few fixes this time, mostly buffer overflows and two
Qualcomm driver fixes. I know there's some more stuff coming
for iwlwifi, but I didn't have it yet.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 629840e208bfe10008da3e8366493f3d71b21251:

  Merge tag 'wireless-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-08-29 13:35:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-09-03

for you to fetch changes up to 27893dd6341b929f87d45fc4d65c5778179319dd:

  Merge tag 'ath-current-20250902' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2025-09-03 09:40:20 +0200)

----------------------------------------------------------------
Just a few updates:
 - a set of buffer overflow fixes
 - ath11k: a fix for GTK rekeying
 - ath12k: a missed WiFi7 capability

----------------------------------------------------------------
Ajay.Kathat@microchip.com (1):
      wifi: wilc1000: avoid buffer overflow in WID string configuration

Dan Carpenter (3):
      wifi: cw1200: cap SSID length in cw1200_do_join()
      wifi: libertas: cap SSID len in lbs_associate()
      wifi: cfg80211: sme: cap SSID length in __cfg80211_connect_result()

Johannes Berg (1):
      Merge tag 'ath-current-20250902' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Rameshkumar Sundaram (1):
      wifi: ath11k: fix group data packet drops during rekey

Ramya Gnanasekar (1):
      wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable stations

 drivers/net/wireless/ath/ath11k/core.h             |   2 +
 drivers/net/wireless/ath/ath11k/mac.c              | 111 +++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.c              |   1 +
 drivers/net/wireless/marvell/libertas/cfg.c        |   9 +-
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.c |  39 ++++++--
 drivers/net/wireless/microchip/wilc1000/wlan_cfg.h |   5 +-
 drivers/net/wireless/st/cw1200/sta.c               |   2 +-
 net/wireless/sme.c                                 |   5 +-
 8 files changed, 147 insertions(+), 27 deletions(-)

