Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8D698278
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBORnS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 12:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBORnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 12:43:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8D21284
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=thkmbSvo++vteVUZ4wrW/o6bEV8amItdP0fgdfx7U0g=;
        t=1676482997; x=1677692597; b=dgmSd8KX7/HRmAhMlwiiRfJ0MFNb36Si+PpP9XnCwwyX3zI
        9pUBdFsR5czroPq2+YFgoj9y3UGeULV7vyRB2GGmAK9sFcZLnelaCxrfecQiB5IGMmSzDuAFc0y7i
        teCwMz1L1fgRU2L7Vs843RgAtS0NpkiallpAcZey9xidtzTm7z7YxrVhZcCkS2+XVewrC/J4mEOzh
        zXD+A3JYSIWot6Pmv9tO85iSqC9M1da/oKfPeXD6W2ab2Wg60gHVYzgSNtjtSmzpOFUV8ryoY0qdN
        OlQt5EfO4ub/UfFAPU5o+KloW7t3mqAfAx+kRTeJNGIZLagi1rMdmCD5HBFP5EXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSLoI-00D9VL-0t;
        Wed, 15 Feb 2023 18:43:14 +0100
Message-ID: <165dcb98f58e8d6049d89d8e4ebb326b8fe631b8.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211: add LDPC related flags in
 ieee80211_bss_conf
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
Date:   Wed, 15 Feb 2023 18:43:10 +0100
In-Reply-To: <4e5cff1c538cbd9ecca171e0e4d6fddd87c3dfa0.1675893838.git.ryder.lee@mediatek.com>
References: <c1a6ef2f42e26a6e0473d4fb2ce1b572f8448d87.1675893838.git.ryder.lee@mediatek.com>
         <4e5cff1c538cbd9ecca171e0e4d6fddd87c3dfa0.1675893838.git.ryder.lee@mediatek.com>
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

On Thu, 2023-02-09 at 06:09 +0800, Ryder Lee wrote:
> This is utilized=C2=A0to pass LDPC configurations from user space (i.e. h=
ostap) to driver.

again, hostapd

why do we need this?

> + * @ht_ldpc: in AP mode, indicates interface owns HT LDPC capability.
> + * @vht_ldpc: in AP mode, indicates interface owns VHT LDPC capability.
> + * @he_ldpc: in AP mode, indicates interface owns HE LDPC capability.

what do you mean by "owns" the capability? Has? Uses it?

> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 6bf1cdf254f6..a080010da8fb 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -1252,7 +1252,16 @@ static int ieee80211_start_ap(struct wiphy *wiphy,=
 struct net_device *dev,
>  	prev_beacon_int =3D link_conf->beacon_int;
>  	link_conf->beacon_int =3D params->beacon_interval;
> =20
> +	if (params->ht_cap) {
> +		link_conf->ht_ldpc =3D
> +			params->ht_cap->cap_info &
> +				cpu_to_le16(IEEE80211_HT_CAP_LDPC_CODING);
> +	}

No need for braces.

johannes
