Return-Path: <linux-wireless+bounces-37932-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Eg8N3gBNmpe6wYAu9opvQ
	(envelope-from <linux-wireless+bounces-37932-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 04:56:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7616A83DE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 04:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="H8n47/0A";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37932-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37932-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D331302FB7A
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jun 2026 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3A1DC1AB;
	Sat, 20 Jun 2026 02:56:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m60231.netease.com (mail-m60231.netease.com [210.79.60.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B64A8D;
	Sat, 20 Jun 2026 02:56:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781924212; cv=none; b=ZfKtaAJkJ+TYdUrO66HBDD6gk49dtkSixDKLGe0oH8UQlE3JaSRX0FF2BLpUVwj3JF/uqP+6D3L6gvXDNUNGbraUtGKbHHibRPcCyQBWuBcmS9DN/MvMfZjObp/NHjjlDc5C3yu1boOcjhq6f8DT7X1p8H/NSTa9cfIETjo7NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781924212; c=relaxed/simple;
	bh=JNpBd+uZkP6DfCrlhTY/drlL03eMzz5KkGj4NbXGVJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAXRJMNGcQ5CURrcmimJuPr45bjfTdhckqFJouO9fCLfv8rZfIdzeWfPR38KsJ41zdqBB7MPvQ8/mQPizdkQR3QtucG66CI+1Tx2SGqrRD6PQZOABMt5jzQXKZWlsr3K2/85zhgZ3b2WRxtuyB6rmN9awB0XlkGcM0xNT2dgl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=H8n47/0A; arc=none smtp.client-ip=210.79.60.231
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4314e50de;
	Sat, 20 Jun 2026 10:56:37 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids
Date: Sat, 20 Jun 2026 10:56:32 +0800
Message-Id: <20260620025632.46206-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee2f574f803a1kunm08c4dea4e65b2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB8YVkwYHk1MS0sZQk5LSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=H8n47/0AWazikQVEYseH7wOscfM60hPCE0l7xvqUy6iVyAqg6DFz0fT5NPEOuUWvLn9tW+qBo/5R9GMDKWD42OlPZn/YdeEq8cG752Mnws48Pt/q/rwuYxgrvCoxJnzB/e/NLSL8IKGOsSZ1lBCfnyRHquw6S+z1zgWONT++0Tg=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=1IWZ9O+Sl5aFiIfjp0uZas22aqensvgdoia6QJQRyjY=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,seu.edu.cn];
	TAGGED_FROM(0.00)[bounces-37932-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:rtl8821cerfe2@gmail.com,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C7616A83DE

rtl92du_tx_fill_desc() uses ieee80211_get_tid() to read the QoS TID
from the 802.11 header and then uses it as an index into
sta_entry->tids[]. ieee80211_get_tid() returns the low 4-bit QoS TID
value, so the result can be in the range 0..15.

rtlwifi only allocates MAX_TID_COUNT entries for sta_entry->tids[], and
MAX_TID_COUNT is 9. A QoS TID greater than 8 therefore indexes past the
aggregation state array. Keep the default RTL_AGG_STOP state for
out-of-range TIDs, matching rtl92cu_tx_fill_desc().

This issue was detected by our static analysis tool and confirmed by
manual audit. UBSAN validation for the same bug pattern reports an
array-index-out-of-bounds access with index 10 for type
'rtl_tid_data [9]'.

Fixes: 8321424134a4 ("wifi: rtlwifi: Add rtl8192du/trx.{c,h}")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
index 743ce0cfffe6..c608c51f1b78 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
@@ -106,7 +106,8 @@ void rtl92du_tx_fill_desc(struct ieee80211_hw *hw,
 	if (sta) {
 		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 		tid = ieee80211_get_tid(hdr);
-		agg_state = sta_entry->tids[tid].agg.agg_state;
+		if (tid < MAX_TID_COUNT)
+			agg_state = sta_entry->tids[tid].agg.agg_state;
 		ampdu_density = sta->deflink.ht_cap.ampdu_density;
 	}
 
-- 
2.34.1


