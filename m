Return-Path: <linux-wireless+bounces-38691-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s7vIHFPWS2qabAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38691-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 18:22:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFCC7132E2
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 18:22:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QBo2DLrH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38691-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38691-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3E830870C5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F75367F45;
	Mon,  6 Jul 2026 14:08:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638B2BEC5F
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 14:08:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346931; cv=none; b=XQvEASnqj7Yhx3ogw6xNPa2PT2oHbL+uiCvXFrZQviPP4aAByWA2d9O0l1UyYKjtRqOZdFdBU/Rw2V4eRbCq8HUJrfUBeNwyVN43/25H2ULbhIHaIcqqD9/zY75viHr3XqZXNbkPp5um0E3vD46ECdpVsIAtSb6sjsRhk/IcRMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346931; c=relaxed/simple;
	bh=OvcBXbb6svnS9dw+2GJsgsoZ6wtG7buzXxSzu/ncMi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2kEHF0Fkqa+57WlxdmfmOkw0ycghXcgKvIdJeTjPWi2RQfuclKctwLiz23vd3ph52ZihMVvG7MPvjVJdVcCXe/x9dwS9aP2BNfrtkyP+7DrAc5llFYyy52V8fS+ghrbBCqLKPQjum6TtIGWFDaf+8pAH6oZRuGw9ld7Q5hvFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBo2DLrH; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847aebc56b6so2358733b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783346929; x=1783951729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IBS76Mn/jkVR/fb7F7t2ovJU0n/S9uOhgPtwi9Ts4o=;
        b=QBo2DLrH8f0YhWuwwVB+PIu+h0C6TnhI8B0z2N411WZ0dV34ZF+ey4dLQFoQKVaCt+
         xC9hlSdwjnWRg1kmC0Dwd7chQ3NOaqxp1BMYuELC50FoO55lgV9j/S7AC4E8PiY/rpmY
         WJgrZVsGsIt7kpgoi5KHUESaW+oMSm8QPmELd6Du7de7E1NevOEmeIsCsK7lLOnzF9+y
         VaMOFAum+fM7e14Gqs8d5pmfFK60I/iZb2/o2T9iuBZPYFuYlbv7mygSrG0BKeR3kNn6
         jf/H9Ool8osc5z6lMtAv4rc8qbfghiT8hxE77QOJjT+7ruVi9RrBAzJRE3nuz1/QMlwm
         pB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346929; x=1783951729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IBS76Mn/jkVR/fb7F7t2ovJU0n/S9uOhgPtwi9Ts4o=;
        b=fXyBU/55jEnSVw3hb72AplduteyVKGOqjYDS2p2/5/ktcAoZz1WXF7I6IGvyMkJpAN
         aN/SwSbg/+qenn4cpeMuternrFabQ3T4tZ8lk//JwyYPkTxHf4VoZbJ0tm31NbgxaSTq
         RqhWjOjjZonKzcZys/iC488lajbqv2yybNcj59uLGd2YxTu9tI+zlClUvOJOpAs7b+Y0
         x8nAzsgitGNIpSeB+wQLT+vlyKf5HuLPeiNppyCZMKPCBtpvKOPdrYUUJYKLx2BjwHuV
         I5at2/9qWjZbxPuOtIArAqSx08h+AyMSCN2gUvcqFXoiROBU3EaU9fdEYCvSbc+mVXUA
         6eiw==
X-Gm-Message-State: AOJu0Yx2Kfwr54/lQ73yv7ibwcNhmKitJTG2WdcBstHBtN1Kr+Q0mzYi
	0HpkxwpNPc5wQpQg5jukE+pKE4Ay0gpmvwlMrTeZoX5Xf0rrSHRpyUW1
X-Gm-Gg: AfdE7ckAEYN1erZxhFJBj5njG5kOCwLiBxwQ+S2tW2ybHNeyFp+qvLQ9n3Lvagu9ftd
	tEOXrSM6UCIWH1alwsNorG9Frzhbrq/wYkU5kdkv0m0Kwewq5CzosArnXu5NBgemKVj+WMbw1HK
	M2SWM5csrrEndqNAEH49GXK1LwiWhtScZnZo49/IFcHy1jnq+lIBkeq9maPnfc/kJRVAyjBuO07
	hOUJjDDrH0B4Zuna15rV7LZeotRWWsKLcjuDBu3IimbgNi6jX/wk8OBkGhGFnfEN5AZVEcNG2IV
	yJUDOSUzKNLGqsc2o4cb+fLbssPEIu34woD5lStg23RIztlfyaQRcTcQ4axIEhVQgIzHChsBuvH
	a/uA6ioghXcQldL7TetV4SJsYQl0qibBd9uTxM8loCkdj1WvKcmT3WdRcMvqwfofrtHdIOcrvie
	DgsMlcX/A=
X-Received: by 2002:a05:6a00:4fcb:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84826c9765dmr647961b3a.16.1783346928949;
        Mon, 06 Jul 2026 07:08:48 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bd1078sm3875262b3a.24.2026.07.06.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:08:48 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] wifi: mac80211: free AP_VLAN bc_buf SKBs outside IRQ lock
Date: Mon,  6 Jul 2026 22:08:41 +0800
Message-Id: <20260706140841.581566-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38691-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDFCC7132E2

ieee80211_do_stop() removes AP_VLAN packets from the parent AP
ps->bc_buf while holding ps->bc_buf.lock with IRQs disabled. It then
calls ieee80211_free_txskb() before dropping the lock.

ieee80211_free_txskb() is not just a passive SKB release. For SKBs with
TX status state it can report a dropped frame through cfg80211/nl80211,
and that path can reach netlink tap transmit. This is the same reason
the pending queue cleanup in ieee80211_do_stop() already unlinks SKBs
under the queue lock and frees them after IRQ state is restored.

The buggy scenario involves two paths, with each column showing the
order within that path:

AP_VLAN management TX:             AP_VLAN stop:
1. attach ACK-status state         1. clear the running state
2. queue a multicast SKB on        2. take ps->bc_buf.lock with IRQs
   parent ps->bc_buf                  disabled
                                   3. unlink the AP_VLAN SKB
                                   4. call ieee80211_free_txskb()

Unlink matching AP_VLAN SKBs from ps->bc_buf under the existing lock,
but move them to a local free queue. Drop the lock and restore IRQ state
before calling ieee80211_free_txskb().

WARNING: kernel/softirq.c:430 at __local_bh_enable_ip

Fixes: 397a7a24ef8c ("mac80211: free ps->bc_buf skbs on vlan device stop")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/mac80211/iface.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 086272c3ec08..43460a705a6b 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -588,6 +588,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		WARN_ON(!list_empty(&sdata->u.ap.vlans));
 	} else if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
 		/* remove all packets in parent bc_buf pointing to this dev */
+		__skb_queue_head_init(&freeq);
 		ps = &sdata->bss->ps;
 
 		spin_lock_irqsave(&ps->bc_buf.lock, flags);
@@ -595,10 +596,15 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			if (skb->dev == sdata->dev) {
 				__skb_unlink(skb, &ps->bc_buf);
 				local->total_ps_buffered--;
-				ieee80211_free_txskb(&local->hw, skb);
+				__skb_queue_tail(&freeq, skb);
 			}
 		}
 		spin_unlock_irqrestore(&ps->bc_buf.lock, flags);
+
+		skb_queue_walk_safe(&freeq, skb, tmp) {
+			__skb_unlink(skb, &freeq);
+			ieee80211_free_txskb(&local->hw, skb);
+		}
 	}
 
 	if (going_down)
-- 
2.43.0


