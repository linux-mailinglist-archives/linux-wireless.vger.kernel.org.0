Return-Path: <linux-wireless+bounces-23744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFEFACED27
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D319A7A9FBC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970320B1E8;
	Thu,  5 Jun 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cOKR5TZh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B242C3242;
	Thu,  5 Jun 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117292; cv=none; b=WmNPLX/O7Y7PFnSo+zFmo9fiH5215GfEmbhB0nywBpQWeINcEi4FmPGP9PIz28L75K0r476UNbBRRTtQAJIoQPzBgPndThGkYbIZ+WAtUelzMjp01WRnHD79oBtizQBDDoJSn9Fce0EXsCS/Bdgbqo8L3LHxWgqErqUVk+ref0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117292; c=relaxed/simple;
	bh=DmjHcnxxXghLWewLB4CIo5GegDNFRkuT/KyPu4lRXBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fu40M7Fgwu3H0XtTkzttmhxD4brWUcqABOm7Pnh5feYYoIH6HdPSqhfKJ1iy+u4Bjhj41n+8FKP714Ii7XF+xUP4HM4HPtKmHqAnNSTj1NznlQAktmHbXbkThEP02IeXe6wn369o5Uy3xHr22o6s7mA1rpwt2BgOCL3zMYDCI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cOKR5TZh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=iMlViXmimPkwbyhs6IdSuw5ZMK0qViLQ2UlSFgI+Uks=; t=1749117291; x=1750326891; 
	b=cOKR5TZhpzKc9WbzxjTCH9o6GJEhRJ2aUECxYXuHFhSTOKIZOzRhGYtbPP3hKO0sL4TzmO3J4Pm
	zzxfTJaG0RSkLl2hnExQuX/WN4Yht0ESWOnixgPdH2E6DzSUYnvoZXSZRunqWCkedSBjvvoYq6MvD
	AQG0wVRyTNHwF/aUjc99Tx7fRDh7ycd/z2bfsvF5QLHF3l/oPKsYuLm4l/UQ007R5ZNHRNzj8tQmN
	bavn1uwr3Q51DY/9BA4cD6xpZVgTbI6h/tVDuKsYeqGI2T2tpPtO7XtxEAXl/VDpxPN6R6TKqHL90
	vn/CkAhJMPYwJUA6kU4R+XoeG6CRt3cbiX2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uN7J8-00000001x4c-02uq;
	Thu, 05 Jun 2025 11:54:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-06-05
Date: Thu,  5 Jun 2025 11:53:56 +0200
Message-ID: <20250605095443.17874-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So normally I wouldn't send fixes right now, but there
have already been reports about those iwlwifi issues,
so here we are.

If this somehow doesn't work out I can defer to after
-rc1 too though.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21:

  Merge tag 'net-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-05-28 15:24:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-06-05

for you to fetch changes up to 787fe16b435668205fba19aaa7387972b7575991:

  Merge tag 'iwlwifi-fixes-2025-06-04' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-06-05 11:52:39 +0200)

----------------------------------------------------------------
Couple of quick fixes:
 - iwlwifi/iwlmld crash on certain error paths
 - iwlwifi/iwlmld regulatory data mixup
 - iwlwifi/iwlmld suspend/resume fix
 - iwlwifi MSI (without -X) fix
 - cfg80211/mac80211 S1G parsing fixes

----------------------------------------------------------------
Ilan Peer (1):
      wifi: iwlwifi: mld: Move regulatory domain initialization

Johannes Berg (2):
      wifi: iwlwifi: pcie: fix non-MSIX handshake register
      Merge tag 'iwlwifi-fixes-2025-06-04' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Lachlan Hodges (1):
      wifi: cfg80211/mac80211: correctly parse S1G beacon optional elements

Miri Korenblit (2):
      wifi: iwlwifi: mvm: fix assert on suspend
      wifi: iwlwifi: mld: avoid panic on init failure

 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |  8 +--
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |  2 +-
 include/linux/ieee80211.h                          | 79 +++++++++++++++++++---
 net/mac80211/mlme.c                                |  7 +-
 net/mac80211/scan.c                                | 11 ++-
 net/wireless/scan.c                                | 18 ++---
 8 files changed, 92 insertions(+), 40 deletions(-)

