Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2026961E6D2
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 23:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKFWQO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 17:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKFWQN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 17:16:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FDDFC3
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 14:16:11 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i3so8997558pfc.11
        for <linux-wireless@vger.kernel.org>; Sun, 06 Nov 2022 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dA0A2mS1zZRzZ7Q/qYp11n/Ay7A+Rsz4JSiBN+wojww=;
        b=fOp7H9XFZm/TtBG8jneitttsCEoDpcbawxTHV8TnTMxDptzZqklBsAX1ncRk68V5wg
         obVglUvY7DFageMkgQvMmYqUWHO8tg0ZR2353FOZYyYbS/Pc66SpA9gcUzGQSxkRBcrI
         GbmVH74xLZBt3/YTVI876W9MDo0f8oYfEzeNQpB0gu/P1ag2VyGKeNkRYGHdF9ttHtaq
         oi3ia9JvdWtu+C82lA4RFOxtr49A5qbcKe/c7codC54vIFGi3H6cmclvOjr3km3RYi2G
         yE88KFzCNZNqLbO9Nx1YJeweLWxmglk58VFWbkIVt8EDD2ZsSnHT0X59SUNHR/Xff5Ih
         AVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dA0A2mS1zZRzZ7Q/qYp11n/Ay7A+Rsz4JSiBN+wojww=;
        b=SKytZE/X0uZOVb1GEfw3SFDgf9z2I2k4Ydyygvrs0GGSqpm7cmydh9FFjcRTc6iDDS
         I/gNb2fYHqS6vxvIeCzEC83aDkPqUVvct+8JQOP4j7ilcmwNagWTDvRvZzreRdqunPaF
         XDanuXzkZ9/bm6092Bw5algXRUkHJEkyxXPGSVBaMbw6E84DNf4+/eFpl1MY5KjTJ4gy
         qOT+jI2db436jX2js+Ntu9KQzYuY5D0kSkpM7m5Hjfxc0sj3Z95v52kqAlICbuV10sAB
         0OKNSN4TxrRJ2nfovyTSpE/INfTCVljhUSsrE+67w5YIxHZchf8XIWHXBZ5suPt6Nuwp
         KRJA==
X-Gm-Message-State: ACrzQf3+C4mg6oZLJ1PeMkuq/16Rl+vayPl8knd0CxDRpx84pTB6/IlW
        MICJsMyd++c9Im+1jlGFb03PAA==
X-Google-Smtp-Source: AMsMyM6xvPWEf8iqSp9hTCZxA4G+WflDjaADTy8DkSBYTt+ONJGOhZB8Pdh8WP1utWaFn0kJqUvhBw==
X-Received: by 2002:a63:8942:0:b0:46e:c02e:2eb5 with SMTP id v63-20020a638942000000b0046ec02e2eb5mr40392674pgd.141.1667772970960;
        Sun, 06 Nov 2022 14:16:10 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b00176b84eb29asm3520629plr.301.2022.11.06.14.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 14:16:10 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] wifi: mac80211: update TIM for S1G specification changes
Date:   Mon,  7 Nov 2022 11:16:02 +1300
Message-Id: <20221106221602.25714-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Updates to the TIM information element to match changes made in the
IEEE Std 802.11ah-2020.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/tx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bb2e54610101..383e0242e95f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4769,9 +4769,9 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 			ps->dtim_count--;
 	}
 
-	tim = pos = skb_put(skb, 6);
+	tim = pos = skb_put(skb, 5);
 	*pos++ = WLAN_EID_TIM;
-	*pos++ = 4;
+	*pos++ = 3;
 	*pos++ = ps->dtim_count;
 	*pos++ = link_conf->dtim_period;
 
@@ -4802,13 +4802,18 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
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
+		if (ieee80211_get_link_sband(link)->band != NL80211_BAND_S1GHZ) {
+			skb_put(skb, 1);
+			tim[1] = 4;
+			*pos++ = 0; /* Part Virt Bitmap */
+		}
 	}
 }
 
-- 
2.34.1

