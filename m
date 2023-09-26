Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199A7AE980
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjIZJoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjIZJoP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 05:44:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F811F
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HmkCa+CDajndIlz08jjKz46l6h4i8QXpU+sUtr7YgfM=;
        t=1695721449; x=1696931049; b=qHSoX/eXRJSk8C4PetB6fCPtSMXwCDaMNqcLjAeEqJUifYN
        6AZxGh4hCLk8kZQSRD1G03XAutBduSiBKKLY777ogY3xy5N43zwx2qmQUkoDOl+01YXHdW1kL17TX
        hlAQzuZU8KWt/5GXI7L9sAXnWHcSKY+9ebeyLl4Asfhe7JyEo4tR+rYAkKSH/g98EwQ0Gdh5UEC/6
        Udhj0lXB/jCLaUH8U0iXMQcfivGxIoHaU8fLN3u4aNSU9olqX4s0s7yB9xBO2pqG7UmjbO7oN/5zV
        SE67xUnP8lq+oRniyn2Yp5SJAUiYrBfENW2ETFIEYHuwpHCITicKfGVZ1ink8Mmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql4br-005RiW-1I;
        Tue, 26 Sep 2023 11:44:03 +0200
Message-ID: <18228b58173d9f33b1c3ddda9df5b3c4b49fb075.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] wifi: mac80211: update link RX NSS by
 ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 Sep 2023 11:44:02 +0200
In-Reply-To: <bfdcbf9a-0b27-1f7e-3eca-7390a9a7404e@quicinc.com>
References: <20230906103458.24092-1-quic_wgong@quicinc.com>
         <20230906103458.24092-4-quic_wgong@quicinc.com>
         <e6ea3009c489fae910adbf2e1c766f2d827f287f.camel@sipsolutions.net>
         <bfdcbf9a-0b27-1f7e-3eca-7390a9a7404e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Fri, 2023-09-15 at 16:43 +0800, Wen Gong wrote:
> On 9/13/2023 5:04 PM, Johannes Berg wrote:
> > On Wed, 2023-09-06 at 06:34 -0400, Wen Gong wrote:
> > > Currently for MLO connection, only deflink's rx_nss is set to correct
> > > value. The others links' rx_nss of struct ieee80211_link_sta is
> > > value 0 in ieee80211_set_associated(), because they are not pass into
> > > ieee80211_sta_set_rx_nss() in mac80211 except the deflink in
> > > rate_control_rate_init(). This leads driver get NSS =3D 0 for other l=
inks.
> > > Add the ieee80211_sta_set_rx_nss() in ieee80211_assoc_config_link(),
> > > then the other links' rx_nss will be set to the correct value.
> > This is pretty much true, but I also think it's problematic the way you
> > phrase it. Software rate control is pretty much, at least currently,
> > _not_ supported for MLO (and I don't really see how to support it, if
> > firmware picks the link to transmit on, as it probably should).
> I searched all the folder wireless, I only found 5 places have the=20
> handler of rate_init below,
> and the functions are all empty. Is it means no driver support rate_init=
=20
> currently?
> drivers/net/wireless/realtek/rtlwifi/rc.c:304:=C2=A0=C2=A0=C2=A0=C2=A0 .r=
ate_init =3D=20
> rtl_rate_init,
> drivers/net/wireless/intel/iwlwifi/mvm/rs.c:4098:=C2=A0 .rate_init =3D=
=20
> rs_rate_init_ops,
> drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3276:=C2=A0 .rate_init =3D=
=20
> rs_rate_init_stub,
> drivers/net/wireless/intel/iwlegacy/4965-rs.c:2779: .rate_init =3D=20
> il4965_rs_rate_init_stub,
> drivers/net/wireless/intel/iwlegacy/3945-rs.c:867: .rate_init =3D=20
> il3945_rs_rate_init_stub,
> [...]
>=20

Well, many other drivers use minstrel, and the _stub ones in intel are
atually not doing anything.

So most drivers would use=20

net/mac80211/rc80211_minstrel_ht.c:     .rate_init =3D
minstrel_ht_rate_init,

here.

johannes

