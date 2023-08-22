Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B9784082
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjHVMPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjHVMPw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:15:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630DD1BE
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NilICWeyqYWrREBgq7q7i2zZQeSD/nrekC6rhMzBxhc=;
        t=1692706551; x=1693916151; b=sZNWGo1OpRTiEFKPCnJTEbW0R7vmUKC3U0ftH6qAOqV4ypP
        b5P+rlV8b+6aeNEZNpd3OX3l5Wy2s87wSQWI7arfaJsL8sz6dtYAOr7BxITTIF3Vut6DJ3r7Yeoux
        BG7DlwgTYDqpKy0iLYqM0Jt0JETxv0Z8w2TLm6onCBzif5zDrDo+AIXND0ovMWGXv9znssBBMu3C3
        AKcvdm7pdGeGmqz5PGkvCpMEVWaDnKLyuXzhwr66Q85Z1cnX/nyxthkdhLcUEb+hDnvcf2xmzJMiE
        85szIEFGIQwqPezQS9cWV+ejAS39xLMpmt2J2U6yp/AX+V79PcqveIea/am4T05w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qYQIU-0056u8-2J;
        Tue, 22 Aug 2023 14:15:46 +0200
Message-ID: <339891ad481cfdcfa48a726da80202b3121a6000.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: do not ignore the value returned
 by nla_put_u32()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Tue, 22 Aug 2023 14:15:45 +0200
In-Reply-To: <20230814092128.14330-1-dmantipov@yandex.ru>
References: <20230814092128.14330-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-08-14 at 12:21 +0300, Dmitry Antipov wrote:
> In 'mac80211_hwsim_vendor_cmd_test()', do not ignore the value
> returned by 'nla_put_u32'. This follows commit b970ac68e0c4
> ("wifi: mac80211_hwsim: check the return value of nla_put_u32").
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/=
wireless/virtual/mac80211_hwsim.c
> index f446fd0e8cd0..2a3393a47bf2 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -597,9 +597,9 @@ static int mac80211_hwsim_vendor_cmd_test(struct wiph=
y *wiphy,
>  	/* skb_put() or nla_put() will fill up data within
>  	 * NL80211_ATTR_VENDOR_DATA
>  	 */
> -	nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 2);
> +	err =3D nla_put_u32(skb, QCA_WLAN_VENDOR_ATTR_TEST, val + 2);
> =20
> -	return cfg80211_vendor_cmd_reply(skb);
> +	return err ? err : cfg80211_vendor_cmd_reply(skb);
>=20

You can use ?: here, but more importantly, this introduces a memory
leak.

johannes
