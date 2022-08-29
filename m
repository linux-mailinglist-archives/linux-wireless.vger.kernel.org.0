Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946D95A4682
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiH2Jwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 05:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH2Jwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 05:52:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD1D2A26A
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UXIOzAhPulFSeFkkTvPHV18Z51XO59zIxRLXVF3NGmA=;
        t=1661766768; x=1662976368; b=vQBsRbNvgyIO3xpB8lkbWSN+IFzbTk2sqOYpbTmTdRIM987
        6EudtbbWErfgwsSlq1/clm9Ma6qHMkYAaP3VnkiEiwEa/Nd2mikVQGE+26b0BwxLPGfk2OW74RM4U
        TDTNPfpoMzPMt/esg+wAyCQ5hvC/sbfTw83Mck2eZKOBCDD2iCnzIyoZwO/YgicNYj7jZFqrPkmJr
        tpn0fpsbulodeCKb+f9lAyfhOqmRvVCmrWnONBztgRspRt4jlSFt8j8DGBdmzll3DFLvgK8J1STfr
        3qv6QXm8rR0IgtBzGxKZpKVQeXBQAtavxcG7Wg9cw5iIqr7aPH96VLiKx3HSuuUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oSbRl-002igP-39;
        Mon, 29 Aug 2022 11:52:46 +0200
Message-ID: <ce01865907335ee597d204eb3cc8caea6b6326c2.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] cfg80211: Update Transition Disable policy during
 port authorization
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     linux-wireless@vger.kernel.org, jithu.jance@broadcom.com
Date:   Mon, 29 Aug 2022 11:52:45 +0200
In-Reply-To: <c177e3cc-ae69-b8c8-bb72-be85b2262149@quicinc.com>
References: <e8fb69386675e5d128db141dabb9e6dad75eb841.1661516424.git.vinayak.yadawad@broadcom.com>
         <c177e3cc-ae69-b8c8-bb72-be85b2262149@quicinc.com>
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

On Fri, 2022-08-26 at 08:48 -0700, Jeff Johnson wrote:
>=20
> > @@ -3268,6 +3270,7 @@ enum nl80211_attrs {
> >  =20
> >   	NL80211_ATTR_TX_HW_TIMESTAMP,
> >   	NL80211_ATTR_RX_HW_TIMESTAMP,
> > +	NL80211_ATTR_TD_BITMAP,
> >  =20
> >   	/* add attributes here, update the policy in nl80211.c */
>=20
> Johannes, do you want the policy updated even thought this is=20
> driver->userspace and hence the policy is never applied to it?

Yeah in a sense, it doesn't really matter... I think not updating is
fine, then it will likely even be rejected, at least in any new
commands.

> >   		struct {
> >   			u8 bssid[ETH_ALEN];
> > +			s16 td_bitmap;
>=20
> I know you are using -1 as an indication that the bitmap is not used,=20
> but using signed with a bitmap seems strange since bitops can be=20
> affected by sign extension. Just something that set off my Spider-Sense.

Yeah true ... maybe a separate validity bool would've been better?
dunno.

johannes

