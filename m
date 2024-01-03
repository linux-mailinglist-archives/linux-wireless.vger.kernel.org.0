Return-Path: <linux-wireless+bounces-1448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EAD822FC5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 15:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E564285E6C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933041A5B3;
	Wed,  3 Jan 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pwAFg6xW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2D1A5B2;
	Wed,  3 Jan 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=XieUvQ+0Cs0hkDJiu4t354gLAedz0r3kr7KlBt7rpjY=; t=1704293079; x=1705502679; 
	b=pwAFg6xW0EozTARwtKqYaTfKxL9cZ6noOkvqNfe/y2yawnQCJLMQNgCjMAe41RydMimU74umX6h
	DzBiKXo9DOjEEKL3xrvdrm4oVXTu31UXWMKE4nboHcxfIXDYtrAZue0L1vu3gJ3PvviXTjtfe80Eq
	NwXcgo+GoTikGhr3wpDBaQuSmSVAnSzNMdEgswm2cgqbdGEyipndlthxZYWV8VZYUEwxCvyOFe/TE
	wCCMBImKr0As3mwYIjzy3jPEexX1SuyIjwSyDkpntmKLqRpX6qtOID71e9wKPyGAsvikgD6GWuFLj
	Ou9rVInxmA68idu1PR/jbs0EzNZ9s3Tt/2eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rL2Tq-000000039pO-1gix;
	Wed, 03 Jan 2024 15:44:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2024-01-03
Date: Wed,  3 Jan 2024 15:43:39 +0100
Message-ID: <20240103144423.52269-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So ... since we were discussing and wrapping up the kunit stuff,
I decided to put together another pull request with a few things,
notably the first kunit tests for wifi.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 968509128207f122d7177ffb6ff51c9c6fa7e13d:

  wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP (2023-12-21 20:35:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-01-03

for you to fetch changes up to 3aca362a4c1411ec11ff04f81b6cdf2359fee962:

  wifi: mac80211: remove redundant ML element check (2024-01-03 15:35:38 +0100)

----------------------------------------------------------------
Just a couple of more things over the holidays:
 - first kunit tests for both cfg80211 and mac80211
 - a few multi-link fixes
 - DSCP mapping update
 - RCU fix

----------------------------------------------------------------
Benjamin Berg (5):
      kunit: add parameter generation macro using description from array
      kunit: add a convenience allocation wrapper for SKBs
      wifi: cfg80211: tests: add some scanning related tests
      wifi: cfg80211: correct comment about MLD ID
      wifi: cfg80211: parse all ML elements in an ML probe response

Edward Adam Davis (1):
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Ilan Peer (1):
      wifi: cfg80211: Update the default DSCP-to-UP mapping

Johannes Berg (4):
      wifi: mac80211: add kunit tests for public action handling
      wifi: mac80211: kunit: generalize public action test
      wifi: mac80211: kunit: extend MFP tests
      wifi: mac80211: remove redundant ML element check

Zheng tan (1):
      wifi: mac80211: fix spelling typo in comment

 Documentation/dev-tools/kunit/usage.rst |  12 +-
 include/kunit/skbuff.h                  |  56 +++
 include/kunit/test.h                    |  19 +
 net/mac80211/debugfs_sta.c              |   2 +-
 net/mac80211/ieee80211_i.h              |  10 +
 net/mac80211/mlme.c                     |  29 +-
 net/mac80211/rx.c                       |   4 +-
 net/mac80211/tests/Makefile             |   2 +-
 net/mac80211/tests/mfp.c                | 286 +++++++++++++++
 net/wireless/core.h                     |  13 +-
 net/wireless/scan.c                     |  58 ++-
 net/wireless/tests/Makefile             |   2 +-
 net/wireless/tests/scan.c               | 625 ++++++++++++++++++++++++++++++++
 net/wireless/tests/util.c               |  56 +++
 net/wireless/tests/util.h               |  66 ++++
 net/wireless/util.c                     |  56 +++
 16 files changed, 1244 insertions(+), 52 deletions(-)
 create mode 100644 include/kunit/skbuff.h
 create mode 100644 net/mac80211/tests/mfp.c
 create mode 100644 net/wireless/tests/scan.c
 create mode 100644 net/wireless/tests/util.c
 create mode 100644 net/wireless/tests/util.h

