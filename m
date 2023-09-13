Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A518D79E48D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbjIMKGT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbjIMKGS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 06:06:18 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFDF19B3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=E5/3EokUL9b/oTCtDJRyvfxwFJp1yaX0dODpevqohlw=;
        t=1694599574; x=1695809174; b=aMkIcOypvvHxRlpO8WISmdpbiiYyCRYYh7AisIh6frMmr+R
        h4XXsnmzZavEcx49dGBiP/WC5FTTPS/7LsTuw5wajR9IUUJF8/9259sX4xZ04LkUegTXHSMXWdPBC
        VVc7CrQLiHbDyyvNPe3TsSr4BIP1L+qFIGpdee0FhiyGgVAD3CfvXboSSzHXNlnh2/t7xWV9zEjvq
        6wDzK9xwUW90SmzTykncpRgkIB/jQq6sv1RvDn0sLUDGl7buM7ZJ/QMq2+WVB8766kTR1x/axEe3s
        ok3hmWtinaqSmFIXXoHl25Ylxj6zjFKzpjK0GjtE0eiRbIkhhmQVeIa3u8q4puKg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgMl2-00Elhu-29;
        Wed, 13 Sep 2023 12:06:04 +0200
Message-ID: <31eb0df432f813453b487ae8fdc26a9402c448fa.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: export ieee80211_tpt_led_trig_tx/rx
 for driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 13 Sep 2023 12:06:01 +0200
In-Reply-To: <a887a7bb660837cbb3466e183d1714364d8ba9fe.1693549288.git.yi-chia.hsieh@mediatek.com>
References: <a887a7bb660837cbb3466e183d1714364d8ba9fe.1693549288.git.yi-chia.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +++ b/net/mac80211/led.c
> @@ -319,6 +319,24 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211_=
hw *hw,
>  }
>  EXPORT_SYMBOL(__ieee80211_create_tpt_led_trigger);
> =20
> +void __ieee80211_tpt_led_trig_tx(struct ieee80211_hw *hw, int bytes)
> +{
> +	struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +	if (atomic_read(&local->tpt_led_active))
> +		local->tpt_led_trigger->tx_bytes +=3D bytes;
> +}
> +EXPORT_SYMBOL(__ieee80211_tpt_led_trig_tx);
> +
> +void __ieee80211_tpt_led_trig_rx(struct ieee80211_hw *hw, int bytes)
> +{
> +	struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +	if (atomic_read(&local->tpt_led_active))
> +		local->tpt_led_trigger->rx_bytes +=3D bytes;
> +}
> +EXPORT_SYMBOL(__ieee80211_tpt_led_trig_rx);
>=20

It feels a bit wasteful to export not one but even two functions for
this ...

The trigger only really cares about the sum of the two, so maybe we
shouldn't really care too much, even in mac80211? I think the only
reason we currently separate RX and TX is that they can run
concurrently, but the truth is that it already can race anyway, at least
if you have multiple interfaces ...

So maybe we should just switch to a single counter, and accept that we
may sometimes lose an update?

Also this seems wasteful for mac80211 internals, so maybe instead add
triple-underscore versions that are still inline and called from the
double-underscore versions as well as the existing mac80211 callers.

What do you think?

johannes
