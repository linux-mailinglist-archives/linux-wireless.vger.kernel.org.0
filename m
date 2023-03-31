Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3766D1BB4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjCaJPa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjCaJPO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 05:15:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB401FD3A
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Wqb2lcPwAMyYrXupUdzt9vjrm3y+zww6oKAmtT0HLfg=;
        t=1680254066; x=1681463666; b=dg0xVEKFz3a5RMPGuyDecC8KzduGxeTDUkeaxk0OQ5L1jsY
        ecoPp77hikzM3559076kxfjH17RAEKOrKNjQua2Ak2dKCgL12D6DXwrpHOGyk4BLU8BK8WKmWjCre
        Pmww33JsDJruQUOuvFDX1coJph/jcSPYkWSq9V+rPHn2/TLMIPE3xnLWYtz2qdUs9kJQEUS7EIFOM
        nazfnqGVePPJch0HfJmG7M41lfKSYIVWphfOCMBogbowsvufEEChOPu4aCtZr5O748cZSnbYWdJf7
        U0eGJSpnhrDr2tHg5IydSGdC9EEVhYGmLvF9qRcwxGrlP3BW7y8bZjU0BiJSU78A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1piApr-0029L1-28;
        Fri, 31 Mar 2023 11:14:15 +0200
Message-ID: <3d09a8c687fc3d37a8be367a518ea174cdc1325d.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Add support to configure allowed frequency
 list for AP operation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 31 Mar 2023 11:14:14 +0200
In-Reply-To: <ZCW5HVMLHHW2bzKW@w1.fi>
References: <20230328093105.3640436-1-quic_vjakkam@quicinc.com>
         <421e93d78deda5ac9e62c58ee275758a3355a503.camel@sipsolutions.net>
         <ZCW5HVMLHHW2bzKW@w1.fi>
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

On Thu, 2023-03-30 at 19:30 +0300, Jouni Malinen wrote:
> On Tue, Mar 28, 2023 at 11:42:17AM +0200, Johannes Berg wrote:
> > On Tue, 2023-03-28 at 15:01 +0530, Veerendranath Jakkam wrote:
> > > Add support to configure the list of allowed 20 MHz channels for AP
> > > operation using an array of channel center frequencies in MHz, this
> > > configuration is valid until the AP is stopped. Driver shall filter o=
ut
> > > channels on top of this list of channels based on regulatory or other
> > > constraints during channel switch etc. Driver shall stop the AP
> > > operation if all the channels are filtered out during such operation.
> >=20
> > Normally hostapd is doing anything related to the channel picking, so
> > you need to explain why this is needed.
>=20
> hostapd does this for many cases, but there are drivers, including a
> couple of the upstream drivers, that select a channel internally for
> channel switch cases. Those would be able to use this information. Is
> that of sufficient generic interest or do you prefer vendor commands to
> be used for such functionality?

Oh, no, I'm entirely happy with this happening in nl80211, it's just the
age-old question again of whether those upstream drivers will ever even
get support for it, or if we end up with more code that effectively
looks dead as far as upstream is concerned :-)

If this actually came with a driver patch using it, the question
wouldn't even arise, since then it's clear why it's needed and what
for...

johannes

