Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3A25A22AE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbiHZIN0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiHZINZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 04:13:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC4D3ED7
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=q5zsXaomwsc2N8AHGmPJifVgxRcqWAti2vFpHMNuRUg=;
        t=1661501602; x=1662711202; b=FAlqvMhJSPzRS/SR6kZhHwAG34mKtpAfei+iRcHseBwW/v/
        WuyxwvSYh1gdjsZyFTzsQ/6CTSQFrYcm7Ui4VCY8yvcJYHbBLDfBPuOL9LHmiL7HxkXxXj5Ihas2q
        4zBAdee/zFzltODCkCUh3p0Aai+p1s8a8YH31WfbnvFK2BBoPqr3buspqn4Fe9d8bcCQ6vfDyzUk6
        qu740F2Z8YToMrz6yV16eFjghELXUQplGXqMvaJ9KhQGiFoV21UHKNhZOqeaPyjEcN/uWtgkD7ixj
        4+ESdnNd+/3NA0KxSnu+GCqCjCMKD/era+vRcWGeoe5IXMgwCTUL/kWCKx+D9Tfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRUSt-000A3M-2B;
        Fri, 26 Aug 2022 10:13:19 +0200
Message-ID: <5e0b07409a8c30f61ebe514d31d77e4564b86258.camel@sipsolutions.net>
Subject: Re: [PATCHv4] wifi: mac80211: Mesh Fast xmit support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sriram R <quic_srirrama@quicinc.com>, nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Aug 2022 10:13:18 +0200
In-Reply-To: <20220818070542.15870-1-quic_srirrama@quicinc.com>
References: <20220818070542.15870-1-quic_srirrama@quicinc.com>
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

Hi,

Couple of small things, sorry I didn't see that before.
=20
> +/**
> + * struct mesh_hdr_cache

need a short description, e.g.

struct mesh_hdr_cache - mesh header cache entry

> + *
> + * @enabled: Flag to denote if Header caching is enabled.
> + * @rhead: the rhashtable containing struct mesh_cache_entry, keyed by a=
ddr_key which
> + *	For a 6addr format which is currently supported in the cache, the key
> + *	is the external destination address or a5

I don't understand this - should the "which" (on the too long line) be
removed? Can you please rewrite this?

> + * @walk_head: linked list containing all mesh_cache_entry objects

Also both here refer to mesh_cache_entry which doesn't exist anywhere?
Did you mean 'struct mhdr_cache_entry'?

> + * @walk_lock: lock protecting walk_head
> + * @size: number of entries in the cache
> + */
> +struct mesh_hdr_cache {
> +	bool enabled;
> +	struct rhashtable rhead;
> +	struct hlist_head walk_head;
> +	spinlock_t walk_lock; /* protects cache entries */
> +	u16 size;

might be nicer to put 'bool enabled' last since otherwise you have a lot
of padding

> +struct mhdr_cache_entry {
> +	u8 addr_key[ETH_ALEN];

probably better to __aligned(2) even if of course this would matter only
if someone were to add some entries before it

> +	u8 hdr[MESH_HEADER_MAX_LEN];
> +	u16 machdr_len;
> +	u16 hdrlen;
> +	u8 pn_offs;
> +	u8 band;
> +	struct ieee80211_key __rcu *key;
> +	struct hlist_node walk_list;
> +	struct rhash_head rhash;
> +	struct mesh_path __rcu *mpath;
> +	struct mesh_path __rcu *mppath;
> +	unsigned long timestamp;
> +	struct rcu_head rcu;
> +	u32 path_change_count;
> +};
> +
>  /* Recent multicast cache */
>  /* RMC_BUCKETS must be a power of 2, maximum 256 */
>  #define RMC_BUCKETS		256
> @@ -299,6 +338,13 @@ void mesh_path_tx_root_frame(struct ieee80211_sub_if=
_data *sdata);
> =20
>  bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt);
> =20
> +struct mhdr_cache_entry *mesh_fill_cached_hdr(struct ieee80211_sub_if_da=
ta *sdata,
> +					      struct sk_buff *skb);

that's a fairly long line, you can break it better maybe:

struct mhdr_cache_entry *
mesh_fill_...

