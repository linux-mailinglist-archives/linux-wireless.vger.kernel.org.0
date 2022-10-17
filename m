Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EFC60080C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Oct 2022 09:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJQHtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJQHth (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 03:49:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3AF019
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=m0E61T8C49akwBDi+VEffYu3F6Yg+wN2JpVKxh4v6WU=;
        t=1665992975; x=1667202575; b=WNJnRqxQpsMZqHmzoJPUhJH7wo+o6BCEgorSgUYS63agU4p
        PpYYewUKcKAZdyfXls2iUSo3fjzi/VbHB4S/cMk2zI9gmtyTChTQU5KzLjfJtEZy5wYZbzQ/mi1Xl
        Bv5AG/rptZ3LB5gFGByZL18TDe0PNYh9x4rUlYbZxFZKZgbWfUnwSfMACXtFJpNu0q6PbucuZbG+S
        Vt/ynM276/WSbIBVsUh9ZsNbM/qH0EumF85znl+mA1nugGWN2Z3hRwCYMzhzGeJwNW5UpRmLigbQe
        yZVf9BWyPkFajd1Oog7IMNIWrk7upOwjOVEtgi0yKEV6E4cYQJfrQXDyflsKBvUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okKsP-009BNs-1y;
        Mon, 17 Oct 2022 09:49:33 +0200
Message-ID: <2a2c466fbdcc2c3cc7af81bcd4d370d0119ea865.camel@sipsolutions.net>
Subject: Re: wifi: mac80211: mlo rx nss value 0 of wifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     ath11k@lists.infradead.org
Date:   Mon, 17 Oct 2022 09:49:32 +0200
In-Reply-To: <91b975e2116521cfa9f9371a976039a53ed9a85c.camel@sipsolutions.net>
References: <913ee04f-a16f-f765-96c2-0586282831b4@quicinc.com>
         <1a440c62-ffd0-9602-9454-f08765beadf0@quicinc.com>
         <91b975e2116521cfa9f9371a976039a53ed9a85c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Mon, 2022-10-17 at 09:48 +0200, Johannes Berg wrote:
> Hi,
>=20
> > > Currently for MLO test, the others links's rx_nss of struct
> > > ieee80211_link_sta is still value 0 in ieee80211_set_associated(),
> > > becaue they are not pass into ieee80211_sta_set_rx_nss() in
> > > mac80211 except the deflink which means the primary link in
> > > rate_control_rate_init(). This lead driver get nss =3D 0 for
> > > other links. Will you fix it or is it design by default?
> > >=20
> > > Only primary link has valid rx_nss value which is not 0 by below call=
=20
> > > stack.
> > > ieee80211_assoc_success()
> > > =C2=A0=C2=A0=C2=A0 ->rate_control_rate_init(sta);
> > > =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 ->ieee80211_sta_set_rx_nss(&sta=
->deflink);
>=20
> Right, none of the rate scaling related stuff was updated yet.
>=20

Though for this case maybe we can just move ieee80211_sta_set_rx_nss()
to some better place outside of rate_control_rate_init() and have it
done with the right link, and also on changes?

johannes
