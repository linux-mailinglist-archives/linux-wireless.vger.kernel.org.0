Return-Path: <linux-wireless+bounces-31406-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK/pGGgrfWmEQgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31406-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 23:06:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C7BF046
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 23:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2DDD3004DBD
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF12D302742;
	Fri, 30 Jan 2026 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b="Nbo72YCd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail63.out.titan.email (mail63.out.titan.email [34.202.218.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE237F738
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.218.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810787; cv=none; b=YtxwM4L/1IgJMNmeeziLWm3eFd41mm/hPLXkREJ7ZpnHHIemkhmsA0pWqvqgisvYSRROnaxtEWf84HKMPummWxYDVL67a6IEvy9ya482mASryBeAN/+JSLVRiJUMgdKoRdw11v+AdlLGnrQQkgvnNQfUw/kp2N+hDYZmybIvXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810787; c=relaxed/simple;
	bh=NvW0j/IPtfRxrfHcvuXsBGejuGbHx3SHkxip22KJtSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMi3OF+al9QBHJ4AqP8JpSJ5hzNKDJ4g3p3Rbqvp/YosWCz1jY+3hM3C/bjwF7cCqrtJ/eQC3TMlh/HPSWkLOyQCzJ9oGFL3r3+toa7KDW1Yv/c+O64fLWhWlnl08+gXFNf0XhI8zNN6jlwR/tbJuqicySOAKO7UmeM5a04LzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=t32smtp-sign002.email header.i=@t32smtp-sign002.email header.b=Nbo72YCd; arc=none smtp.client-ip=34.202.218.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4f2qcS69Z4z7t7c;
	Fri, 30 Jan 2026 21:57:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=MwwWLj4eeNXnRvWtijrDlpKGfUs69J8IRxmAQsiVCGA=;
	c=relaxed/relaxed; d=t32smtp-sign002.email;
	h=from:in-reply-to:mime-version:to:cc:message-id:references:subject:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1769810248; v=1;
	b=Nbo72YCd4doRqhidMKp7SizTX2LTPE+1q0yVgIbkVEI/W0ZpVkziMkVDGPvNe7QSjJs8vio5
	BnilIRqDraTnJcJNcnVDF4Af0B14A8FC7UYLVwdLldEqkq2KuJeSX9crG/ewX4e8tgMapgHbqhQ
	n3Q4YZeuM/NfW6rw3N0FnP9w=
Received: from fedora (unknown [185.153.179.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4f2qcS0w0Wz7t7g;
	Fri, 30 Jan 2026 21:57:27 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	linux-wireless@vger.kernel.org,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: [PATCH v2] wifi: mt76: mt7921: fix txpower reporting
Date: Fri, 30 Jan 2026 13:54:58 -0800
Message-ID: <20260130215458.52886-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125222235.36565-1-lucid_duck@justthetip.ca>
References: <20260125222235.36565-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1769810248697378188.6018.7758287459213392978@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=PI31+eqC c=1 sm=1 tr=0 ts=697d2948
	a=r7RGZ+kgjEOtWJk29F+/ow==:117 a=r7RGZ+kgjEOtWJk29F+/ow==:17
	a=CEWIc4RMnpUA:10 a=ThxqNdz_AAAA:8 a=RcvUDfp-PueuT0lGCoYA:9
	a=X5WbqfxFh8zCdCUNm0Nt:22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[t32smtp-sign002.email:s=titan1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31406-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[justthetip.ca];
	DKIM_TRACE(0.00)[t32smtp-sign002.email:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,t32smtp-sign002.email:dkim,justthetip.ca:mid,justthetip.ca:email]
X-Rspamd-Queue-Id: 7D8C7BF046
X-Rspamd-Action: no action

The mt7921 driver never updates phy->txpower_cur, causing
mt76_get_txpower() to report incorrect values via nl80211.
Users see bogus txpower readings (typically 3 dBm or 67 dBm)
regardless of actual regulatory limits.

Fix this by updating txpower_cur in mt7921_bss_info_changed()
when BSS_CHANGED_TXPOWER is set. Use bss_conf.txpower as the
primary source, with a fallback to the channel's max_reg_power
for cases where bss_conf.txpower is not populated (INT_MIN).

Tested on Alfa AWUS036AXML (MT7921AU), kernel 6.18.6:
  - 2.4GHz ch1:  33 dBm (30 dBm limit + 3 dBm path delta) - PASS
  - 5GHz ch100:  27 dBm (24 dBm limit + 3 dBm path delta) - PASS
  - 6GHz ch5:    15 dBm (12 dBm limit + 3 dBm path delta) - PASS

Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f37a35b..99fe46d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -725,6 +725,25 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_CQM)
 		mt7921_mcu_set_rssimonitor(dev, vif);

+	if (changed & BSS_CHANGED_TXPOWER) {
+		int tx_power = info->txpower;
+
+		/*
+		 * Workaround for kernel 6.18+: bss_conf.txpower may not be
+		 * populated (INT_MIN) even when BSS_CHANGED_TXPOWER is set.
+		 * In this case, use the channel's max regulatory power.
+		 */
+		if (tx_power == INT_MIN || tx_power <= 0) {
+			struct ieee80211_channel *chan = phy->mt76->chandef.chan;
+			if (chan)
+				tx_power = chan->max_reg_power;
+		}
+
+		/* txpower is in dBm, txpower_cur is in 0.5dBm units */
+		if (tx_power > 0 && tx_power < 127)
+			phy->mt76->txpower_cur = tx_power * 2;
+	}
+
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
--
2.43.0

