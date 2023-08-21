Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D913D782802
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 13:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjHULep (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjHULep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 07:34:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C24DC
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=10j7nSi0oES0gzYMMnw/ATUF+5EK7anVMHuFrw42oUc=;
        t=1692617683; x=1693827283; b=F+YiRAET+DZtoIKgcp9j4hohVVrAWG7fFEEksXgj1R6LkHF
        m/fZSCzkfsg+V/+UyTph8DvZXJSwvzfx8rI1c1YI/tGDmLmJoDob9Vav7bDN0qizXX1AiUlIEXdCV
        qQWYzlt+7Xzgcot7c8SyYfWiAqfVCNXE6J+NYf0fNVKf/JwetD43E9oOxX6m9RQySxaDG6OmHQJm4
        yR6k1PBuvOuT7dEbMihy5hXCOVvbi0AoQAVx7j1VMPh6bt2i1ommzB+5wPA9XaPvN6ukfjKY0RATM
        puc/IyDdKvSIwwlYm7Crn6xD0DkA9ReMubivEVDZV9914ZibBnhlVe5UZDkYOOag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qY3BA-0034V5-2g;
        Mon, 21 Aug 2023 13:34:41 +0200
Message-ID: <0f34540e71e7ba63a3d38e85aefec74350384a33.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz
 operation information"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Date:   Mon, 21 Aug 2023 13:34:39 +0200
In-Reply-To: <6adeb7be-9c7a-c122-71be-cc0143115fe6@quicinc.com>
References: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
         <f28ee65621bd52ad59cae891e81431ef83eeaf2e.camel@sipsolutions.net>
         <9ce54e8e-556b-976c-06d9-145b747705db@quicinc.com>
         <714fd7374225db9e8d8225197931c5183f12e534.camel@sipsolutions.net>
         <6adeb7be-9c7a-c122-71be-cc0143115fe6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-08-21 at 19:11 +0800, Wen Gong wrote:
> On 8/21/2023 6:57 PM, Johannes Berg wrote:
> > On Mon, 2023-08-21 at 18:36 +0800, Wen Gong wrote:
> > > On 8/21/2023 5:06 PM, Johannes Berg wrote:
> > > > On Mon, 2023-08-21 at 10:59 +0200, Johannes Berg wrote:
> > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > >=20
> > > > > This reverts commit cb751b7a57e5 ("mac80211: add parse regulatory=
 info
> > > > > in 6 GHz operation information") which added a station type bss_c=
onf
> > > > > assignment in a parsing helper function, which will corrupt mesh =
data.
> > > > >=20
> > > > Ah crap this won't work, rtw89 already uses this.
> > > >=20
> > > > Wen please send a fix for this ASAP.
> > > >=20
> > > > johannes
> > > Hi Johannes,
> > >=20
> > > I looked the patch some times, but I do not know how it corrupt mesh =
data,
> > >=20
> > > Is there any clue for me?
> > Hah, no, I'm wrong ... I looked at it and for some reason thought of
> > u.mgd instead of vif.bss_conf. Sorry!
> >=20
> > Still it's not correct though to write to vif.bss_conf in this function
> > because it's called from mesh_matches_local() to see if it's even
> > compatible, for example, so the mere calling a "give me the 6 GHz
> > chandef" function doesn't indicate we actually are going to use it now.
>=20
> Do you mean mesh_matches_local() is only a try to call=20
> ieee80211_chandef_he_6ghz_oper(),
>=20
> NOT real use the 6 GHz chandef?

Yes, I believe so.

Anyway it would seem better for a utility function to have clearer
defined output, I think?

johannes
