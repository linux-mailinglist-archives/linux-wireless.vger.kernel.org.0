Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C4673DBA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjASPk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 10:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjASPkx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 10:40:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CD83844
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 07:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H+v1oPQi0eWbrLdEl43IuNda6IyQKSkyUvMsbkrKPJo=;
        t=1674142850; x=1675352450; b=Bk+O2Uic/87L25YZb4MypHRDvKe561VZGSZpYG8i0wmDyBt
        Zk8hbMC1+5r88Xm0szI1w/hCZsj8jYMeX7rk10ui9q/x7Ir4B/wFm/qDxhfOexKckvJtHEsj5hsmy
        wSWBUWDkZP9sJYxgS0EfzohGOnTsd9zLiMfAHTmLyImpx5SjBIHa7qjY7rkb3rZZ3RLaKKprz7xHg
        V4ox42oN2gfbVlOwJhNUQDbDUYxWOg1tqedZDpPvm+rdSUeTiaXqUEaXJJCWv5S7rFb1xQYXiwUgb
        CKxKQLWTgEsVbFCXVdPVssw+Xh0Vdfjcd1q8ssUhzc/7tNH++zCdrSuZ+RQMZ9eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIX1z-006Yyt-2E;
        Thu, 19 Jan 2023 16:40:47 +0100
Message-ID: <4ce75ba96bcfe5cd35f524d881124cb0defdb6aa.camel@sipsolutions.net>
Subject: Re: [RFC 4/4] wifi: mac80211: Handle RU Puncturing information
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 16:40:46 +0100
In-Reply-To: <1670006154-6092-5-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
         <1670006154-6092-5-git-send-email-quic_msinada@quicinc.com>
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
> Handle RU Puncturing information received from user space.
> RU Puncturing bitmap is initially received during
> ieee80211_change_iface() and stored. During AP chanwidth setting,
> the bitmap is validated. In addition driver is notified of new bitmap
> value.


"initially" is a bit of a problem, right?


> @@ -213,6 +213,12 @@ static int ieee80211_change_iface(struct wiphy *wiph=
y,
>  	struct sta_info *sta;
>  	int ret;
> =20
> +	sdata->vif.bss_conf.ru_punct_bitmap =3D params->ru_punct_bitmap;
> +	sdata->vif.bss_conf.ru_punct_bitmap_supp_he =3D params->ru_punct_bitmap=
_supp_he;

I mean this can happen at any point in time due to the way you've wired
it up in nl80211 (which I'm not happy about), and then ... it just gets
ignored.

> +	if (!sdata->vif.bss_conf.ru_punct_bitmap)
> +		sdata_dbg(sdata, "RU Puncturing Bitmap was not set by user\n");
> +

?

> @@ -1251,6 +1257,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, =
struct net_device *dev,
>  	prev_beacon_int =3D link_conf->beacon_int;
>  	link_conf->beacon_int =3D params->beacon_interval;
> =20
> +	sdata->vif.bss_conf.ru_punct_bitmap =3D dev->ieee80211_ptr->ru_punct_bi=
tmap;

Why grab only one of them here? In fact why grab them at all?

I think you really need to work on the API here.

Also this completely ignores links ... so it's wrong for that too. Must
use link_conf->...

johannes
