Return-Path: <linux-wireless+bounces-37342-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KObdGD8TIGoMvgAAu9opvQ
	(envelope-from <linux-wireless+bounces-37342-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 13:42:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC02F6372B2
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 13:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=bUzjJYbp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37342-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37342-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5598F30CEFAB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37D3AC0F3;
	Wed,  3 Jun 2026 11:32:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EEE44E038;
	Wed,  3 Jun 2026 11:32:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486335; cv=none; b=BkwP+KmXqdtL72rCS7d6UdMpcGuXrgwcWj/8+VasdX4jRVOP57ukMTYJYPKljlLsa24itEHlKjJ/isI+hNHAneADj8eBBoMaaixqw00t4CRLfwRZluZ5kXZD6CW9JFhWqE3xeUfxEJ5QEhXB8E43d+E7AIKWYmQ/6RH7E+6nKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486335; c=relaxed/simple;
	bh=pCDoyBf5uPusqtWnqqYqcwcm/dibKpLzPR3UQtm+MqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUbWPiwHxJ2MqB9+vlNrWnxVi2h1p4cLTywG/R5aEN8sBxUwuZa4eiJGhU+fPlRcOHhCepSOo7WFVZoYbp6pOi6M8TOj54kmE9KunXdMkQEOHAk7QhT39cxR/HJPl9emSoicstsXzREy71UHaFtuTn+8OU72d/v5jl2i2KL0yIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bUzjJYbp; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wq1BxYgyTqInpfevdpxaUw/6SPUNQSybMXqUxDLHxcs=; t=1780486334; x=1781695934; 
	b=bUzjJYbpinjKL85bfU3YegKlS4u42IudQVKSLcyeQtL5B67mSwQp5pI5K60iZaZO6wNmo7eWPtO
	LcBka5rneCyNtEz7EZD3F/BmONKOhOGl3vctSddOGp4ZyJkGtC0QSzbBKpR/YQc4kUIRhArUfG5Q/
	a/l2WmQUbw3IReK4YzcFdUPqB9L2SFJTmZr27qRlW5evIIHi1VWbMeO0Gt5gEfe7nLlc9suWeasmo
	D8w0OuvxoajkmgJV2lk55YFuCl5MexzHSYrnkOACWfFXGr13IN0hnLxuDkJXAPxV0X0v5qSpqu/x6
	cFYYrdUEugsJe3gwXq+SPulCsXJ2Dm4upN0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wUjpT-0000000H5Ij-1Pa7;
	Wed, 03 Jun 2026 13:32:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-06-03
Date: Wed,  3 Jun 2026 13:31:24 +0200
Message-ID: <20260603113208.171874-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37342-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC02F6372B2

Hi,

And yet more things ... I'm going to defer a number of driver
things to wireless-next though, e.g. a PCIe device IRQ race.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit f3be0c984ecbcb82b0bec408022c4ef738cb3843:

  Merge tag 'net-7.1-rc6-2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-29 15:46:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-06-03

for you to fetch changes up to cb9959ab5f99611d27a06586add84811fe8102dc:

  wifi: cfg80211: enforce HE/EHT cap/oper consistency (2026-06-03 13:25:19 +0200)

----------------------------------------------------------------
Things are finally quieting down:
 - iwlwifi:
   - FW reset handshake removal for older devices
   - NIC access fix in fast resume
   - avoid too large command for some BIOSes
   - fix TX power constraints in AP mode
 - cfg80211:
   - fix netlink parse overflow
   - fix potential 6 GHz scan memory leak
   - enforce HE/EHT consistency to avoid mac80211 crash
 - mac80211: guard radiotap antenna parsing

----------------------------------------------------------------
Deepanshu Kartikey (1):
      wifi: mac80211: limit injected antenna index in ieee80211_parse_tx_radiotap

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't support the reset handshake for old firmwares
      wifi: iwlwifi: mvm: avoid oversized UATS command copy
      wifi: iwlwifi: pcie: simplify the resume flow if fast resume is not used

Fedor Pchelkin (1):
      wifi: fix leak if split 6 GHz scanning fails

Johannes Berg (2):
      Merge tag 'iwlwifi-fixes-2026-05-31' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      wifi: cfg80211: enforce HE/EHT cap/oper consistency

Pagadala Yesu Anjaneyulu (1):
      wifi: iwlwifi: mld: send tx power constraints before link activation

Yuqi Xu (1):
      wifi: nl80211: reject oversized EMA RNR lists

 drivers/net/wireless/intel/iwlwifi/mld/ap.c       |  4 --
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c |  7 +++
 drivers/net/wireless/intel/iwlwifi/mld/power.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       | 28 +++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  6 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c     | 56 +++++++++++++----------
 net/mac80211/tx.c                                 |  4 +-
 net/wireless/nl80211.c                            |  9 ++++
 net/wireless/scan.c                               |  9 +++-
 9 files changed, 88 insertions(+), 37 deletions(-)

