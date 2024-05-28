Return-Path: <linux-wireless+bounces-8209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE238D1EC1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D388AB23704
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B331170847;
	Tue, 28 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFw/p2NA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DAF16F858
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906370; cv=none; b=SvDNRO0h5zreht83xrBqAWObLGIp3o+ZA8e5CAwN9KNrSDCg4XG/MQHgaDDW6iJ4WUSJ44ufrfxaRcKRCZu8aWpIoaHh2jnKvgEkL/zUSnfKjpuWhFiNa2J5F4xGOTas3zAy+cp5WHCVFZWHx5rAFZWAHn12ZY06nKOhvkDpFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906370; c=relaxed/simple;
	bh=C1hVxkxy3hUEzYKSoZerjCJb26LivcLWJ7T3Q87ghss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ri7b+TtKxzH9epPwIf8wD14iccdYGbGMfXLAuBrQTE2AyvD81WjkPPxhMzA217bB1Lq8miSsqRDGcQrYroAW2OWHZexYhxEWx7jbpXPpWOhR+R4cOBvqrWHIWpibR0Ffr1iCH8V3LHHxF+Lnhn7rDSBdpxGzk+CDxCkvh8CyJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFw/p2NA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35bf77ba8fbso272726f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906367; x=1717511167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x8+DkuElYA3ADQa85sMEiVRrEKkTDVMIKMXRNnlRv5Y=;
        b=iFw/p2NAvbF7FVpKR8rUEs4vgZk56RO9RwWZanTKR3nNiYNlvTJGEyCJmULFL3X+HA
         f/Y3dMTSzl797mVX1OwPrTpK8OO+wPA53Sjh/HkLdS2rzWceFknwyYYut6+eTpx984hG
         o+Pr59EGkBzYMZh0iKty/Va0A2o/x0OcRj+OB2TKBLOgMQv9j+0d2Zk17nzcOHsmjBRo
         l/G+tgII74YmZJZtcZT3rUvwn7JwTa0Vvfoi+fGTL9MgJTkW7bps7qKh6gnNmMsXo50r
         BsHAmz3ffYwsYkSYL4Eygw9RMNLlCh1hB4kX8FBzAEQex3hhWhqItCMNFZ5sVcFIRNy9
         aE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906367; x=1717511167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8+DkuElYA3ADQa85sMEiVRrEKkTDVMIKMXRNnlRv5Y=;
        b=TmFpwzknCEz1/+LYZICHMt01yqULShHtYGkbG1ZltOmWmMRW/ncEGZ05w+l1sFMVhC
         NH6a9jmnhnyA4VjD82upxYkbuG9acq2rR1zaZYOzfajl8yQCur7L0BotUFUkt1Rq/1Mg
         fG1K4OWkyHQuccSZazyWKjMcbs2TAlAV6txXWupEaABZRUJCR0INGAn1FfQoW8nvEtwI
         5fAwMcE++LDc8JVGYqEwx3aAm1BvRtRRj1S006y4ACfT3DTYbycpj9334GoK9FjSCsDu
         S/hDzPQaVYZqODsRFkeGROeDS3zWFiSe401/+DEaH9G3oYkgX+hOWxESJwnHZS3KkjIB
         UaOw==
X-Gm-Message-State: AOJu0YwnP+JHXk+cpt5OPgBT0SspVtAyOcIWYYWjIsX9JetCYOIhtRiY
	fn8uSk213CMkT01lXcVf4QLX3xHkxG6t//gGSVBaQdYBeU+KgpTfka+lkw==
X-Google-Smtp-Source: AGHT+IF8uVJdvkzPQ4m0XFO2OhGdvj/Td378MxYma+p7jrp40TTzF3y7tEDZepCQG6gCKAIFTLMIFA==
X-Received: by 2002:a5d:498a:0:b0:354:f57f:7bdd with SMTP id ffacd0b85a97d-3552fe0292fmr8333605f8f.45.1716906366477;
        Tue, 28 May 2024 07:26:06 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf0740sm11899719f8f.107.2024.05.28.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:26:06 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects
Date: Tue, 28 May 2024 16:26:05 +0200
Message-ID: <20240528142605.1060566-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hwmp code use objects of type mesh_preq_queue, added to a list in
ieee80211_if_mesh, to keep track of mpath we need to resolve. If the mpath
gets deleted, ex mesh interface is removed, the entries in that list will
never get cleaned. Fix this by flushing all corresponding items of the
preq_queue in mesh_path_flush_pending().

This should take care of KASAN reports like this:

