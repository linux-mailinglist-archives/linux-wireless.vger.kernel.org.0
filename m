Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202C6E5D82
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjDRJei (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjDRJed (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:34:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9DBE7F
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RzCgGYfROrvIQhr2HcmBHV9WvQ0SlwHJfX0zaCj22AQ=;
        t=1681810472; x=1683020072; b=Z7+5dOu+roKDXCMm97s0M3m/2FjmKzOOtQFdDCZVz2Oq31w
        xh+o5HTqm+7Yv+BxIj7spr14900D0riDSbDuFHXaBGqRmIdLddJv9fW+rrwaFzEn1aUG2k9NGOJQE
        yzwD9hK1BGipAHLFYp2dzuxv/cPWNWCSDmEtRb6Y5liQKVJDpEPHMetDG59EB1dhargC32sJ+YP3E
        VnRsRPtfNzbst56P02LZ16oKpeCQ5fmt3I5WGjfAvdEbizXxiLh8mNtBYQwG0eLpo97JcnmSfr7zf
        vYORgTbzLeRhOksMI6Hlp6E0jbHKzAXTrmvFaKfBgARRo7gBE+Xdy0bfd9P5MPCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pohjJ-001Z9e-2d;
        Tue, 18 Apr 2023 11:34:29 +0200
Message-ID: <2cc79101249548f2a92c14af6aff6121143907d6.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 18 Apr 2023 11:34:28 +0200
In-Reply-To: <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
         <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
         <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
         <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
         <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
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

On Tue, 2023-04-18 at 17:27 +0800, Wen Gong wrote:
>=20
> Now lower driver I used do not store the key=C2=A0
>=20

Sure, that's fine.

> and do not trigger
> BSS_CHANGED_ASSOC for new links after assoc.

I think you need to think hard about this ... whatever BSS_CHANGED_ASSOC
causes is likely no longer correct in MLO. Again, the assoc state
*itself* is only changed once, when the whole MLD associated.

> So my suggestion is a way to active all links while assoc, this way is=
=20
> simple for lower driver I used.

Sure, and we do that.

But that's not what you're asking - you're asking to re-do some *MLD*
state when a new link is added, and I'm saying that it doesn't make
sense to "add" (again) a key to the MLD that was already added, nor
calling a vif (MLD!) level method saying the MLD changed state to
associated (again).

I really think you should solve this in the driver, that doesn't mean
you have to _store_ he key, you can use one of the iteration functions
as well.

> Also ieee80211_set_active_links() is another way to active all links=20
> after assoc.
>=20

Sure.

johannes
