Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9D58DF31
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 20:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbiHIShh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347274AbiHISgY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 14:36:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D410C2BB10
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mSC8diFt6Gw7FNsYIzWY3bkJ7ZtbH2lAlt+igTyCh7Y=;
        t=1660068761; x=1661278361; b=JWZQk9O7J3/ygjdMrqsy3xRepsDhzfSSumSuzsRei+QN+yL
        D1i1k+IiUVnvkg/O/tCuXCSotFzbK2hHKVzX+mZcw9mp6KOKGLlB7LXHzx9VzCZ15UuHE3CbBjTYO
        qrHBmym6trHCQzCQhWjNIyFaiQ+70Gu5XrsnOngUNUHU0f+o1NOE8ljRe6coGKf0bh8c19ua+ZE2j
        mf99Gc6vAOR4RW+JaaBrkY1WxKyP5uK+LNO3HG+kK0fa1/HIXuxyBqfRPzoWTicReKTe4HZeitDuw
        5REStD0QEOhCm8BWCIjle+XyLb3dOdaN5RPki4/GvkaigTK8OWRSRWK/038u4tKw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oLTiY-003Hd3-2w;
        Tue, 09 Aug 2022 20:12:39 +0200
Message-ID: <9e37eb24f63dbac0b13ae8b36393c8f393599d1e.camel@sipsolutions.net>
Subject: Re: [RFC 1/2] wifi: mac80211: add a new field in
 ieee80211_rx_status for link id
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 09 Aug 2022 20:12:38 +0200
In-Reply-To: <733b6f1a-8b07-4b23-2b10-af1ce68b6227@quicinc.com>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
         <20220802065019.20791-2-quic_vthiagar@quicinc.com>
         <29694008-63ef-4cd3-a6c6-f82fc8377be6@quicinc.com>
         <733b6f1a-8b07-4b23-2b10-af1ce68b6227@quicinc.com>
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

On Wed, 2022-08-03 at 22:16 +0530, Vasanthakumar Thiagarajan wrote:
>=20
> > > +=C2=A0=C2=A0=C2=A0 u8 link_id;
> > > =C2=A0 };
> > > =C2=A0 static inline u32
> >=20
> > in other parts of the MLO code the link_id is defined as int and a valu=
e=20
> > of -1 is used for a non-MLO link. but I don't know if that is currently=
=20
> > universally true.
> >=20
> > if that is curently universally true, do we want to now have divergent=
=20
> > definitions of a link_id?
>=20
> Good point, i see link_id is used both as unsigned and int based on
> their usage. The reason I preferred unsigned is that we can make use of=
=20
> the remaining 4-bits for some other purpose in future,=20
> ieee80211_rx_status has size limitation.
>=20

It's a bit tricky though - do we want to have 0 for all the drivers that
don't support MLO? Might not really be an issue, but OTOH not
initializing it should probably not result in a valid value otherwise
you might test something, think it's fine, and it really isn't.

I think we should spend a bit to have a validity indication in this
case. Even -1 wouldn't address it since you'd have to initialize to
that.

It works better the other way around in APIs etc. where we have a few
producers and many consumers (cfg80211 down to drivers), but less well
this way where we'd have to change drivers...

johannes

