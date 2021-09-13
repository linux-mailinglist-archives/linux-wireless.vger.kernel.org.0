Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12AC408DE5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbhIMNae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:30:34 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57726
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240596AbhIMNWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:22:01 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 435EC40258
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539245;
        bh=ygx+SrZOuhDRvL55hE9xxzLOd3db853TUebx3pnrgoQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fdf45LTIcq4mY7uCJUaLFAQgCz3vWBx/FnEVwAbo+Hj+B5/BPnnEAD+bWjqq2YjMh
         +tI44rlwaDSfR4mh3WTwH83F+cW1xaWLJTLe7GG+tERPiOSL2bZgYuZFwC8pcpAHqy
         wSp/Ygf+Yr7bwMHj/HF4Bzv7+FA+pyuvQzDDA05nDTdWqKZ7vnneCwQsu6FQuzFh5L
         LbRnOeS5W0ifR1vRwmWIV4Bxw2sX+ZNpiPKFBhURZE3XGWy2fcHCtxU6O6BH2JtWdy
         576PwalssVDl8qDDtEPmMGs61LQj9gbkvgmra1rTcJzut9OsMSr1/vEy9pheoLcr5q
         Nf4FpLtwRQygA==
Received: by mail-wm1-f72.google.com with SMTP id h1-20020a05600c350100b002e751bf6733so1648035wmq.8
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygx+SrZOuhDRvL55hE9xxzLOd3db853TUebx3pnrgoQ=;
        b=pF6YtA83XSff0j/vWkrrGmoGsOWZubkg10qQpnmS1Ztc97d2w8quEjsXwf45qqlmdl
         8zD8Aqxha194zL/sRpCaCAW9w7hctRJJzleGxX4k0mvo8X8GhDXLuJVhE9YQCxysq6Ox
         SfSLpKVZroyVMAeQZrFmyOMfuFU+NlnwxpZcGeOTu+wKuz9VMCt2g6cKvv15A1UVQm8e
         GEKfi6VWOlend1TLak/ncJL+LoThsVQyZRe4RR6q3eEkJx8fmS/7nAaKyF7rzOL3KdpT
         A8xWc/f4tsGsLkoLmUFBPhmJCQ4hgD4VoqW8rXLk8e7+ZkGRZ9WQ77oV+cbywOObBGJv
         4sJg==
X-Gm-Message-State: AOAM530DRFA19/Nurxht9or7xHr+aeLn/W9yMxylCqmUMjbvQ2yHXI70
        tP0zHbcaG8tlWOoNF/Z6eCgyVcoN2yp8V4Tp/Va0EbfOKxQgzfcZsHVbLHdF+VAb9wdzchErU9e
        Xhi15jiCFguIyvqUujwR8Aq87XD9R406OKOmv8qzwUbfP
X-Received: by 2002:adf:fb07:: with SMTP id c7mr12251634wrr.399.1631539244940;
        Mon, 13 Sep 2021 06:20:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzILgpQkYxJU/M3MzweCeFPT+kDGa1TnDYwi3heoPxDFjyRATx52X0us/D5TSUHmIkvEVgWw==
X-Received: by 2002:adf:fb07:: with SMTP id c7mr12251611wrr.399.1631539244768;
        Mon, 13 Sep 2021 06:20:44 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 02/15] nfc: do not break pr_debug() call into separate lines
Date:   Mon, 13 Sep 2021 15:20:22 +0200
Message-Id: <20210913132035.242870-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
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

