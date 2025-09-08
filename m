Return-Path: <linux-wireless+bounces-27097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764BB491F8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B271715EA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C415853B;
	Mon,  8 Sep 2025 14:47:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1706235BE8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342853; cv=none; b=lKWZBwTsyooYKhtrx44AnXWDsYb3jmo0Mjv0erMuIE8kU9oW14P1bpKxOj6nrKbcbepO4511upxBVE1UU5BZAF4VBR6RZ4q9skLbbK46DvPVgezIsofrX0P6SDyqSY1a1Ti7h9Rjbpmi1VwFQpiiP+JvkWJf4SadzaJ3qYOZ4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342853; c=relaxed/simple;
	bh=qRY+E0C0Z/W/uyD3swNPH1GCA7zUrDFtCYBHclgDLVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqLhtqLkAVb/WJ2ad4wp4BPQ/BRRdPbTk8TmiW9F2KrgEWUFjQm4llONB1fNqDGZdG8u+FwhqYOsbhuE9THsDWY0TR9+VpsoKK6Zux/jdDCb1DdIcsRtORT+gA9tnzSFtQDZIGGjPaDLQB2sPnd/KbEz9sX30fOuSd6IWPvvZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-01 (Coremail) with SMTP id qwCowAAXbqB57L5ojYOuAQ--.49720S2;
	Mon, 08 Sep 2025 22:47:21 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Chen Yufeng <chenyufeng@iie.ac.cn>
Subject: [PATCH] wifi: mac80211: fix RCU use in ieee80211_build_hdr
Date: Mon,  8 Sep 2025 22:47:09 +0800
Message-ID: <20250908144709.1122-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXbqB57L5ojYOuAQ--.49720S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4rCFyfXF4fCFyktF4rAFb_yoWkArg_X3
	Z7Xas5JF45t3W3Ar17Ar4fJr4Fkr9xtFW8Kw42ya93AF98tay0vFnagrW5ZrZ7Gay7u3W3
	Crn8K34rKwn2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5XwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6WlgUUUUU=
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAgTEmi+slWqNwAAsp

The variable link is accessed under RCU protection, but isn't guaranteed to
actually have protection. So add rcu_read_lock() and rcu_read_unlock() to
ensure RCU protection.

This is similar to the commit 9480adfe4e0f("wifi: mac80211: fix RCU 
 use in TDLS fast-xmit").

Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
---
 net/mac80211/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 00671ae45b2f..94ac7f954cb8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2773,12 +2773,15 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 			/* DA SA BSSID */
 			memcpy(hdr.addr1, skb->data, ETH_ALEN);
 			memcpy(hdr.addr2, skb->data + ETH_ALEN, ETH_ALEN);
+			rcu_read_lock();
 			link = rcu_dereference(sdata->link[tdls_link_id]);
 			if (WARN_ON_ONCE(!link)) {
 				ret = -EINVAL;
+				rcu_read_unlock();
 				goto free;
 			}
 			memcpy(hdr.addr3, link->u.mgd.bssid, ETH_ALEN);
+			rcu_read_unlock();
 			hdrlen = 24;
 		}  else if (sdata->u.mgd.use_4addr &&
 			    cpu_to_be16(ethertype) != sdata->control_port_protocol) {
-- 
2.34.1


