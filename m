Return-Path: <linux-wireless+bounces-23010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63195AB8648
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 14:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44503BCBDF
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F41298CB5;
	Thu, 15 May 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ckPoYWGW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAC298C28;
	Thu, 15 May 2025 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311475; cv=none; b=U1mNvesBT7NGFCTvcp2DJjJr/6vZ+YscEbzEx3o9O2E+3DcV3cIFR9wppBLwDScaDJ0w3vEtKFqD4L8kgoXf/LrExHkpcMPmoZjbGtjKAn1qUgBzp351jJyWAqPdVKUxd4ubLjOMonlThx5NFgzurVg3MhXCw7CTPo6N95S8pCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311475; c=relaxed/simple;
	bh=upvheuT9U+vPFBmxrb2y/zHTlu/4dEiyt30tRJxT7mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyuTqYgPspZ5dJEk+OpgX7QloF4zF2nacpqWiOlH0aKw4Csey+ee/hy514ivUTikHBy2kr23TN0mYemQoYYNRBN2qRUE1uUkTsgODmMiRHXTcFrMRW4HY6hM2tQ4NfptJ3mpCDCcb6K9XczGT0lcSm/cSiBBxFEi1Y+3fCIiVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ckPoYWGW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=F0f0AG38+HQO0YXdjlttYURzgFgAqkO1MV32GipdyCk=; t=1747311474; x=1748521074; 
	b=ckPoYWGWLfGuMGOoXn6jirfp4t7yjwPSwj7mPx5KI3pes00QPKnujtNrBln1eUqupfZND9BewWe
	hmKk/c+j/eD/sDaFSUBS3rOY/aa6KQm5WqmT8/Zy22gn2E01j6ogjqeU1wLwIA0GZ3EKheurKE6dp
	E89OMR1N1aO6x8H5e2PbW0fP2taUIPmLQhYy5fzJ2PXY2z7nqQIrhM7lvzp7OZIlBW+PGCv/OaROM
	OI4uc9kkUbYGjLtTCz0ebnf+vxjTMhLFYKcwNtfx1NfwixE7fN6vqv9srULEzE9T2mTtvFB8KVIgf
	sDRxKJ47pTepXK7lLCpR4aWkUH5zqqPv+Yew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFXX5-0000000BD09-1ZY7;
	Thu, 15 May 2025 14:17:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-05-15
Date: Thu, 15 May 2025 14:16:56 +0200
Message-ID: <20250515121749.61912-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So originally I thought last week was the end of it, but
mt76 fixes just got in now, and I threw in a counted_by
fix as well.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 2c89c1b655c0b06823f4ee8b055140d8628fc4da:

  Merge tag 'net-6.15-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-08 08:33:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-05-15

for you to fetch changes up to 943aeda0d75a24038723414dff6f63e337821197:

  Merge tag 'mt76-fixes-2025-05-15' of https://github.com/nbd168/wireless (2025-05-15 13:44:57 +0200)

----------------------------------------------------------------
Couple of stragglers:
 - mac80211: fix syzbot/ubsan in scan counted-by
 - mt76: fix NAPI handling on driver remove
 - mt67: fix multicast/ipv6 receive

----------------------------------------------------------------
Fedor Pchelkin (1):
      wifi: mt76: disable napi on driver removal

Johannes Berg (1):
      Merge tag 'mt76-fixes-2025-05-15' of https://github.com/nbd168/wireless

Kees Cook (1):
      wifi: mac80211: Set n_channels after allocating struct cfg80211_scan_request

Ming Yen Hsieh (1):
      wifi: mt76: mt7925: fix missing hdr_trans_tlv command for broadcast wtbl

 drivers/net/wireless/mediatek/mt76/dma.c        | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 ++--
 net/mac80211/main.c                             | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

