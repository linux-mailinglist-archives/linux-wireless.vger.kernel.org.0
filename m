Return-Path: <linux-wireless+bounces-31767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GRzOhPGjWnT6gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:22:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108612D68A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 13:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9F131D112A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82AC34AAF9;
	Thu, 12 Feb 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DODzoQRI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D223570CC;
	Thu, 12 Feb 2026 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770898702; cv=none; b=pJGKCLv25KRdlcENiDMC73I/jFWl+l8MsXIWfair8UdPs9pCZhjhQgsX4cotBz8B5LvXLnc+m7pWs/KXn/EkMbNcI0QL5UguScIrL7UD3ex58BvcNAM4/JuA+/bSsf6/ZuDX4sDmCzr3ri9MJV0//5VI/ttu9HZN8jPvV3SWAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770898702; c=relaxed/simple;
	bh=TWtniP21rK8Dr4OoTKS6jMFec9BtEszxfgXu6Kn3fZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrJstTn0hPWj/A1WWnFlOQuZAlNwudzQOy62whh6d0jou+7jSApGuTRBnMlKYspTOYfjMzkNFQHUamqzW/95KR5UkX2XnNE6L294QHfn9ha+VlocYC51LaAjGnh9rgLNcDHnbP6uH/htv6t731lnHh98L+CWlmJRzyqzj9e+SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DODzoQRI; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:489d:0:640:baa6:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id A7CB380BFE;
	Thu, 12 Feb 2026 15:18:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pHTFRX8GA8c0-aRdntUwY;
	Thu, 12 Feb 2026 15:18:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770898691; bh=jrz4g1phh87EGonmqHIlMvyC8hpNoCLcKt+puwxL+DI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=DODzoQRID1zaSfJjJi1VYb2/uQrmgOAN6zh5ELqXJnft6rpu1/eslJqrUbhGBRdDD
	 tWVYxRzhVkmMydciWoffGJNP0Ssj+Ncf0IltWtUgwrbVAw6Uw1H6x7XWKucwogx0Pc
	 AYt8o/W2vhDbAltMQQDzGvpL/UrMHMKAaGruh3ck=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next v2 1/4] wifi: ath12k: return error when survey frequency is not found
Date: Thu, 12 Feb 2026 15:17:43 +0300
Message-ID: <20260212121746.329619-2-m.limarencko@yandex.ru>
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
	TAGGED_FROM(0.00)[bounces-31767-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 5108612D68A
X-Rspamd-Action: no action

From: Mikhail Limarenko <m.limarencko@yandex.ru>

freq_to_idx() currently returns a trailing synthetic index when the
requested channel frequency is not found.

chan-info handlers already bound-check survey index, but an explicit
error on no-match keeps semantics clear and avoids propagating a fake
index value.

Keep matched-frequency index progression unchanged, return -ENOENT on
no match, and make callers reject negative indexes.

Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
---
v2:
- drop out-of-bounds claim from commit message
- keep original index progression for matched frequencies
- return explicit -ENOENT on no-match and reject negative idx in callers

 drivers/net/wireless/ath/ath12k/wmi.c | 9 +++------
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e647b84..a2f8a7c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6528,12 +6528,11 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 				continue;
 
 			if (sband->channels[ch].center_freq == freq)
-				goto exit;
+				return idx;
 		}
 	}
 
-exit:
-	return idx;
+	return -ENOENT;
 }
 
 static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
@@ -7475,7 +7474,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 	}
 
 	idx = freq_to_idx(ar, le32_to_cpu(ch_info_ev.freq));
-	if (idx >= ARRAY_SIZE(ar->survey)) {
+	if (idx < 0 || idx >= ARRAY_SIZE(ar->survey)) {
 		ath12k_warn(ab, "chan info: invalid frequency %d (idx %d out of bounds)\n",
 			    ch_info_ev.freq, idx);
 		goto exit;
@@ -7550,7 +7549,7 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 
 	spin_lock_bh(&ar->data_lock);
 	idx = freq_to_idx(ar, le32_to_cpu(bss_ch_info_ev.freq));
-	if (idx >= ARRAY_SIZE(ar->survey)) {
+	if (idx < 0 || idx >= ARRAY_SIZE(ar->survey)) {
 		ath12k_warn(ab, "bss chan info: invalid frequency %d (idx %d out of bounds)\n",
 			    bss_ch_info_ev.freq, idx);
 		goto exit;
-- 
2.47.3

