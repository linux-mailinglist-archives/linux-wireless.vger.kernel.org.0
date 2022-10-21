Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62716076B9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJUMNh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUMNf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:13:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2731D
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Z1+hOdsPHyECuypV3QMOiwqB9UN50mHdU+YxzxIWR/4=;
        t=1666354415; x=1667564015; b=l39cVldXt+Aet8nV7zV57ccwDUkocpYPWoJ4Aaqb8DhSGhr
        tvuUenu20vNQb0++bXqzQnV1eQ5xe/+kdIZSdCTYwyYNVb1fvoJrU4b+xZa9iXeoDhCA/Zv9jyduf
        xa26oaLYMdOIQrSJDmKO8S5BEWMcnjxQR2ROh1zcFWoEfoG3mdZaN5t0oYG+QF/Mk5l+mQ3KCFxPB
        +P+JWyh41clzsyWTSe3DtctwE/fHMFyCubWxTk16SQhvlcKtxJGQ3OtHQEnYzVX/FL5JWL9fV/4Rx
        TtMziEIOOM5iGscHOFjQu+2IY1NiMc9BfjZ1te/sL1ybXuwTvFsUXvqp42S6iVmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olqtz-00Cqyq-2c;
        Fri, 21 Oct 2022 14:13:32 +0200
Message-ID: <9d09ce8fa217cdba7a79f4b35e4a4663e3a66e16.camel@sipsolutions.net>
Subject: Re: [RFC 2/4] wifi: nl80211: send underlying multi-hardware channel
 capabilities to user space
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 21 Oct 2022 14:13:26 +0200
In-Reply-To: <20220920100518.19705-3-quic_vthiagar@quicinc.com>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
         <20220920100518.19705-3-quic_vthiagar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
>=20
> +++ b/include/uapi/linux/nl80211.h
> @@ -2749,6 +2749,12 @@ enum nl80211_commands {
>   *	When used with %NL80211_CMD_FRAME_TX_STATUS, indicates the ack RX
>   *	timestamp. When used with %NL80211_CMD_FRAME RX notification, indicat=
es
>   *	the incoming frame RX timestamp.
> + *
> + * @NL80211_ATTR_MULTI_HW_MACS: nested attribute to send the hardware ma=
c

Not sure I'd call this multiple MACs? It's multiple devices in some
sense, but from a spec POV at least, I'd think our NIC also has multiple
MACs when it doesn't use this infrastructure. Might get a bit confusing?

Maybe just stick to "multi_hw" or so?

> +/**
> + * nl80211_multi_hw_mac_attrs - multi-hw mac attributes
> + *
> + * @NL80211_MULTI_HW_MAC_ATTR_INVALID: invalid
> + * @NL80211_MULTI_HW_MAC_ATTR_IDX: (u8) array index in wiphy @hw_chans t=
o refer an
> + *	underlying hw mac for which the supported channel list is advertised.

I'd prefer this to be primarily written from a userspace POV, so the
whole "@hw_chans" etc isn't really right. Maybe say something like

"(u8) multi-HW index used to refer to an underlying HW ...; internally
the index of the wiphy's @hw_chans array."

or so?

> + * @NL80211_MULTI_HW_MAC_ATTR_FREQS: array of supported center frequenci=
es

FWIW, Jakub has started advertising for using the same attribute
multiple times to have arrays, so you'd just have

 {NL80211_MULTI_HW_ATTR_FREQ: 2412},
 {NL80211_MULTI_HW_ATTR_FREQ: 2417},
 {NL80211_MULTI_HW_ATTR_FREQ: 2422},

etc. in the message. Not sure we want to try that here, but it'd also
simplify splitting messages for dumps.


> +static int nl80211_put_multi_hw_support(struct wiphy *wiphy,
> +					struct sk_buff *msg)
> +{
> +	struct nlattr *hw_macs, *hw_mac;
> +	struct nlattr *freqs;
> +	int i, c;
> +
> +	if (!wiphy->num_hw)
> +		return 0;
> +
> +	hw_macs =3D nla_nest_start(msg, NL80211_ATTR_MULTI_HW_MACS);
> +	if (!hw_macs)
> +		return -ENOBUFS;
> +
> +	for (i =3D 0; i < wiphy->num_hw; i++) {
> +		hw_mac =3D nla_nest_start(msg, i + 1);
> +		if (!hw_mac)
> +			return -ENOBUFS;
> +
> +		if (nla_put_u8(msg, NL80211_MULTI_HW_MAC_ATTR_IDX, i))
> +			return -ENOBUFS;
> +
> +		freqs =3D nla_nest_start(msg,
> +				       NL80211_MULTI_HW_MAC_ATTR_FREQS);
> +		if (!freqs)
> +			return -ENOBUFS;
> +
> +		for (c =3D 0; c < wiphy->hw_chans[i]->n_chans; c++)
> +			if (nla_put_u32(msg, c + 1,
> +					wiphy->hw_chans[i]->chans[c].center_freq))
> +				return -ENOBUFS;

Ah you used a nested array even.

So the argument for using a real array would've been that it's smaller,
but I guess with nested that argument goes way.

Would you mind trying Jakub's preferred approach here and see how that
works out?

For the generator basically you'd just have

hw_mac =3D nla_nest_start();
nla_put_u8(IDX, i)
for (c =3D 0; c < ...; c++)
	nla_put_u32(MULTI_HW_ATTR_FREQ, ...->chans[c].center_freq);


johannes
