Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7B6B985E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 15:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCNO5O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCNO5M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 10:57:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F39A592A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 07:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5/3OEh9aHIKt8k5ibOIooZOcdX0BwsqGuHtV7Ga3OBA=;
        t=1678805831; x=1680015431; b=beQyiCh+4Cw9XPAli+Unq4i3GiJjvqiKwfHNX7tQHnIe6OT
        dTV8350/h9SzBHPe0lgVeLrq8c7mxceYcIGnQ4tLZb8VWFtnAjCqXAKw2ASItefxJC6euGLQP2Y/X
        04nkJYM9Z7Lw2nzyj1KZ0hpmatYUW8W4vaE+p2PJ4+WeLlOrXZeFTdbGxTlcF3FYPxyTzyPIYymPh
        5IVxRzQ3imkI5bC8+dagq2NzToOXJ6nlSoJkBZ2lh69rkQudAuiwLtqKM4PDm7uaexLPJuRP4CMh2
        Wt1lWI6u8YzEGXv5BOsfSsods2sIwsc/Bawltt7oYpihojxw3xBKHiZFuCtintVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pc65D-003DUC-2u;
        Tue, 14 Mar 2023 15:57:00 +0100
Message-ID: <18728c67cffad35f827d9a32af34044592254093.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: mvm: fix double list_add at
 iwl_mvm_mac_wake_tx_queue (roaming)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc:     gregory.greenman@intel.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pstourac@redhat.com
Date:   Tue, 14 Mar 2023 15:56:59 +0100
In-Reply-To: <20230314145209.401875-1-jtornosm@redhat.com>
References: <20230314103840.30771-1-jtornosm@redhat.com>
         <20230314145209.401875-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-03-14 at 15:52 +0100, Jose Ignacio Tornos Martinez wrote:
>=20
> We have some Bugzilla (i.e.=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2152168).
> You only have to create a user for this tool.

Looks like it's not public, and anyway I was mostly asking for a commit
log record, so that's not useful even if I could get access:

"You are not authorized to access bug #2152168."

> > > This can be reproduced with a single script from the station:
> > >     while true; do
> > >         wpa_cli -i wlp3s0 roam 34:13:E8:B1:DB:9A
> > >         sleep 2
> > >         wpa_cli -i wlp3s0 roam 34:13:E8:3C:FB:DB
> > >         sleep 2
> > >     done
> > > And flooding with tx traffic.
> > Oh, nice to have a reproducer.
> It is not immediate but I can reproduce here like this.

Right.

> > Funny thing is, I was _just_ looking at this exact bug, because we were
> > discussing all this concurrency over in
> So more people is struggling this this, good to get the best solution.

Well that was a different issue in different drivers, but then we looked
at it ...

> > While this might fix the issue as far as you could observe, that is
> > clearly not sufficient, since you don't protect the list on the other
> > side, where the items are removed from it again.

> Ok, I thought about that as well but I was not able to find any problem w=
ith
> the other side. Anyway, the better the solution is made the better.

Well it doesn't _look_ like it accesses the list, but the
list_del_init(&mvmtxq->list) on the other side will access the list too.

> > Below are the two patches that I've come up with so far, if anyone want=
s
> > to try them. Please ignore all the extra metadata, I exported this
> > directly from our internal code base.
> Of course, I can test the soutions here in order to be sure.
> Do you prefer I reply with the result here or in the other thread that yo=
u have
> commented me before?

Here is fine, thanks!

johannes
