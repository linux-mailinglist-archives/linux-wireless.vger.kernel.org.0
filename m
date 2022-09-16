Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46BD5BB14B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIPQvG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIPQvF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 12:51:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E6EAA3DC
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hdQ0vxWCf/i69ElmKkr7pvNCrQZ7ifmqgzMKPZJaKoM=;
        t=1663347064; x=1664556664; b=ZN0xAQHomkjKjF0K07pT812ZVCwnVHVNUEtFGUxP+TCpyG9
        ebYs2uwHY8hxuRdlGt8wBbivOmDfuwHZJHgkjRMRt6W0QcFUeexU3N2CzwmBjTdEHLpguLJRfv7W9
        MvwxNUXFaUlwBd0fKWMhEyDHHe1GLk2wouQFQAek36iPAF+p77S6gt1aqlRYVu9PX4s23nbbY93GS
        AQrOzkhZ1ulGHE5HvV3dWgm2iBBBYGA03qTWRrue6zdFWeqfz+9Va5uhErEh9vyl6oIm8Z0MynT5I
        c6jaQcdgHGrl6lI9RUx1o4RulEyEQM4a5pITZv4ummqL1qgM9lC6dTezfvql4jmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oZEYM-000fxL-2E;
        Fri, 16 Sep 2022 18:50:59 +0200
Message-ID: <014de3ef48c3a12bf134e7cef967153665c84d6a.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Align with Draft P802.11be_D1.5
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Howard Hsu <howard-yh.hsu@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Fri, 16 Sep 2022 18:50:55 +0200
In-Reply-To: <20220916141700.28378-1-howard-yh.hsu@mediatek.com>
References: <20220916141700.28378-1-howard-yh.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Fri, 2022-09-16 at 22:17 +0800, Howard Hsu wrote:
> Fix ieee80211_prep_channel to aligh with Draft P80211.be_D1.5. It shall
> shift 4 byte to fetch EHT Operation information.
>=20
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> ---
>  net/mac80211/mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index ff449e0c2e62..9bb085eab12a 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -4735,7 +4735,7 @@ static int ieee80211_prep_channel(struct ieee80211_=
sub_if_data *sdata,
>  						   cbss_ies->data, cbss_ies->len);
>  		if (eht_oper_ie && eht_oper_ie[1] >=3D
>  		    1 + sizeof(struct ieee80211_eht_operation))
> -			eht_oper =3D (void *)(eht_oper_ie + 3);
> +			eht_oper =3D (void *)(eht_oper_ie + 4);
>=20


No, the +3 is just to skip the type/len/ext-tag

johannes
