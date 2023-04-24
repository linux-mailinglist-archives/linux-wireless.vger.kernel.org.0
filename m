Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450806ED34D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjDXRPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXRPI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 13:15:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3EE6187
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gmZbqoVRC2YNoI0nxu/hwBDBylMLGu9SiPIUqJ1ahlY=;
        t=1682356507; x=1683566107; b=wmn3accGj/bP3FVg9BMJntNRFO1eOPUio5XAGg0zyQPFjdR
        BzbiczxGHknn+F0SE/cTGyc67gm/QCDcPusyBlbeLuhWc9hBtQlkEuDaAVknxvGB00fmY85iVdz9T
        S/61s3yig1lMwxdDeMaXab4uFDlHENE+AOcq9gPtP+vADICygRl5r1Uwp5+x4PIci7966rPquHJBd
        xClH1WxGGIwm+3RmFIoQxcl17XD2PGE9Ix7dRzUstbCC4TseWrWzCxMMWR0Hub0cw+zSiyFEH/owd
        3wZ4FZ/ItIL5dOHA5OtsQKcFEJ/JSACJ1J5Ib+mhMQ65nmRBDuwjzt+8oNincsFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pqzmI-007K8X-34;
        Mon, 24 Apr 2023 19:15:03 +0200
Message-ID: <38649e92c619dc2f1482aba08c977d1611064e05.camel@sipsolutions.net>
Subject: Re: Automatically adding OCI in mac80211
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     ilan.peer@intel.com
Date:   Mon, 24 Apr 2023 19:15:02 +0200
In-Reply-To: <33e23355cd8cfcf2296bba1272df814af32b003f.camel@gmail.com>
References: <432703ce83ac979ba06e2b85d6dc500f246c6a76.camel@gmail.com>
         <199f2ac280a1e1a195add45290411a9c1dc519fc.camel@sipsolutions.net>
         <cba322cbf992067e843114ab53da610978768d64.camel@gmail.com>
         <33e23355cd8cfcf2296bba1272df814af32b003f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

Sorry - going through old email that might still need attention, clearly
dropped the ball on this ...

On the other hand, now we have all the MLO code in the tree :)

> So thinking about it more I think we have two options:
>=20
> 1. Improve CMD_ASSOCIATE to be non-destructive on failure and allow the
> API to accept a channel definition directly i.e. enough info for
> nl80211_parse_chandef() to work. Then use this chandef rather than
> derive its own. If this fails (e.g. due to a downgrade) return an error
> and userspace could downgrade the width itself and try again. What I'm
> thinking here is not modifying any values in sdata, link, ifmgd etc.
> until the channel switch returns successfully.

That seems rather complex too, to be honest.

> 2. Build the OCI element all in the kernel. As far as figuring out the
> operating class I'm happy to contribute that (IWD already does this).

That might be easier, though I guess it needs to have an opt-in from
userspace to solve this issue.

> And I'm not sure what you mean about it not working with MLO, I don't
> know much about it.

I don't know how OCV works with MLO in the first place, but I guess it'd
have to be per link?

So I guess it would work, just have to be done for each link.

> Also I do think there would be some value doing (1) in general as far
> as it being non-destructive. ieee80211_mgd_assoc() starts modifying
> state almost immediately making any failure (even -EBUSY) result in a
> disconnect AFAICT. This seems kinda bad...

Well, there could be some plausible reordering here, but a lot of hw/fw
fundamentally cannot try to make a new connection while maintaining an
old one, so in general you can't really fix that completely.

johannes
