Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5539E65E6FD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 09:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjAEImu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 03:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAEIme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 03:42:34 -0500
Received: from out20-86.mail.aliyun.com (out20-86.mail.aliyun.com [115.124.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CC04C71D
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 00:42:31 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1015252|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.169081-0.000819096-0.8301;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047213;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.Qky.SOh_1672908116;
Received: from eq59.localnet(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.Qky.SOh_1672908116)
          by smtp.aliyun-inc.com;
          Thu, 05 Jan 2023 16:41:57 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Date:   Thu, 05 Jan 2023 16:41:55 +0800
Message-ID: <2669054.mvXUDI8C0e@eq59>
In-Reply-To: <cef2bd45d48127dfb65d8cf7243ec09cfbb30921.camel@intel.com>
References: <20230102024021.2900-1-aiden.leong@aibsd.com>
 <b5b67842-17a2-f2b8-3c58-b6242b77e5b7@aibsd.com>
 <cef2bd45d48127dfb65d8cf7243ec09cfbb30921.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12131945.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart12131945.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Aiden Leong <aiden.leong@aibsd.com>
Subject: Re: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Date: Thu, 05 Jan 2023 16:41:55 +0800
Message-ID: <2669054.mvXUDI8C0e@eq59>
MIME-Version: 1.0

On 2023=E5=B9=B41=E6=9C=885=E6=97=A5=E6=98=9F=E6=9C=9F=E5=9B=9B CST =E4=B8=
=8B=E5=8D=882:39:52 Greenman, Gregory wrote:
> On Mon, 2023-01-02 at 22:32 +0800, Aiden Leong wrote:
>=20
> > 1. I know nothing about what `tx_with_siso_diversity` is. It's just a=20
> > hardware flag to me. Main line.
> >=20
> > 2. I have the real device. Tested. Two photos was sent to Luca Coelho a=
s=20
> > well.
> >=20
> > 3. /drivers/net/wireless/intel/iwlwifi/pcie/drv.c#L623
> >=20
> >  > IWL_DEV_INFO(0x4DF0, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0, NULL),
> >=20
> > The device I have is 0x4DF0, 0x0244. They share the same device ID.
> >=20
> > 4. I have narrowed down my code with _mac_step, _rf_type, _rf_id,=20
> > _no_160 and _cores, so it should be safe to other devices.
> >=20
> > Happy New Year
> >=20
> > Aiden
> >=20
> > On 2023/1/2 21:32, Greenman, Gregory wrote:
> >=20
> > > On Mon, 2023-01-02 at 10:40 +0800, Aiden Leong wrote:
> > >=20
> > > > AX101NGW(0x4DF0, 0x0244) should have tx_with_siso_diversity unset.
> > >=20
> > > Why it should be unset? Which kernel do you have?
> > > Commit 3f910a25839b13436bf0a22186f1698b23eafb91 added AX101 device.
> > >=20
> > >=20
> > > > Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
> > > > ---
> > > > Ref Commit: 9352ed0165ff4313ab340c979446c3d64c531f7a
> > > > Tested on my own device.
> > > > ---
> > > >   drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > > b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
 index
> > > > 99768d6a6032..a46df1320372 100644
> > > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > > @@ -986,6 +986,11 @@ static const struct iwl_dev_info
> > > > iwl_dev_info_table[] =3D {
 iwl_qu_c0_hr_b0, iwl_ax201_name),
> > > >  =20
> > > >          /* QuZ */
> > > > +       _IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
> > > > +                     IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
> > > > +                     IWL_CFG_RF_TYPE_HR1, IWL_CFG_RF_ID_HR1,
> > > > +                     IWL_CFG_NO_160, IWL_CFG_CORES_BT,
> > > > IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 +                   =20
> > > > iwl_cfg_quz_a0_hr_b0, iwl_ax101_name),
> > > >          _IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
> > > >                        IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
> > > >                        IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
>=20
>=20
> So, still the only thing that this patch does is to *disable*
> tx_with_siso_diversity flag.=20
 The configuration one line below it (looking
> at Linux 6.2-rc2) is essentially the same (but with wildcards instead), t=
he
> only thing different is using iwl_quz_a0_hr1_b0 instead of
> iwl_cfg_quz_a0_hr_b0. These two configurations differ only in setting
> tx_with_siso_diversity. Thus the question, what is the reason for the
> change? Did you experienced FW crashes, throughput degardataion?

Correct.

1. The FW crashes with "NMI_INTERRUPT_UNKNOW". Not interface shows up=20
via `ip a`.

2. With iwl_cfg_quz_a0_hr_b0, it works. However, I get=20
"NMI_INTERRUPT_UMAC_FATAL " in dmesg. Throughput degardataion not tested.

Please let me know if I should send you more info for further debugging.

Cheers,
Aiden Leong
--nextPart12131945.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEENSNFoSpoTSrmxF9vGvlck5mKYvIFAmO2jVMACgkQGvlck5mK
YvKgbAf/SSwmTjRzp4inMRqbuiuBPfI00X7JP20gCJq1PQs7nOKx9oMQsnY+4XC/
dNHsGE2BRQBmwaKR2KndLWZZL6KIsEjCs0kj76UdkJxCWZoC/KnXvhlu9jEQr9GS
2lKodUjt4Ilnmd4BcJ1ZE37HvMfS/Q9IsRfeBKZZmUIvV2NcUdh7hWn0ta4srwwH
Wg7PZXX7T8hjvgVfR6x5DvtIbuF6GXaMxWJqzAzMP3vO11eJebTLaAoqPBXDYlEq
zDTAii4EU6ocvn1QyD/DkZuYdhdpvcOT9ZfHM/Wd/gwM1xBNkf6QLB8fP8OOMX1k
Gvwij1zSMMFU0gh8Q4i7iHxdqowoNg==
=keLB
-----END PGP SIGNATURE-----

--nextPart12131945.O9o76ZdvQC--



