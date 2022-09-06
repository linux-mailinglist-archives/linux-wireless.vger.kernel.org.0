Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAF5ADEA5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiIFEs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiIFEsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:48:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C086B5F233
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:48:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q15so10197648pfn.11
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BiyzywgHHj+IVb5QDXTCFlBPfP6+IwHSEhwSM4r8OT0=;
        b=V7DCEhsYjTgi2OkQTP2r11v1NCdy9TiI+7gLB7gxxRAjuaOd1uetcsziLD0uDf2KI9
         PvrTlzibVCi0Eon3jdZpRg4bPv4kzSe676mZEVs1zlVXCVpc7YG7QcIMggvhPxfchoj2
         UYRAmC5STYNkUeTzB0lHWMnKHBSg8lldYjJsnlwr248eWfpc3BJb5nCwNsKOMmO5xdl2
         h5RJkXiRo4Bb/f8MESTA9HPngjxzNWorcUdJMLurqe07Q8hOsTYUt0Ebf4WgyTE6yh0A
         vSiJgDbiMD974czwXNCyDqyrEhPaGERHRZBBOl0HvVoQfGLw6WFkenJJCB00cjHSVeBm
         NlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BiyzywgHHj+IVb5QDXTCFlBPfP6+IwHSEhwSM4r8OT0=;
        b=Q195rvjz/AEd2o4/5PpbaNQMF8h7NEOgAPIjhr0frxxlPqShn8o2bE/X9QR4EX/BvW
         A/aDQvQiPVJJ6Evskh707Gl/q+22RnMi3tS5u2DGmLTiWjvpUerPDvRoAr93zWNW1cYO
         rfNbi1kkX7RRPVie3SHIX3EAbbWXdg2rMG4Eib1pzOoUEOofZi1SrgRlCLGrryp99xUv
         kje5M1thktrcYjTFJHsr+POP9VoeC+urHgpb0pzpiOL6xZ0wYsdnk01YEshSNBSz46Da
         gMxOzbJAZLH7N/5Q622dgBU6woeJyr0NTFrXr6CFd5bULVgfiuCROtaF43veeFBqoZ2E
         FeUQ==
X-Gm-Message-State: ACgBeo1iGlLjmQIqQjulcyjPCaVR/PXN9JUDGdrzq2AvOnRG+A9iNazl
        7XU357nRiHPTXBGB3TNl1TKwZw==
X-Google-Smtp-Source: AA6agR5HHoAF9pOmXIkxjI0QqA++GZUo1e+WTnmSF2SYJdknFX6alnb+buf0LDQ39opBSQKbwXupwg==
X-Received: by 2002:a63:fd47:0:b0:432:be56:9ab1 with SMTP id m7-20020a63fd47000000b00432be569ab1mr15069551pgj.252.1662439729304;
        Mon, 05 Sep 2022 21:48:49 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:48 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 02/12] mac80211: update TIM for S1G specification changes
Date:   Tue,  6 Sep 2022 16:48:02 +1200
Message-Id: <20220906044812.7609-3-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
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
2.34.1

