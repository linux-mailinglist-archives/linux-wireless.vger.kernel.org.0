Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642EB573DBA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiGMUWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiGMUWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 16:22:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA372E694
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ZF2H7O1O20G5Zoeg8X6NGyGj833JjYzget13bvKZ1yA=;
        t=1657743759; x=1658953359; b=vtb2nOihIRpfX+lM8homCVxnCvcFTJv0BgT8Ao9uozwJl1t
        nJ9ryXmGnJ7hi1pdGFiBGPJUkxfvneJotV6UHqbXzoQUvdkNmccYnuo6uk40acKzo0Nn3valCxqPR
        e/MYJLnVlPAbRPMFfayGTJDYriquTefONGb+WCSB//PbHSl+zZ0FZzH7hgqxPbnFPnLLW++TObhIQ
        vRC7TOD/jl7WsAVh+9uZK3mBWgF6P63Wv8SHbU8w5sJ1P8PJh64W7WTlJAwe0vYTtHLd4HkQQ5XH9
        CNRhQH1aJDP/of8NjFePwPiJtz7+67xZT/+rkyhanG1n0QCoi0ownYKBA0v7j3qA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBisW-00EsFS-9p;
        Wed, 13 Jul 2022 22:22:36 +0200
Message-ID: <2d90dfefd79fb2d4c942026856ef11ae6b4279cb.camel@sipsolutions.net>
Subject: Re: [RFC] cfg80211: Add link_id to various key operations for MLO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Jul 2022 22:22:35 +0200
In-Reply-To: <1657518327-17390-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1657518327-17390-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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

