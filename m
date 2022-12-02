Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50D641093
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 23:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiLBW0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 17:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiLBW0R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 17:26:17 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609EEAB79
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 14:26:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so9569019pjh.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Dec 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yt6U61saWMCsM6WunZD+lQTQ9rMom+0MKUGAGbXh2To=;
        b=JpkNSnUTQREjjU9X/9QyMGlgjT/ma/hBiV5HrI0DcxE2Idct0EzQS0SPud8jNOc4+y
         fXMXZoENWijXmad/5W89LY3KmeTspX126DxZCyiKxuGu7IPFcGkSTw/ysnfS7+GLRNUc
         hpzjNdf+6K6vfsBpzuGOOMwwpfTw94FefHU4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yt6U61saWMCsM6WunZD+lQTQ9rMom+0MKUGAGbXh2To=;
        b=i8uxi3yZof7XG6ZZmDQGUmBOagN8dQKxo1pTHDACvaEnIEbN5Y6Am96ozoIXNf4wQg
         yG7EY4H3JeSAOs3GDEE3joTqHQw36ur/fNob2UCuVuyVJbjWMQr1U0PKCwT1nDiGzulW
         n56XSnS08Gx0Sf+XbFbIFzBj6Idx6JARL0lqb1yX7/TK1NSp+PGhY2i1F+OnqGKAkLsu
         mF9VPQfjc8kBKwm3uIFxlev93WbiP7xJ2OdBYMyLoWKiDALAKfD1uqJlN3X/LmyZ5Byd
         j0L1xDJOhZEij5Rip+TDoDQ0f6qNzUmQgmro+pErsG1Qg7UFsP3t3EY+RVs2YV8AGBE7
         R1WA==
X-Gm-Message-State: ANoB5pli/f+j+oJX513NPwgNsvRR7CW9zzayTrO2ELVFF9r4MI+6xtMp
        ro6KKxzNiCyDystk6Js8l6KFAg==
X-Google-Smtp-Source: AA0mqf5hBB6FtCKudJpUxOEaTUIc1ooouR7B5mUlnUXJWd9jB2xbI+K89flhWre2qJUd9p1XkrgzFw==
X-Received: by 2002:a17:90b:4b89:b0:213:d2c:1923 with SMTP id lr9-20020a17090b4b8900b002130d2c1923mr20326111pjb.234.1670019974390;
        Fri, 02 Dec 2022 14:26:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w81-20020a627b54000000b0057255b7c8easm5570259pfc.33.2022.12.02.14.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:26:13 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 2 Dec 2022 14:26:12 -0800
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: mt7915_rate_txpower_get(): Resource leaks
Message-ID: <202212021426.BE8F5215@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221202 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Thu Dec 1 17:29:14 2022 +0100
    bd2404d42821 ("wifi: mt76: mt7915: add basedband Txpower info into debugfs")

Coverity reported the following:

*** CID 1527799:  Resource leaks  (RESOURCE_LEAK)
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:999 in mt7915_rate_txpower_get()
993     	buf = kzalloc(sz, GFP_KERNEL);
994     	if (!buf)
995     		return -ENOMEM;
996
997     	ret = mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr));
998     	if (ret)
vvv     CID 1527799:  Resource leaks  (RESOURCE_LEAK)
vvv     Variable "buf" going out of scope leaks the storage it points to.
999     		return ret;
1000
1001     	/* Txpower propagation path: TMAC -> TXV -> BBP */
1002     	len += scnprintf(buf + len, sz - len,
1003     			 "\nPhy%d Tx power table (channel %d)\n",
1004     			 phy != &dev->phy, phy->mt76->chandef.chan->hw_value);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527799 ("Resource leaks")
Fixes: bd2404d42821 ("wifi: mt76: mt7915: add basedband Txpower info into debugfs")

Thanks for your attention!

-- 
Coverity-bot
