Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB783266595
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgIKRHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:07:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39513 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725881AbgIKPCG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 11:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599836494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfz2/7wuGD8Y38djXdRgoUk4t9vywrYM1kI/TWx1ITc=;
        b=DeKE7xYKvalGqlu/SVMnViFmCU6Cd5QQ4igNYHUc7yh6qOiKpJCE5dVkPQ1iEnl5ejKF9D
        S5OzFrIbfaLl+0kyp9o/gbza0uI8BhmLojN1c4XioYCdrnch+TSC5N1koYN6/alG7F9YXu
        7aTxc2iBee4smzsWu526BjE8l5vhHs4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-0qUsD-WoPuOOEnaG2eAYLQ-1; Fri, 11 Sep 2020 10:36:47 -0400
X-MC-Unique: 0qUsD-WoPuOOEnaG2eAYLQ-1
Received: by mail-wr1-f72.google.com with SMTP id k13so3592474wrl.4
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 07:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hfz2/7wuGD8Y38djXdRgoUk4t9vywrYM1kI/TWx1ITc=;
        b=ssI+K+NgbU00urQDZISDF9kB/QzbKXrejAWQR78yACaNQqyxILv5PMqzqvDOB+TG6n
         G2kcM8uoZIDZYT4OHMhOeC8CppxUgMsKaTImF0+AgBKEnij8PA1Ur0EMExO6qtkVt1Og
         3DK6WC/tZjktYuKWZaEWSQUZCWVMKVDB3GgcCQHKJLHDAvC3Qe+smxEYKHwsF+97usYc
         SiGhv/rx6hT+KJEXz+yEC9VMPoA3035uzKTcMRpqQ2Ugsiydoh8aRUOYyO/3Lbw23zYN
         i/vteOgOdvtJQCuVyZVwWdflqvBbrzEsR8XHRfDwFDtQms5Ta5v/akTN9ivknqYQfkIp
         jr0w==
X-Gm-Message-State: AOAM531SGgUWzsWcCiGpViDixf6DaBRH0x0h+4gK70UVRDzpyKOY07vU
        jU4iRNnzNWVqKR+ZiUncx5ws3ufClqqUu/QVMIR7FMg+kcfjbQA8ruAtesH2aAn1K4UJLww5TiB
        5c3Whmi6WShueW6hV1lew9jaqv5U=
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr2551310wmo.186.1599835006036;
        Fri, 11 Sep 2020 07:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI6BrikLZy71rWmHNHzSrhZH9gf7fYU6Cn05cLB9G07nNv9LxRdHcIEjCuBRxPjElcafqyKg==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr2551273wmo.186.1599835005573;
        Fri, 11 Sep 2020 07:36:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v6sm4810082wrt.90.2020.09.11.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 07:36:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 396561829D4; Fri, 11 Sep 2020 16:36:44 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Miguel Catalan Cid <miguel.catalan@i2cat.net>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org
Subject: Re: [Make-wifi-fast] Support for airtime scheduling using ath10k
In-Reply-To: <CAMHmoos8p7icOfsXT7q+-uThGCd-k04hPT0BWiCzNTPqH3CJUQ@mail.gmail.com>
References: <CAMHmoovK_m=Yd4uUPhsdHZ588+d1DF-fyS+uGKdRWvd33Q2u+A@mail.gmail.com>
 <87zh8uruou.fsf@toke.dk>
 <CAMHmoouFjdOSBAq00SMeauO2GvEnXMvJG+vEMwhYUD4rdW9rxg@mail.gmail.com>
 <87366ei2x7.fsf@toke.dk>
 <CAMHmoovWrXhMheEPapgEw9b_7S-jOZdJDRvAp-1Cb_i0=pBfEw@mail.gmail.com>
 <87lfk4ftnc.fsf@toke.dk>
 <CAMHmoos8p7icOfsXT7q+-uThGCd-k04hPT0BWiCzNTPqH3CJUQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Sep 2020 16:36:44 +0200
Message-ID: <87k0x09y83.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miguel Catalan Cid <miguel.catalan@i2cat.net> writes:

> Hi,
>
> after doing some tests with different ath10k Wi-Fi cards and clients, I
> found the following behaviour when combining AQL and the airtime
> scheduler:

Thank you for taking a closer look at this!

> - When using the default AQL limits (threshold 24000, limits per AC
> 5000/12000), the airtime scheduler is not working at all, regardless of the
> airtime weights of the STAs. Indeed, in some cases, slower stations were
> able to use a higher amount of airtime, leading to unfairness. I was
> thinking that maybe the default AQL limits are too high to these slow
> stations, allowing them to obtain too much pending airtime. I already used
> the last patches from Felix Fietkau with the same results.

Hmm, I think I can see what's going on here: The AQL patches changed the
behaviour of ieee80211_next_txq() so it will keep iterating as long as
there's at least one station that's eligible for transmission from the
AQL PoV. Which means all station deficits will keep increasing, erasing
the fairness throttling...

> - Indeed, I was able to activate the airtime scheduler by fixing lower AQL
> limits (e.g. threshold of 5000, limits per AC 0/5000). This way, it seems
> that the STAs start competing again for the airtime, and their behaviour
> follows the airtime weights. However,  slower STAs lose a bit of
> performance due to these lower limits.

... and the effect of lowering the AQL parameters is that this situation
will occur less often, making the fairness scheduler work better.

> - The airtime weights have to be higher (e.g. 10000 vs 20000 to obtain a
> 33% vs 66% relation); I found the same behaviour using ath9k and 11n cards,
> so I guess this is due to the aggregation of packets.

This is a bit more puzzling, but I guess it's related to the above.
Also, for ath9k, the airtime check *always* returns true, which just
exacerbates the behaviour.

> Looking into the code, it seems that the key airtime check is the one
> in ieee80211_tx_dequeue. To enable the airtime scheduling, the
> "ieee80211_txq_airtime_check" function has to return false more usually;
> maybe it is just a matter of adjusting the AQL limits according to the
> airtime weights or to modify a bit the "ieee80211_txq_airtime_check"
> function to consider the airtime weight or the deficit of the
> stations.

Yup, you're right on point here, it's a bad interaction between those
two throttling mechanisms. The fairness mechanism relies on not
reshuffling the RR rotation.

I'll think a bit more about what we can do about this. May need to set
up a box for testing a few ideas, but I have been meaning to do that
anyway.

In the meantime, I wonder what happens if we just don't do that? I.e.,
something like the below (completely untested)?

-Toke

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d2136007e2eb..3a2898cbb111 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3743,8 +3743,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_txq *ret = NULL;
-	struct txq_info *txqi = NULL, *head = NULL;
-	bool found_eligible_txq = false;
+	struct txq_info *txqi = NULL;
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
@@ -3755,34 +3754,22 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 	if (!txqi)
 		goto out;
 
-	if (txqi == head) {
-		if (!found_eligible_txq)
-			goto out;
-		else
-			found_eligible_txq = false;
-	}
-
-	if (!head)
-		head = txqi;
-
 	if (txqi->txq.sta) {
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						    struct sta_info, sta);
-		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
 		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
 
-		if (aql_check)
-			found_eligible_txq = true;
-
-		if (deficit < 0)
+		if (deficit < 0) {
 			sta->airtime[txqi->txq.ac].deficit +=
 				sta->airtime_weight;
 
-		if (deficit < 0 || !aql_check) {
 			list_move_tail(&txqi->schedule_order,
 				       &local->active_txqs[txqi->txq.ac]);
 			goto begin;
 		}
+
+		if (ieee80211_txq_airtime_check(hw, &txqi->txq))
+			goto out;
 	}
 
 

