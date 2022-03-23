Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32564E52D3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbiCWNME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 09:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244147AbiCWNMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 09:12:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB5F5881C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Z2yzTyOYASwEuQAelkSipCGrR3PaRyKe2/oJV4xXKLE=;
        t=1648041032; x=1649250632; b=NBEZFboKyuUSaaaDQ+Jm5FKMs5Tu43/UF2qloVeas+snwDJ
        bqQvbvqPogM9kJL2BYpIOgXecj+kciBYvEft81lwTj2NQn7TkJK7JRv5aN/aFPqZC4TrnYjz+gzxU
        5buvEAWnnmqcdVkD8FCR/2DPV32DjAwJwYY49ydfkAuxkc2twvuuUVJF0kbbJzUu8LPg7otH7PSvh
        kxpy8osNtKQLRymY1xKShkhpqgc3LP6w0YzTpIj7fknKKIj4SVjjrM32f9NYB0nnfCjWq2eLq/uoy
        UeReu3cmwJ1qtw+1aYiTO6SEpYlhV4T+RU8xAt/Fh60KPV0DqzwACs+atLQBolYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX0ku-00H5rF-Uj;
        Wed, 23 Mar 2022 14:10:29 +0100
Message-ID: <98a39edef048fef625cdec32030d62699f89d9e8.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: adjust the replace_state of
 ieee80211_find_chanctx()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 23 Mar 2022 14:10:28 +0100
In-Reply-To: <40aabb3e10302f1d7da92b7a4eb46577d5ed8e05.1647641256.git.ryder.lee@mediatek.com>
References: <40aabb3e10302f1d7da92b7a4eb46577d5ed8e05.1647641256.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2022-03-19 at 06:18 +0800, Ryder Lee wrote:
> We observe that the condition of chanctx could not be back to
> IEEE80211_CHANCTX_REPLACE_NONE occasionally while STA connection.

Not sure I parse this correctly, can you elaborate?

> In this case the state could be IEEE80211_CHANCTX_REPLACE_OTHER, which
> fails the check and then creates another chanctx that leads to the next
> round of chan_switch failure in cfg80211_check_combinations().

But if it's REPLACES_OTHER (note your typo), then it's not yet
registered properly or anything.

> So, modify state to just rule out IEEE80211_CHANCTX_WILL_BE_REPLACED.

Therefore, that really doesn't seem right.

A chanctx with IEEE80211_CHANCTX_REPLACES_OTHER needs to get used via
ieee80211_vif_use_reserved_switch().

johannes
