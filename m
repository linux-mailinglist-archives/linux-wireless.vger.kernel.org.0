Return-Path: <linux-wireless+bounces-21974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552BDA9ACD1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0583ABFC6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EED22A1FA;
	Thu, 24 Apr 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="d/OX914x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0D1FAC46;
	Thu, 24 Apr 2025 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496341; cv=none; b=DZNN00bQRIBN2gVSF/3LGS7mmRihugpKPWXiOnobfPAqqycqDMR835WSHq4VDj8E558IhAAfpFJ1pqCg4ivaU8OQbY4r6+OPZJ1z/8OLZTOYr/Eda4SojBe72r5NQmxyhTnhkMKu50kHg7o1hxpXq6SmewgWdtE1i9bJs7DgO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496341; c=relaxed/simple;
	bh=LdvVn3vD5PEw+p2rGtchK6WZasNfVt6AxRmAGMWeFyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxhax90INsb4v9+f53T5ebDa4HNcqkgxJCEJhl9GU4CsdxcDxHcF7LbRlt/HQ4E+1UGj7VL3qK7t3uM6dma9SqBqrIzkyIKgclWObmOyfyF5n9FIJpt3zR08kY5450vPwAEaC/ZMIcPrfh3AxLaGW2sj24BsLig8Ko2dIbnxqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=d/OX914x; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+ssIICqG5fsCIIvA7xsf3kAjlA8mLhDr52xt+ZTEOpM=; t=1745496340; x=1746705940; 
	b=d/OX914xR4nN16brej8G+poonKTXWW4De8JDfiR3lDfAo9XG12Kk9xfYqWhiZuH+l31+vpaH5js
	MTxRjBXAWIPyFYLCjJUxvh+nwkRK9ZeUxUQ/9Yh5ALZlL7gchXj6ipSpBWrC1cHAmC0vUJO8HnIet
	Lq6L1BgpS6jddG1Ky7VequW1S61Tw5LJlkpz3j8qK1iEtFBTRw4FBwTFjJSCUmsXxZYXdK1J1jXmr
	p5yUk8ZRVzu63DvduxS0vfCmdNsQBmjU9izbrXgk8JW3QrGVKuvYALrgz+7POuZa4vwgoQDqEm8Qa
	P5fix6xgdyaPnWitCWxOb3F356RP9vvM9cRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7vKj-0000000H4DT-1aeS;
	Thu, 24 Apr 2025 14:05:37 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2025-04-24
Date: Thu, 24 Apr 2025 14:04:57 +0200
Message-ID: <20250424120535.56499-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Got a bit late due to holidays/vacations, but here are
a couple of fixes, including somewhat high profile
regressions for some devices in iwlwifi.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 491ef1117c56476f199b481f8c68820fe4c3a7c2:

  net: ethernet: mtk_eth_soc: net: revise NETSYSv3 hardware configuration (2025-04-22 18:51:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-04-24

for you to fetch changes up to 175e69e33c66904dfe910c5f43edfe5c95b32f0c:

  wifi: iwlwifi: restore missing initialization of async_handlers_list (2025-04-23 14:59:06 +0200)

----------------------------------------------------------------
Some more fixes, notably:
 * iwlwifi: various regression and iwlmld fixes
 * mac80211: fix TX frames in monitor mode
 * brcmfmac: error handling for firmware load

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: iwlwifi: mld: only create debugfs symlink if it does not exist

Emmanuel Grumbach (2):
      wifi: iwlwifi: don't warn if the NIC is gone in resume
      wifi: iwlwifi: fix the check for the SCRATCH register upon resume

Itamar Shalev (1):
      wifi: iwlwifi: restore missing initialization of async_handlers_list

Johannes Berg (3):
      wifi: mac80211: restore monitor for outgoing frames
      wifi: iwlwifi: back off on continuous errors
      wifi: iwlwifi: mld: fix BAID validity check

Miri Korenblit (4):
      Revert "wifi: iwlwifi: add support for BE213"
      Revert "wifi: iwlwifi: make no_160 more generic"
      wifi: iwlwifi: mld: properly handle async notification in op mode start
      wifi: iwlwifi: mld: inform trans on init failure

Murad Masimov (1):
      wifi: plfxlc: Remove erroneous assert in plfxlc_mac_release

Wentao Liang (1):
      wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()

 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  28 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |  13 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |  11 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   5 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 245 ++++++++++-----------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |  15 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |   1 -
 net/mac80211/status.c                              |   8 +-
 20 files changed, 224 insertions(+), 196 deletions(-)

