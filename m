Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFCE632009
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 12:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKULO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 06:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKULOK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 06:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FFBE863
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669028895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+hS5Wzvy+tgi/lKBcaZFtWi/x76gJ+HRemIeEuqod0=;
        b=LvqW1uzh7xsP9l6QKlVo2ic1imvGlz7t6gBJE6uRg0eHtTCwzltJyLVwOhvHGDWI0N8YZO
        dXaTPOhGT9NEN9lVfjlhk705NBCuUZGqwvlNvgWSVbuvqi8ye3HCZw+2ZdlvwxQiw8KU0L
        xs934Pol754d/SDm5jHjuiihfKp2EKY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-RWYglFGUM-a2mafO4Xc3Rg-1; Mon, 21 Nov 2022 06:08:14 -0500
X-MC-Unique: RWYglFGUM-a2mafO4Xc3Rg-1
Received: by mail-pj1-f72.google.com with SMTP id c10-20020a17090aa60a00b00212e91df6acso5821154pjq.5
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 03:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+hS5Wzvy+tgi/lKBcaZFtWi/x76gJ+HRemIeEuqod0=;
        b=nZIyPz1nirNvqc+vJ0S/fJ1wDsmYsInnJlbKPBdoK8M01gu0tidsiii2C67UhBFqW1
         wQWeLz3bR5BNZd/AMYWZhT3Pm/f7Hi0zGf3tqceCSmJ3w24sFJ9RqkfL5kgrfrYqEaoN
         NkO77ueIqC9IFzDw7kF73cAur+cVB4SCKkcYxY6EBI8S+zGwywe0xI2rtHp0oxVZwoBI
         PyHYIyOVn+rXYKgd11YJQjfxUVHnTLe4+6Un/5n2O7H7vP4AQiUa4aabywLin9RVaFwY
         uo7gmbf0xqiaUzH3fKF7lOqt5o4Uv765OA78pstAOMdCPk6udJMLtr8NPo9+USc5+vg9
         yPug==
X-Gm-Message-State: ANoB5pkwA9bt+HannDZ4X5d0quVklwImKB7gu1siQ3bw36iYfjwLFcYN
        IgvwbSSD6cLHIFz9P5dm5Z3Sj6nQaOMGabkArwcbFTekoNqvRh2rVAhgFfcDYMZMEkZcFUCUqhZ
        EGKAln/+RUPg8KnBEV5iXTLoKkGApJfvA2mukUDBFUF4=
X-Received: by 2002:a17:902:ec01:b0:186:a27d:8e81 with SMTP id l1-20020a170902ec0100b00186a27d8e81mr11240129pld.133.1669028893052;
        Mon, 21 Nov 2022 03:08:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wXoXKtXWP56fuwVrUAnaldXLeUzJ5VYY2hYxD6WCgQh5rXKJhcsrbgHQGM3Zev6E8w7fKzhJhei8cEHFBqUs=
X-Received: by 2002:a17:902:ec01:b0:186:a27d:8e81 with SMTP id
 l1-20020a170902ec0100b00186a27d8e81mr11240102pld.133.1669028892753; Mon, 21
 Nov 2022 03:08:12 -0800 (PST)
MIME-Version: 1.0
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
 <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
 <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
 <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
 <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com> <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
In-Reply-To: <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 21 Nov 2022 12:08:01 +0100
Message-ID: <CACT4oufZpLToemYLHcnQ+hAa=SAbhJT0QxKYjs9fNWV8frsMtg@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 21, 2022 at 11:42 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Mon, 2022-11-21 at 09:32 +0100, =C3=8D=C3=B1igo Huguet wrote:
> >
> > > --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > > @@ -1119,6 +1119,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime =
*fwrt, union iwl_ppag_table_cmd *c
> > >          int i, j, num_sub_bands;
> > >          s8 *gain;
> > >
> > > +       /* many firmware images for JF lie about this */
> > > +       if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) =3D=3D
> > > +           CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
> > > +               return -EOPNOTSUPP;
> > > +
> > >          if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_S=
ET_PPAG)) {
> > >                  IWL_DEBUG_RADIO(fwrt,
> > >                                  "PPAG capability not supported by FW=
, command not sent.\n");
> > >
> > >
> > > johannes
> > >
> >
> > Sorry for the delay with this, I had some issues with the hardware.
> >
> > Using this workaround it doesn't show any errors and I can connect.
>
> OK.
>
> > However, using iwlwifi-QuZ-a0-jf-b0-74 from linux-firmware I get lots
> > of errors, both with this patch applied and without it. Maybe the
> > driver needs some changes?
> > I get stack traces, fw dumps and message `iwlwifi 0000:00:14.3: Failed
> > to send MAC context (action:1): -5`
>
> Probably some other error?
>
> > What would you recommend to do? It seems you didn't like this solution
> > very much (and, as I say, it doesn't work with fw 74)
>
>
> Well I think we still need this solution even if I didn't like it, and

Will you post the patch?

> the fw 74 seems to be a different issue - could you post more info about
> separately?

Sure, will do in a few hours, thanks!

>
> johannes
>


--=20
=C3=8D=C3=B1igo Huguet

