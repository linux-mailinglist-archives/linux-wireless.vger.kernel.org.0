Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3878AF83
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjH1MFr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjH1MFW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31911A
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=3IM/xQxCNmMb+roBoyf++Go/ZcPS4Yk17bmSlUeSEJw=; t=1693224319; x=1694433919; 
        b=tN8QFIh9CSARwlbuuh7gvMfHsJHi3TFsPREzwmtQdcomkuDMrxPFsiu6gqjnQdA62xIW1enZOSx
        P6mAp5eObeI5X2tjM/W+SMraaxhMkL6bbGBfI96lECGeKkyqW1i1fYXMrAJ6YNyUqn1w2sRWpz9js
        DdyV9mmuiVF7f5Ph930R9LWOwBBUvrsjyTNnSgYZYUTJyDUdbJ0oxHIfLKx/187/pgS3zqcmqzzd+
        ScSSBi6AEL7/NoJdId7AQtArA1rO1y1QvT0OUMZXjzyKGC8dKla7cBDEXhHlD7h/Lw9zoG6ZV6FAD
        IQ0p1yvHFi+RYf+SnL3WrerE2s6QLX1uuQlw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazd-00Gjgt-23
        for linux-wireless@vger.kernel.org;
        Mon, 28 Aug 2023 14:05:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/40] wifi: cfg80211/mac80211: locking cleanups
Date:   Mon, 28 Aug 2023 13:59:28 +0200
Message-ID: <20230828115927.116700-41-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So ... I mentioned a few months ago this was the direction I was
going in, and now here I have it. We've been running with it for
a while, and it looks good.

There's a kind of pointless commit in there that adds some wiphy
locking assertions to the wdev as an intermediate step, I can
remove that if you think that's better. We ran with it at that
intermediate stage for a while to test things.

As you can see in the list of patches, mutexes are removed:

 * in mac80211: sta_mtx, key_mtx, chanctx_mtx, ampdu_mlme.mtx,
                local->mtx, and iflist_mtx is reduced to just
                a driver helper mutex basically
 * in cfg80211, and was used by mac80211, the wdev mutex

This also fixes a number of potential deadlocks lockdep would
report in multi-link scenarios, but generally of course radically
simplifies locking, no more worries about dependencies between
the different mutexes in mac80211, etc.

johannes


