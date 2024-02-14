Return-Path: <linux-wireless+bounces-3596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A4855276
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B2C2834FB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92912F594;
	Wed, 14 Feb 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G9GFoIf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB5D1272CD;
	Wed, 14 Feb 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936217; cv=none; b=fW3g2VazBBMDLREnc32zuLzDYMwtshyck0Aet4Ndef8OC3cnvt1JJkgRGGdwhoS6Idjj3A0z6KQhfhunqRjFZ/QiQah0Q4q+PTXyNGAsPKJ7UotKBDfawz4JnNjqthFMuvCUdFzHB8o9kneqFOd0CeLSTkrUk43OEzctm8EVYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936217; c=relaxed/simple;
	bh=gYRWH27SOIfQq47zFoDGqcvTqlyASrUc5BQdsxHgnNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qv8INb5BtlDWiWuAkF0RZTZCTUMajoo70B+SAnWDMsB0waPOhIIpOIQB+8zlUAhjreBRk8swDwgA/GRNV+vE4MKHaywflaoRNohAdKucV7Nn03aLeFUUNeXkM3Ysl32u7skOQoVE9nYNGRAZAMwN4htWimT+KVdAyF6EZQGih/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G9GFoIf8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hXjonGfScZcWjqKJ0PXiEEiqv2qLn9WjZ5Zcp9ryGXA=; t=1707936213; x=1709145813; 
	b=G9GFoIf87RNgbphsQbd+pzvwuwOz5uDNbHZZoNnIOjtc6TO4EE6RtTBoZyPoqDhaepjyWnI8fl6
	KYM3qA8CleftXEjXJzyn51fWJ2oPW4+xB45rBftQwTp0ZYEBn5wuj/WQMY3JOnmuzuFdjbeF+UHLS
	iysq/B9r2WMk+T6MS6GmmgkH4Ijob0TDL+TibTxLxxY2ZIPOF3oEO0Pceae2W6SVT1Nx9SBI/JG6q
	Y4zfuWZHbowYV9oMuJiKZz7XDwa3zo/U7BN1i+X3AB5WrZhOLlWqepll0MxhflVUzTDUz2HisBap3
	rZ2+j0f0xwkgZrZjsd1JVDxd/r3eCv897DhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raKEE-00000009JMH-2apM;
	Wed, 14 Feb 2024 19:43:30 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-02-14
Date: Wed, 14 Feb 2024 19:41:42 +0100
Message-ID: <20240214184326.132813-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

So this came later than I wanted, I simply forgot earlier.
Not much to say about it, just a handful of fixes, mostly
in iwlwifi.

As reported by Stephen earlier, this has a conflict against
-next material, but once pulled into net I plan on pulling
it into wireless-next to resolve that.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0647903efbc84b772325b4d24d9487e24d6d1e03:

  wifi: mt76: mt7996: fix fortify warning (2024-02-05 20:00:45 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-02-14

for you to fetch changes up to b7198383ef2debe748118996f627452281cf27d7:

  wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)

----------------------------------------------------------------
Valentine's day edition, with just few fixes because
that's how we love it ;-)

iwlwifi:
 - correct A3 in A-MSDUs
 - fix crash when operating as AP and running out of station
   slots to use
 - clear link ID to correct some later checks against it
 - fix error codes in SAR table loading
 - fix error path in PPAG table read

mac80211:
 - reload a pointer after SKB may have changed
   (only in certain monitor inject mode scenarios)

----------------------------------------------------------------
Dan Carpenter (2):
      wifi: iwlwifi: Fix some error codes
      wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()

Daniel Gabay (1):
      wifi: iwlwifi: mvm: use correct address 3 in A-MSDU

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a crash when we run out of stations

Johannes Berg (1):
      wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Miri Korenblit (1):
      wifi: iwlwifi: clear link_id in time_event

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 15 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  4 ++
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        | 69 ++++++++++++++++++----
 net/mac80211/tx.c                                  |  5 +-
 6 files changed, 80 insertions(+), 19 deletions(-)

