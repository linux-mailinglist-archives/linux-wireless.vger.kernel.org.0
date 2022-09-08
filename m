Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CBF5B2286
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiIHPhf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIHPhJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 11:37:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D41203D7
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XySWOJ6DXXcakq2HM6nLg5xaD+E0DbvXQUhX/rMLrrA=;
        t=1662651418; x=1663861018; b=W5cOgZt3wmJQBtHD0qytfGVKejj8JsgWryjw26wVUgqO+Rr
        DbRfU75+A3mRwBd+flN7leD5KMblap2p7o5KuEG9A8Lbd01psYQReRcIJdmwDs5HqrisLC2BoCGpw
        iGItW468DucdibvchAhpK7zLH1jUQwR2lJFniaQiBK2t7ZmJou2oQREeZe24f3lunRmZdyVEwEr22
        ADllVU8xxx6At0BGPV5fJGtytttnOVpmB3IKkhYb/cv9GbwDMqZA7q2NJ9OuHahGgUjb1jyYJMNEn
        0pU9dR6RLkyHQTr2Y4mqWj63aoB0S0iwn76PMso6X326saMyuQSDaA6EChCLZ4Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oWJaI-00BFG0-10;
        Thu, 08 Sep 2022 17:36:54 +0200
Message-ID: <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Thu, 08 Sep 2022 17:36:53 +0200
In-Reply-To: <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Thu, 2022-09-08 at 23:23 +0800, Wen Gong wrote:
>=20
> Now I found it only active the primay link(the link for=20
> authentication/assoc request) in my station MLO test,

Yes, that's intentional. It gives the driver choice about which links to
activate; first of all because we don't have interface/link combinations
stuff yet (waiting for your side on that), and secondly because we might
very well (want to) negotiate more links than we can concurrently have
active, e.g. a NIC that can have two active might still want to
negotiate four and switch dynamically.

> change_vif_links of struct ieee80211_ops *ops of driver will only be=20
> called one time for the primary link.

Correct.

> it means only one link for MLO.

Right.

> I plan to revert this patch in my local test now.
>=20
> Will you implement muti-links later?

Yes. I have patches pending to add API that the driver can call to pick
the active links (as a bitmap).

I'll send it out when I can, likely tomorrow.

johannes
>=20
