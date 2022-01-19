Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C13493B82
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350144AbiASN5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 08:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiASN5A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 08:57:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FACC061574;
        Wed, 19 Jan 2022 05:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mRjTHJ5rF8IUJzsB/yHeS+lbAHxC/yFDhwE6s8qRjeU=;
        t=1642600620; x=1643810220; b=chSeEJmKPYXMGMLE76UlAtTUUzdktGTy9huKJOpNrQHNrz4
        /+qeW8Tmt1G50jItYuoLbredU4+pvJDwyZ1XP7dU7+eYsq10z8kJZimcmFq7H7OG5gx1Ty/jqw/2Y
        J3OXJiAkx4Uuyu5oilcc2/znKvXQ19p4QJB31p1uoK4h8nnwHmYYI9Fq3hhd0vGCdo5RVHCxxFahV
        2v5xfGats3uJsc2uGYjWpM2gYw13AjNz2Wlk4stwXCfLiJIZfOGCcAWBIfItLQzTcO5lnWR6AduUH
        4wQp12qRkPwWgTAeRtY4ZnPjb8Uft4qWsvKd5be4oUGSoUl8RqcaqnaxDjCINUUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nABSH-007aoP-Lg;
        Wed, 19 Jan 2022 14:56:53 +0100
Message-ID: <ea8638fcd820e5b777bc6d5befc5eab9369edbbf.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: prevent out of bounds access in
 ieee80211_rx_h_action()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Wed, 19 Jan 2022 14:56:52 +0100
In-Reply-To: <20220119125923.GB9509@kili>
References: <20220119125923.GB9509@kili>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-01-19 at 15:59 +0300, Dan Carpenter wrote:
> Smatch complains that status->band comes from the skb->data
> 

Hmm. How does it come to that conclusion? It's not really true? It comes
from skb->cb, and the driver should fill it. Also, we have:

void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
                       struct sk_buff *skb, struct list_head *list)
{
...
        if (WARN_ON(status->band >= NUM_NL80211_BANDS))
                goto drop;


so I really don't think this patch is needed?

johannes
