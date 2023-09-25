Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296487AD052
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 08:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjIYGic (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 02:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIYGia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 02:38:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D023A9
        for <linux-wireless@vger.kernel.org>; Sun, 24 Sep 2023 23:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=M1hPzSJuLBW1+FWm/Ve3X8Sn0QK2spKaLZ5yy/mAmEE=;
        t=1695623903; x=1696833503; b=GpGNYEhLnlAUDd8bNTDj72YiquVGAUAmTAoYw/zBdfeeEZ2
        +iFV+bnSb6p7m2hBf3M4zJIt0c/k0izJdFpbfqVsUfTyzB+hKXcPdnwPmLzInHZW8N5CIBVPo7Tq2
        C/+R5YE8C/jhLVSmhd6ojUW5kWltfJni1TPOnYkJFfMhIgQ1mhsa1qVm+PtcrLOYYo4eMdjjp8HhR
        wh69rD/JJ79F0XyHEw8t35WsbkkUp7etrj196P+cophBRWU/9vtfbDQirkK7X+o/JPX1cRnNnkp8T
        fBZSvtYr++L8Yrc2n0EcZk0qqc/6fwConnzVbRACvBcuOM6H0hpCjr9psRmrvVdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qkfEW-003DrB-1E;
        Mon, 25 Sep 2023 08:38:16 +0200
Message-ID: <35c14b437f8c4b61e2fc14c6b156bf5de330a493.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: add exported tpt_led_trig function
 for softmac driver
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
Date:   Mon, 25 Sep 2023 08:38:14 +0200
In-Reply-To: <038706d9bbf434642013e880300d4f597f13b514.1695329290.git.yi-chia.hsieh@mediatek.com>
References: <038706d9bbf434642013e880300d4f597f13b514.1695329290.git.yi-chia.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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


> +++ b/include/net/mac80211.h
> @@ -4733,6 +4733,8 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211=
_hw *hw,
>  				   unsigned int flags,
>  				   const struct ieee80211_tpt_blink *blink_table,
>  				   unsigned int blink_table_len);
> +void __ieee80211_tpt_led_trig_trx(struct ieee80211_hw *hw,
> +				  int tx_bytes, int rx_bytes);

Hm, I think you misunderstood what I said.

I still think you need to have a well-documented function or two here,
but now you can make the exported versions of this be inlines calling
this new function.

But also this now fails the build if !CONFIG_MAC80211_LEDS, you need to
have an ifdef somewhere.

> +void __ieee80211_tpt_led_trig_trx(struct ieee80211_hw *hw,
> +				  int tx_bytes, int rx_bytes)
> +{
> +	struct ieee80211_local *local =3D hw_to_local(hw);
> +
> +	if (atomic_read(&local->tpt_led_active)) {
> +		local->tpt_led_trigger->tx_bytes +=3D tx_bytes;
> +		local->tpt_led_trigger->rx_bytes +=3D rx_bytes;
> +	}
> +}
> +EXPORT_SYMBOL(__ieee80211_tpt_led_trig_trx);

Even that won't build.

> --- a/net/mac80211/led.h
> +++ b/net/mac80211/led.h
> @@ -71,8 +71,7 @@ static inline void
>  ieee80211_tpt_led_trig_tx(struct ieee80211_local *local, int bytes)
>  {
>  #ifdef CONFIG_MAC80211_LEDS
> -	if (atomic_read(&local->tpt_led_active))
> -		local->tpt_led_trigger->tx_bytes +=3D bytes;
> +	__ieee80211_tpt_led_trig_trx(&local->hw, bytes, 0);
>  #endif

Ah. Actually what I was thinking is that __ieee80211_tpt_led_trig_trx is
still an inline, and then the ieee80211_tpt_led_trig_trx() exported to
drivers can call this alongside these inlines - that way mac80211 still
gets the (trivial) code inlined.

johannes

