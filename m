Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C98B4DE797
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Mar 2022 12:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiCSLW4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Mar 2022 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242808AbiCSLWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Mar 2022 07:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721AF199E2D
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 04:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 655B26112B
        for <linux-wireless@vger.kernel.org>; Sat, 19 Mar 2022 11:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B1C340EC;
        Sat, 19 Mar 2022 11:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647688891;
        bh=nQboeRw4EpHkl5AQE8IKF+bwgT1/W0my/Fjov0ky86o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnanin3QsqZuzWUlz+BNxiEa4FSYF9U/+LSSAE8r0YwR3A1UtGSvUB8yThs1sTwSt
         LDeg0Zv9Rku754yY6yO8XVf+J5+gVwJCF8PAije87VA5dsRaJ5zeAAmmndG2wS4HOR
         MRG1rr6cJPLAk7V4uN5uRKQUO+cuQiMRCgcl/Llu7BS6nXueGBAE5LMjUpelBj1KEM
         2vWT+GuXfkf239qNgbsgjymaB7EjQGbBpai4Gd0VRPgxyueFrMR8dKBrih2QI4+6hc
         e8DTaqTiFCqSEgelxGuL5/GSRea8wydD06VcWlQ/aUXeXOciqJgC3Qn/OLGjO+Q5mx
         5dRGNRkZoedIA==
Date:   Sat, 19 Mar 2022 12:21:27 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] mt76: mt7915: introduce 802.11ax multi-bss support
Message-ID: <YjW8t8N7T6EgGiOe@lore-desk>
References: <20220319090501.GA5051@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9/FoJLMF4HHheNmm"
Content-Disposition: inline
In-Reply-To: <20220319090501.GA5051@kili>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--9/FoJLMF4HHheNmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo Bianconi,
>=20
> The patch 6b7f9aff7c67: "mt76: mt7915: introduce 802.11ax multi-bss
> support" from Mar 15, 2022, leads to the following Smatch static
> checker warning:
>=20
> 	drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:1872 mt7915_mcu_beacon_m=
bss()
> 	error: undefined (user controlled) shift '(((1))) << (data[2])'

I do not think it is a real issue since bssid_index is supposed to be limit=
ed
by mbssid_max_interfaces (set to 16 for 7915), but I will add a check. Than=
ks.

Regards,
Lorenzo

>=20
> drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>     1828 static void
>     1829 mt7915_mcu_beacon_mbss(struct sk_buff *rskb, struct sk_buff *skb,
>     1830                        struct ieee80211_vif *vif, struct bss_inf=
o_bcn *bcn,
>     1831                        struct ieee80211_mutable_offsets *offs)
>     1832 {
>     1833         struct bss_info_bcn_mbss *mbss;
>     1834         const struct element *elem;
>     1835         struct tlv *tlv;
>     1836=20
>     1837         if (!vif->bss_conf.bssid_indicator)
>     1838                 return;
>     1839=20
>     1840         tlv =3D mt7915_mcu_add_nested_subtlv(rskb, BSS_INFO_BCN_=
MBSSID,
>     1841                                            sizeof(*mbss), &bcn->=
sub_ntlv,
>     1842                                            &bcn->len);
>     1843=20
>     1844         mbss =3D (struct bss_info_bcn_mbss *)tlv;
>     1845         mbss->offset[0] =3D cpu_to_le16(offs->tim_offset);
>     1846         mbss->bitmap =3D cpu_to_le32(1);
>     1847=20
>     1848         for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
>     1849                             &skb->data[offs->mbssid_off],
>     1850                             skb->len - offs->mbssid_off) {
>     1851                 const struct element *sub_elem;
>     1852=20
>     1853                 if (elem->datalen < 2)
>     1854                         continue;
>     1855=20
>     1856                 for_each_element(sub_elem, elem->data + 1, elem-=
>datalen - 1) {
>     1857                         const u8 *data;
>     1858=20
>     1859                         if (sub_elem->id || sub_elem->datalen < =
4)
>     1860                                 continue; /* not a valid BSS pro=
file */
>     1861=20
>     1862                         /* Find WLAN_EID_MULTI_BSSID_IDX
>     1863                          * in the merged nontransmitted profile
>     1864                          */
>     1865                         data =3D cfg80211_find_ie(WLAN_EID_MULTI=
_BSSID_IDX,
>     1866                                                 sub_elem->data,
>     1867                                                 sub_elem->datale=
n);
>     1868                         if (!data || data[1] < 1 || !data[2])
>=20
> This probably needs a "|| data[2] > 31" but maybe using a define?
>=20
>     1869                                 continue;
>     1870=20
>     1871                         mbss->offset[data[2]] =3D cpu_to_le16(da=
ta - skb->data);
> --> 1872                         mbss->bitmap |=3D cpu_to_le32(BIT(data[2=
]));
>     1873                 }
>     1874         }
>     1875 }
>=20
> regards,
> dan carpenter

--9/FoJLMF4HHheNmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjW8twAKCRA6cBh0uS2t
rBu+AQDLKqKuVxCGR++YMtY534nbRMMq09uGcKJsgPAqoiqG7QD/bApEj5OtgkYz
ZwmuPsidsxRKDZfdSN+y0l3cgeauYAI=
=eLFX
-----END PGP SIGNATURE-----

--9/FoJLMF4HHheNmm--
