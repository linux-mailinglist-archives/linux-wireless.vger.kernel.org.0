Return-Path: <linux-wireless+bounces-31649-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPk1EYVOiWlm6QQAu9opvQ
	(envelope-from <linux-wireless+bounces-31649-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A210B480
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 04:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02645301386B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 03:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614043043D2;
	Mon,  9 Feb 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CjtLErJe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F501301485;
	Mon,  9 Feb 2026 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606188; cv=none; b=lYCBQ3IoC+zsl+Mik2XrOTB7BQIIcr8c8iQCcZaYLsSyishnYRowEb4otsushsuNv/ocUzb32Clsdvn3OUxUCwrNkjoHRKcV3xYMZZnPBWhXU0XhkuklilxDFJPsseMorrmJrFDJC8M84ARnfDTCpXpmc6IUV0zMP7tBHVJ4xxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606188; c=relaxed/simple;
	bh=i8e0Z5t7th9323WCkMyYpegZ/+lKN0RTpwAEcQcJNzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRjxExyj647VFDcLcqxj0+7j+IDeq8JJ6KiRDx6RlJQILwamFZV6n8VSo+ILe9VEI8muhqS9ykNFQ1gYCtRYbW5z92LyxIBrO0ovneyLSPG/iRVa/C04VNyJtzr6THUkWoXKVV/YMFWnh3z2MHf5vVCa//My8OxX6sbaWqwpyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CjtLErJe; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:190d:0:640:bab5:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id E9CE88087F;
	Mon, 09 Feb 2026 06:02:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s2H8uoNGO0U0-dI9Bbd29;
	Mon, 09 Feb 2026 06:02:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770606178; bh=l2rzyeifuTvLESFEtUsG8awO2sxZc/zhl6syNBHYDnA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=CjtLErJesnAQ45HNe2kQZFyrnYE/fDffNbvekhw7czZzP4QK+JRQQg+YIuBqyt/4c
	 yFkuAR7RIvC8n8wBP3BQMjmYsyCftIwsrEWNyM/xVr5p3vvO6lL+GKvXJ0EZqMi6K+
	 LpnQIlKtcMcSA4pRiy/eRq9kmFvYpn2nY8eGi9+Y=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: m.limarencko@yandex.ru
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Limarenko <m.limarencko@yandex.ru>
Subject: [PATCH ath-next 4/4] wifi: ath12k: sanitize invalid MCS metadata in monitor rx path
Date: Mon,  9 Feb 2026 06:02:43 +0300
Message-ID: <20260209030243.1530075-5-m.limarencko@yandex.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,yandex.ru];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31649-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C59A210B480
X-Rspamd-Action: no action

From: Mikhail Limarenko <m.limarencko@yandex.ru>

Apply the same invalid-MCS hardening in monitor path status

conversion to keep metadata handling consistent in both data and

monitor pipelines.

Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 38 ++++++++++++++----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 009c495..6e894ef 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1922,9 +1922,11 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 	case RX_MSDU_START_PKT_TYPE_11N:
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH12K_HT_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in HT mode %d\n",
-				     rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid HT mcs %u in monitor path, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
 		rx_status->rate_idx = rate_mcs + (8 * (nss - 1));
@@ -1933,35 +1935,41 @@ ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AC:
 		rx_status->encoding = RX_ENC_VHT;
-		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in VHT mode %d\n",
-				     rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid VHT mcs %u in monitor path, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
+		rx_status->rate_idx = rate_mcs;
 		if (sgi)
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AX:
-		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_HE_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in HE mode %d\n",
-				    rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid HE mcs %u in monitor path, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
+		rx_status->rate_idx = rate_mcs;
 		rx_status->encoding = RX_ENC_HE;
 		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		break;
 	case RX_MSDU_START_PKT_TYPE_11BE:
-		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
-			ath12k_warn(ar->ab,
-				    "Received with invalid mcs in EHT mode %d\n",
-				    rate_mcs);
+			dev_warn_ratelimited(ar->ab->dev,
+					     "ath12k: invalid EHT mcs %u in monitor path, forcing legacy rate metadata\n",
+					     rate_mcs);
+			rx_status->encoding = RX_ENC_LEGACY;
+			rx_status->rate_idx = 0;
 			break;
 		}
+		rx_status->rate_idx = rate_mcs;
 		rx_status->encoding = RX_ENC_EHT;
 		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
 		break;
-- 
2.47.3


