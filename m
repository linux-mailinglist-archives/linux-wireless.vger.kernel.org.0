Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1B5F54AC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJEMkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJEMkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 08:40:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB3517A89
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PQjzUBP8kM997Xe6KE3m2VcZfm7s/1qmyU9fX1px1k0=;
        t=1664973607; x=1666183207; b=HinmYluYGeY9uDpKvnczRMJ6BBCM0RAyXRHiu6P4knHXJeP
        gMEd9YWJbh+T4Cnm7FjEJnfx7V+TVHZDQF+nHigMff977tpDVzVVt9FexD1l9BzWqOch20FLEoiEp
        Mbc5zvMX6NUPReVCAZispjU7OqNsJmlTLiAQKY4oao0hCOPw97N6z3uNyGB41V9isBljVDQAxb/T4
        qLYF5Vsn76mVR2XlFE1mpUmpqcRiaCxLUDsR96WWjKwjcp39PU9MuPlij9ak9g6XdADTzSrrSQZgx
        bROJz4wcRhmyBJSZ+34WL4KRyZouRDggD4+j+s472k3+3d4r8tQy2n/xEzive08w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og3gw-00G23p-2O;
        Wed, 05 Oct 2022 14:40:02 +0200
Message-ID: <bf6f9d8707021dc6017c7cb17805d63edea63333.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>,
        Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Wed, 05 Oct 2022 14:40:01 +0200
In-Reply-To: <875ygyihhm.fsf@toke.dk>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
         <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
         <875ygyihhm.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-10-05 at 14:26 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> > void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
> > 				    struct ieee80211_txq *txq)
> > {
> > 	... *local =3D from_hw(hw);
> > 	... *sdata =3D from_vif(txq->vif);
> >=20
> > 	wake_tx_push_queue(local, sdata, txq);
> > }
> >=20
> > Actually ... I wonder why you'd here - in waking a single TXQ - use
> > ieee80211_next_txq() at all, Toke, what do you think?
>=20
> Well, this patch does almost exactly the same as the ath9k driver does,
> for instance. Really, the wake_tx_queue() is a signal to the driver to
> start transmitting on the *hardware* queue that the txq points to. For
> some drivers (like Intel, right?) that's a 1-to-1 mapping, for others
> there are multiple TXQs being scheduled on the same HW-TXQ. So I think
> it's probably the right thing to do to just call next_txq(); if there's
> only a single TXQ scheduled it should be pretty cheap to do so.

Oh OK. So then the logic Alexander had makes sense.

>=20
> This logic has implications for putting "urgent" frames (like PS(?)) on
> TXQs as well, of course, but that needs to be handled somehow anyway...

But that probably then anyway needs to be handled in next_txq()?

johannes
