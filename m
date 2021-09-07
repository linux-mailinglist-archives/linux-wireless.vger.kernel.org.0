Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E514D40286D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbhIGMTm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:19:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33442
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343867AbhIGMTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:31 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D2A7040784
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017104;
        bh=ygx+SrZOuhDRvL55hE9xxzLOd3db853TUebx3pnrgoQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jyUbkNv7nILzyveTW7jxCZgSs1rmx3R2NggqiL9rX23ZlrjOC7qGYwo/Z6Pl+9bXQ
         tY7dz1GeYGgl0Vd0IEAuuSzQPQxIRHoXsNDXy8QLlZcu1eCMOKRRjuN8AK+yvcSboU
         Nn/tFodei3Qi1jtn6JunhDAWaI//CRW32IT9vhGwHjffOD2ZEdVXVOOx2PvZTh8Ydg
         lPiA6b00V28yMRED0VYTvk9mW0rsb5ld/FMBKZsdby5wNjSci6vWmbGz5uaPb70dLb
         uR1YhGwze5n0qDdsw2BtTucZBcpTkz2aio/8L/agf2RgEP3GDDTGBm6/Dp2Qt/mMdx
         xNIROWBFIGfiw==
Received: by mail-wm1-f71.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so1105295wmj.8
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygx+SrZOuhDRvL55hE9xxzLOd3db853TUebx3pnrgoQ=;
        b=Y3C55NuVgnDUackcFQ2lxU/pbnyi8AH56nTbz7BpN9wgK52XbgASzVc6u24ROMJDkr
         FTeZ7OfanV3XL96glwXJWdRrHnVI7rgrX9GCGPzQSti1/pwVWTstnYQe8t8W5XKfDPGw
         GhghYz8k0AehU0w+blW9aA16wLZaZU5qd8gQkyVM+w6MzSCcLj9C3DQF6FZyJ6UXlOuO
         XYSXDXsA4ewEZTj/X/ZFPseO+QZJoXihxmmsEoIYA7lZV7owYTIUTMTszEcMj9xwLerF
         xjCAsFXUkO0x+AJbpD7xdYGN3rZ1xwXmRr0/doUnyPwimeiwkubTBfw6k7CRZ39WnX8A
         Qdmw==
X-Gm-Message-State: AOAM531d87yVPMdotfYZg3xfyKNxpIDbBYJi9nVLGDoXsyjJvbD/uiuz
        19lL/UlOHoBpaEPe2cVISa5rPSLZc3favj98NzrlbYamYWYE4ybRlnTw+Vuhhuqm0FpO6CfVF1q
        IWvHU1p/vgKIApn+pAqBdBQrxViIyB3yknK6npbzpzqOP
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr3576588wml.127.1631017104502;
        Tue, 07 Sep 2021 05:18:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB9lpSYRjC+nwBj78YNN3ZDlBL5vpXCZ8sbbrL5Cjob2y7j5eoJJP5w2OFbtm4kDLZhWgyyA==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr3576575wml.127.1631017104347;
        Tue, 07 Sep 2021 05:18:24 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 02/15] nfc: do not break pr_debug() call into separate lines
Date:   Tue,  7 Sep 2021 14:18:03 +0200
Message-Id: <20210907121816.37750-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unneeded line break between pr_debug and arguments.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/hci/llc_shdlc.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/nfc/hci/llc_shdlc.c b/net/nfc/hci/llc_shdlc.c
index 78b2ceb8ae6e..e90f70385813 100644
--- a/net/nfc/hci/llc_shdlc.c
+++ b/net/nfc/hci/llc_shdlc.c
@@ -201,8 +201,7 @@ static void llc_shdlc_reset_t2(struct llc_shdlc *shdlc, int y_nr)
 			del_timer_sync(&shdlc->t2_timer);
 			shdlc->t2_active = false;
 
-			pr_debug
-			    ("All sent frames acked. Stopped T2(retransmit)\n");
+			pr_debug("All sent frames acked. Stopped T2(retransmit)\n");
 		}
 	} else {
 		skb = skb_peek(&shdlc->ack_pending_q);
@@ -211,8 +210,7 @@ static void llc_shdlc_reset_t2(struct llc_shdlc *shdlc, int y_nr)
 			  msecs_to_jiffies(SHDLC_T2_VALUE_MS));
 		shdlc->t2_active = true;
 
-		pr_debug
-		    ("Start T2(retransmit) for remaining unacked sent frames\n");
+		pr_debug("Start T2(retransmit) for remaining unacked sent frames\n");
 	}
 }
 
@@ -518,12 +516,11 @@ static void llc_shdlc_handle_send_queue(struct llc_shdlc *shdlc)
 	unsigned long time_sent;
 
 	if (shdlc->send_q.qlen)
-		pr_debug
-		    ("sendQlen=%d ns=%d dnr=%d rnr=%s w_room=%d unackQlen=%d\n",
-		     shdlc->send_q.qlen, shdlc->ns, shdlc->dnr,
-		     shdlc->rnr == false ? "false" : "true",
-		     shdlc->w - llc_shdlc_w_used(shdlc->ns, shdlc->dnr),
-		     shdlc->ack_pending_q.qlen);
+		pr_debug("sendQlen=%d ns=%d dnr=%d rnr=%s w_room=%d unackQlen=%d\n",
+			 shdlc->send_q.qlen, shdlc->ns, shdlc->dnr,
+			 shdlc->rnr == false ? "false" : "true",
+			 shdlc->w - llc_shdlc_w_used(shdlc->ns, shdlc->dnr),
+			 shdlc->ack_pending_q.qlen);
 
 	while (shdlc->send_q.qlen && shdlc->ack_pending_q.qlen < shdlc->w &&
 	       (shdlc->rnr == false)) {
@@ -641,8 +638,7 @@ static void llc_shdlc_sm_work(struct work_struct *work)
 		llc_shdlc_handle_send_queue(shdlc);
 
 		if (shdlc->t1_active && timer_pending(&shdlc->t1_timer) == 0) {
-			pr_debug
-			    ("Handle T1(send ack) elapsed (T1 now inactive)\n");
+			pr_debug("Handle T1(send ack) elapsed (T1 now inactive)\n");
 
 			shdlc->t1_active = false;
 			r = llc_shdlc_send_s_frame(shdlc, S_FRAME_RR,
@@ -652,8 +648,7 @@ static void llc_shdlc_sm_work(struct work_struct *work)
 		}
 
 		if (shdlc->t2_active && timer_pending(&shdlc->t2_timer) == 0) {
-			pr_debug
-			    ("Handle T2(retransmit) elapsed (T2 inactive)\n");
+			pr_debug("Handle T2(retransmit) elapsed (T2 inactive)\n");
 
 			shdlc->t2_active = false;
 
-- 
2.30.2

