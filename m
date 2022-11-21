Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144A2631B7C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKUIdi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 03:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKUIdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 03:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8526D8
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 00:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669019561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mUjxyZm4bf6OXy+M0eYpXbYeaYwNkkTkGVWURuKWwFs=;
        b=F2y+osKkAFcCCLEOhQtbOSMi/favRMY4Wc0dDAojRPPgzwqnUE75Qqh8EQkOzxoXp+0W2D
        agUQ1HJVV3wL4QEbGHTVzjo0KzF8HoLVYyLXG2Y+0YSDelJdJlFziRblVSeh4aybPeIAA6
        DMkb5kLT3Y2pKV7TosFDAcvQlr780lE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-v1fQe8qdMXay5QTkh1W0JA-1; Mon, 21 Nov 2022 03:32:39 -0500
X-MC-Unique: v1fQe8qdMXay5QTkh1W0JA-1
Received: by mail-pl1-f197.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so8977674plh.12
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 00:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUjxyZm4bf6OXy+M0eYpXbYeaYwNkkTkGVWURuKWwFs=;
        b=3JhY+ddRWwfOc4mEoYPAfP4hUcG9gs+Nkac7vOJ/VQGY885fSjfexdQ8vaM+ZnETvf
         yYUhXhG/14JLzH1N3n4zjvBpafo06zcmzKniiU37zzHZbLTRoeLr4XWghIsrWB+wuo9a
         LGVau1AlQfZYx//x/eCIWAShcVf5Q0as3pXHGJiqqyGVwsUeBmjgm7EUc5oyn0TgO8F3
         Y2NY0IZpWWo0qUSDuCJwzI5pNCGpNaVmFXpAjzFLh2fRsFWc3BdcLpqgQfKheJA5gDGl
         ztJc9Q/HTgMENuBLgyFL/x5PQ5gArrbQgZAqplMRo3JoPjKstzlAfYYSDJqfhJBdEvgL
         DHqQ==
X-Gm-Message-State: ANoB5plHXRNWzU6s2rRbQ7fmPJjbQNWf5w8WYjMbEYme4sNjNm3wvbym
        +FYKMQSfeXIt60LpLCmH28k2x+dmhj9yaawurhMxQTXqiwaXUv3ExkDmOONuLfrfpZ4IMta4bp7
        hfyrnF1mhbOfckm8D0G6m1DULHhihaCVYimqP+i7C2BY=
X-Received: by 2002:a62:1d05:0:b0:56b:a0f4:decc with SMTP id d5-20020a621d05000000b0056ba0f4deccmr3700393pfd.33.1669019558564;
        Mon, 21 Nov 2022 00:32:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Y0MdiZQcjiiIrvjhe9UwkMeOFVr4gZrJVlsD14N+QNlAq3C/YmTnSYeUbtXOR72xXUr2Mm52oSXY2tM28rN8=
X-Received: by 2002:a62:1d05:0:b0:56b:a0f4:decc with SMTP id
 d5-20020a621d05000000b0056ba0f4deccmr3700372pfd.33.1669019558251; Mon, 21 Nov
 2022 00:32:38 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com> <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
In-Reply-To: <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 21 Nov 2022 09:32:26 +0100
Message-ID: <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0 versions
 above 55
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 5, 2022 at 12:07 PM Johannes Berg <johannes@sipsolutions.net> w=
rote:
>
> On Wed, 2022-10-05 at 11:50 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > On Wed, Oct 5, 2022 at 11:35 AM Johannes Berg <johannes@sipsolutions.ne=
t> wrote:
> > >
> > > On Fri, 2022-09-09 at 12:41 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > > > With an AC9560 installed on a system with Quasar (11th gen processo=
r,
> > > > in my case) we're getting a firmware crash as soon as you try to do
> > > > something with the card. The problem doesn't happen with the card
> > > > installed in older platforms (8th / 9th gen), and it neither happen=
s
> > > > with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any oth=
er
> > > > newer version.
> > > >
> > > > I've tried different versions of kernel and firmware, including the
> > > > latest kernel and linux-firmware available today, and all of them f=
ail
> > > > unless I remove all fw files above version 55.
> > > >
> > >
> > > I believe this is a duplicate of
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D214343
> > >
> > > which was supposed to be fixed in firmware, but evidently that fix wa=
s
> > > never backported to older images.
> > >
> > > Internally, FW commit d8887278 fixed this, so FW version 69 should be
> > > OK?
> >
> > I don't think so, we've reproduced it with iwlwifi-QuZ-a0-jf-b0-71.ucod=
e
> >
>
> Indeed, my git-fu was bad. Looks like 74 only fixes it (or will, since
> it hasn't been released, apparently).
>
> We could do some awful workaround like this I guess:
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/w=
ireless/intel/iwlwifi/fw/acpi.c
> index 009a4074d062..0c0a28d748f2 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> @@ -1119,6 +1119,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwr=
t, union iwl_ppag_table_cmd *c
>          int i, j, num_sub_bands;
>          s8 *gain;
>
> +       /* many firmware images for JF lie about this */
> +       if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) =3D=3D
> +           CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
> +               return -EOPNOTSUPP;
> +
>          if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_P=
PAG)) {
>                  IWL_DEBUG_RADIO(fwrt,
>                                  "PPAG capability not supported by FW, co=
mmand not sent.\n");
>
>
> johannes
>

Sorry for the delay with this, I had some issues with the hardware.

Using this workaround it doesn't show any errors and I can connect.

However, using iwlwifi-QuZ-a0-jf-b0-74 from linux-firmware I get lots
of errors, both with this patch applied and without it. Maybe the
driver needs some changes?
I get stack traces, fw dumps and message `iwlwifi 0000:00:14.3: Failed
to send MAC context (action:1): -5`

What would you recommend to do? It seems you didn't like this solution
very much (and, as I say, it doesn't work with fw 74)
--
=C3=8D=C3=B1igo Huguet

