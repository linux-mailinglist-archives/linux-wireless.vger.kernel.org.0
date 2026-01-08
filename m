Return-Path: <linux-wireless+bounces-30575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A3D0436F
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E293023561
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97FD423A7D;
	Thu,  8 Jan 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dFB5skw8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837640FD89;
	Thu,  8 Jan 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880908; cv=none; b=Vng8Lb+8bqtkLRHiyxEC/BVw0zXUAcOwNYuYAK4/0qgaHBMhGpmBceRd/6ew04kHRNA6TPfrjFpp4xOkkVGGYXiTLV898XYZGlZLicSnGOyAKxBb+tcucWrghheELc97kC+MHCS3IiTzEuqWxrawXHiMEmjbaaS9UNNoHkZH3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880908; c=relaxed/simple;
	bh=/a6tor3t3BHXPf6cV1FkvZgBVzI83Fmb2fWyG8E85nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzdM75hZ006gjkAnS76/zlfNO3wTpycige3UKFW4rMSBXheVQVmZrplPCuarKA0u1vwH91E0oKcLyiuY1go7DCErrmfhnxqRjwozh5m5tXKAum+vzNL20Gf6lmdINUfZd1c4GAGeNrr5OWefogr1jE4Y+t60HEs1s6WfmvaOUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dFB5skw8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=CHsYpmrl3ptgn/SH1+1dZo3E9tUPIlXIh6WzL+1xlrU=; t=1767880907; x=1769090507; 
	b=dFB5skw8p+/z8w6j6pkGCnsYOXuVlI8+anoooXH/nJSHa8Zhu8CGHKEjAUVWQpmmgG55qfCqyBn
	Eji3C3Y71mShBlo7zHfiSbMi1FcaZ+Y4kSxH3RQU+RYIjXeSYSUMhCGzLZwlFPezI1LB0azR/VkXP
	xh56ZZWgHCm6xHao1kh//DBBnTGkp5YPlmHuoGAu9WU0PUBjHPMbjRYvpaNgGhbW+sLFzbHzdPE5+
	38YGjcXcK3+w3mqqj8HyDx48H59XHCi/pqhznP4Yu0NHE15TvBgPKw1lG+7Z/l1jeO3I6iK6e8B4a
	pwOFXgBmiq2tVJnXpfzNECYALUpWNPt6s+XA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdqa8-00000006XK8-3ShP;
	Thu, 08 Jan 2026 15:01:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-01-08
Date: Thu,  8 Jan 2026 15:01:23 +0100
Message-ID: <20260108140141.139687-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

After the holidays and all we don't seem to have that
much yet, but I've collected what we have for now.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit dbf8fe85a16a33d6b6bd01f2bc606fc017771465:

  Merge tag 'net-6.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-12-30 08:45:58 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-01-08

for you to fetch changes up to a203dbeeca15a9b924f0d51f510921f4bae96801:

  wifi: mac80211: collect station statistics earlier when disconnect (2026-01-08 13:33:11 +0100)

----------------------------------------------------------------
Couple of fixes:
 - mac80211:
   - long-standing injection bug due to chanctx rework
   - more recent interface iteration issue
   - collect statistics before removing stations
 - hwsim:
   - fix NAN frequency typo (potential NULL ptr deref)
   - fix locking of radio lock (needs softirqs disabled)
 - wext:
   - ancient issue with compat and events copying some
     uninitialized stack data to userspace

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: mac80211: collect station statistics earlier when disconnect

Benjamin Berg (2):
      wifi: mac80211_hwsim: fix typo in frequency notification
      wifi: mac80211_hwsim: disable BHs for hwsim_radio_lock

Eric Dumazet (1):
      wifi: avoid kernel-infoleak from struct iw_point

Johannes Berg (1):
      wifi: mac80211: restore non-chanctx injection behaviour

Miri Korenblit (1):
      wifi: mac80211: don't iterate not running interfaces

 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 +++---
 net/mac80211/chan.c                           | 3 +++
 net/mac80211/sta_info.c                       | 7 ++++---
 net/mac80211/tx.c                             | 2 ++
 net/wireless/wext-core.c                      | 4 ++++
 net/wireless/wext-priv.c                      | 4 ++++
 6 files changed, 20 insertions(+), 6 deletions(-)

