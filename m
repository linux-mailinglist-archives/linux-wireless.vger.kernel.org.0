Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4243E7F0FDA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKTKHp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 05:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjKTKHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 05:07:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EEF2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ACBikKPIRqzr9payxhpI5XM4jMhbiP2iolHg18i3IrE=;
        t=1700474851; x=1701684451; b=IuS+7nmA+l2gANpc9/2dO9gdATaCsGryH/0IWSJviJcFh9t
        hCbx1fr5JHjcZu1teORbuDsa/RZkdZ625bblBHyzwnE/UXq14sIWztCXzOc6peeBISE8bfx2K9rG3
        vY5/Hss/BKoBy4hlZfvaqU9u2AJNwzefymUWlsd8Q1NrWJ8E5O95s6Gkqwt0fjff90eRFGWhvkdlH
        GfP1nayk4Z1Kk6wMcrZtpHs+1juGqzx14L+K3U3Is7X6rHoZpgXCAQgDaa2h1B0it5NHEfDujQZ+T
        A1a7bgn6NtKGYbGrJT1B0IJ0rSMcH+aONQD7a3NJtBPgOhUSG2NI0Mi2mZ3YjiNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r51Be-0000000F5C6-06Ta;
        Mon, 20 Nov 2023 11:07:26 +0100
Message-ID: <f246e61a32590b8b543f02fa810da32f2d1c9a81.camel@sipsolutions.net>
Subject: Re: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?= 
        <Michael-cy.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?= 
        <Evelyn.Tsai@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?= 
        <Money.Wang@mediatek.com>
Date:   Mon, 20 Nov 2023 11:07:25 +0100
In-Reply-To: <e56d4b60d6b0e7305cc9db4f4b1e33fc44317ce5.camel@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
         <20231113021107.13110-2-michael-cy.lee@mediatek.com>
         <2eaa04080702230b8dbe3b3541d6d831484c4f1f.camel@sipsolutions.net>
         <e56d4b60d6b0e7305cc9db4f4b1e33fc44317ce5.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Michael,

> I will fix the typos and change all the =E2=80=9CIE =E2=80=9D to =E2=80=
=9CElement=E2=80=9D. The TODO
> for 320 MHz bandwidth is used for internal tests, I=E2=80=99ll remove it,=
 too.

Sounds good.

> We had checked the D4.1, and unfortunately, the additional description
> for WBCS Element in D3.2 9.4.2.159 is removed. In other words, D4.1
> does not change the definitions of WBCS Element and WBCS Element should
> be parsed as VHT operating information regardless of the BSS being VHT,
> HE, or EHT.

Right, I thought there were going to be some changes here.

> After parsing the WBCS Element, the STA needs to check whether the new
> channel fits its capabilities according to the operating mode
> (VHT/HE/EHT).
> However, the existing flow only checks the VHT capability after the
> WBCS Element parsing, which is incorrect when the BSS is HE/EHT or the
> band is 6 GHz.
> =20
> In summary, I will refactor the WBCS Element parsing part of this
> patch, along with other fixes.

Sounds good.

We'll have to figure this out separately, but I'm also working on
something else that will certainly affect this code. I noticed very
recently that the whole STA_DISABLE_* flags are very messy, and am
working on some improvements along these lines. The current version
looks like this, but it doesn't even compile yet:

https://p.sipsolutions.net/ccb552810b020745.txt

No idea if this would help/hinder you in any way, but I figured since it
has some overlap I'd let you know. I don't think you need to worry about
it for now, it'll take me some more time to work on it.

johannes
