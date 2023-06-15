Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B5E731178
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjFOH5D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjFOH5C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 03:57:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C0C2119
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+Hu0ck9XCxIY2n8/byR+TEcnYCe2b0gqlzoS7QzsYf4=;
        t=1686815819; x=1688025419; b=hGg9gKbeMf5w/ctD93T7RlGLY+o0eYOTn9DHtQOrbHjfKoN
        h8gXGPUSA7LDHEjrEF3CK/L77/3WnFDWmCaObkuDgaBLPJIzSojfsi0vH8tYsPBpIKzgygKkCarQx
        7YIzHMbxEHTP/jNiuiM/Cr8cv70Eoe1zZpyUTjPZGRQpieSsUKPTmmPcKkIrjk7xOsQ5cOmigqaJy
        hcPK7i19maVlIsGY5l9dUHy/bgLplsYVoayVRgft4JyCWwEkf+e7QIR008fCQl5ZXVDwqCOMa/JcH
        l95fYc8asNrjJfUTMwiGV+ZwGdNoefW3jg2P37QBBgoVa20ykRwPfqXGpE8Z9UAw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9hqi-0075q8-0G;
        Thu, 15 Jun 2023 09:56:56 +0200
Message-ID: <c60af4eb116ed330e8035503fb7944f8853bcfa4.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Thu, 15 Jun 2023 09:56:55 +0200
In-Reply-To: <a7093d7a-0179-7b5f-cc61-a501331d35c6@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
         <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
         <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
         <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
         <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
         <2cc79101249548f2a92c14af6aff6121143907d6.camel@sipsolutions.net>
         <1c26c205-0240-7670-117d-02a7af068724@quicinc.com>
         <6f8db032286923845202c7d658f1d39db79a758c.camel@sipsolutions.net>
         <a7093d7a-0179-7b5f-cc61-a501331d35c6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Thu, 2023-06-15 at 10:26 +0800, Wen Gong wrote:
> On 6/15/2023 2:32 AM, Johannes Berg wrote:
> > On Wed, 2023-05-24 at 15:41 +0800, Wen Gong wrote:
> > > May I add a new ops in struct ieee80211_ops? like this:
> > >=20
> > > u16 active_links(struct ieee80211_hw *hw, struct ieee80211_vif vif, u=
16
> > > new_links)"
> > >=20
> > > then ieee80211_set_vif_links_bitmaps() call the ops to get the links =
for
> > > station and set the sdata->vif.active_links with the return value fro=
m
> > > lower driver,
> > > it means lower driver will dynamic select the links count at this mom=
ent.
> > >=20
> > > If lower driver not register ops active_links, then keep current logi=
c.
> > >=20
> > I guess you can can send patches for whatever you want :)
> >=20
> > But I have no idea what you're trying to do? Why would you need to have
> > a callback?
>=20
> Currently driver could use ieee80211_set_active_links_async() to active=
=20
> links after connection completed.

Right.

> But I would like to allow driver to select active links in a early time,=
=20
> it will be more convenient for driver.

How so? All you have to do is look for the connection becoming
authorized (e.g. sta state for the AP moving to authorized) and then
selecting the links you want. We've already been working on that, it's
really easy?

On the flip-side, it would be highly inconvenient for mac80211 to try to
enable more links *during* the association process, and actually it's
not even allowed by spec until the 4-way-HS finishes. So the earliest
possible time is pretty much when you can just do it in the driver as I
just described.

> > Was this for link selection in the driver? We should have a patch
> > somewhere that adds a BSS_CHANGE flag for when the valid links change,
> > so the driver can select others.
> >=20
> > johannes
>=20
> Yes, it is for link selection in driver at a early time before=20
> connection completed.

This is not really allowed ... At least not without also finding ways to
really transmit the 802.1X and 4-way-HS only on the right link, etc.

> Could you tell detail about how the BSS_CHANGE flag works?=F0=9F=98=81

The work isn't complete yet, but basically it just calls the callback
whenever the valid_links changed, say by link-reconfiguration.

johannes
