Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A053DD5B
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jun 2022 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiFERZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Jun 2022 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiFERZ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Jun 2022 13:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4518344
        for <linux-wireless@vger.kernel.org>; Sun,  5 Jun 2022 10:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 020DB6114D
        for <linux-wireless@vger.kernel.org>; Sun,  5 Jun 2022 17:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBEFC385A5;
        Sun,  5 Jun 2022 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654449927;
        bh=kA1rE6coALLPyy9Pp2w6PONiCb6kJCX0DuutN6amvxU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=knL7dzbC2lKmFSVvKivkCTWvrtliUavnOD5Hc+D6/gMkH/bWiOwuFhu8MPqaiBAH6
         NDEUq4XCGWib2Q3wqrVrjoOdz6r9ymlKzyL+FugdLzTyVjXezBKTizHMv0pSQlGyDQ
         eNLXmIpJKoUEogK+1KnclbCAwUT05OZNwGbMssTpqLpHy5tzchDxhgtBf1zgplAaxQ
         d7xBtPrANAm45BWN6uwEkSRHWXqNf/kf/4gC/1mFtKtNBOn56fmQXBQD1LOGsI7mRY
         8j/jGX6kX1b+9eI0ituo+ygcX6XBK5Z/We3Y6rTXLCsSKgwooK8z3sA0ir9mFBZhg3
         DBfZ/2IZZkZcg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6C129405523; Sun,  5 Jun 2022 19:23:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH] mac80211: do not wake queues on a vif that is being
 stopped
In-Reply-To: <20220531190824.60019-1-nbd@nbd.name>
References: <20220531190824.60019-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 05 Jun 2022 19:23:37 +0200
Message-ID: <874k0zowh2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> When a vif is being removed and sdata->bss is cleared, __ieee80211_wake_t=
xqs
> can still be called on it, which crashes as soon as sdata->bss is being
> dereferenced.
> To fix this properly, check for SDATA_STATE_RUNNING before waking queues,
> and take the fq lock when setting it (to ensure that __ieee80211_wake_txqs
> observes the change when running on a different CPU
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I think it's a little ugly to expand usage of fq.lock across more and
more places, I don't really have a good alternative, so:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>
