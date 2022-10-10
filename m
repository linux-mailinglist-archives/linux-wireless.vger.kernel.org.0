Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953A95FA222
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJJQpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJJQpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 12:45:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678D70E4B
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GjYDrYuqUk4qSyT0EJEdKPGfktC9nVTm0zzwdHhlr+4=;
        t=1665420325; x=1666629925; b=TPpbVrex73JTdf3xHTcZaA6lUhb1KkMme5y1yLscPCF80v3
        xlNLbTNFnXJ4cikauk5sdCzBcQIRcgQfyYNqfX/dVTvqDWnpUeEjEFhGbm09ySkGau2ZKrcW/05bM
        ojokAmq6HOBqHBYfvNShknempdGr/04LtNLq8ku5t3WNkAT7+toV5HQfKHFk0LY4/uOlDZUrq7Uvj
        oc+SJSblrjeybu6Mve0Uo/FVLlhSj++s+4QxBdABG996g8JOn6DsBfnIwR3wzaTt4QEhZjhItBmdv
        bcl+84nA0X+L1yf95LfOHoubCzCtPMp1PdiYyQOtVXnDv/U7c2n5RBdDuG7b2g/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ohvu6-00383b-2o;
        Mon, 10 Oct 2022 18:45:23 +0200
Message-ID: <35c743cf4468bcf5ebbbefd2bf6e3faae9cdd1cf.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] wifi: mac80211: add wake_tx_queue callback to
 drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alexander@wetzel-home.de
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 10 Oct 2022 18:45:21 +0200
In-Reply-To: <20221010161621.1855515-1-martin.blumenstingl@googlemail.com>
References: <20221009163040.25637-2-alexander@wetzel-home.de>
         <20221010161621.1855515-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Mon, 2022-10-10 at 18:16 +0200, Martin Blumenstingl wrote:
> [...]
> > diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/ne=
t/wireless/realtek/rtw88/mac80211.c
> > index 07578ccc4bab..bf917ef20e3b 100644
> > --- a/drivers/net/wireless/realtek/rtw88/mac80211.c
> > +++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
> > @@ -896,6 +896,7 @@ static void rtw_ops_sta_rc_update(struct ieee80211_=
hw *hw,
> > =20
> >  const struct ieee80211_ops rtw_ops =3D {
> >  	.tx			=3D rtw_ops_tx,
> > +	.wake_tx_queue		=3D ieee80211_handle_wake_tx_queue,
> >  	.wake_tx_queue		=3D rtw_ops_wake_tx_queue,
> >  	.start			=3D rtw_ops_start,
> >  	.stop			=3D rtw_ops_stop,
> > diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/ne=
t/wireless/realtek/rtw89/mac80211.c
> > index a296bfa8188f..91674c63b9f9 100644
> > --- a/drivers/net/wireless/realtek/rtw89/mac80211.c
> > +++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
> > @@ -918,6 +918,7 @@ static int rtw89_ops_set_tid_config(struct ieee8021=
1_hw *hw,
> > =20
> >  const struct ieee80211_ops rtw89_ops =3D {
> >  	.tx			=3D rtw89_ops_tx,
> > +	.wake_tx_queue		=3D ieee80211_handle_wake_tx_queue,
> >  	.wake_tx_queue		=3D rtw89_ops_wake_tx_queue,
> >  	.start			=3D rtw89_ops_start,
> >  	.stop			=3D rtw89_ops_stop,
>=20
> For rtw88 and rtw89 the wake_tx_queue callback is now duplicated.
> I'm not sure if other drivers are affected as well.
>=20

Ouch. I looked at a whole bunch of them, how did that not cause a
compiler warning??

I'll check and fix.

johannes
