Return-Path: <linux-wireless+bounces-34917-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMrLJ9zm4WmKzgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34917-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 09:53:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E941831F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 09:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5123D310C75A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F437B03E;
	Fri, 17 Apr 2026 07:46:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE136894B;
	Fri, 17 Apr 2026 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411983; cv=none; b=n1kW62OiSGNv8YpzDmnli2F/jLxh1t5eKLd1c3N0NLlc4erGR8Vo/BNX4qLOQrpLEccdvWUHpoucQBY+dhe0mVBEu0W401fRYSRyaNq9d12KoKVKUR6ad0gOPS2DkQODMbbwAyGSCqMToiNAgljHOPV7LtHhP2hNGolZl2wpej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411983; c=relaxed/simple;
	bh=+wMCUOm7aCcI+kPinihk2gL24vhViYIY7IvSn04hjv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwYQWLn4ggXTD3BlondRlZT2JCioroyTSlssej3KeIjupa4Vwz/dHbLh4zYiHbJDxpHNVRhuyRNLqWiol0hCzeRl1HhoTnrLk4VdfOqKKuqyK/qtC4yn0LZ0CosI+HrgcxgqATxADoNl0Swmp45ikp9ttpuAZL4x6ctbZOzOWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowABX7A8+5eFpECPYDQ--.42062S2;
	Fri, 17 Apr 2026 15:46:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] mac80211: debugfs: bound queue state formatting to PAGE_SIZE
Date: Fri, 17 Apr 2026 15:46:04 +0800
Message-ID: <20260417074604.18976-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7A8+5eFpECPYDQ--.42062S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyfZw47Gw1DZw13GrW3Wrg_yoW8tr48p3
	ZIkrW3Jrs5Xa17Ary7Cw1fXa4fC3ykWF1UCrWxurZ7AwnFqr90vr1vkFW2grykWrZ2vryf
	JFn8GrZ8ur1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUsiSdUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34917-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 105E941831F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

queues_read() formats all queue state lines into a fixed stack buffer
that budgets only 20 bytes per queue and appends each line with
sprintf().

The queue-stop reason bitmap is printed with %#.8lx, whose width is not
capped on 64-bit builds, and the pending queue length field can add more
digits still. The cumulative output can therefore run past the end of
the fixed stack buffer.

Format the output into a PAGE_SIZE heap buffer with scnprintf() and stop
once the debugfs read buffer is full.

Fixes: db2e6bd4e966 ("mac80211: add queue debugfs file")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/mac80211/debugfs.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 5a1831b08677..2cf6342d28db 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -9,6 +9,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/rtnetlink.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -596,17 +597,24 @@ static ssize_t queues_read(struct file *file, char __user *user_buf,
 {
 	struct ieee80211_local *local = file->private_data;
 	unsigned long flags;
-	char buf[IEEE80211_MAX_QUEUES * 20];
-	int q, res = 0;
+	char *buf;
+	int q, res = 0, ret;
+
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
-	for (q = 0; q < local->hw.queues; q++)
-		res += sprintf(buf + res, "%02d: %#.8lx/%d\n", q,
-				local->queue_stop_reasons[q],
-				skb_queue_len(&local->pending[q]));
+	for (q = 0; q < local->hw.queues && res < PAGE_SIZE; q++)
+		res += scnprintf(buf + res, PAGE_SIZE - res,
+				 "%02d: %#.8lx/%d\n", q,
+				 local->queue_stop_reasons[q],
+				 skb_queue_len(&local->pending[q]));
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	kfree(buf);
+	return ret;
 }
 
 DEBUGFS_READONLY_FILE_OPS(queues);
-- 
2.50.1 (Apple Git-155)


