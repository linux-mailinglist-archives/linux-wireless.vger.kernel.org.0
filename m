Return-Path: <linux-wireless+bounces-31647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPzGAXJOiWlm6QQAu9opvQ
	(envelope-from <linux-wireless+bounces-31647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A473010B467
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D123007CB5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619562DC322;
	Mon,  9 Feb 2026 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LqtkhmxF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DC1F30A4;
	Mon,  9 Feb 2026 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606186; cv=none; b=mcyvo/TKamsbAVDgmBbVq9hxGw+uoU+5C++d7NgylsJDiyM7iSZujXKxiPfLDkVPGjZDUrJrYJPiiCBh4AGCT6SrnQPARugcQYoebo215qLRj0P+2L56KwPHgrJWaka+Yc3N00MdYhPh7I+sQPHM2QhNZC0b0o4x6udSrJ9vudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606186; c=relaxed/simple;
	bh=XV2WYtg7J8m9mPREpomkceBNFkGNsrTbN7bAzToa4Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4YKYNHquIAt6RkQYV1Jz1rEaoOxx57Ug1U+SixfrB3D/safIQJYi9P/2WjQCQKH6ny+yOS+5gLgGTlPRHpogzCvXQbz5v/6Ukkc/uGua/qR8Hm5DaVPyha3IWIyrSVsH3TNeE3KegDFN7GnEYVwrpPXa5GD/+y8W2x8VwtwQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LqtkhmxF; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:190d:0:640:bab5:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id E2C82C005B;
	Mon, 09 Feb 2026 06:02:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s2H8uoNGO0U0-duZv1Cca;
	Mon, 09 Feb 2026 06:02:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770606176; bh=+RQwyoKmfRyBBXSU6RgQl8En3RjfT4P9NFlE8zO5JL0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=LqtkhmxFJf95LWbUkQIgbDTbPu1pziIZ8zwzLm/2yLF+cG1MNEOoqlMRlsp6AJEKS
	 NoGkb1JqZgdcHk5f8UNPqZTicLbfuW74g1uPH4gPvwkwlCNdJuE7GPLcPsBkB6upmL
	 IfU53r7FbweOKWTVh59uiC6Qwrl8W06x0yaK8KZ4=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next 1/4] wifi: ath12k: validate survey index when frequency is not found
Date: Mon,  9 Feb 2026 06:02:40 +0300
Message-ID: <20260209030243.1530075-2-m.limarencko@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209030243.1530075-1-m.limarencko@yandex.ru>
References: <20260209030243.1530075-1-m.limarencko@yandex.ru>
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
	TAGGED_FROM(0.00)[bounces-31647-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: A473010B467
X-Rspamd-Action: no action

From: Mikhail Limarenko <m.limarencko@yandex.ru>

freq_to_idx() currently returns a monotonic index even when the

frequency was never matched.

In chan info paths this can lead to out-of-bounds survey indexing

for unexpected frequency events.

Return -EINVAL on no match and make callers reject negative

indexes.

Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index e647b84..422e3f8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6520,7 +6520,7 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 		if (!sband)
 			continue;
 
-		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
+		for (ch = 0; ch < sband->n_channels; ch++) {
 			if (sband->channels[ch].center_freq <
 			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
 			    sband->channels[ch].center_freq >
@@ -6528,12 +6528,13 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 				continue;
 
 			if (sband->channels[ch].center_freq == freq)
-				goto exit;
+				return idx;
+
+			idx++;
 		}
 	}
 
-exit:
-	return idx;
+	return -EINVAL;
 }
 
 static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
@@ -7475,7 +7476,7 @@ static void ath12k_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 	}
 
 	idx = freq_to_idx(ar, le32_to_cpu(ch_info_ev.freq));
-	if (idx >= ARRAY_SIZE(ar->survey)) {
+	if (idx < 0 || idx >= ARRAY_SIZE(ar->survey)) {
 		ath12k_warn(ab, "chan info: invalid frequency %d (idx %d out of bounds)\n",
 			    ch_info_ev.freq, idx);
 		goto exit;
@@ -7550,7 +7551,7 @@ ath12k_pdev_bss_chan_info_event(struct ath12k_base *ab, struct sk_buff *skb)
 
 	spin_lock_bh(&ar->data_lock);
 	idx = freq_to_idx(ar, le32_to_cpu(bss_ch_info_ev.freq));
-	if (idx >= ARRAY_SIZE(ar->survey)) {
+	if (idx < 0 || idx >= ARRAY_SIZE(ar->survey)) {
 		ath12k_warn(ab, "bss chan info: invalid frequency %d (idx %d out of bounds)\n",
 			    bss_ch_info_ev.freq, idx);
 		goto exit;
-- 
2.47.3


