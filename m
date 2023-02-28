Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176116A5E5E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Feb 2023 18:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1RoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Feb 2023 12:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1RoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Feb 2023 12:44:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF82B62E
        for <linux-wireless@vger.kernel.org>; Tue, 28 Feb 2023 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=9RXcqq4iumQYbVvukje9rz+agvouujARFpVx+cH6LNY=;
        t=1677606246; x=1678815846; b=iiEJ5Yq1KC2Pq9+b0lbGLzz9OMpjH3h+xqXSBa/qJ3MPXO7
        eJ4hjD4X5T19zIWeXqfFwvi7a0yEpFm22fs4oGqH5oce+wXhl/JESMFKNux7B8C7zQU0jspr9RQmn
        8XXNs55+JKV10Y2uQM9wY9FktI/TBMk/sMTNplSmlMVF4IrP2Chf0AaoE3Qo0lFEvJrZmb8J+3nLX
        opk0yZe46GJ7pAINuwUNBVGJi2lC9NMhTF/Odhp0GclYlsh75xqAF9CY4cyut6mJoLuRwXnMtl3cq
        20oUQ5cOplex9JIsbZo6wPVNJRcTAkKkG3UaK9MioEWyZ1TbHe9pUYYDxKycKv0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pX41E-0084Et-1r;
        Tue, 28 Feb 2023 18:44:04 +0100
Message-ID: <12fce295c582793e662ca322b0d3ae3b461ddb24.camel@sipsolutions.net>
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Date:   Tue, 28 Feb 2023 18:44:03 +0100
In-Reply-To: <03B7A24C-D6E2-4DBB-B52D-6174539BB781@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
         <20220920104032.496697-6-jelonek.jonas@gmail.com>
         <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
         <03B7A24C-D6E2-4DBB-B52D-6174539BB781@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Thu, 2023-01-26 at 17:53 +0100, Jonas Jelonek wrote:
> >=20
> > On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
> > > @@ -4846,16 +4989,32 @@ static int
> > > hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
> > >=20
> > > tx_attempts =3D (struct hwsim_tx_rate *)nla_data(
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info->attrs[HWSIM_ATTR_TX_INFO]);
> > > + tx_attempts_flags =3D (struct hwsim_tx_rate_flag *)nla_data(
> > > +     info->attrs[HWSIM_ATTR_TX_INFO_FLAGS]);
> > > + sta =3D (struct ieee80211_sta *)txi->rate_driver_data[1];
> >=20
> > That seems dangerous - what if the STA was freed already? You don't
> > walk
> > the pending list or something if the STA goes away.
>=20
> Yes, I see. Is it in general a bad idea to take the sta reference from
> ieee80211_control, put
> it in rate_driver_data and use it for tx-status? I guess I should pass
> sta to tx_status_ext whenever
> possible because it is used for several statistics.

Well you have to think about the lifetime. In most cases you do a lookup
of the STA (under RCU) etc. but=20

> I could think of two ways:
> - add NULL checks for the case that the sta pointer might be freed as
> you said

How would that pointer even go NULL though? The pointer would remain,
but the STA can be freed, no?

> - get sta by using, e.g., sta_info_get_by_addrs to get the sta if it
> is available. However, this always
> loops through the sta list. Might be a performance issue?

It should use the hashtable?

> Or do you suggest something different?

Well you could keep it here and walk the list of queued skbs (?) when a
STA is removed, and kill them all at that point, or something. Not sure
it's worth it vs. the hash table lookup, this is just hwsim after all.

johannes