unreferenced object 0xffff00000668d800 (size 128):
  comm "kworker/u8:4", pid 67, jiffies 4295419552 (age 1836.444s)
  hex dump (first 32 bytes):
    00 1f 05 09 00 00 ff ff 00 d5 68 06 00 00 ff ff  ..........h.....
    8e 97 ea eb 3e b8 01 00 00 00 00 00 00 00 00 00  ....>...........
  backtrace:
    [<000000007302a0b6>] __kmem_cache_alloc_node+0x1e0/0x35c
    [<00000000049bd418>] kmalloc_trace+0x34/0x80
    [<0000000000d792bb>] mesh_queue_preq+0x44/0x2a8
    [<00000000c99c3696>] mesh_nexthop_resolve+0x198/0x19c
    [<00000000926bf598>] ieee80211_xmit+0x1d0/0x1f4
    [<00000000fc8c2284>] __ieee80211_subif_start_xmit+0x30c/0x764
    [<000000005926ee38>] ieee80211_subif_start_xmit+0x9c/0x7a4
    [<000000004c86e916>] dev_hard_start_xmit+0x174/0x440
    [<0000000023495647>] __dev_queue_xmit+0xe24/0x111c
    [<00000000cfe9ca78>] batadv_send_skb_packet+0x180/0x1e4
    [<000000007bacc5d5>] batadv_v_elp_periodic_work+0x2f4/0x508
    [<00000000adc3cd94>] process_one_work+0x4b8/0xa1c
    [<00000000b36425d1>] worker_thread+0x9c/0x634
    [<0000000005852dd5>] kthread+0x1bc/0x1c4
    [<000000005fccd770>] ret_from_fork+0x10/0x20
unreferenced object 0xffff000009051f00 (size 128):
  comm "kworker/u8:4", pid 67, jiffies 4295419553 (age 1836.440s)
  hex dump (first 32 bytes):
    90 d6 92 0d 00 00 ff ff 00 d8 68 06 00 00 ff ff  ..........h.....
    36 27 92 e4 02 e0 01 00 00 58 79 06 00 00 ff ff  6'.......Xy.....
  backtrace:
    [<000000007302a0b6>] __kmem_cache_alloc_node+0x1e0/0x35c
    [<00000000049bd418>] kmalloc_trace+0x34/0x80
    [<0000000000d792bb>] mesh_queue_preq+0x44/0x2a8
    [<00000000c99c3696>] mesh_nexthop_resolve+0x198/0x19c
    [<00000000926bf598>] ieee80211_xmit+0x1d0/0x1f4
    [<00000000fc8c2284>] __ieee80211_subif_start_xmit+0x30c/0x764
    [<000000005926ee38>] ieee80211_subif_start_xmit+0x9c/0x7a4
    [<000000004c86e916>] dev_hard_start_xmit+0x174/0x440
    [<0000000023495647>] __dev_queue_xmit+0xe24/0x111c
    [<00000000cfe9ca78>] batadv_send_skb_packet+0x180/0x1e4
    [<000000007bacc5d5>] batadv_v_elp_periodic_work+0x2f4/0x508
    [<00000000adc3cd94>] process_one_work+0x4b8/0xa1c
    [<00000000b36425d1>] worker_thread+0x9c/0x634
    [<0000000005852dd5>] kthread+0x1bc/0x1c4
    [<000000005fccd770>] ret_from_fork+0x10/0x20

Fixes: 050ac52cbe1f ("mac80211: code for on-demand Hybrid Wireless Mesh Protocol")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 net/mac80211/mesh_pathtbl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 7a1afb5d13af..fed32bc33719 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -1017,10 +1017,23 @@ void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
  */
 void mesh_path_flush_pending(struct mesh_path *mpath)
 {
+	struct ieee80211_sub_if_data *sdata = mpath->sdata;
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
+	struct mesh_preq_queue *preq, *tmp;
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&mpath->frame_queue)) != NULL)
 		mesh_path_discard_frame(mpath->sdata, skb);
+
+	spin_lock_bh(&ifmsh->mesh_preq_queue_lock);
+	list_for_each_entry_safe(preq, tmp, &ifmsh->preq_queue.list, list) {
+		if (ether_addr_equal(mpath->dst, preq->dst)) {
+			list_del(&preq->list);
+			kfree(preq);
+			--ifmsh->preq_queue_len;
+		}
+	}
+	spin_unlock_bh(&ifmsh->mesh_preq_queue_lock);
 }
 
 /**
-- 
2.45.0


