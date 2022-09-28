Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF2D5EE9A8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 00:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiI1WtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiI1WtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 18:49:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1058B111DC5
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 15:49:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b23so13734610pfp.9
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Yrf9VypQmXniiAt1Rrqqdwkj06oR7gkPD9h3efyfcaY=;
        b=WDGdFfpvzhqU1ZnRxaqxRcJ22foTvQ1gbkCFu6ztXYfIDE+gwTWmn2dRXMgy5jgzjR
         X909+NKSbCtXbUWLCjL4VocKXEa+Aj896zxXW94FFXGL32h5tOor9oDqI9IuYR3RQFaF
         c5hCj37MVPF3+xyd42nkXxV42eyPgeWMeG8GCj6pHFA2IqvCJ/skSxUA3j4BdjweEB9Z
         SVFo++CV+6pIaBHrUIv/2N/OnSwPDDUvheV4ICvicyJf1WDmX//H/tqn2GTU5wDYj8Ed
         lmrayRBGcXqeltYMlTrAJNUR+ZE12rwnJ4qdSxWvGC00QG4hEpVtassPyx/Ht0sEy+v5
         4GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Yrf9VypQmXniiAt1Rrqqdwkj06oR7gkPD9h3efyfcaY=;
        b=qXGFiVO5GvKe0Y1nUr7zxII/oEVPTPokxQlj9ZhNVR9UqjqwerSCioFg97ZKQb1UC3
         Y/8X0UDU1Hu/lYzizrhunsV+Q3Bmb4nbO7V3dDTuHsCdesTCgr4OnOHBc5ybb89jsrsc
         I2KH/Sur/em+e9VfxiKrXIOD0dJW+vGP3yO0U0ZKxBikZ02Y81TxYWvWJQ6apaBtWfBZ
         qFyWNPpIEn1Qkabpm9Uwf1jzfqx1muq7eJIeF06+zs77mCpA5s12t9HMMXWPlLnFuaVE
         R48M25mXDnNEfkt+0yo4Ea1StgsyJDAgH9+ZP+F+EkPvawdYa75f3g8SvjtkvH2jjiDX
         Fkqw==
X-Gm-Message-State: ACrzQf0+1VXYhzXiiWQkM6OKH+ik+kotHUhL9nLqa01vuYyf2q854cmF
        MyZwu9KlVUH/8hNDdA6aLPXJaT3KiJc=
X-Google-Smtp-Source: AMsMyM4AKteQKMlJKcyAS6FYfSWFaQLlvDl4zljbRZfY/CFWvaE1Dp4hOkfoNkAGMhCpOrSVVvd7xQ==
X-Received: by 2002:a63:da4b:0:b0:439:14a8:52b with SMTP id l11-20020a63da4b000000b0043914a8052bmr96473pgj.500.1664405354362;
        Wed, 28 Sep 2022 15:49:14 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id ob6-20020a17090b390600b001f2fa09786asm643738pjb.19.2022.09.28.15.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:49:14 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/1] wifi: mac80211: fix probe req HE capabilities access
Date:   Wed, 28 Sep 2022 15:49:10 -0700
Message-Id: <20220928224910.453232-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928224910.453232-1-prestwoj@gmail.com>
References: <20220928224910.453232-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When building the probe request IEs HE support is checked for
the 6GHz band (wiphy->bands[NL80211_BAND_6GHZ]). If supported
the HE capability IE should be included according to the spec.
The problem is the 16-bit capability is obtained from the
band object (sband) that was passed in, not the 6GHz band
object (sband6). If the sband object doesn't support HE it will
result in a warning.

Fixes: 7d29bc50b30e ("mac80211: always include HE 6GHz capability in probe request")
Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 net/mac80211/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0ea5d50091dc..be69cddaf139 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2046,7 +2046,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		if (he_cap) {
 			enum nl80211_iftype iftype =
 				ieee80211_vif_type_p2p(&sdata->vif);
-			__le16 cap = ieee80211_get_he_6ghz_capa(sband, iftype);
+			__le16 cap = ieee80211_get_he_6ghz_capa(sband6, iftype);
 
 			pos = ieee80211_write_he_6ghz_cap(pos, cap, end);
 		}
-- 
2.34.3