> +struct mhdr_cache_entry *mesh_fill_cached_hdr(struct ieee80211_sub_if_da=
ta *sdata,
> +					      struct sk_buff *skb)
> +{
> +	struct mesh_hdr_cache *cache;
> +	struct mhdr_cache_entry *entry;
> +	struct mesh_path *mpath, *mppath;
> +	struct ieee80211s_hdr *meshhdr;
> +	struct ieee80211_hdr *hdr;
> +	struct sta_info *new_nhop;
> +	struct ieee80211_key *key;
> +	struct ethhdr *eth;
> +	u8 sa[ETH_ALEN];
> +
> +	u8 tid;
> +
> +	cache =3D &sdata->u.mesh.hdr_cache;
> +
> +	if (!cache->enabled)
> +		return NULL;

If you check fast-xmit capability here, then I think you don't need the
'enabled' at all? The other use of it is to avoid double-release, but I
don't see how that would happen or be legal in the first place.

> +	if (!cache->enabled)
> +		return;
>=20
>=20

OK same here, but still?

Dunno. Maybe the extra byte is OK and cache locality is better that way
...

Though I've actually thought for a while now that we have so many
capability checks, we might benefit from making those static keys for
systems that only have a single wifi NIC (or multiple similar ones),
which is quite many I guess.

> +	if (key) {
> +		bool gen_iv, iv_spc;
> +
> +		gen_iv =3D key->conf.flags & IEEE80211_KEY_FLAG_GENERATE_IV;
> +		iv_spc =3D key->conf.flags & IEEE80211_KEY_FLAG_PUT_IV_SPACE;
> +
> +		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
> +			return;
> +
> +		if (key->flags & KEY_FLAG_TAINTED)
> +			return;
> +
> +		switch (key->conf.cipher) {
> +		case WLAN_CIPHER_SUITE_CCMP:
> +		case WLAN_CIPHER_SUITE_CCMP_256:
> +			if (gen_iv)
> +				pn_offs =3D hdrlen;
> +			if (gen_iv || iv_spc)
> +				crypto_len =3D IEEE80211_CCMP_HDR_LEN;
> +			break;
> +		default:
> +			/* Limiting supported ciphers for testing */

Nit: "limit"

But GCMP should be trivial, since it's the same? Feels strange to limit
to just CCMP.

> +			return;
> +		}
> +		hdr->frame_control |=3D cpu_to_le16(IEEE80211_FCTL_PROTECTED);
> +	}
> +
> +	if ((hdrlen + crypto_len + mshhdr_len + sizeof(rfc1042_header)) >
> +		MESH_HEADER_MAX_LEN) {

strange line-break/indentation - maybe just indent the second line by
another tab or so to make it clear it's not part of the code.

> +	if (pn_offs) {
> +		/* ignore the invalid data getting copied to pn location since it will
> +		 * be overwritten during tx
> +		 */
> +		memcpy(mhdr->hdr, skb->data, mhdr->machdr_len);

Not sure I understand that comment?


> +
> +		/* copy remaining hdr */
> +		memcpy(mhdr->hdr + mhdr->machdr_len,
> +		       skb->data + mhdr->machdr_len - crypto_len,
> +		       mhdr->hdrlen - mhdr->machdr_len);
> +	} else {
> +		memcpy(mhdr->hdr, skb->data, mhdr->hdrlen);
> +	}
> +
> +	if (key) {
> +		hdr =3D (struct ieee80211_hdr *)mhdr->hdr;
> +		hdr->frame_control |=3D cpu_to_le16(IEEE80211_FCTL_PROTECTED);
> +	}

Isn't "if (key)" equivalent to "if (pn_offs)" at this point, so you can
move it into the same if?

> @@ -2921,12 +2922,18 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_da=
ta *rx)
>  			mpp_path_add(sdata, proxied_addr, mpp_addr);
>  		} else {
>  			spin_lock_bh(&mppath->state_lock);
> -			if (!ether_addr_equal(mppath->mpp, mpp_addr))
> +			if (!ether_addr_equal(mppath->mpp, mpp_addr)) {
> +				update =3D true;
>  				memcpy(mppath->mpp, mpp_addr, ETH_ALEN);
> +			}
>  			mppath->exp_time =3D jiffies;
>  			spin_unlock_bh(&mppath->state_lock);
>  		}
>  		rcu_read_unlock();
> +
> +		/* Flush any hdr, if external device moved to a new gate */
> +		if (update)
> +			mesh_hdr_cache_flush(mppath, true);

This feels pretty expensive during RX, could/should it be done
asynchronously? Maybe it's not too bad since "is_mpp=3D=3Dtrue".

> +	/* availability of hdr entry ensures the mpath and sta are valid
> +	 * hence validation can be avoided.

What about key? :)

johannes
