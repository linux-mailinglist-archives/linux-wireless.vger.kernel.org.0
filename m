Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC495FD69E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJMJHO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJMJHN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 05:07:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB674B992
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 02:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1F60CE16A8
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 09:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF41C433D7;
        Thu, 13 Oct 2022 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665652029;
        bh=/ViHuil8PnhqqIda2qisrZIAtbDkwmd6nRFvTkmtl5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiAu4Uuqsm3rF4NfGcczcENjmqoPeUfjWj7obGIVo12Vv1hOKspx79VnTjvztqKkM
         ALq6Y2s6GuSETyxcH3scdu1ZYfeuUAICNZyssybROHmMkXFzF8xnqxLTeh9+WjMWl6
         BUPzXsznUmTD4yc0REtWbH0ZqbaWQVc/91zq9peyrUhFLnP11lgo5X/pC1iQWHM339
         l+nL/ptR3mIFnkOMw5V5/oezn8ZmpuPMdTIGFof0L+GadDvZYjqN96cWcTi+KAE6w7
         TQjxRlXT3QkawT4Gij1n8mSSACo0+No8WLD4JB+cJGFqgKlS+fZwlmToPUvPq3R5Hy
         KlH+jhyrkb3tg==
Date:   Thu, 13 Oct 2022 11:07:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com,
        daniel@makrotopia.org, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
Message-ID: <Y0fVOX5tvbWabVZI@lore-desk>
References: <cover.1664356281.git.lorenzo@kernel.org>
 <87r0zd4mxw.fsf@kernel.org>
 <Y0aH8T8pTARNWcPE@lore-desk>
 <87zge0memc.fsf@kernel.org>
 <Y0fQ0f3uy5p9f2mP@lore-desk>
 <3b029dc7-054b-3510-f159-de6622d8ce01@nbd.name>
 <87v8oom6wl.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hWagu6+icqVdB5Z+"
Content-Disposition: inline
In-Reply-To: <87v8oom6wl.fsf@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--hWagu6+icqVdB5Z+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Felix Fietkau <nbd@nbd.name> writes:
>=20
> > On 13.10.22 10:48, Lorenzo Bianconi wrote:
> >>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>>
> >>> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>> >> >> > Enable WED TX support for mt7915 and mt7986-wmac drivers
> >>> running on MT7986 SoC.
> >>> >> >> What's WED TX?
> >>> >
> >>> > It is the same as we did for MT7622. It is the capability to offloa=
d traffic
> >>> > from lan/wan to wlan. I specified "TX" since MT7986 supports even RX
> >>> > offloading (I am working on it at the moment).
> >>>
> >>> It would be nice to mention in the commit log that the feature is abo=
ut
> >>> offloading traffic from lan/wan to wlan. That way it's stored to to g=
it
> >>> history and people like me have some clue what the patch is about,
> >>> otherwise we are totally in dark.
> >>
> >> I think Felix has already applied them.
> >> @Felix: are you taking care of it or do I need to repost?
> >
> > No need to repost - just send me the description that you want to put
> > in there, and I'll update the commit.
>=20
> Thanks. And if it's too much work to change it feel free to keep it as
> is. Just try to keep this mind in the future when using exotic acronyms :)

ack, I will do for the rx counterpart :)

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--hWagu6+icqVdB5Z+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY0fVOQAKCRA6cBh0uS2t
rFufAQCGvi6u8fZ/b1WQgqSyEjlMguskyH3c210+fqmlmppywgEAk4I/p4OOnQSQ
RmZznhpQG4ONKnjsoVfM9VtJRhYACQg=
=if/y
-----END PGP SIGNATURE-----

--hWagu6+icqVdB5Z+--
