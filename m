Return-Path: <linux-wireless+bounces-13928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D399B71A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2024 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305901C20FB0
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4CC146599;
	Sat, 12 Oct 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rxKluLvb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014C12CDA5;
	Sat, 12 Oct 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766523; cv=none; b=UIbC8GMdf0/jRkgWs7M2uN+M/gSmcdWnriQ2ejpX0+ohbfbfMFZnWG97MMc8TBJzwXJ6fYROxnt8Jr/BhXA1bEegd51HfyM5LQTCd4/e9MZbl1iOGdUJJGNOWLLfYhcZqif7vk2L4fpQ/oDqnLDxUaoOXANKVebT5085A47wNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766523; c=relaxed/simple;
	bh=/9vvY2eKL7girIMximjebAKd53ExFcJZ+ZsIsMghqU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4e9O6ijB0KJTAPvCkdyP6GHeRizQyl7srdKFJ5SQUVOtOAlhwiesHSC9GCpjFHWFB/kOq+1CksJQ+ndoQt1MJ8fAfRS4SQRlH/PKR14MEKmF5Y6Jl0iT8rK4wplle8HAGYSVM+OwP/eI1ZGw8vKl6qyYm5WTw0MK2HNacV5Kh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rxKluLvb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=wvYKHcFqppquqswVxJCB39KuSTx+SdhHabWlL/bm2+I=; b=rxKluLvbBH4sa5sW
	elOpo+yQ5TAmHidGZTGFs3AQdGNz+TmHOQJcUZJ051DDSS2fa1O3ZkMsyiRoyuEU5oGaoOXnnOdbC
	fOhNC7GHLI3QvuOxYWtCHwF1NKq5bwTWe4grAmfNIS2LoNCr6SmCmFqF+7yrvQPk+YIZopzCoSh9j
	Mt+YDtJADLFmDYpo7YiiYJtkWYHPUQhJcsmZjowRI8zvdRlBMA2sdU8vMKEzVTW2Xjs3S+H4i9ExA
	KhsKDGYDBtCafDXF/1upq3TqfeswNjRLSHnJOuPTAxwTEk+U3G8J+8206fUHj5bFVDu+jvXea5mNg
	D4ikGP3Ak1R05I87Ew==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1szit3-00Aiud-0x;
	Sat, 12 Oct 2024 20:38:53 +0000
From: linux@treblig.org
To: kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] cw1200: Remove unused cw1200_queue_requeue_all
Date: Sat, 12 Oct 2024 21:38:52 +0100
Message-ID: <20241012203852.229151-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cw1200_queue_requeue_all() has been unused since it was added in 2013
by commit
a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/st/cw1200/queue.c | 27 --------------------------
 drivers/net/wireless/st/cw1200/queue.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/queue.c b/drivers/net/wireless/st/cw1200/queue.c
index 805a3c1bf8fe..259739e53fc1 100644
--- a/drivers/net/wireless/st/cw1200/queue.c
+++ b/drivers/net/wireless/st/cw1200/queue.c
@@ -411,33 +411,6 @@ int cw1200_queue_requeue(struct cw1200_queue *queue, u32 packet_id)
 	return ret;
 }
 
-int cw1200_queue_requeue_all(struct cw1200_queue *queue)
-{
-	struct cw1200_queue_item *item, *tmp;
-	struct cw1200_queue_stats *stats = queue->stats;
-	spin_lock_bh(&queue->lock);
-
-	list_for_each_entry_safe_reverse(item, tmp, &queue->pending, head) {
-		--queue->num_pending;
-		++queue->link_map_cache[item->txpriv.link_id];
-
-		spin_lock_bh(&stats->lock);
-		++stats->num_queued;
-		++stats->link_map_cache[item->txpriv.link_id];
-		spin_unlock_bh(&stats->lock);
-
-		++item->generation;
-		item->packet_id = cw1200_queue_mk_packet_id(queue->generation,
-							    queue->queue_id,
-							    item->generation,
-							    item - queue->pool);
-		list_move(&item->head, &queue->queue);
-	}
-	spin_unlock_bh(&queue->lock);
-
-	return 0;
-}
-
 int cw1200_queue_remove(struct cw1200_queue *queue, u32 packet_id)
 {
 	int ret = 0;
diff --git a/drivers/net/wireless/st/cw1200/queue.h b/drivers/net/wireless/st/cw1200/queue.h
index 96ac69ae97de..d46304b58747 100644
--- a/drivers/net/wireless/st/cw1200/queue.h
+++ b/drivers/net/wireless/st/cw1200/queue.h
@@ -85,7 +85,6 @@ int cw1200_queue_get(struct cw1200_queue *queue,
 		     struct ieee80211_tx_info **tx_info,
 		     const struct cw1200_txpriv **txpriv);
 int cw1200_queue_requeue(struct cw1200_queue *queue, u32 packet_id);
-int cw1200_queue_requeue_all(struct cw1200_queue *queue);
 int cw1200_queue_remove(struct cw1200_queue *queue,
 			u32 packet_id);
 int cw1200_queue_get_skb(struct cw1200_queue *queue, u32 packet_id,
-- 
2.47.0


