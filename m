Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE06E5D10
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjDRJLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDRJLl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:11:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6961A7
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7ILc4+BfvwuBllNWVNLEj4EEAqqiOcTH9Dm5qpsUoH8=;
        t=1681809100; x=1683018700; b=Xpgo10RPEbRAAXAYNKgrXWyZcK4Ej3JpSJtBe6VLk6n8Vjp
        ceBnWfTYTV86q4emjEjZLSCDx+9jfqcWt/BHgEP88Zh+gEl+HS4Fy688rFNcg3AhCcvpjeGzpq0MK
        vZN1EMEPFvXKW9LIawawR/Z2kS3N5A1N+QEa0ibeIz3Pl9dyumQcyuOtG5u8G4S3E6AfRLnruqLHm
        JtfrWhKIhXMWnWf2245h1dystsJjehrca7ZyJatv3WzJiLo5fY4PA5NtFLzvrcexa1KH8yDi4w1hk
        4KoccRLHnRJf8eriJD5cLGrSOhoEUTwCzrGGokwP9IQgoYvBV/M8dGhKmwqHQSJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pohNB-001YTt-2f;
        Tue, 18 Apr 2023 11:11:37 +0200
Message-ID: <34ed0938b69ead648da1aa250a2e081054fb49d4.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 18 Apr 2023 11:11:36 +0200
In-Reply-To: <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
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
         <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
         <edfc26b5-f6d1-2ab7-f3cc-60a74c8c334d@quicinc.com>
         <61268d31f8a6dd4eea10fcb6048d39244bc584e2.camel@sipsolutions.net>
         <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
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

On Tue, 2023-04-18 at 16:59 +0800, Wen Gong wrote:
> On 4/18/2023 4:15 PM, Johannes Berg wrote:
> > On Mon, 2023-04-17 at 22:07 +0800, Wen Gong wrote:
> > > OK. So I will try to put this in mac80211 layer, is it OK?
> > >=20
> > I guess? I'm still not really sure why you even want it, but hey, that'=
s
> > up to you in a way. I really didn't like the suggestion with
> > wiphy_iftype_ext_capab (or any other capability for that matter), it
> > feels like it should be more dynamic, like maybe a new "add link"
> > callback or something? At least then you can't blame mac80211 for when
> > it breaks when you have two 5 GHz links ...
>=20
> ok, so I would like to add callback such as
>=20
> "add_link(struct ieee80211_hw *hw, struct ieee80211_vif vif, struct=20
> ieee80211_bss_conf *link_conf, unsigned int link_id)"
>=20
> in struct ieee80211_ops, and mac80211 call it in=20
> ieee80211_mgd_setup_link()/ieee80211_vif_update_links,
>=20
> then lower-drvier could dynamic set the local addr of assoc=20
> link_conf(also for 2nd link_conf), is it OK?
>=20

Seems OK, but I'm not sure that _works_?

After all, we first set the addresses in assoc_data, when we don't have
a link_conf yet, no? Just what we were discussing in the other thread
about the leak.

johannes
