Return-Path: <linux-wireless+bounces-34959-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVhApCS4mkL7gAAu9opvQ
	(envelope-from <linux-wireless+bounces-34959-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 22:05:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C669741E701
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 22:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E55F3019397
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1BF31D730;
	Fri, 17 Apr 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="S7zvHENI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B83128C6;
	Fri, 17 Apr 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456327; cv=none; b=rzpYCduWeM1oHFMHPcSlpmSlSGWzSs6kiwBtNLMJ/45UhhHmEDsryCvsDzVB9SiA6yX+wqGQbBXX29nU8P5z5W2OjFdYyfXzSbX02wkOfZbjsRKfdU+II7tZY4k+26PTeh0dC1+QanHzJk7B+BXKipyj1rMA6C2mV9eYmPvvGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456327; c=relaxed/simple;
	bh=b3E9oE4xAaLxwZQQLpyVjn2xB5i7BZZr3aYrpSL7ut4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EufRTqnxqgrAzPZVUBeKKu5QMFIYmxyydAOOWwzcl26ljkvsMfrWNVQLExvXweHl9Vvfeb3LZjzP3p4hQzIbBbu2kyl6Q7xr8dj0/tKCWa0ECclIz3H3+pUjky8S/3k+SzUQ/z+6RDt3P8x1gcI5+cHsenp6xTt7N+2qek0IKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=S7zvHENI; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=BqPWJwS6dVqRTAKinSAIGALIFXzHBxQhVSoEUuSHneA=; b=S7zvHENIVi/VNGGdyqiw0Km0dC
	iLvS9kyLrd75UUw1Ul3oZczoTwe6kqsvnlrWs+5JZI0wVEnYrtERUwRAo0uc+fQ2/UQe6EbEnTUYG
	6Inmv+AzSf0aw2RC30Dpv8ILpb2WAr+/VzQLGILEXGwR3sT95jVYhwqu4hOXcyeUnmv4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDpRJ-000000007kZ-3exx;
	Fri, 17 Apr 2026 16:05:22 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtlwifi: fix typos in comments
Date: Fri, 17 Apr 2026 16:05:17 -0400
Message-ID: <20260417200520.3919437-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hugovil.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hugovil.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34959-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugo@hugovil.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hugovil.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dimonoff.com:email,hugovil.com:dkim,hugovil.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C669741E701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix typos in rtl8821ae_card_disable() comments.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 3a4a334762055..035760287a4f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2355,7 +2355,7 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 			rtl8821ae_set_fw_disconnect_decision_ctrl_cmd(hw, true);
 		}
 
-		/* 3 <3> Hw Configutations */
+		/* 3 <3> Hw Configurations */
 
 		/* Wait until Rx DMA Finished before host sleep.
 		 * FW Pause Rx DMA may happen when received packet doing DMA.

base-commit: 59bd5ae0db22566e2b961742126269c151d587c7
-- 
2.47.3


