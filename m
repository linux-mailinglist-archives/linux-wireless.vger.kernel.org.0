Return-Path: <linux-wireless+bounces-31765-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DIrIJ7FjWnT6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31765-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:20:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA2412D623
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65291304A161
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE234C9B7;
	Thu, 12 Feb 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XlNguKAE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F927E7EB;
	Thu, 12 Feb 2026 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898683; cv=none; b=DxEofaadsw7f3ogltDhVqt1vzW6xnWLkZKTgyIvTJoI59c/RqY2MKICw64XjZ/z7jexk1WjAKTRDeG1Mc5t/kbC3+ALHsUo12wXTHvegcQxUAj4iR7kg/nJSc0FgT4Gmoi6VRmdIJ7QBytbME6sttHX5PWcyCBy/2crgVO46iOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898683; c=relaxed/simple;
	bh=mRr5EamHBwwjexpy39vxlVi3FADfE8gDZH7Wy8P3gZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0SStNSbko4W+NtHeviM1h8LRu+zSaDRk/4+PyfHknMMr7UIUjIFmrzyLMR20UMyK+1rFRdddW0rRztWE8PAIJTD6ZvhDtD7cc+o/hdUJ+7SJs5muO5tUV0UsQYdQ6LZP7TfoXlofIx+ZYQrUTdEccgfaU5lben1UVLK3ub4VNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XlNguKAE; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:489d:0:640:baa6:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id B1841C00AD;
	Thu, 12 Feb 2026 15:17:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pHTFRX8GA8c0-kZaQgNJw;
	Thu, 12 Feb 2026 15:17:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770898673; bh=bdN8UGuyDuSz8FZy7c2p7fmMONXAeWNjoIt2IOUIftY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XlNguKAEVD2P9CBLdtliAV4ghXsSbTMyuBICURjVr2Uo0qBxbliOkxCAYtqxNhk6E
	 y4fk4WzMdWI8i5eQCEcEDWTWCG3CQ+MOMqe94PhEo6SIDQM+g2ftpmxXyzxu+kynb2
	 Fuv+gKosLr6YLybvlVwcRrReQDwD5H4OFgJFhHbU=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next v2 0/4] wifi: ath12k: harden stats/rate handling for WCN785x stability
Date: Thu, 12 Feb 2026 15:17:42 +0300
Message-ID: <20260212121746.329619-1-m.limarencko@yandex.ru>
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
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,yandex.ru];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31765-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.limarencko@yandex.ru,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDA2412D623
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
1. returning an explicit error from freq_to_idx() when no channel
   matches, and rejecting negative indexes in callers;
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

v2:
- patch 1/4 commit message no longer claims OOB in chan-info paths
- patch 1/4 keeps matched-frequency index progression unchanged
- patch 1/4 returns -ENOENT on no-match and callers reject negative idx

Thanks,
Mikhail Limarenko

Mikhail Limarenko (4):
  wifi: ath12k: return error when survey frequency is not found
  wifi: ath12k: avoid long fw_stats waits on vdev stats hot path
  wifi: ath12k: sanitize invalid MCS metadata in rx path
  wifi: ath12k: sanitize invalid MCS metadata in monitor rx path

 drivers/net/wireless/ath/ath12k/dp_mon.c | 38 ++++++++++++++---------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 39 ++++++++++++++----------
 drivers/net/wireless/ath/ath12k/mac.c    | 22 +++++++++++--
 drivers/net/wireless/ath/ath12k/wmi.c    |  9 +++------
 4 files changed, 70 insertions(+), 38 deletions(-)

-- 
2.47.3

