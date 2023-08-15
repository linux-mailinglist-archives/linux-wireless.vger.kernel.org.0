Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F577D360
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbjHOT0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239871AbjHOT0F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 15:26:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB22132
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=EMT+7of2Cg19pT8Ih/2kBAX5Btr6IHTfd6+SWvnf85U=;
        t=1692127526; x=1693337126; b=OEqave6zxoAvdyFtydPpYI8QTS/VTLFcn5mM0WBU4AHayY/
        vhCnKHbuGI+rKVV/iCJecpayeYT7N4RRLJkPufZRrLkxwAs/xVc5Fdcbi6uNWoT5zoI0NaBNDVvZ3
        VfMc98vu761vA0Oskei84EwmfcrStUR2KBl5uO6wYoyaA3bu0hkvVCrZk080+JYNph/fx9BxLq+Es
        c0Rp04gnUDeeN6ce1hH64aJBYv9wY2fLc6DRMkiL+xXERHXln7mKAdyjiWGvUoD57IpBi2weSojwq
        6bzkhN7Y6NmLNucl6s7c95GD+rJMCOb2Aq56hlHJiksfUjYQrWeHEQNfsTRj3eZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVzfL-009DmT-1J;
        Tue, 15 Aug 2023 21:25:19 +0200
Message-ID: <56f4cee915bd816c61f9fbef10f1a2c10768dbdd.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: drop short frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com
Date:   Tue, 15 Aug 2023 21:25:18 +0200
In-Reply-To: <07997950-0f1b-cc05-6ba4-1378dc35eec8@quicinc.com>
References: <20230815181603.f576bd983875.I1efbeef082c3f7094037882f213202d760848eb7@changeid>
         <07997950-0f1b-cc05-6ba4-1378dc35eec8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Tue, 2023-08-15 at 11:20 -0700, Jeff Johnson wrote:
> On 8/15/2023 9:16 AM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Frames that don't even have addr1 are clearly not valid,
> > drop those early in the netlink/wmediumd path here.
> >=20
> > Reported-by: syzbot+b2645b5bf1512b81fa22@syzkaller.appspotmail.com
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> >   drivers/net/wireless/virtual/mac80211_hwsim.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/ne=
t/wireless/virtual/mac80211_hwsim.c
> > index f446fd0e8cd0..8f1e4420ed1e 100644
> > --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> > +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> > @@ -5626,14 +5626,15 @@ static int hwsim_cloned_frame_received_nl(struc=
t sk_buff *skb_2,
> >   	frame_data_len =3D nla_len(info->attrs[HWSIM_ATTR_FRAME]);
> >   	frame_data =3D (void *)nla_data(info->attrs[HWSIM_ATTR_FRAME]);
> >  =20
> > +	if (frame_data_len < offsetofend(typeof(*hdr), addr1) ||
>=20
> curious why addr1.
>=20

I figured that was the shortest legal 802.11 frame, e.g. an ACK frame.

> if the frame ends after addr1 then don't you have a=20
> problem in mac80211_hwsim_rx() when it passes hdr->addr2 to=20
> ieee80211_find_sta_by_link_addrs()?

But of course you're right about that, so we should just make sure we
have at least the full struct ieee80211_hdr_3addr here, I guess.

johannes
