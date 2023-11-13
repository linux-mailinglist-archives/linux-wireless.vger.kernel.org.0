Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81DB7E9A1F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKMKVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 05:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMKVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 05:21:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6671135
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rwKUQgZ8c/rCfYaF4u6mj2l9ehYS2OQ+enRdM0kGD08=;
        t=1699870868; x=1701080468; b=jRkIO/GppIIWwWXNAabbDnhesMInB3gNiGwAgfeNHOUTtAp
        WWJP4YIHhBH23yq4fmYav59R2RB9PmwQ4fXQZay7ML/th3XkBK3SBPnzMT2jJsP4ySZueSvdGLvdt
        eBfKVEzeBca49tm0H4W08me2D+eu/YKZr8jLp38ADDgR5zd7a03pkxutkzGzUqvma3S/D1/EUcdb5
        TTYoO++1s9O0HajLkzBK94lFl/Rr1qPanJzDBl1jOVs32DclyFCaACTmjH1tRM4nh6bKJwvrG5iXU
        fv+5hgpeMlvMeOfwkNeWPAmIO4r7QHP03CZMUrpZRUjetnm4uB9CEUGFfflIF8tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r2U3r-00000006dsI-0RQY;
        Mon, 13 Nov 2023 11:20:55 +0100
Message-ID: <2eaa04080702230b8dbe3b3541d6d831484c4f1f.camel@sipsolutions.net>
Subject: Re: [PATCH v2,2/2] wifi: mac80211: Refactor STA CSA parsing flow
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael-CY Lee <michael-cy.lee@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Mon, 13 Nov 2023 11:20:53 +0100
In-Reply-To: <20231113021107.13110-2-michael-cy.lee@mediatek.com>
References: <20231113021107.13110-1-michael-cy.lee@mediatek.com>
         <20231113021107.13110-2-michael-cy.lee@mediatek.com>
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

On Mon, 2023-11-13 at 10:11 +0800, Michael-CY Lee wrote:
> The Wi-Fi Standard (IEEE 802.11-2020 9.4.2.160) initially specified that
> the Wide Bandwidth Channel Switch (WBCS) IE subfields have same definitio=
ns
> as the S1G or VHT Operation Information according to the operating band.
>=20
> However, it did not change the definitions in the amendment for 6 GHz
> (IEEE 802.11ax-2021), so the logic remain the same for handling the WBCS
> IE even if there is no VHT mode in 6 GHz.
>=20
> Now the Wi-Fi Standard draft (IEEE P80211be D3.2 9.4.2.159) modifies the
> defitions, making the WBCS IE subfields follow the definitions of S1G,

type - definitions

> VHT and HE Operation Information in S1G, 5 GHz and 6 GHz band, respective=
ly.
>=20
> APs in 6 GHz band might use the VHT or HE Operation Information to build
> a WBCS IE according to the Wi-Fi Standard they follow. Originally, the ST=
A

Probably should say "Element" in place of all those "IE" - the spec
stopped calling them "Information Elements" a long time ago :)

> just parsed the WBCS IE as VHT Operation Inforamtion, which was wrong if
> the AP was actually build the IE by the HE Operation Information.
>=20
> To avoid the ambiguity, STA should prefer the op_class in the Extended
> Channel Switch Announcement (ECSA) IE rathen than the WBCS IE. If the ECS=
A

typo - rather

> IE is not presented in a channel switch to 6 GHz, the STA should be aware
> of the possible ambiguity when parsing the WBCS IE.
>=20
> To derive the correct bandwidtin in use, the STA should check the

typo - bandwidth in

> +	case 4:
> +		/* 320 MHz bandwidth
> +		 * TODO channel switch to 320 MHz bandwidth should be indiated
> +		 * by Bandwidth Indication IE (IEEE P80211be D3.2 9.4.2.159)
> +		 */
> +		he_6ghz_oper->control =3D IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ;
> +		break;

I'm not sure what this TODO was meant to refer to, but I do know that
D4.1 made some changes here, maybe we should check those? I haven't even
checked what the changes are though.

In any case, checking with a newer draft and using that would seem
useful?

Haven't really read all the other things here yet, this just caught my
eye since I also just heard about D4.1 changes, but I don't have that or
even the old stuff all in my head right now.

johannes

