Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77069B2A9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBQSyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 13:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBQSyB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 13:54:01 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE8627F7
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=K4ak8ahu8k35l7y0Hx6rHha0rKjcyTHYW7o0rzdmLJc=;
        t=1676660012; x=1677869612; b=xIkK3H1bC9qjR6o5BZa9Ie3tXKmT6oodOoKHKGXD/se1fdL
        o4J2E7AuEQ4jS7wpJ17oQR5FOn6iPf4aMYWZXM/kDkVMvZIBSLKn8Kp2VFAiQFtnemOoDZueMisLG
        mxPfdggvaAom1FBgJQeDpIiGBBv33o141J3XhJ1xkis9g7ONMPp7sLjpGuSBUv/b6CseFFYso0Tit
        1+q6C0ypQYg5kWMYJqRb/l/QnVvhHfF55SuyAGNvJblfU8Vp0AkuO77tN3fYGAnuXD/Qxabw8DIOm
        DIceyEWMS5C1zI4Iy4zFRbhS68e/Oy1e2xaTZsmg/PC9olOybw2w03Zai3fUQTpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pT5rM-00FA7E-0A;
        Fri, 17 Feb 2023 19:53:28 +0100
Message-ID: <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <Ryder.Lee@mediatek.com>
Cc:     Shayne Chen =?UTF-8?Q?=28=E9=99=B3=E8=BB=92=E4=B8=9E=29?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?= 
        <Evelyn.Tsai@mediatek.com>
Date:   Fri, 17 Feb 2023 19:53:27 +0100
In-Reply-To: <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
         <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Fri, 2023-02-17 at 18:43 +0000, Ryder Lee wrote:
> On Fri, 2023-02-17 at 19:01 +0100, Johannes Berg wrote:
> > On Sat, 2023-02-18 at 01:50 +0800, Ryder Lee wrote:
> > > This allows low level drivers to refresh the tx agg session timer,
> > > based on
> > > querying stats from the firmware usually. Especially for some mt76
> > > devices
> > > support .net_fill_forward_path would bypass mac80211, which leads
> > > to tx BA
> > > session timeout for certain clients.
> > >=20
> >=20
> > Does it even matter? We could just request sessions without a timeout
> > in
> > the first place.
> >=20
>=20
> I think we're already. Our main issue is performance periodically drops
> every few seconds when .net_fill_forward_path is enabled. Wireless
> client have normal 500+ Mb/s iperf3 download speed for several seconds.
> Then it drops less than 100 Mb/s for several seconds. Then everything
> repeats. Issue occurs only on certain clients. (i.e. Intel cards AX200,
> AX1675, Advanced-N 6235 in Win11)
>=20

Strange. But how does this patch do anything about it, that should be
completely client agnostic?

johannes
