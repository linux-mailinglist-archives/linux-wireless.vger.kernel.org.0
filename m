Return-Path: <linux-wireless+bounces-31645-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLZqAm9OiWlm6QQAu9opvQ
	(envelope-from <linux-wireless+bounces-31645-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75210B458
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0416F30071C0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958D28002B;
	Mon,  9 Feb 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="K7LrDtnG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627751D555;
	Mon,  9 Feb 2026 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606186; cv=none; b=XN6G3fYZfNY7KEUepc4RyLXrYMUN/1T/EJr06gy3CaPK4ct1dPoHk5fNqUeY9O07y/wGK9LcWBEwFC5Q7GhOBPA4bO7Mn4ePPvMppEMBf0CqGxW2iWELofU5qDZxLKXTeE0HSSypPCsUh3jlKrlW6zmDHbb65an0ZOKpN7i4G9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606186; c=relaxed/simple;
	bh=9QY5bvH6UOKEfyvZ08P3kTTHaDROZegWUHxl42L35rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAO8yoe0WqvcFfVOyl5XQd+WqHOw5lLstMmezlJqgjJKVa38ykqVCB+cLGoC6PASUeg5Xv+8LLnh40idlOk6Emv7hOuqGgNVk4wcoeIPFZrVmqr8HuERoUM/VXMzQEAlSphLXPjx091OJAl0VNgx8iTHwwfcizAhvYVGi4y42o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=K7LrDtnG; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:190d:0:640:bab5:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 4B884806BC;
	Mon, 09 Feb 2026 06:02:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s2H8uoNGO0U0-ERonRnP4;
	Mon, 09 Feb 2026 06:02:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770606175; bh=QNjMDvA4GT5+5r95oykDTLOoWhHZCwrCD9d6iDvQ+PY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=K7LrDtnGkN0aJhXpHF14YuuLznNSEbxd8M/wE8oWiVZCDbIhFySXUbfzQ33KSc+q5
	 ho2dOdgZTqeXCsDqYm44A35s655MdStwvwec0VB68OS6VXG014FjFMeolMVp7N4bqy
	 4qIPd3kbtIplTsVixnPMd9MKmDqKOWUAyaYfq4Ek=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next 0/4] wifi: ath12k: harden stats/rate handling for WCN785x stability
Date: Mon,  9 Feb 2026 06:02:39 +0300
Message-ID: <20260209030243.1530075-1-m.limarencko@yandex.ru>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,yandex.ru];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31645-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yandex.ru];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.limarencko@yandex.ru,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex.ru:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E75210B458
X-Rspamd-Action: no action

From: Mikhail Limarenko <m.limarencko@yandex.ru>

Hi Jeff, all,

On QCNFA765/WCN785x (PCI, kernel 6.18.5) we observed three recurring
issues:

- chan info events with frequency not present in local survey range,
  producing invalid idx warnings;
- frequent VDEV_STAT polling can block for 3 seconds on fw_stats_done
  timeouts and cause visible hitches;
- occasional invalid MCS metadata (for example HE MCS=12) propagates
  into mac80211 status handling and correlates with ieee80211_rx_list
  warnings.

This series addresses those cases by:
1. returning -EINVAL from freq_to_idx() when no channel matches, and
   rejecting negative indexes in callers;
2. reducing the wait on VDEV_STAT fw_stats completion and skipping
   unnecessary waits for stats types that do not require it;
3. sanitizing invalid MCS metadata in both dp_rx and dp_mon paths by
   falling back to legacy metadata with ratelimited diagnostics.

Tested on:
- hardware: QCNFA765 (WCN785x)
- kernel: 6.18.5+deb13-amd64
- AP mode: 5 GHz (802.11ac)

Observed after applying this series:
- station dump polling no longer shows multi-second stalls in test runs;
- no fresh ieee80211_rx_list WARN was observed in the same windows.

If patch 1/4 is already present in ath-next or stable trees, please drop
it and keep the remaining fixes.

Thanks,
Mikhail Limarenko

Mikhail Limarenko (4):
  wifi: ath12k: validate survey index when frequency is not found
  wifi: ath12k: avoid long fw_stats waits on vdev stats hot path
  wifi: ath12k: sanitize invalid MCS metadata in rx path
  wifi: ath12k: sanitize invalid MCS metadata in monitor rx path

 drivers/net/wireless/ath/ath12k/dp_mon.c | 38 ++++++++++++++---------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 39 ++++++++++++++----------
 drivers/net/wireless/ath/ath12k/mac.c    | 22 +++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.c    | 13 ++++----
 4 files changed, 73 insertions(+), 39 deletions(-)

-- 
2.47.3

