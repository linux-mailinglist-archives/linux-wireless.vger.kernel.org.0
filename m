Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4522553AD5E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiFATni (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 15:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiFATnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 15:43:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773F1C7EE2
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JAVDRJSSdtTN6NFBbruaw741kxUI3kUtROUWIudDn/E=;
        t=1654112508; x=1655322108; b=tdzfxUNgs9u/xX9UJ6GiUS1Ej5pIF8/T3n16yJCIboaanLK
        KU9xuKxMXwR+CXfajXdOVubyFs5k0JoVAfSEBOR89PsoJLRhi7ehG+PRKlL1+XGVS99sw1TktbkK1
        lGGV/PjxClf0Gt3j2VO2oJIPXQs3q97ZimP2oh5KdP2lJLWV5RJEvSAGsNjNRQeTl20athjw5L9z0
        a+3kUgAMXjMCv3FDj/6HIDGCPoOMg/14KXCm+GeaiRzOIOyqJv/0UsBCEL+adQuKAq77oOVBpXfti
        aRQmPasyao0dV/2jNFl/NtF3t4i15TPqoKXhZWeeK6P5xKIJWALQfWPtkuTHhmXg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwUC1-00AX0p-WE;
        Wed, 01 Jun 2022 21:39:46 +0200
Message-ID: <5f5502b05106dea7fae829c22a8e4fad0a1f6da5.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 01 Jun 2022 21:39:45 +0200
In-Reply-To: <4a74852a-0a19-7fe5-95e6-09317bfe0eb3@quicinc.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
         <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
         <4a74852a-0a19-7fe5-95e6-09317bfe0eb3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
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

On Wed, 2022-06-01 at 12:31 -0700, Jeff Johnson wrote:
> On 6/1/2022 12:39 AM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Split the bss_info_changed method to vif_cfg_changed and
> > link_info_changed, with the latter getting a link ID.
> > Also change the 'changed' parameter to u64 already, we
> > know we need that.
>=20
> [snip]
>=20
> > -	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac bss info changed vif %p changed 0x%=
08x\n",
> > -		    vif, changed);
> > +	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac bss info changed vif %p changed 0x%=
llx\n",
> > +		    vif, (unsigned long long)changed);
>=20
> just curious about the typecasting.
>=20
> https://www.kernel.org/doc/html/latest/core-api/printk-formats.html=20
> indicates we should always be able to use %lld or %llx for u64 hence no=
=20
> typecasting should be needed
>=20

Hm. I think you're probably right - I used powerpc 20 years ago and it
had 'unsigned long' for u64, but I guess that changed a LONG time ago...
Yep, commit fe333321e2a71 (Jan 2009). Sorry, old habits die hard. :(

johannes
