Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702454D6165
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 13:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbiCKMSr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 07:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiCKMSq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 07:18:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00E17AAF
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KZF3U/8IONLrjk9Ql0t9pVjfOwEslOcqBZThMf9oqro=;
        t=1647001062; x=1648210662; b=w20T+bQXp1Ed6n6HNCxXHoBXnxD6fhbxsK5nJJQSU0Bt1k+
        5UCzD5KMiph96r1ndXALtFU1CzarPaCtPe7iRDoO/qB+Io19EfdGPR/PkvsOFk7BRpM6Bfk+TUMKh
        lXfhUxTQi/XzH5HEwg5OPZb+uKLVUM/VmcOazMwO95I9zI88WtQP1x5U/G303oPj4XKPaYWWOzrGm
        zkz9CgDqj4YaZUGrmRDeP4ByQvzyKq0o1kHbnIdGg4w8xxuXmVxKyIHPmqoWyysZ6StkR1H8WIE3K
        67UZWoMXeK89j5uxobSlP6vM6g35BCTuxliQIITF+EfWMvh69EfpUF+7jjC+PIrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nSeDE-00Bto6-2K;
        Fri, 11 Mar 2022 13:17:40 +0100
Message-ID: <af96eba158c83a63cb9465b04373e909971d7676.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] cfg80211: Add NL80211_IFTYPE_MLO_LINK type for
 MLO links on MLD STA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_usdutt@quicinc.com,
        Aaron Komisar <akomisar@maxlinear.com>
Date:   Fri, 11 Mar 2022 13:17:39 +0100
In-Reply-To: <1645613200-30221-2-git-send-email-quic_vjakkam@quicinc.com>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
         <1645613200-30221-2-git-send-email-quic_vjakkam@quicinc.com>
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

On Wed, 2022-02-23 at 16:16 +0530, Veerendranath Jakkam wrote:
> 
> Two link non-AP MLD representation:
> 
>                  wlan0 (non-AP MLD)
>                IFTYPE_STATION (netdev + wdev)
>                  /               \
>                 /                 \
>               link0             link1
>       IFTYPE_MLO_LINK (wdev)  IFTYPE_MLO_LINK (wdev)
>               |                   |
>               |                   |
>             radio(2G)           radio(5G)
> 
> In contrast, NL80211_IFTYPE_MLO_LINK can't be used to represent AP MLO
> link since an MLD AP must support pre-11be and 11be clients
> simultaneously so each AP MLO link affiliated with AP MLD must also act
> as independent AP for pre-11be clients so each AP MLO link must be
> represented by NL80211_IFTYPE_AP associated with a separate netdev.
> 
> Two link AP MLD representation:
> 
>                  AP MLD
>              (netdev + wdev)
>                 /      \
>                /        \
>           wlan0          wlan1
>       IFTYPE_AP       IFTYPE_AP
>    (netdev + wdev)  (netdev + wdev)
>            |             |
>            |             |
>         radio(2G)      radio(5G)

So just for posterity's sake - we had more discussions on this out of
band, and decided that the "netdev + wdev" on the wlan0/wlan1 will not
actually happen - they both should be just "wdev" like in the non-AP
MLD.

This solves the issue of broadcast (otherwise you'd need AP MLD + wlan0
+ wlan1 in a bridge and drop all multicast at wlan0 and wlan1), at the
expense of a small amount of flexibility - you cannot consider legacy
and MLD clients to be in different networks.

However, given the complexities around multicast, you probably cannot
consider them to be in different networks _anyway_ because then you'd
have to _not_ drop all the multicast on wlan0/wlan1, and then you send
multicast twice to the MLD clients, which would be wrong too...

So the more reasonable thing to do is to treat this the same way as non-
AP MLD with only a single netdev, and effectively behave as if there was
an internal kind of bridge inside the AP MLD for the legacy clients.

As a consequence, of course this patch will change too.

johannes
