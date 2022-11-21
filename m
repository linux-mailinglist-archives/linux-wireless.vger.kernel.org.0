Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C7631E9E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 11:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKUKmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 05:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKUKml (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 05:42:41 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A22DAE;
        Mon, 21 Nov 2022 02:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YbtrL6oUKk/Wz0uuXLFQJ/MMRALjqxvQYvY7zaXL9bE=;
        t=1669027359; x=1670236959; b=eW3+z8exmCHkF1e4xKnEItEjf9bHyRgRFtCrB0rSS7EXMUr
        iEuRwUuEhdpoxe5WKjczrh9uBzrcNqY9faTuU4NEpEtd8BhUfdVL1oCij4R/Pr+5GvgLnWIro8jI1
        SQifjtXMVWkwP3yx1hPlojI2lJ5PoiFQwjnSqTbSZUJPYv/9CGXCdwoaDOe16DDyl/xRhV/nNEZy7
        jidRUIWiGzGPgYvdOZ9YkMaLFo4cv2aJuscw7/59GD9kZCpCMxpqZVgP+zuRkC/QPBb3CYf1Vm/u1
        f6ZjICpMIE6N7WVIWH0k977HWecI4TOsHCJ4qhZPvigb6w0jsXd4lgLId1PGqkOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ox4Fz-005S2A-2R;
        Mon, 21 Nov 2022 11:42:31 +0100
Message-ID: <122752227576c059d2b1660934d57e991e7d33c8.camel@sipsolutions.net>
Subject: Re: iwlwifi: AC9560 firmware crash with iwlwifi-QuZ-a0-jf-b0
 versions above 55
From:   Johannes Berg <johannes@sipsolutions.net>
To:     =?ISO-8859-1?Q?=CD=F1igo?= Huguet <ihuguet@redhat.com>
Cc:     gregory.greenman@intel.com, golan.ben.ami@intel.com,
        jonathan.sade@intel.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Laura Trivelloni <ltrivell@redhat.com>
Date:   Mon, 21 Nov 2022 11:42:30 +0100
In-Reply-To: <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
         <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
         <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
         <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
         <CACT4ouduybj2Xn_=cgZynf7kF_7tx4cjydkWoTrCAg2=ujR2Tg@mail.gmail.com>
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

On Mon, 2022-11-21 at 09:32 +0100, =C3=8D=C3=B1igo Huguet wrote:
>=20
> > --- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > @@ -1119,6 +1119,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *f=
wrt, union iwl_ppag_table_cmd *c
> >          int i, j, num_sub_bands;
> >          s8 *gain;
> >=20
> > +       /* many firmware images for JF lie about this */
> > +       if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) =3D=3D
> > +           CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
> > +               return -EOPNOTSUPP;
> > +
> >          if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET=
_PPAG)) {
> >                  IWL_DEBUG_RADIO(fwrt,
> >                                  "PPAG capability not supported by FW, =
command not sent.\n");
> >=20
> >=20
> > johannes
> >=20
>=20
> Sorry for the delay with this, I had some issues with the hardware.
>=20
> Using this workaround it doesn't show any errors and I can connect.

OK.

> However, using iwlwifi-QuZ-a0-jf-b0-74 from linux-firmware I get lots
> of errors, both with this patch applied and without it. Maybe the
> driver needs some changes?
> I get stack traces, fw dumps and message `iwlwifi 0000:00:14.3: Failed
> to send MAC context (action:1): -5`

Probably some other error?

> What would you recommend to do? It seems you didn't like this solution
> very much (and, as I say, it doesn't work with fw 74)


Well I think we still need this solution even if I didn't like it, and
the fw 74 seems to be a different issue - could you post more info about
separately?

johannes
