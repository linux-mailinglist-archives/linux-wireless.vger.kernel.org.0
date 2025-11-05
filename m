Return-Path: <linux-wireless+bounces-28627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED14C3673D
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFC82503E61
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8B314B64;
	Wed,  5 Nov 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OOsIX2So"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F321CFF6;
	Wed,  5 Nov 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356513; cv=none; b=c91BCjyTc6g8IDQBK8YYQL73O/18P0TqWYTu5WmnVHky3IezZOi51Z1hG1q4imHxl7V9gqOjNqInoZ+DueptV00DxPFX7/pUcgLJoyJb5PZ7vjOdNfRkRjjp8T4/mCAZcMBCElehR4uLvp4TxQXh/pgsLDYr3SgbmDi7R0p4+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356513; c=relaxed/simple;
	bh=t+L3paWPyf9PWAThlaXWpo8uJ67IO6GD03pH2WW1R+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwHMBWBdb95StTVbFFW9cFgXSBll/pdXTiFLLI4vRUonHmNFA7wHYgeety8Zt/xAfQyuRozUqSy3UJynvsDCzN8hCqcZbkLvWsrKv5Ye3g4anj0LdZFGz+Eh4hOkcOa5FvZ1z7BZg+sWeafN7wJwM8EuJ1y4jfjbUOxABttbKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OOsIX2So; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QcYSytRGfauinZCaCXXy0XR17MQGl5jx8hWozUNb6lU=; t=1762356512; x=1763566112; 
	b=OOsIX2So9uGO+VvD9DlY4Z1+ZPwqr/dz6a7qAW9jPbrVVqfQsi2Zi/tDYYsgFaSfPVqsMoj4A2m
	b0PMYQws/O9UEganEq+6WEzXTpquMCQp0R5n+Jb4TCdGQOvegzw1rRSjNLV1K3b4ELa/SpcpEL4rP
	qNxqm3sVvKAvD036h4b93qMXUlyi3ddDL3Q+HMRLawvl8h57/FwfSAmEe4x1YHR6cFkMJBM8Mqt/5
	L2nMg+PIdajybbTeDo2ExvtpLy4W45vx+ppMQ+VgcljOJhH3EYtRU8XPvmUPNrT09BteYaqTqiz/b
	oIzQAdoqWcLayW3V/BJWEvtLJYb8AlVz+nFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGfR0-0000000FJBF-0RFD;
	Wed, 05 Nov 2025 16:28:30 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-11-05
Date: Wed,  5 Nov 2025 16:27:39 +0100
Message-ID: <20251105152827.53254-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Just two bugfixes this time, I know of one more but
that's going to wait for next week, it's not that
urgent. We also have that netlink socket matching
issue more generally, so will have to fix that in
other places as well.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit b7904323e76b074c59f113ca423e76d90da26875:

  Merge tag 'wireless-2025-10-30' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-10-31 12:30:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-11-05

for you to fetch changes up to 4c740c4d8bac5569c5bf5f86db65ce779178f9a2:

  Merge tag 'ath-current-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2025-11-05 16:18:48 +0100)

----------------------------------------------------------------
Just two small fixes:
 - ath12k: revert a change that caused performance regressions
 - hwsim: don't ignore netns on netlink socket matching

----------------------------------------------------------------
Johannes Berg (1):
      Merge tag 'ath-current-20251103' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Martin Willi (1):
      wifi: mac80211_hwsim: Limit destroy_on_close radio removal to netgroup

Miaoqing Pan (1):
      Revert "wifi: ath12k: Fix missing station power save configuration"

 drivers/net/wireless/ath/ath12k/mac.c         | 122 ++++++++++++--------------
 drivers/net/wireless/virtual/mac80211_hwsim.c |   7 +-
 2 files changed, 59 insertions(+), 70 deletions(-)

