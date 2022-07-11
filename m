Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC10856D25B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiGKBJB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGKBI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:08:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF29FCC
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:08:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so3541459pfd.9
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4/CKqP+X1iR04x3vc0jrPvHXSENxHXVZdbRPwIl99c=;
        b=sBLzmEjBp3AB8IS0gG8sctsRNNVI/8/3t0Doj7ZWbzAd783deBuZINRdQi1Lz36n9+
         KudOHqc/DawJQKSO+O3KOXx30gBXlARmvDd3GG3RownC/o01E9cNTvsxpJpktwbqVsG4
         4W1FKR9KRwm2pGZHhm2BEIwjHV7PqzeNOOSa4k3h/8DM6KMxrJ8d5YN8Dx6d8sw7pue5
         emSFLq/usamxbkRGzXJkp5QQTwX6Q1PaC/WLRZVlMrAnIWYKGoPKLDJrQLR6RNEctNif
         5e3ZOHgtF+UowVbug3YbUjdKS2H1+29+WAjlDy35VWDW+w1unRYtKpOYK3RNM+rS/NG1
         P4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4/CKqP+X1iR04x3vc0jrPvHXSENxHXVZdbRPwIl99c=;
        b=dEXnH7WlN2SY48dFx/SfC1jNZixzR95OXjQaGgQeoNL8zUL0jNPi7PMBH+I8iLdiBj
         pzAJONDA2D1qK8md8sSMt6aw1m7WtRDiYBKLJePDKGF7nLHV+im9dqT6qx2bAQyaPsAN
         SRlDtwoAcz9VrkeqB+5LDjxSS89XV+iGDIAaFWv+a2Ey+iTjK0PZKdI/pMmPCKwtTjGf
         KjgAbyhGMZJG+xjyDstPQu5VcY4+yGX9IysEysXWlYnC9d+Abnpg2jK9uxrKn9HXnqFu
         PpKrqLizofyc+b7jD3kfHiVcgLKvME7NcJbaKNVWtkC9MldDeozsyU5pefzUQ3SsRFRX
         P/Xg==
X-Gm-Message-State: AJIora8BFZPnLQDFbb+ZNuXdDSWEd8BTWp9RrvPuOQ+b+SB/PqxEbcJr
        YyudpFTcz6Oe4XMjhx5DZhQ9jQ==
X-Google-Smtp-Source: AGRyM1t0U4N2I2k1VhTnbat1Za2S+udrEgdp3UKV0RcE0ntSqMo4tUr/xsX/Sf4N/mA2Uj89Bl0fGg==
X-Received: by 2002:a65:4685:0:b0:416:ce1:8d9b with SMTP id h5-20020a654685000000b004160ce18d9bmr1171162pgr.529.1657501738701;
        Sun, 10 Jul 2022 18:08:58 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:08:58 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 02/12] mac80211: update TIM for S1G specification changes
Date:   Mon, 11 Jul 2022 01:08:06 +0000
Message-Id: <20220711010816.45927-3-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Updates to the TIM information element to match changes made in the
IEEE Std 802.11-2020.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/mac80211/tx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c3e14ef20c05..3d83f838d728 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4710,9 +4710,9 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 			ps->dtim_count--;
 	}
 
-	tim = pos = skb_put(skb, 6);
+	tim = pos = skb_put(skb, 5);
 	*pos++ = WLAN_EID_TIM;
-	*pos++ = 4;
+	*pos++ = 3;
 	*pos++ = ps->dtim_count;
 	*pos++ = link_conf->dtim_period;
 
@@ -4743,13 +4743,18 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 		/* Bitmap control */
 		*pos++ = n1 | aid0;
 		/* Part Virt Bitmap */
-		skb_put(skb, n2 - n1);
+		skb_put(skb, n2 - n1 + 1);
 		memcpy(pos, ps->tim + n1, n2 - n1 + 1);
 
 		tim[1] = n2 - n1 + 4;
 	} else {
 		*pos++ = aid0; /* Bitmap control */
-		*pos++ = 0; /* Part Virt Bitmap */
+
+		if (ieee80211_get_sband(sdata)->band != NL80211_BAND_S1GHZ) {
+			skb_put(skb, 1);
+			tim[1] = 4;
+			*pos++ = 0; /* Part Virt Bitmap */
+		}
 	}
 }
 
-- 
2.25.1

