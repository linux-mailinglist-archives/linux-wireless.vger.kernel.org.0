Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30196673DAC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjASPhw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjASPhv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:37:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6171F32
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OGGEXbyKS9wqbA1IkVYZCIHmPl/0bDdj8GS5ATLb7p4=;
        t=1674142670; x=1675352270; b=wlr7BrgczQ67k5nB2NDBdB2QgeDC7EJ4MvJohF0ukPJBR1G
        UzeH7s1mGFixQFVkd0D55wqDJjSngqomqAmUEl0Tf06Oc1zWJEEkMgW+Wfp+g3zbc64zRJMZWuSNg
        ExsRdWMNBFbPm/JYZk7HOyG3zdWyiwfQMM2qb3TXdl0kkIZm4KJen+xhQEOFGiEahrOPH7mJiGSeo
        U3nfQJeNwKuJdmk3aA2LgljLN+K4i/y0uuzKoYGtIb1jIz6A5H5CChkAoWgwv+TY/pERNP34vPD5s
        R5kYbsOPof+uieBCicLuCtqMqxsn5w8je7o5QerAmDTAqb6ajIOKnNISIOBSP9WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIWz6-006Yuw-1A;
        Thu, 19 Jan 2023 16:37:48 +0100
Message-ID: <3df39d4f2e2e64bd3899cfbe7bade547e54330f7.camel@sipsolutions.net>
Subject: Re: [RFC 3/4] wifi: nl80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>
Date:   Thu, 19 Jan 2023 16:37:47 +0100
In-Reply-To: <1670006154-6092-4-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
         <1670006154-6092-4-git-send-email-quic_msinada@quicinc.com>
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

On Fri, 2022-12-02 at 10:35 -0800, Muna Sinada wrote:
>=20
> +	[NL80211_ATTR_RU_PUNCT_SUPP_HE] =3D { .type =3D NLA_FLAG },
> +	[NL80211_ATTR_RU_PUNCT_BITMAP] =3D { .type =3D NLA_U16 },


I feel like at least in the API we should make that bigger already,
maybe U32 or even U64, at some point they're going to come up with wider
channels... should use NLA_RANGE or something to restrict it for now
though.


> +static int nl80211_parse_ru_punct_bitmap(struct cfg80211_registered_devi=
ce *rdev,
> +					 struct net_device *dev,
> +					 struct genl_info *info,
> +					 struct vif_params *params)
> +{
> +	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
> +	bool change =3D false;
> +
> +	if (info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]) {
> +		params->ru_punct_bitmap =3D
> +			 nla_get_u16(info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]);
> +
> +	if (!params->ru_punct_bitmap)
> +		return change;
> +
> +	params->ru_punct_bitmap_supp_he =3D
> +		nla_get_flag(info->attrs[NL80211_ATTR_RU_PUNCT_SUPP_HE]);
> +
> +	if (!rdev->wiphy.ru_punct_supp_bw &&
> +	    (params->ru_punct_bitmap || params->ru_punct_bitmap_supp_he))
> +		return -EOPNOTSUPP;
> +
> +	changed =3D true;

That doesn't even compile, right? :)

But you can get rid of the 'change' variable entirely.

> @@ -4175,6 +4209,12 @@ static int nl80211_set_interface(struct sk_buff *s=
kb, struct genl_info *info)
>  		params.use_4addr =3D -1;
>  	}
> =20
> +	err =3D nl80211_parse_ru_punct_bitmap(rdev, dev, info, &params);
> +	if (err < 0)
> +		return err;
> +	else if (err > 0)
> +		change =3D true;
>=20

Frankly I'm not happy for this to be stuck into set_interface() like
that - can we add it to set_channel() only or something? At least there
should be too? And read it only if the channel is actually touched? This
feels very ad-hoc.

johannes
