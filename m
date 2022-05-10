Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DF52248A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiEJTOX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 15:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349110AbiEJTOF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 15:14:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793121606B
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yagBwk9pW1NwSKdbl9fGHZ2nsd9rjaRs0Bi76+zwz6c=;
        t=1652210044; x=1653419644; b=ZUiA/0sTPeDY2RFP9KqNTzSPsOdq9xyXIo+6uNefTBJn7pq
        uLpVxWlVNxMaIU5h1BjE0Bo8ZciT/JcVrgf3IcetzFuv+gx0qHxQabufIxd6NjUQEvl8EuhGVeJ65
        aW7sGdvn/5nqPBIZparUoA5xoRZi1MUl/EUglbJ9dvdabQXYouwUqxP0MmOEDIUMIBS482sHnUftn
        3GJlGjtPQyh+cLXpk4DmIjhjorC+4ls9iE3olcIn8R9THdokMgmKKFvXPGgBVa1sknuDbBvXvVwr4
        xXcrAun5BNg/wi24viEOdrNGQYqIfyIqca3Xhjvls7sGejXmExTj9psienvxzVKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noVJ3-007vUJ-Ov;
        Tue, 10 May 2022 21:14:01 +0200
Message-ID: <292d11498e4b7c94aa716280361e56b065a2fd49.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: Add support for sending more than two AKMs
 in crypto settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 10 May 2022 21:14:01 +0200
In-Reply-To: <20220505181917.GA25102@w1.fi>
References: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
         <cb419675d2ae276d9b4eac8ab5deafe62167051f.camel@sipsolutions.net>
         <22bf2f78-587d-429b-867f-f73e542018d2@quicinc.com>
         <53062c8fbe3eaaa281f24c4808a15804938c83ef.camel@sipsolutions.net>
         <20220505181917.GA25102@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-05-05 at 21:19 +0300, Jouni Malinen wrote:
> On Thu, May 05, 2022 at 09:18:40AM +0200, Johannes Berg wrote:
> > I also came to think - where's the upstream driver using this?
> 
> This capability is needed to implement WPA3-Personal transition mode
> correctly with any driver that handles roaming internally, i.e., that
> advertises NL80211_ATTR_ROAM_SUPPORT (WIPHY_FLAG_SUPPORTS_FW_ROAM). It
> looks like there are two such drivers in the upstream tree today: ath6kl
> and brcmfmac. Since WPA3 requires PMF, ath6kl is not really a candidate
> for the main use for this (having to indicate PSK, PSK-SHA-256, and SAE
> AKMs as allowed), but brcmfmac looks like an example that would need
> this to allow the local network profile parameters to be set
> appropriately to the driver to allow all the desired roaming cases
> between BSSs using different AKM suite selectors to be performed.


Makes sense.

> That said, I do not know whether someone would be planning on using this
> additional capability to extend brcmfmac to take benefit of the proposed
> extension. I would support this capability in wpa_supplicant, though, so
> the information would be available for that purpose.

:)

Honestly for this patch, I'd drop the dynamic allocation parts that are
problematic - assuming we can limit to something else that's sensible
like 4 or 5 entries?

> Do you have any preference on how to address out-of-the-tree driver
> needs for this type of functionality? 
> 

I don't - I'm just noting we keep having this discussion. And I'm just
grumpy because all my tests failed on this, probably with a kfree() of a
stray pointer or so :)

Upstream the driver? ;-)

johannes
