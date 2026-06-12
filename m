Return-Path: <linux-wireless+bounces-37694-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0SYOLKIK2rM/AMAu9opvQ
	(envelope-from <linux-wireless+bounces-37694-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 06:18:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53874676930
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 06:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=cWjZqvCk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37694-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37694-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C903083CFA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 04:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88C31AF07;
	Fri, 12 Jun 2026 04:18:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C640D56B;
	Fri, 12 Jun 2026 04:18:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237934; cv=none; b=LD/nLzFxAcj/QPSjsHq/PcOaY+KLmFPqyoZFqvv80yDzaBM5jKjNawLti8rFPIL9xFBqxbHVtBTkoJeGtOMMbt1xiyySq9AtzYmQLpLFe9PBKPO3h2t9VEXjWoofVqRZdcUruvnh6lK17ZItevLeA6Vju+/Ggc1KhtIXXIo8tJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237934; c=relaxed/simple;
	bh=97gO9QVyDIk6/2qm521M6xSN2NMIU+1HB3IeTkISDGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1sfq7ZbGB+WbOOW6wTEP3KgdqeRqtVKXbSoY/wM3B1IiWeopR0GXx29bJFM0cWsLPqRENT/DKHN+peomElvEBsE2ay9gC7FzEwbpEI3I9CJ5bccb4gUHzriB8VxeXQ88u1P3UFRUc5yKx2/K4SfyE3r0oMwvke+7eZIi3IozzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cWjZqvCk; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 421956ae9;
	Fri, 12 Jun 2026 12:13:37 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mt76: mt7615: avoid waiting for mac work under the mt76 mutex
Date: Fri, 12 Jun 2026 12:13:31 +0800
Message-Id: <20260612041331.2596331-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eba0914e503a1kunm03fd2058183751
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0geVhofSBkfSkNDGRpPQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=cWjZqvCkwXxZVEbFjh68UQ7EaB9BcYLiUm9fHZlAvdm5EJyYXSjW+nOjIoALwAHo/UPqk9Txv9JBE3aq6u1bPw4ivGw+gzoZbUE12ysfRWnAdD4KKa6nywJJhwBOtfNngJPPp84UWNvUoM2z5o8nqs2eSK5COoxOt58ERLBOfdo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0jVXe+HmAmsUTiUc8ErqpJQFUp2A/OQkNGrhA6RgKRc=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37694-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,seu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53874676930

mt7615_suspend() takes the mt76 mutex and then waits for mac_work with
cancel_delayed_work_sync().  mt7615_mac_work() takes the same mutex at
the top of the worker, so the suspend path can deadlock against the
delayed work it is trying to flush.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the mt7615_suspend() ->
cancel_delayed_work_sync(&phy->mt76->mac_work) path and the
mt7615_mac_work() -> mt7615_mutex_acquire() edge.  Lockdep reported:

  WARNING: possible circular locking dependency detected
  mt7615_mac_work+0x1b/0x29 [vuln_msv]
  __cancel_work_timer
  *** DEADLOCK ***

Stop queueing mac_work while the mutex is held, drop the mutex, and then
flush the delayed work from the sleepable post-unlock path.

Fixes: c6bf20109a3f ("mt76: mt7615: add WoW support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Notes:
  - Validated with a grounded Lockdep PoC that preserves the
    mt7615_suspend() -> cancel_delayed_work_sync(&phy->mt76->mac_work)
    path and the mt7615_mac_work() -> mt7615_mutex_acquire() edge.
  - checkpatch.pl --strict: clean.
  - Not tested on mt7615 hardware.

 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 15fe155ac3f3..fcb619c0f6cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1242,7 +1242,8 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
+	/* mac_work re-enters the mt76 mutex, so flush it after unlock. */
+	cancel_delayed_work(&phy->mt76->mac_work);
 
 	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,
@@ -1254,6 +1255,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, true);
 
 	mt7615_mutex_release(dev);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	return err;
 }
-- 
2.34.1

