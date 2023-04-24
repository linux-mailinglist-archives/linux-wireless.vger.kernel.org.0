Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586106ED303
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDXQ7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjDXQ7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 12:59:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15926AF26
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KhWqgpIMHiV1j+Dv8BwTyQQCk7kgg453ejebDpyOwZI=;
        t=1682355529; x=1683565129; b=cT7tbEYRYWzxQhEfd9PP+W5u7d9aLALl6L270UapuOasnfd
        YI7cLPyuJgwLaD6ovU5lKZzWbkJpLz0k8IEuLQxoIDUamp7OMcDfm/ihexaCph497kzTPt1iMSo0f
        4os3x8hsIHWUt6YAfWJ1u0QDV09trE4CYxt4GA/JdDL8etUht9hJyoxtJP6lll/PVBT50rDk/XZBV
        C9UPuuvREdQq/HXsgYJUj8I+Oh690bVHx8LvwSGuB3gYVBmWkruxpz6buwzj0eqPSzc/Dl94Qrjd0
        +mVi1GXB2pP12OlnYaOf8GCfld1CGP96ZIm+qo+jC1UuB43g1Co5x+MLR+eBL0wA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pqzWV-007JrN-0d;
        Mon, 24 Apr 2023 18:58:43 +0200
Message-ID: <e247d0832435218fcdb78f3b81a66306b8873946.camel@sipsolutions.net>
Subject: Re: Question on why ieee80211_prep_channel clears the
 IEEE80211_CONN_DISABLE_160MHZ flag.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 24 Apr 2023 18:58:42 +0200
In-Reply-To: <451c423b-4d0b-c2e6-7f39-0dc7da3e8080@candelatech.com>
References: <451c423b-4d0b-c2e6-7f39-0dc7da3e8080@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Thu, 2023-03-30 at 16:55 -0700, Ben Greear wrote:
> I'm trying to have supplicant tell the STA to not allow 160Mhz.
>=20
> In the method below, in my setup, *conn_flags has IEEE80211_CONN_DISABLE_=
160MHZ
> set when entering the method, but this method clears that and some relate=
d flags.
> The clear logic dates back to 2012, effectively, but I guess in 5.19 kern=
el era somehow my hacks worked.
>=20
> So question is, should it still be clearing the flags here?  I can add mo=
re
> hack-around logic, but possibly those lines should just be removed for ev=
eryone?
>=20
> static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
> 				  struct ieee80211_link_data *link,
> 				  struct cfg80211_bss *cbss,
> 				  ieee80211_conn_flags_t *conn_flags)
> {
> 	struct ieee80211_local *local =3D sdata->local;
> 	const struct ieee80211_ht_cap *ht_cap =3D NULL;
> 	const struct ieee80211_ht_operation *ht_oper =3D NULL;
> 	const struct ieee80211_vht_operation *vht_oper =3D NULL;
> 	const struct ieee80211_he_operation *he_oper =3D NULL;
> 	const struct ieee80211_eht_operation *eht_oper =3D NULL;
> 	const struct ieee80211_s1g_oper_ie *s1g_oper =3D NULL;
> 	struct ieee80211_supported_band *sband;
> 	struct cfg80211_chan_def chandef;
> 	bool is_6ghz =3D cbss->channel->band =3D=3D NL80211_BAND_6GHZ;
> 	bool is_5ghz =3D cbss->channel->band =3D=3D NL80211_BAND_5GHZ;
> 	struct ieee80211_bss *bss =3D (void *)cbss->priv;
> 	struct ieee80211_elems_parse_params parse_params =3D {
> 		.bss =3D cbss,
> 		.link_id =3D -1,
> 		.from_ap =3D true,
> 	};
> 	struct ieee802_11_elems *elems;
> 	const struct cfg80211_bss_ies *ies;
> 	int ret;
> 	u32 i;
>=20
> 	pr_info("prep-channel-0, CONN_DISABLE_160MHZ: %d\n",
> 		!!(*conn_flags & IEEE80211_CONN_DISABLE_160MHZ));
>=20
> 	rcu_read_lock();
>=20
> 	ies =3D rcu_dereference(cbss->ies);
> 	parse_params.start =3D ies->data;
> 	parse_params.len =3D ies->len;
> 	elems =3D ieee802_11_parse_elems_full(&parse_params);
> 	if (!elems) {
> 		rcu_read_unlock();
> 		return -ENOMEM;
> 	}
>=20
> 	sband =3D local->hw.wiphy->bands[cbss->channel->band];
>=20
> 	*conn_flags &=3D ~(IEEE80211_CONN_DISABLE_40MHZ |
> 			 IEEE80211_CONN_DISABLE_80P80MHZ |
> 			 IEEE80211_CONN_DISABLE_160MHZ);
>=20

I'm guessing - I don't really remember right now - that this is so we
can make a new decision to set these flags? We don't really clear them
in any other place, I guess?

But honestly I don't know. There's a lot of state and maybe we should
just memset() it all whenever we disconnect (get into some kind of idle
state), just like we do with the links now that we free...

johannes
