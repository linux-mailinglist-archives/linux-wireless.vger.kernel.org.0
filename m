Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4CD5957CE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 12:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiHPKPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 06:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiHPKPP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 06:15:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6D106F97
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=cOTvXzbW7+WlBywkRhiLReAqb26tVzFv3kdVusjZcnA=;
        t=1660637023; x=1661846623; b=aAB/d2YbQJPDhsGofVaBaPziDBZKZlX7t1unQd4zPSZT44X
        OhbXra0O7FXSFIrRHI00lrTwVoWX8pb6b5qun72vrX3uXKkfeWi7BbF1lsUk6jLhtzfC/SPos3xWm
        ToaUlWZsE6GpvAEQwuUmgSOReTpBMXsX+9KHBrzdXMduVvO5vOW22U+XInsQrbejrGHn4KY40tr0z
        WPxK9Jy8+6y3KiIuyakK2ToWfrb3u69XOTerdyRPgMyKxnpDgP52A0z+uLyoroWvbiJc4Alz8oRxI
        R4Ef8zpc6OmV/bJb6LNgBte5z1H8GA2a7BZGr3qn7pkAWaKKmrmdm/V6vmwmt3hA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oNrXw-009P0n-18;
        Tue, 16 Aug 2022 10:03:32 +0200
Message-ID: <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] wifi: mac80211: allow enabling chanctx until hw
 registration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Date:   Tue, 16 Aug 2022 10:03:29 +0200
In-Reply-To: <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
         <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
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

On Tue, 2022-08-16 at 08:03 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> MT7921 device can be supported with the channel context depending on
> the newer firmware so that we need a way to enable the chanctx related
> methods until hw is being registered.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  net/mac80211/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 5b1c47ed0cc0..98d05ed1a081 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1011,6 +1011,14 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  		return -EINVAL;
>  #endif
> =20
> +	/* check all or no channel context operations exist */
> +	i =3D !!local->ops->add_chanctx + !!local->ops->remove_chanctx +
> +	    !!local->ops->change_chanctx + !!local->ops->assign_vif_chanctx +
> +	    !!local->ops->unassign_vif_chanctx;
> +	if (WARN_ON(i !=3D 0 && i !=3D 5))
> +		return -EINVAL;
> +	local->use_chanctx =3D i =3D=3D 5;
> +

Not sure I understand this - this just *adds* code, based on the
description I would've expected you to *move* code?

In any case, I'm not sure I see how this makes sense - ops is supposed
to be const, and you're supposed to pass it to alloc_hw already, so how
would it change?!

Also, conceptually, I'm not sure why it's needed to alloc_hw before
loading firmware, we also have a lot of things depend on the firmware
capabilities in iwlwifi/mvm, and so we alloc/register HW after loading
firmware.

johannes

