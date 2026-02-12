Return-Path: <linux-wireless+bounces-31766-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONRIBd3FjWnT6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31766-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:21:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6912D66D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEE95319C83C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3911F34AAF9;
	Thu, 12 Feb 2026 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TvdTRXAc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803D027E7EB;
	Thu, 12 Feb 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898696; cv=none; b=Swj6EDF9uvjw7oz0A8N0ecIRBfPrUOLsronxzfAzg1L74QGp25ZupVAHQubO6tSwW+5CLQsXplZZ8yRUszNVTM617IqG2/6WxPrrDWyC2kaA7m7lvuFbTYqECWoTnubxImga/ucPtqx8pKeULFnGDXrTHGZ377F0ue424TgYKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898696; c=relaxed/simple;
	bh=rcvmteF2gb00/oqKLKmzLGtIPzHXzW289FycTseOWss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmfNs9IIz98O051dS6mpkuY3qgwcOakfGxx2RC2LKLVDK5hhOUqlxKwIglqHAV7jOi4QS77YgmiowNEjcBbWQB7jW89UNvjWM9waxcIieryn9nuK2+aU6jtK5kArXaXXy0cGZosGF+ORqKzRT+6nE8GqEvWmoAsDkF+367fNbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=TvdTRXAc; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:489d:0:640:baa6:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 4D0A2C007E;
	Thu, 12 Feb 2026 15:18:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pHTFRX8GA8c0-h1HwsZxp;
	Thu, 12 Feb 2026 15:18:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770898691; bh=58gkicXTfl/yMiEWBrqSzSMvFG/0h6/5ysLXoi5qXWA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=TvdTRXAcO1PmjczGP7Wx2IZiO19UB5rrORIqm4Pj7yOEebGnKLSKWB+kfDVW805zL
	 39Dbm/LjkpDPqhQCoqGNHudwaGf/LB5MeBoIS3akIBO/tmBFJ5MwLLqvJTyLnd6Oji
	 MICvpjVlq67xpkxZoCswzQqstZjSi7ZYPEkNf9pc=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next v2 2/4] wifi: ath12k: avoid long fw_stats waits on vdev stats hot path
Date: Thu, 12 Feb 2026 15:17:44 +0300
Message-ID: <20260212121746.329619-3-m.limarencko@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212121746.329619-1-m.limarencko@yandex.ru>
References: <20260212121746.329619-1-m.limarencko@yandex.ru>
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
	TAGGED_FROM(0.00)[bounces-31766-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 68B6912D66D
X-Rspamd-Action: no action

From: Mikhail Limarenko <m.limarencko@yandex.ru>

Station info requests can trigger frequent VDEV stat pulls from

user space (iw/NM polling).

On affected firmware, waiting 3 seconds for fw_stats_done causes

repeated stalls and visible hitches.

Use a short timeout for VDEV_STAT requests and skip unnecessary

waits for stats types that do not need completion

synchronization.

Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 095b49a..1b550e9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4829,6 +4829,7 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
+	unsigned long done_timeout = 3 * HZ;
 	unsigned long time_left;
 	int ret;
 
@@ -4859,15 +4860,32 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 		return -ETIMEDOUT;
 	}
 
+	/* VDEV stats are queried frequently from station info paths (e.g. iw/NM).
+	 * On buggy firmware this path can timeout repeatedly and block callers for
+	 * multiple seconds; keep the hot path responsive while preserving behavior
+	 * for other stats types.
+	 */
+	if (param->stats_id & WMI_REQUEST_VDEV_STAT)
+		done_timeout = msecs_to_jiffies(200);
+
+	/* Non-vdev/bcn stats are handled in a single event. */
+	if (!(param->stats_id & (WMI_REQUEST_VDEV_STAT | WMI_REQUEST_BCN_STAT)))
+		return 0;
+
 	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
 	 * when stats data buffer limit is reached. fw_stats_complete
 	 * is completed once host receives first event from firmware, but
 	 * still there could be more events following. Below is to wait
 	 * until firmware completes sending all the events.
 	 */
-	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
+	time_left = wait_for_completion_timeout(&ar->fw_stats_done, done_timeout);
 	if (!time_left) {
-		ath12k_warn(ab, "time out while waiting for fw stats done\n");
+		if (param->stats_id & WMI_REQUEST_VDEV_STAT)
+			ath12k_dbg(ab, ATH12K_DBG_WMI,
+				   "time out while waiting for fw stats done (stats_id 0x%x)\n",
+				   param->stats_id);
+		else
+			ath12k_warn(ab, "time out while waiting for fw stats done\n");
 		return -ETIMEDOUT;
 	}
 
-- 
2.47.3


