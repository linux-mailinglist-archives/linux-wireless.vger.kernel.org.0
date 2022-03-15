Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364964D98F6
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 11:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiCOKmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbiCOKmI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 06:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26BF4506D2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647340856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CBuUkxCn0HKYWUNhwwgJJtc4TQ+XeJrK44DM5yUrDSM=;
        b=iDtmu6zfun9j7vQe+VV9q9f2x6VB5jWddzjlvtRZElK70N4AHV0dm+WmEDZoaxLrYMsNmS
        VCDW9NwZVyoOXm/rPZkSBIlKkPVGG/kXgCwlpoH38/yCcOiDtKJ6bl/dYlUG9LlETJJFL3
        wXD7Jn6bNNYfONZBmb2FibVjdHslqpE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-RtTSy3ewP02icqz8QWQJeQ-1; Tue, 15 Mar 2022 06:40:55 -0400
X-MC-Unique: RtTSy3ewP02icqz8QWQJeQ-1
Received: by mail-wm1-f71.google.com with SMTP id a26-20020a7bc1da000000b003857205ec7cso991992wmj.2
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 03:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CBuUkxCn0HKYWUNhwwgJJtc4TQ+XeJrK44DM5yUrDSM=;
        b=x9TEiqdTodwwDU9Fhi+sCeotFfoeYO6pKeNv1hEK3NYwI5N5pQxcPHXLzrO3pqYWRJ
         hnAkCXqFM5xc30HvNQp8vNWWOLAPE3V79qjXliQPCyg5P6f69eyuWjz057bXUfHBg2tu
         V3NI99M05FAEkw5pi1GB1Nkcwq99ZiPx3k3mAVbTkzPJC2I137/GCOhGFdZLCowHnXPO
         w168WcN14jMs9091YHwWg+eBNCR06BysWHZCt0gBQrpMhu3tBzZ2W6PROCht5eRfrlIB
         BhxCMXtVtGqsM/vG9/hC8GTA5+kMfn4u+97NgCnf19IwmEBVv4joLeORSKJ7dIrPbuun
         /jXA==
X-Gm-Message-State: AOAM530+uCN1IjuPAXv16nSH5vkFbOneg0s1V3U9LTKsNtEZET7UUeii
        lcxZIAw3QkZ0350fm27lemyd3qf3V1S+TSo0BdXbzr35p8t5wkV5WCTnUjYaz4v9+oqLeFBOSTK
        TtgMTbLE4uDahQzT21gQ4u824FgA=
X-Received: by 2002:a05:600c:1554:b0:38c:29ee:610a with SMTP id f20-20020a05600c155400b0038c29ee610amr354647wmg.118.1647340853552;
        Tue, 15 Mar 2022 03:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwU5m59gPSuMYUVa945kakBxvN3Hd8ATteMoPhVaMhODFMnPbC8mZhbBP//saq728WzG8BeQQ==
X-Received: by 2002:a05:600c:1554:b0:38c:29ee:610a with SMTP id f20-20020a05600c155400b0038c29ee610amr354631wmg.118.1647340853322;
        Tue, 15 Mar 2022 03:40:53 -0700 (PDT)
Received: from localhost ([37.183.9.66])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm1928291wmc.25.2022.03.15.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 03:40:52 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:40:50 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, quic_alokad@quicinc.com,
        john@phrozen.org, nbd@nbd.name, ryder.lee@mediatek.com,
        money.wang@mediatek.com, evelyn.tsai@mediatek.com
Subject: Re: [PATCH v14 mac80211-next 1/3] mac80211: MBSSID beacon handling
 in AP mode
Message-ID: <YjBtMps9nEEKuDYT@lore-desk>
References: <cover.1645702516.git.lorenzo@kernel.org>
 <5322db3c303f431adaf191ab31c45e151dde5465.1645702516.git.lorenzo@kernel.org>
 <6a24f667a41dbfba9639f63baa1da4db@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ENzw7ekDMPf1SJXa"
Content-Disposition: inline
In-Reply-To: <6a24f667a41dbfba9639f63baa1da4db@codeaurora.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ENzw7ekDMPf1SJXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2022-02-24 03:54, Lorenzo Bianconi wrote:
> > Add new fields in struct beacon_data to store all MBSSID elements.
> > Generate a beacon template which includes all MBSSID elements.
> > Move CSA offset to reflect the MBSSID element length.
> >=20
> > Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
> > Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> > Co-developed-by: John Crispin <john@phrozen.org>
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
>=20
> Hi Lorenzo,
> Looks like you removed the EMA portion from this ptch.
> Can you please fold that in as well from v13.
> Thanks.
>=20

Hi Aloka,

I remove the EMA part from the series since it was a bit convoluted and I w=
as
not able to test it since mtk fw does not support it for the moment. I guess
you can add it on top of the current series when it is merged.

Regards,
Lorenzo

--ENzw7ekDMPf1SJXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYjBtMgAKCRA6cBh0uS2t
rLyZAP4qI8srhOdqSHK/7fBWPQCNMrZNZPnVz39UEurBZchh0QD9HWz8qbWZFzEi
KQVf7MUYuo21VwAt1RmXpc+TBTrRvAc=
=y21p
-----END PGP SIGNATURE-----

--ENzw7ekDMPf1SJXa--

