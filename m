Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F846DD447
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 09:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDKHcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDKHce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 03:32:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E9213D
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=A26bYEqubFAWpH0mnm5E/iESlPBoaj8MhF1NDhDI674=;
        t=1681198350; x=1682407950; b=nUEBB07bekhzGz2bU85tFaf5ZxHhmzFrkZwjqQs+UiAsVqs
        sV3A7mQikio0kQkFoGDVazkjhRwqEorfPFLwYgJ3Dtc+uv7+PGeC4w2jL1401Ar+GGGu9q8kP7Qqp
        jR2c6iMxpuz8/Ua/w2y62bxaqSN2WTvA0tgOxuPfLuXfmUg5kXHlkEi3rBLJ9mRBfKcmlFP+0Wewq
        l+vANj+4hRN4PYj/4W/l5YVtP2qo2sr0hJ/ORvW433SqoFxhtpyQvKGiiQ/lpJmZv677r3rpjWS7s
        M+7BEftVoLuVCMp00jlumXCBTJ9C4V6BiG+cc5XrepXgXVJdVGuvKvJsw6dDR31g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pm8UL-00CdHm-2y;
        Tue, 11 Apr 2023 09:32:26 +0200
Message-ID: <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 11 Apr 2023 09:32:25 +0200
In-Reply-To: <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
         <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
         <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
         <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
         <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
         <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
         <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
         <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
         <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
         <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-04-04 at 10:54 +0800, Wen Gong wrote:
> On 10/11/2022 3:26 PM, Johannes Berg wrote:
> > On Tue, 2022-10-11 at 12:07 +0800, Wen Gong wrote:
> > > On 9/28/2022 11:28 PM, Johannes Berg wrote:
> > > ...
> > > > > May I know some more info/status about the "incoming=C2=A0 new me=
thod to let
> > > > > drivers set the link address"?
> > > > >=20
> > > > I wasn't actually planning to work on that myself, FWIW.
> > > >=20
> > > > johannes
> > > OK. So has some body will work for that now?=F0=9F=98=81
> > >=20
> > Yes, I don't personally have a need for anything other than what we hav=
e
> > right now.
>=20
> May I add method to let low-drivers set the primay link address like belo=
w?

> I add a field in struct wiphy_iftype_ext_capab, if it is valid, then it=
=20
> will be used as
>=20
> local primary/assoc link addr in function ieee80211_mgd_setup_link() for=
=20
> station.
>=20

I don't really think that it makes sense to push this to cfg80211 when
we only need it in mac80211?

johannes
