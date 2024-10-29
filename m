Return-Path: <linux-wireless+bounces-14631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 697769B45D7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E011C21E45
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 09:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971FF2036F4;
	Tue, 29 Oct 2024 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sQ66qEAQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9E7DA82;
	Tue, 29 Oct 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194779; cv=none; b=BnC07yLpl5yFK9Fufu9IXZ2w/pQiqouwhw92qbl8KbfUL3r7bzqKMpCzjo38uJevES3qqfony6mSbnHuup9KQPRHkogFhB1Mf5fQAP2wJt0ibA9hEdA6XZeYvK4RhSlOzGWkrBFGYPlHrSa63KH4GIjI9bT/4DfyO8IUcjx1nHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194779; c=relaxed/simple;
	bh=wjKh3Y/EW6aDWLY9xkwOOGoTgEC5VDgRV9BYS6shpbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPn8X4S/hZIR15MaHjRpz3v4a10n+5bDSIJAv6MHZ6I0MuDWQ/BO52zW2Nr+cY3gSblMtno8n+Zfq8cX1Rp4hzclFKshz0AHxSV8bo31lUqXWW+I6367Kyhzqg4C6JQE0hQhcyCzXUJY0tHA3oCD1tdaDcdiqDiAvMA0fUqSC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sQ66qEAQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=lJgy+uS5MvZRnt5KBckuuVPIjDa4nis657tfLdv9kJQ=; t=1730194777; x=1731404377; 
	b=sQ66qEAQOQu1UdHpacEYtT5ujVU1CFjnabbRq000BJO+SsbHb0ebz36AoNxOv2BYo9RQIJutDaq
	x/6LQMZr+47e2h6bTIRRKbWwd+168y6JVUDGZDfo2Xc+5kjqubcNxbIRz2WZ2D04P6cnpqABBr9BL
	EVDlMiU/BKJUn0bbhW9osY0lJ7779qZQURfg9Xa9NWGaiGAw5FuIINlNAKTChekXhoWQ3WGRd14j7
	q1QeR1la9ke/oo7S0miZwbYbK8WUja+7B8sxFBTu17i8KIlvrk0a2epbZiEy22DmcZrPohmjyRkeb
	vNlqeNqh1BrBNFqs0MyePjR2QAieeyi0tWgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t5ihK-00000008AqU-2N9t;
	Tue, 29 Oct 2024 10:39:34 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-10-29
Date: Tue, 29 Oct 2024 10:06:23 +0100
Message-ID: <20241029093926.13750-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A couple of important bugs were found, notably an infinite
loop in iwlwifi but also other bugs, which is why we have
a new pull request so soon.


Note that this unfortunately introduces two merge conflicts
with the previous wireless-next pull request. I'm guessing
they will land together in net-next after wireless-next is
pulled, and then net goes into net-next.

The first conflict is in net/mac80211/cfg.c, and is just
two new lines in the same place:

@@@ -3070,7 -3046,7 +3070,8 @@@ static int ieee80211_set_tx_power(struc
        enum nl80211_tx_power_setting txp_type = type;
        bool update_txp_type = false;
        bool has_monitor = false;
 +      int user_power_level;
+       int old_power = local->user_power_level;


The other conflict in drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
looks more complicated, but really isn't all that much,
just take the -next version. Which I think really means
I incorrectly did the iwlwifi changes in 188a1bf894323b
("wifi: mac80211: re-order assigning channel in activate links")
because that never claimed to move the iwl_mvm_link_changed()
vs. iwl_mvm_send_ap_tx_power_constraint_cmd() calls ...


Please pull and let us know if there's any (other) problem.

Thanks,
johannes



The following changes since commit e31a8219fbfcf9dc65ba1e1c10cade12b6754e00:

  Merge tag 'wireless-2024-10-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-25 10:44:41 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-10-29

for you to fetch changes up to cf44e745048df2c935cb37de16e0ca476003a3b1:

  wifi: mac80211: ieee80211_i: Fix memory corruption bug in struct ieee80211_chanctx (2024-10-26 00:42:49 +0200)

----------------------------------------------------------------
wireless fixes for v6.12-rc6

Another set of fixes, mostly iwlwifi:
 * fix infinite loop in 6 GHz scan if more than
   255 colocated APs were reported
 * revert removal of retry loops for now to work
   around issues with firmware initialization on
   some devices/platforms
 * fix SAR table issues with some BIOSes
 * fix race in suspend/debug collection
 * fix memory leak in fw recovery
 * fix link ID leak in AP mode for older devices
 * fix sending TX power constraints
 * fix link handling in FW restart

And also the stack:
 * fix setting TX power from userspace with the new
   chanctx emulation code for old-style drivers
 * fix a memory corruption bug due to structure
   embedding
 * fix CQM configuration double-free when moving
   between net namespaces

----------------------------------------------------------------
Anjaneyulu (1):
      wifi: iwlwifi: mvm: SAR table alignment

Ben Greear (1):
      mac80211: fix user-power when emulating chanctx

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Use the sync timepoint API in suspend
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't leak a link on AP removal
      wifi: iwlwifi: mvm: don't add default link in fw restart flow
      Revert "wifi: iwlwifi: remove retry loops in start"

Gustavo A. R. Silva (1):
      wifi: mac80211: ieee80211_i: Fix memory corruption bug in struct ieee80211_chanctx

Johannes Berg (2):
      wifi: cfg80211: clear wdev->cqm_config pointer on free
      wifi: iwlwifi: mvm: fix 6 GHz scan construction

Miri Korenblit (1):
      wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cmd

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 96 +++++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       | 34 +++++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 12 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 34 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  6 +-
 net/mac80211/ieee80211_i.h                         |  5 +-
 net/mac80211/main.c                                |  2 +
 net/wireless/core.c                                |  1 +
 12 files changed, 134 insertions(+), 75 deletions(-)

