Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FC7D4A0A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjJXI3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjJXI27 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 04:28:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C04109
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PhADDkUghEUk/hgdZXZ5btSk8LqI7w2I+J1lM9ypi+8=;
        t=1698136135; x=1699345735; b=BxaD9stxhW5zwapdgeQzGO/Y5SEfJ7Q2wDga8tAt7WnZ0/w
        yBdEt9inrd5ybfKpFiTmKVxAccK3FMwTDPzFGhxWlXziSTIujPYAYrc+a9YhJ5Wz3VJTDtBlko8+Q
        0xX5joJBCFHX6BaewQVmxgzg76pwqCaLRvQTF1GypZrYWmiIrSf8AfeY3mqLQYOB8+ONyLeokJNgj
        sZr/P+c6Up75c6WA1ijl5pafUjxE+emCcKwOkASUZ/AD+zpcVU9nOS7YN2kIiqR4sV7sqr8rfNQ5k
        tLJgSNP5hADpQ1ZORhhiOTNM1yOfe860o3M6ciKH489YOVfKm7SIRCyGk8D+p/rQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvCmT-00000001JEX-1u7M;
        Tue, 24 Oct 2023 10:28:53 +0200
Message-ID: <f260261edd307a8befe3561185acc5b24c0d3ff8.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: work around crash in mlme.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 24 Oct 2023 10:28:52 +0200
In-Reply-To: <c6a2047e-0b01-bdd7-9920-5a1c81aa96b3@candelatech.com>
References: <20231023175738.1686631-1-greearb@candelatech.com>
         <08a47f34f85bb64be720e473d5a43193412185a1.camel@sipsolutions.net>
         <c6a2047e-0b01-bdd7-9920-5a1c81aa96b3@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-10-23 at 13:05 -0700, Ben Greear wrote:
> On 10/23/23 11:17, Johannes Berg wrote:
> > On Mon, 2023-10-23 at 10:57 -0700, greearb@candelatech.com wrote:
> > > From: Ben Greear <greearb@candelatech.com>
> > >=20
> > > Protect from NULL ifmgd->assoc_data in ieee80211_mgd_deauth, crash
> > > was seen here fairly often in a 32-station test case utilizing
> > > mtk7922 and be200 radios.  I'm not sure if radio types matters
> > > though.
> > >=20
> > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > ---
> > >=20
> > > Patch is for wireless-next tree, bug was likely introduced in
> > > this release since this crash was not seen in earlier 6.6-rc testing
> > > nor in 6.5 or earlier.
> > >=20
> > > There may be a better way to fix this...
> >=20
> > I mean, you're not *actually* suggesting we merge this patch, right?
> > Right?!
>=20
> No, but it is easier to explain backtraces when you can see the code that
> generated it.

Sure, but why actually post it as a [PATCH] then rather than just part
of the bug report or something? :)

Anyway ...

> The bug appears to have come in with this patch that I grabbed from linux=
-wireless
> mailing list:
>=20
> [greearb@ben-dt5 linux-6.6-wn.dev.y]$ git show 4600547c01ef7
> commit 4600547c01ef728113253c6df9367eb4ed75193c
> Author: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Date:   Thu Sep 28 17:35:34 2023 +0300
>=20
>      wifi: mac80211: add link id to mgd_prepare_tx()
>=20
>      As we are moving to MLO and links terms, also the airtime protection
>      will be done for a link rather than for a vif. Thus, some
>      drivers will need to know for which link to protect airtime.
>      Add link id as a parameter to the mgd_prepare_tx() callback.
>=20
>      Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>      Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>=20
>=20
> I see no response to it on linux-wireless mailing list.  I applied the
> series locally since it preceded other iwlwifi related patches that
> I wanted to test.

I applied the same patch as commit
e76f3b4a73ea60ef098c5762b2aef4d11e094a04
Author: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Date:   Thu Sep 28 17:35:34 2023 +0300

    wifi: mac80211: add link id to mgd_prepare_tx()

from

https://lore.kernel.org/r/20230928172905.c7fc59a6780b.Ic88a5037d31e184a2dce=
0b031ece1a0a93a3a9da@changeid


It doesn't contain that bug, neither in my version nor in the list
version.

Maybe you had some conflicts due to other changes and resolved them
incorrectly by accident?

> So proper fix (assuming Miri's patch is applied at all) is to just not
> assign link-id in this specific case?

No, it should assign the link ID from the correct place, as Miri's patch
does :)

> Also, there was a WARN_ON from net/wireless/mlme.c that was triggered jus=
t
> after my splat, from the method below.
>=20
> eca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  128) s=
tatic void cfg80211_process_disassoc(struct wireless_dev *wdev,
> 3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  129) =
                                     const u8 *buf, size_t len,
> 3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  130) =
                                     bool reconnect)
> 6039f6d23fe79 (Jouni Malinen             2009-03-19 13:39:21 +0200  131) =
{
> f26cbf401be93 (Zhao, Gang                2014-04-21 12:53:03 +0800  132) =
       struct cfg80211_registered_device *rdev =3D wiphy_to_rdev(wdev->wiph=
y);
> 6829c878ecd24 (Johannes Berg             2009-07-02 09:13:27 +0200  133) =
       struct ieee80211_mgmt *mgmt =3D (struct ieee80211_mgmt *)buf;
> 19957bb399e27 (Johannes Berg             2009-07-02 17:20:43 +0200  134) =
       const u8 *bssid =3D mgmt->bssid;
> ceca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  135) =
       u16 reason_code =3D le16_to_cpu(mgmt->u.disassoc.reason_code);
> ceca7b7121795 (Johannes Berg             2013-05-16 00:55:45 +0200  136) =
       bool from_ap =3D !ether_addr_equal(mgmt->sa, wdev->netdev->dev_addr)=
;
> 6829c878ecd24 (Johannes Berg             2009-07-02 09:13:27 +0200  137)
> 3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  138) =
       nl80211_send_disassoc(rdev, wdev->netdev, buf, len, reconnect,
> 3bb02143ff55f (Johannes Berg             2020-12-06 14:54:42 +0200  139) =
                             GFP_KERNEL);
>=20

> And of course it is always possible some other patch I've applied or crea=
ted is actually
> triggering this problem.


I think there's a good chance that's just a consequence of this
particular workaround, but I'm not really sure. If you can see this with
a less patched kernel I can take a look, but as is I don't even know
what you're running.


> Of course I don't expect every patch to go upstream effortlessly.

:)

> But there is also the case where a patch may be technically OK, and usefu=
l
> to me, but it is not an API or feature that the driver/stack maintainer
> cares about, so it is ignored.

Well, it does raise the question of whether we (or often really just
me?) should maintain something in upstream that's not generally useful,
or already solved in another way (like ethtool stuff).

Yes, I tend to not want to commit to saying no and let stuff linger, and
that's really a bad pattern that I have.

> Regarding my previous patch to fix a
> crash,
>=20

If you mean this:

https://patchwork.kernel.org/project/linux-wireless/patch/20231021154827.11=
42734-1-greearb@candelatech.com/

>  I'm not going to spend my time renaming
> variables on the off chance that you'd like the patch vs just fixing the
> specific broken code and moving on to other tasks.

I actually applied it. Someone else was replying there :)

> Since you known your
> own mind, you could rename variables in 2 minutes, post the patch, and
> you'd be done.

Agree. I think I do that, but maybe not often enough.

johannes
