Return-Path: <linux-wireless+bounces-17139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832DA03C94
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 11:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4961881446
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBA1DED66;
	Tue,  7 Jan 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="npapYdDD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D039FF3
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246231; cv=none; b=KLleTxDk85Rrfqkz2IpWZa3MZaKL0bSjJFXWmEWxXgcs7c6j60np2SQND1QGox4Kp0aRiN9yU3jJ1Lsq37z4c3S75Ql08WrJ/nuCjElhdjCJ+JY612SyHssaISHtNfRIaUgyw2Thajm0hAYnPGMDOlO3pSNrXUljZzHO2pB6e1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246231; c=relaxed/simple;
	bh=EIbLzYAMs7jaMQQXNYbPFeTHoSuLe/OH0IozztkNBJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nqZ8LPMtoVZyyZZPHdLiNMCYuQoY7GLsq3iMOkeysgNeMvtc5ZG2bf86lJTqlKzs13C6wAUCyD6AJOqJGxMmMMVnmvCgES/vaVdleccTkEwy+sZNFyE4qcL3kKggdbSIAJ76gfAjkytinL1cnnH3hRMtAqg4x54tdyuYSK74FZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=npapYdDD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21675fd60feso27685965ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 02:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1736246226; x=1736851026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EbWeQ9z9CtzX2Z1+X6h13trZpxmHkhHGzNTw5A5xSY=;
        b=npapYdDD7PjVSqqTcxmAP9H21/GJtivmNalHzwjr1DCuKSV4EUApif/2EO1xGL+YtJ
         v5gb/2dIvaUIiBz0WUxvdRYlnrVNun8V7P8PHxg5AsSUSWhhxlBqx2jct82cUTagzv94
         RcohgQMMhfeEsOQVqoBxfCx47RLnAgdgPZNIVVqFz3vyzcI2FzV7Lb7YGTugJ/Gn6/7t
         KG/47445y8b/WOA871XEAEwMxruZiibaZNrej0OGiVhJApAsqUwCoYbLJLua2Gs5A4Ze
         jvib1Yw+uIblugTjCbw2HBovkVkldw5Vw9IA5qlKNoUOCtdE1hNbQY9FllydqM8SO4Bu
         u6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736246226; x=1736851026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EbWeQ9z9CtzX2Z1+X6h13trZpxmHkhHGzNTw5A5xSY=;
        b=JDPF74kQq2+eOXYv3APi1v09NX+X72P3YH6tCrDIs/fmbxj1nXJsRn7iQ4bMn152hd
         rB9sd31/wyJFuGw6mOeoS6QbpV6p+9RWjo0C9nbsYuHkGl4nWy6/JvVSy68w4PBMHRfW
         Ku+gX3P466sXja2bG/ofreK4rCP0ll0TvkWf8edSku6YybbTRjNTsdlb/tQOQUNzJPvY
         qNQtImbDoSIChytnPc9o4UIfTLIBTVZ6A0w7qeAvu879qyBAIh8UC1c3S/xzz0ddFoZ2
         DtXAnfoJW+mM5V1U2t9R+2x2hF5yJVp7AsIrA9MVHWEPQlIR5KOuXDUpON480NcQRE2o
         WgvQ==
X-Gm-Message-State: AOJu0YzJETs6OwiQjmJkMVGZDEn4TJLkQ9E6BDHkmBTGrHnR/Yujk/Ke
	QmEZoHGa/OKsTGabQUeOv8L0WU1BFpU8TzEDC/1zX6KoX0A9uyyoYpVUDvlyD08=
X-Gm-Gg: ASbGnctAHuccff0XGETyl3L4i0g/L7FkjUHaT8bUm6ga6Ywi/ybagfr9sJxZ238yIF3
	TG0RQ5ZbVhvspuiTqfU3M20k33BUMbjwYnE1NsMLMKIv5qH2PqTGhbCDZf6sYgR+zcQVuZzXzjS
	egbqrf/aNdro/w0JC7FvRPzfLyvlEWoS6n7GgUsy0ziFQMY8yPFCBnWaKPxHFy+wykxqcMWzfFt
	n4vBHwD2FpKPx/25mGLCE17fesiLDm6zeNuky3MUdhIo/iW3zol8dxZf5gEzLWT/BRa9+rXpU+K
	i/EJvkm+JRC7PRJ0vRxz5DEnaOpw7ieBHuIQTZU=
X-Google-Smtp-Source: AGHT+IF+5ymQTkIbHmivIsmuT379ON7ikMTUOW7XS7Pmx2MCikIvY1WKHl+26je+pPQogdiudcAmTw==
X-Received: by 2002:a05:6a00:35ca:b0:725:e499:5b86 with SMTP id d2e1a72fcca58-72abde97ec4mr93606276b3a.20.1736246226313;
        Tue, 07 Jan 2025 02:37:06 -0800 (PST)
Received: from localhost.localdomain (c-71-197-149-76.hsd1.wa.comcast.net. [71.197.149.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb0d1sm32947674b3a.137.2025.01.07.02.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 02:37:05 -0800 (PST)
From: Andy Strohman <andrew@andrewstrohman.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org,
	Andy Strohman <andrew@andrewstrohman.com>
Subject: [wireless] wifi: mac80211: fix tid removal during mesh forwarding
Date: Tue,  7 Jan 2025 10:44:31 +0000
Message-Id: <20250107104431.446775-1-andrew@andrewstrohman.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With change (wifi: mac80211: fix receiving A-MSDU
frames on mesh interfaces), a non-zero TID assignment
is lost during slow path mesh forwarding.

Prior to this change, ieee80211_rx_h_mesh_fwding()
left the TID intact in the header.

As a result of this header corruption, packets belonging
to non-zero TIDs will get treating as belonging
TID 0 by functions such as ieee80211_get_tid().
While this miscategorization by itself is an
issue, there are additional ramifications
due to the fact that skb->priority still reflects
the mesh forwarded packet's ingress (correct) TID.

The mt7915 driver inspects the TID recorded within
skb->priority and relays this to the
hardware/radio during TX. The radio firmware appears to
react to this by changing the sequence control
header, but it does not also ensure/correct the TID in
the QoS control header. As a result, the receiver
will see packets with sequence numbers corresponding
to the wrong TID. The receiver of the forwarded
packet will see TID 0 in QoS control but a sequence number
corresponding to the correct (different) TID in sequence
control. This causes data stalls for TID 0 until
the TID 0 sequence number advances past what the receiver
believes it should be due to this bug.

Mesh routing mpath changes cause a brief transition
from fast path forwarding to slow path forwarding.
Since this bug only affects the slow path forwarding,
mpath changes bring opportunity for the bug to be triggered.
In the author's case, he was experiencing TID 0 data stalls
after mpath changes on an intermediate mesh node.

These observed stalls may be specific
to mediatek radios. But the inconsistency between
the packet header and skb->priority may cause problems
for other drivers as well. Regardless if this causes
connectivity issues on other radios, this change is
necessary in order transmit (forward) the packet on the
correct TID and to have a consistent view a packet's TID
within mac80211.

Fixes: 986e43b19ae9 ("wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces")
Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
---
 net/mac80211/rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 2bec18fc1b03..c4a28ccbd064 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3001,6 +3001,7 @@ ieee80211_rx_mesh_data(struct ieee80211_sub_if_data *sdata, struct sta_info *sta
 	}
 
 	IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, fwded_frames);
+	ieee80211_set_qos_hdr(sdata, fwd_skb);
 	ieee80211_add_pending_skb(local, fwd_skb);
 
 rx_accept:
-- 
2.34.1


