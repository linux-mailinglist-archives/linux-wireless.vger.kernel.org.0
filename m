Return-Path: <linux-wireless+bounces-21447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C15A8607B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96B3173E02
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36331C3BEB;
	Fri, 11 Apr 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KfAV37/7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF524142E83;
	Fri, 11 Apr 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381440; cv=none; b=E9TCncAzUviMELO1V/D0z8V859b79J+/2F0CquvgKfiD0BWLEctBKaUOmRgObsosiAEy+KUqspNhyJo7twrE9MU+wM/bynYgbl4JhW2EMIzA97HcCitC0dE2LAn8x6NHHkIXbNqaQtco1J/p5akgcufPQPgN1kwDDTobYqPJCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381440; c=relaxed/simple;
	bh=5e1yD0s3dV92lEk/EZEe4YsbQTmBHgp1mEzPj1lJMwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3+lNlhQseZp3vT774kmOpjXQbUleeSCg6kMR0Jf20tIo9LRitazt6ilhFzAwjCo6OwZp5w/y3IXH8gTPGaCoMUpa9m+VLsFYYCd9qG78VzS/xEhboL8DiGLAsV/5/P6+ah10w1PrNiomIPSYRlYRyGegqV6wPceTIaOR9sYeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KfAV37/7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=zmBSYdyDgilKPQjyvIq2q1GoQG+IWdkAFaOI+yQt1wU=; t=1744381439; x=1745591039; 
	b=KfAV37/78Z2BrTwqaBWZOKhvoX8tKPTLcgLwYoXXaVa07Lc6bgp53UrXahzdTyeg5FTLoyFLtlp
	MImarJJ4aqXHvockeF7jJhdk73F1P8HyfWGsiEXDgUAGnT327R8MaFIhh6bnBSgUOdibcUZ1ldUzZ
	JRL6sug/ZQ1/8QbaAff7iDY0gVyv5RclI22OuElF4vrDLxcVMPoomupEos4mJgOZDJkUwSKuKVoho
	YHZsK5s7lP0F+ihGlgS7N9dpJCh6uZua2zLrmdklgQTFvlcHLhm2AAhAqGrCcJngwUwJBx3Bh07ce
	S4PZu75Y++l+7yyL+SQJ2Y7REB3uu7dvec8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u3FIS-00000007hCx-2EuK;
	Fri, 11 Apr 2025 16:23:56 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull request: wireless-2025-04-11
Date: Fri, 11 Apr 2025 16:22:42 +0200
Message-ID: <20250411142354.24419-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So I meant to send this a couple of days ago for -rc2
to get the build fixes in, but on the flip side I had
to revert a fix that caused some other issues, which
was only reported yesterday.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95:

  Merge tag 'net-next-6.15' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-03-26 21:48:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2025-04-11

for you to fetch changes up to 85bf1ae049468d6cdf8f3876819c1f526f10ed92:

  Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()" (2025-04-11 16:17:21 +0200)

----------------------------------------------------------------
Just a handful of fixes, notably
 - iwlwifi: various build warning fixes (e.g. PM_SLEEP)
 - iwlwifi: fix operation when FW reset handshake times out
 - mac80211: drop pending frames on interface down

----------------------------------------------------------------
Abdun Nihaal (3):
      wifi: at76c50x: fix use after free access in at76_disconnect
      wifi: brcmfmac: fix memory leak in brcmf_get_module_param
      wifi: wl1251: fix memory leak in wl1251_tx_work

Arnd Bergmann (1):
      iwlwifi: mld: fix building with CONFIG_PM_SLEEP disabled

Dan Carpenter (1):
      wifi: iwlwifi: mld: silence uninitialized variable warning

Johannes Berg (4):
      wifi: iwlwifi: mld: fix PM_SLEEP -Wundef warning
      wifi: add wireless list to MAINTAINERS
      wifi: iwlwifi: pcie: set state to no-FW before reset handshake
      Revert "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

Lukas Wunner (1):
      wifi: iwlwifi: mld: Restart firmware on iwl_mld_no_wowlan_resume() error

Remi Pommarel (2):
      wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
      wifi: mac80211: Purge vif txq in ieee80211_do_stop()

Yedidya Benshimol (1):
      wifi: iwlwifi: mld: reduce scope for uninitialized variable

 MAINTAINERS                                               | 6 ++++++
 drivers/net/wireless/atmel/at76c50x-usb.c                 | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c               | 8 +++-----
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c          | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h            | 2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c         | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c      | 8 +++++++-
 drivers/net/wireless/ti/wl1251/tx.c                       | 4 +++-
 net/mac80211/iface.c                                      | 3 +++
 10 files changed, 33 insertions(+), 13 deletions(-)

