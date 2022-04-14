Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5690B5019B3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbiDNRNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 13:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245085AbiDNRMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 13:12:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5DD793F
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jPkFnEW/AegCSyFsKArFjkdCtfobWlGQbWTatvC8UQI=;
        t=1649955787; x=1651165387; b=tVfnccZyPVNbVH1Fc+DZt8BaCjD4itxDxqFFXFklaXjc2gk
        JaWOBQsZtzZSiAp9t+ugUKqg2pREcMXiT9e7LU9+wxOoYBpisj8llai3HFshj2dd8xcaKA5N5HCVs
        4XRPKSrpsQVfbgSzNl7dvT/ivK2/g0tlQNMZn62RkJk9+WHd3Z7Jq+XB9Yke3JD5F6VOHR2k06viV
        nBbINE9UNI5mc2EuKkBW4rMBNcDZzy59r2by/dnJwNAZmKCStm5SR1hwMRESLMdGXFKAS8Q2GmihQ
        u7ZkyoLEsX5pHsrCS8lf19mBctzzGXcb/4xWgEmpe75J9mrx4+kJNOwYahR7vD0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nf2s5-009xf8-8g
        for linux-wireless@vger.kernel.org;
        Thu, 14 Apr 2022 19:03:05 +0200
Message-ID: <f62861eb093a98a4acbfc2046cc4a4a47f1a825d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] cfg80211: do some rework towards MLO link APIs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Date:   Thu, 14 Apr 2022 19:03:04 +0200
In-Reply-To: <20220414145522.116716-1-johannes@sipsolutions.net>
References: <20220414145522.116716-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
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

On Thu, 2022-04-14 at 16:55 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In order to support multi-link operation with multiple links,
> start adding some APIs. The notable addition here is to have
> the link ID in a new nl80211 attribute, that will be used to
> differentiate the links in many nl80211 operations. The one I
> mostly looked at so far was start_ap and friends, but that is
> also still incomplete.
> 
> Mostly the idea of this is to give everyone an idea of what
> such an API might look like and what it might result in at
> the nl80211 level.
> 
> Note that this depends on the two patches here:
> https://lore.kernel.org/linux-wireless/20220414140402.70ddf8af3eb0.I2cc38cb6a10bb4c3863ec9ee97edbcc70a07aa4b@changeid/T/#u
> 

Oh, also on this:

https://lore.kernel.org/linux-wireless/20220412220958.1a191dca19d7.Ide4448f02d0e2f1ca2992971421ffc1933a5370a@changeid/

since I didn't bother updating that code, it was dead anyway.

johannes
