Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3595A5940
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiH3CUq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH3CUo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:20:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3587C333
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f12so9567401plb.11
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=u9vzsvJZ1zw3iEr8rRQq4rL8aF67x/gQVDonBdLqrj8=;
        b=rwmV+1k0r0oczG2b7U6PmTPq9sbN46chMwNh6qsvObFFA90d4ba8jHv7Llq7vvgdqi
         dawRPxA7zFTo48GaB/GgXnVVc/fYet2srRGvMwQIUc3UQT3z2Z4HuAS4Mz5DX2nLV6yc
         +qkXUtp3uwgOE2xcFONYwZt2FoWb2TueZKk9Kpm3ncGDCz82KW0Lnf/w6S8DRj+kg4FZ
         R+DUiwxEiQBEroP/BbJIgUDSqQtzpiPBFkpWScksg+hMKIucb0TgJ0RzOCeBuuBKyTxQ
         QlwrDuk0zJiWu7j23jcuUAqvok9rlmF0k8b6fl3jYxN4Zu+T8nn3iXBb8azpMCiNgGUd
         07cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=u9vzsvJZ1zw3iEr8rRQq4rL8aF67x/gQVDonBdLqrj8=;
        b=3IsZcgzDUcVTLvxyO6T2j8/8H5xaEXtNZIKbcU2cqcf9bdo6fnv/DzraDjbtESncDh
         tcfjVjA6v0iabwmid7xHg+iSS0exXC5iuGyXEbzNlwZTmzZf7f7XIYsNCeOHlg0oNTCD
         A1t7ZLJP4cm/RjMeE3Me8mhKPUag9SbtSIKgw6N3S1EBH4QRgF+hpIaLI7uZZh3Q5qRL
         iyDr/+p+UZrUiVrfDUr527hR+csRKvS5t8e3oagvLg5e4tLEGCx+3t3dZiZPLAtXigHF
         MOHkpwY8irILQWu4bUVo2NI775nV1ZLHj/UCSbvWLGv4TZ8KmQSaQshOKT1qp/qqaZ0t
         Sz9w==
X-Gm-Message-State: ACgBeo1dlQcdwHX/FzFt4G4KQl8UZfYAUodB2hz2SfDjqJKVxspxRJHe
        /QP6FtaFF04/gxfkpz9XlZ9W8g==
X-Google-Smtp-Source: AA6agR7nd9QijXSsHWkTEHn2yQ9q1Rgi4zl0IdqT69eiX9+ag5xSLbYoUtd3K2ZpYbkHINzMshhipQ==
X-Received: by 2002:a17:903:110e:b0:171:3114:7112 with SMTP id n14-20020a170903110e00b0017131147112mr19919316plh.114.1661826043643;
        Mon, 29 Aug 2022 19:20:43 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:43 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 02/12] mac80211: update TIM for S1G specification changes
Date:   Tue, 30 Aug 2022 02:20:07 +0000
Message-Id: <20220830022017.51017-3-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
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
IEEE Std 802.11ah-2020.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 net/mac80211/tx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 45df9932d0ba..bf85a01fcf9d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4749,9 +4749,9 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 			ps->dtim_count--;
 	}
 
-	tim = pos = skb_put(skb, 6);
+	tim = pos = skb_put(skb, 5);
 	*pos++ = WLAN_EID_TIM;
-	*pos++ = 4;
+	*pos++ = 3;
 	*pos++ = ps->dtim_count;
 	*pos++ = link_conf->dtim_period;
 
@@ -4782,13 +4782,18 @@ static void __ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
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

