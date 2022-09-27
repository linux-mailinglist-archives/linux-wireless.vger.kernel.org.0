Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC905EC204
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiI0MB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiI0MBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 08:01:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127FF15D641
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 05:01:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u12so914200pjj.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=STECnK09ybfpudoK7Aetstw1TIQh/pyx7/8qM08Br4Y=;
        b=HzJpX9Yu+kUIFDSt3FGO4s8UyJOvSgIs/t+KTHJPVqw/aSLeN9PYuYTxwfO8L5Tjd2
         TV4vwfGj4lg757oyLzki6/CP5FpLXtb8LjRWaJZExUJv0qGsxC+xFkgN8YYOI64yETjC
         kKNBCP4hJ8sKOMV52VpjZo/LN7BwP2NHdOr60yD/hj2UdTTC+tkopiGuFnSVJNntnJP/
         o5roUJCvWscl8SaUY8dORlhpmkzFDljExDdWvGWfF2NOdOZoLkDo7O9N/hUp5v5Nav9t
         ZKX7A5bQYeMxZL4ShRLSIDR+wr4Uj8m4c3vfSDGjRM1wrFsxX1k4e+uA9mNkH3PKmVMt
         Ouqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=STECnK09ybfpudoK7Aetstw1TIQh/pyx7/8qM08Br4Y=;
        b=QOKUJrUHYk/YrpJRUrs1IJ8KjtNm9vTSFzojVdps0OAivvXzIhN5q/PHsWqjSJw78h
         M0+3qvqlSaY1bFjXzS8XWX2cJGOzrgWkO+neuY//9culDUILNa8JTAkepXR8yK4Yqr7h
         I9YPkeb9hGNYwwb2INxWdPxvGEDEOslbfZpMG2tjeGXL26/pOJSant1l8B+B1Z1ZY9w/
         uC1DFJUWtAK/Cx6egq94HpEioqopJBDxqyhg8a/3OMK3DNNtTg4fsrA4oOXi5Qh/+f7v
         /G83ZV9fUEqkzu/IeK09tiwbGquUWAIVOWB+8cIpsCw6mkjoZFcYhs+KV6FUMB6neLZe
         wQSw==
X-Gm-Message-State: ACrzQf1taD+Lgz1UAqHiL/2aX4h2nCBaXGHpL6Nc6SaDJ5MgXE+ej5l9
        qbuRcB1zC3szAwj/qnNOWk8vrfK8lYmIisNCc4M=
X-Google-Smtp-Source: AMsMyM4oZirwdJ/+oGpkW4MpyGIqF6vW/NPhuqt4lGQNc8CtDumz09xC3LgTGzxI5BotXF57aU95yxsL5Ai/psrbQ7s=
X-Received: by 2002:a17:902:cecf:b0:178:3b53:ebf5 with SMTP id
 d15-20020a170902cecf00b001783b53ebf5mr27371140plg.122.1664280065358; Tue, 27
 Sep 2022 05:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220927093823.6007-1-nbd@nbd.name>
In-Reply-To: <20220927093823.6007-1-nbd@nbd.name>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 27 Sep 2022 17:00:53 +0500
Message-ID: <CABXGCsOfE1eRsS2jtVo63QbMxyf-jGX_QPhpgsh55varpzjVnQ@mail.gmail.com>
Subject: Re: [PATCH 6.0] wifi: mt76: fix rate reporting / throughput
 regression on mt7915 and newer
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, kvalo@kernel.org,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 27, 2022 at 2:38 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> mt7915 and newer need to report the rate_info that's stored in wcid->rate,
> since they don't fill info->status.rates.
>
> Cc: Jonas Jelonek <jelonek.jonas@gmail.com>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/all/CABXGCsP0znm9pS-MiKtyxTXR7XiyFVqen0qzNpicGHDZKCzbwg@mail.gmail.com/
> Fixes: 44fa75f207d8 ("mac80211: extend current rate control tx status API")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/tx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> index e67cc7909bce..6c054850363f 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -60,14 +60,20 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
>                         .skb = skb,
>                         .info = IEEE80211_SKB_CB(skb),
>                 };
> +               struct ieee80211_rate_status rs = {};
>                 struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
>                 struct mt76_wcid *wcid;
>
>                 wcid = rcu_dereference(dev->wcid[cb->wcid]);
>                 if (wcid) {
>                         status.sta = wcid_to_sta(wcid);
> -                       status.rates = NULL;
> -                       status.n_rates = 0;
> +                       if (status.sta && (wcid->rate.flags || wcid->rate.legacy)) {
> +                               rs.rate_idx = wcid->rate;
> +                               status.rates = &rs;
> +                               status.n_rates = 1;
> +                       } else {
> +                               status.n_rates = 0;
> +                       }
>                 }
>
>                 hw = mt76_tx_status_get_hw(dev, skb);
> --
> 2.36.1
>


Thanks, the issue is solved.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