>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 140354f..dc37b7b 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3880,22 +3880,36 @@ struct mgmt_frame_regs {
>   * @del_intf_link: Remove an MLO link from the given interface.
>   *
>   * @add_key: add a key with the given parameters. @mac_addr will be %NUL=
L
> - *	when adding a group key.
> + *	when adding a group key. @link_id will be >=3D 0 for a MLO group key =
and
> + *	-1 for MLO pairwise key. @mac_addr will be AP MLD address for MLO
> + *	pairwise key. @link_id will be -1 for non-MLO connection.
>   *
>   * @get_key: get information about the key with the given parameters.
>   *	@mac_addr will be %NULL when requesting information for a group
> - *	key. All pointers given to the @callback function need not be valid
> - *	after it returns. This function should return an error if it is
> - *	not possible to retrieve the key, -ENOENT if it doesn't exist.
> + *	key. @link_id will be >=3D 0 for a MLO group key and -1 MLO pairwise =
key.
> + *	@mac_addr will be AP MLD address for MLO pairwise key. @link_id
> + *	will be -1 for non-MLO connection. All pointers given to Other

"other" I guess, no need to capitalise?

> + *	@callback function need not be valid after it returns. This function
> + *	should return an error if it is not possible to retrieve the key,
> + *	-ENOENT if it doesn't exist.
>   *
>   * @del_key: remove a key given the @mac_addr (%NULL for a group key)
> - *	and @key_index, return -ENOENT if the key doesn't exist.
> + *	and @key_index. @mac_addr will be AP MLD address for MLO pairwise key=
.
> + *	For MLO connection, if @link_id is >=3D 0, pairwise/group key
> + *	on corresponding link will be deleted. if link_id is -1, specified ke=
y

but capitalise "If" here at the beginning,

> + *	index data will be deleted on all links. return -ENOENT if the key

and "Return" here

> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -377,14 +377,23 @@
>   *	the non-transmitting interfaces are deleted as well.
>   *
>   * @NL80211_CMD_GET_KEY: Get sequence counter information for a key spec=
ified
> - *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
> + *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC. For MLO pairwise k=
ey
> + *	%NL80211_ATTR_MAC represents AP MLD address and for MLO group key lin=
k

[...] group key _the_ link [is identified by ...]

> + *	is identified by %NL80211_ATTR_MLO_LINK_ID.
>   * @NL80211_CMD_SET_KEY: Set key attributes %NL80211_ATTR_KEY_DEFAULT,
>   *	%NL80211_ATTR_KEY_DEFAULT_MGMT, or %NL80211_ATTR_KEY_THRESHOLD.
> + *	For MLO connection, link to set default keys identified by
> + *	%NL80211_ATTR_MLO_LINK_ID.

Same here.

>   * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
>   *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
> - *	and %NL80211_ATTR_KEY_SEQ attributes.
> + *	and %NL80211_ATTR_KEY_SEQ attributes. For MLO pairwise key
> + *	%NL80211_ATTR_MAC represents AP MLD address and link to add MLO group
> + *	key identified by %NL80211_ATTR_MLO_LINK_ID.

same

>   * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_ID=
X
> - *	or %NL80211_ATTR_MAC.
> + *	or %NL80211_ATTR_MAC. For MLO pairwise key %NL80211_ATTR_MAC represen=
ts
> + *	AP MLD address and link to delete pairwise/group key identified by

same

> + *	%NL80211_ATTR_MLO_LINK_ID, If %NL80211_ATTR_MLO_LINK_ID is not presen=
t
> + *	the specified key index data should be deleted for all the links.

really? for all the links seems... complicated?

> +++ b/net/wireless/nl80211.c
> @@ -1539,7 +1539,6 @@ static int nl80211_key_allowed(struct wireless_dev =
*wdev)
>  		return -ENOLINK;
>  	case NL80211_IFTYPE_STATION:
>  	case NL80211_IFTYPE_P2P_CLIENT:
> -		/* for MLO, require driver validation of the link ID */
>  		if (wdev->connected)
>  			return 0;
>  		return -ENOLINK;

hmm, right, I guess you're validating something now

> @@ -4288,6 +4287,23 @@ static int nl80211_set_noack_map(struct sk_buff *s=
kb, struct genl_info *info)
>  	return rdev_set_noack_map(rdev, dev, noack_map);
>  }
> =20
> +static int nl80211_validate_key_link_id(struct wireless_dev *wdev,
> +					int link_id, bool pairwise)
> +{
> +	if (pairwise && link_id !=3D -1)
> +		return -EINVAL;
> +
> +	if (wdev->valid_links &&
> +	    (link_id =3D=3D -1 ||
> +	     !(wdev->valid_links & BIT(link_id))))
> +		return -EINVAL;
> +
> +	if (!wdev->valid_links && link_id !=3D -1)
> +		return -EINVAL;

Might be nicer to split that into

 if (wdev->valid_links) {
     if (link_id < 0) return -EINVAL;
     if (!(valid_links & BIT(link_id)) return -EINVAL;
 } else {
     ...
 }

etc. to make the conditions less convoluted? (obviously fixing code
style)

Also might be worth adding some error messages (GENL_SET_ERR_MSG)?

> -	err =3D rdev_get_key(rdev, dev, key_idx, pairwise, mac_addr, &cookie,
> -			   get_key_callback);
> +	err =3D nl80211_validate_key_link_id(wdev, link_id, pairwise);
> +	if (err) {
> +		GENL_SET_ERR_MSG(info, "invalid link id");

Ah you did that here, but that doesn't say that much. Maybe good enough
though. But if you pass 'info' to the function, you don't have to
duplicate that code, e.g. like

> @@ -4455,18 +4481,24 @@ static int nl80211_set_key(struct sk_buff *skb, s=
truct genl_info *info)
>  			goto out;
>  		}
> =20
> -		err =3D nl80211_key_allowed(dev->ieee80211_ptr);
> +		err =3D nl80211_key_allowed(wdev);
>  		if (err)
>  			goto out;
> =20
> -		err =3D rdev_set_default_key(rdev, dev, key.idx,
> -						 key.def_uni, key.def_multi);
> +		err =3D nl80211_validate_key_link_id(wdev, link_id, false);
> +		if (err) {
> +			GENL_SET_ERR_MSG(info, "invalid link id");
> +			goto out;

here

> @@ -4479,16 +4511,22 @@ static int nl80211_set_key(struct sk_buff *skb, s=
truct genl_info *info)
>  			goto out;
>  		}
> =20
> -		err =3D nl80211_key_allowed(dev->ieee80211_ptr);
> +		err =3D nl80211_key_allowed(wdev);
>  		if (err)
>  			goto out;
> =20
> -		err =3D rdev_set_default_mgmt_key(rdev, dev, key.idx);
> +		err =3D nl80211_validate_key_link_id(wdev, link_id, false);
> +		if (err) {
> +			GENL_SET_ERR_MSG(info, "invalid link id");

and here

(and many more places)

> -	wdev_lock(dev->ieee80211_ptr);
> -	err =3D nl80211_key_allowed(dev->ieee80211_ptr);
> +	wdev_lock(wdev);
> +	err =3D nl80211_key_allowed(wdev);
> =20
>  	if (key.type =3D=3D NL80211_KEYTYPE_GROUP && mac_addr &&
>  	    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
>  		err =3D -ENOENT;
> =20
> +	if (!err && link_id !=3D -1 &&
> +	    (!wdev->valid_links || !(wdev->valid_links & BIT(link_id)))) {
> +		err =3D -EINVAL;
> +		GENL_SET_ERR_MSG(info, "invalid link id");
> +	}

maybe still call nl80211_validate_key_link_id() if it's not -1?

> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -935,13 +935,13 @@ void cfg80211_upload_connect_keys(struct wireless_d=
ev *wdev)
>  	for (i =3D 0; i < CFG80211_MAX_WEP_KEYS; i++) {
>  		if (!wdev->connect_keys->params[i].cipher)
>  			continue;
> -		if (rdev_add_key(rdev, dev, i, false, NULL,
> +		if (rdev_add_key(rdev, dev, -1, i, false, NULL,
>  				 &wdev->connect_keys->params[i])) {
>  			netdev_err(dev, "failed to set key %d\n", i);
>  			continue;
>  		}
>  		if (wdev->connect_keys->def =3D=3D i &&
> -		    rdev_set_default_key(rdev, dev, i, true, true)) {
> +		    rdev_set_default_key(rdev, dev, -1, i, true, true)) {
>  			netdev_err(dev, "failed to set defkey %d\n", i);
>  			continue;
>  		}

Now in this case we probably couldn't have made an MLO connection, can
we? Or maybe we can with full offload firmware? And then should this
really be -1 towards the driver?

Actually - these are WEP keys, so no MLO?

> diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
> index a9767bf..3dd0946 100644
> --- a/net/wireless/wext-compat.c
> +++ b/net/wireless/wext-compat.c
> @@ -470,7 +470,7 @@ static int __cfg80211_set_encryption(struct cfg80211_=
registered_device *rdev,
>  			    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
>  				err =3D -ENOENT;
>  			else
> -				err =3D rdev_del_key(rdev, dev, idx, pairwise,
> +				err =3D rdev_del_key(rdev, dev, -1, idx, pairwise,
>  						   addr);
>  		}
>  		wdev->wext.connect.privacy =3D false;


All of this stuff has me thinking though - now you still need driver
validation, because on an MLO connection the WEXT handlers could be
called?! YUCK!

Maybe we should just prevent all of these handlers on interfaces that
are MLDs, i.e. have valid_links !=3D 0?

I guess that's not really specific to your patch though.

johannes
