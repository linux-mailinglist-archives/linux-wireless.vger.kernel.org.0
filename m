Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B125A4FAD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiH2OwW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiH2OwU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 10:52:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9692F6B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Z/vg02kKTtdlcV1MPITs8XtFsLXNA/LxUXsG2vgSKYA=;
        t=1661784739; x=1662994339; b=IqEUyRIC9FSfRKGMwpZIFLoM7I6r243AddbkY5QKlnNZqdj
        YsSy4GwmjvNTuo/NMWfwQI3xiY9eY6S1pNM12lf6txAvxM9q+5DURITCRnEmArq3l+eZLiMAPKZ6D
        IgzBRirDcyT/4QiC0NGPnDvC3TIlJwdJdRMbBBeI+b7ec3TaylJ+VYaC6qJr9MoJBipGTujiFy8AJ
        wKLp1PRcn7drDOTqptgYCR4M/CsAs+wgsL0gTbuFkYQ5mBydeWi5EqOQS6P1tnGuo39LFX9FITJpn
        lrNoEAp3S3utj3uAzxuCtOIRF6uMqeMe0ZbGrHHE8wYZV7iz6qfc8+j5S07YYxgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oSg7c-002pnW-20;
        Mon, 29 Aug 2022 16:52:16 +0200
Message-ID: <8867d4a7552fc036da51ef5451ead1fd4df7f139.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas =?ISO-8859-1?Q?H=FChn?= <thomas.huehn@hs-nordhausen.de>
Cc:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
Date:   Mon, 29 Aug 2022 16:52:15 +0200
In-Reply-To: <5AA24131-A7E9-451D-97AB-97D925B2A53A@hs-nordhausen.de>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
         <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
         <5AA24131-A7E9-451D-97AB-97D925B2A53A@hs-nordhausen.de>
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

On Mon, 2022-08-29 at 16:51 +0200, Thomas H=C3=BChn wrote:
> > >=20
> > > Compile-Tested: current wireless-next tree with all flags on
> > > Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
> > >        Kernel 5.10.137
> > >=20
> >=20
> > That seems just a little old? Not sure I'd trust that given the major
> > changes in the tree recently?
>=20
> Good point, we can test this with 5.15.63 by enabling the OpenWrt testing=
 kernel =E2=80=A6 would that be ok ?
>=20

Well a lot of major changes just happened 5.19 -> 6.0, so something more
recent would be better?

johannes
