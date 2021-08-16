Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070AC3ED3D9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHPMXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhHPMXN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 08:23:13 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938BC061764
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OFxJhb5ChaydorJtYsN/zuRAZ1Omn83stZGoS+7n3JU=; b=s6ZX6FOYm/rasv3s29dyRmqvHW
        ZklGhjacYIZjkRnGMdCtjyhGSQM+L+Erm+rC8Zhnn44FFAareb6c5ks/bFODUQ/Xj6/2h1bDCEUiN
        +kTSWrjR8mgyxQiABphRaNWPATjM0mWQTZEhX0hmljC9DT2qfWiQb9tU5gVRTwj7RQnI=;
Received: from p4ff13206.dip0.t-ipconnect.de ([79.241.50.6] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mFbdX-0006xf-OD; Mon, 16 Aug 2021 14:22:39 +0200
Subject: Re: [PATCH 1/2] mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug
To:     Ping-Ke Shih <pkshih@realtek.com>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, gary.chang@realtek.com
References: <20210816085128.10931-1-pkshih@realtek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <1a7bdf33-046a-b67b-f650-7b4c3d7e2859@nbd.name>
Date:   Mon, 16 Aug 2021 14:22:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816085128.10931-1-pkshih@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-16 10:51, Ping-Ke Shih wrote:
> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> In ieee80211_amsdu_aggregate() set a pointer frag_tail point to the
> end of skb_shinfo(head)->frag_list, and use it to bind other skb in
> the end of this function. But when execute ieee80211_amsdu_aggregate()
> ->ieee80211_amsdu_realloc_pad()->pskb_expand_head(), the address of
> skb_shinfo(head)->frag_list will be changed. However, the
> ieee80211_amsdu_aggregate() not update frag_tail after call
> pskb_expand_head(). That will cause the second skb can't bind to the
> head skb appropriately.So we update the address of frag_tail to fix it.
I think instead of iterating over fragments a second time, we should
move the ieee80211_amsdu_prepare_head call further up.

- Felix

