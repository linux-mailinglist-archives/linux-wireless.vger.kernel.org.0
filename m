Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49306B6448
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Mar 2023 10:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCLJwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Mar 2023 05:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLJwm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Mar 2023 05:52:42 -0400
Received: from out28-81.mail.aliyun.com (out28-81.mail.aliyun.com [115.124.28.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80C73251A
        for <linux-wireless@vger.kernel.org>; Sun, 12 Mar 2023 01:52:26 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437009|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0457661-0.00786077-0.946373;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047213;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.RlVkT8w_1678614742;
Received: from eq59.localnet(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.RlVkT8w_1678614742)
          by smtp.aliyun-inc.com;
          Sun, 12 Mar 2023 17:52:23 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
Date:   Sun, 12 Mar 2023 17:52:22 +0800
Message-ID: <6385511.DvuYhMxLoT@eq59>
In-Reply-To: <41704272e91ede88e49a61d7943d4e1c6c88e9c4.camel@intel.com>
References: <20230119175657.9205-1-aiden.leong@aibsd.com> <4811051.31r3eYUQgx@eq59>
 <41704272e91ede88e49a61d7943d4e1c6c88e9c4.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6644225.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart6644225.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Aiden Leong <aiden.leong@aibsd.com>
Date: Sun, 12 Mar 2023 17:52:22 +0800
Message-ID: <6385511.DvuYhMxLoT@eq59>
MIME-Version: 1.0

On Sunday, March 12, 2023 5:47:07 PM CST Greenman, Gregory wrote:
> On Fri, 2023-03-10 at 13:14 +0800, Aiden Leong wrote:
>=20
> > On Wednesday, February 8, 2023 5:14:50 AM CST Aiden Leong wrote:
> >=20
> > > On Wednesday, February 8, 2023 1:44:39 AM CST Greenman, Gregory wrote:
> > >=20
> > > > On Fri, 2023-01-20 at 01:56 +0800, Aiden Leong wrote:
> > > >=20
> > > > > Fix a bug introduced by:
> > > > > commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to =
the
> > > > > new
> > > > >=20
> > > > >  config table"), so now we pick the FIRST matching config.
> > > > >=20
> > > > > Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
> > > > > ---
> > > > >=20
> > > > >  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > > > b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > >=20
> > >=20
> > >  index
> > >=20
> > >=20
> > > > > 99768d6a6032..05764eef15a7 100644
> > > > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > > > @@ -1456,7 +1456,7 @@ iwl_pci_find_dev_info(u16 device, u16
> > > > > subsystem_device,
> > >=20
> > >=20
> > >  if (!num_devices)
> > >=20
> > >=20
> > > > >                 return NULL;
> > > > >=20
> > > > > -       for (i =3D num_devices - 1; i >=3D 0; i--) {
> > > > > +       for (i =3D 0; i < num_devices; i++) {
> > > > >=20
> > > > >                 const struct iwl_dev_info *dev_info =3D
> > > > >=20
> > > > > &iwl_dev_info_table[i];
> > > > >=20
> > > > >                 if (dev_info->device !=3D (u16)IWL_CFG_ANY &&
> > > >=20
> > > >=20
> > > > It failed or internal testing, so it's more complicated. To traverse
> > > > this
> > > > table
> > >=20
> > >=20
> > >  from the beginning to the end requires some changes to the table
> > >=20
> > >=20
> > > > itself and the "goto" wasn't omitted by a mistake, but for a
> > > > reason...
> > > > For the device that you have (device id 0x4DF0, sub-device id 0x024=
4,
> > > > right?)
> > >=20
> > >=20
> > >  is it enough to have the first fix (disable
> > >=20
> > >=20
> > > > tx_with_siso_diversity)?
> > >=20
> > >=20
> > > Hi Gregory,
> > > That's exactly why I put a warning in previous emails.
> > > My opinion will be a little different than yours in this situation.
> > > 1. We SHOULD traverse this table from top to bottom to keep our source
> > > tree
 as clean as possible.
> > > 2. One simple option is to reverse every config items in this table so
> > > the
> > > logic keep the same.
> > > 3. Your team(I assume Luca Coelho is your colleague) may need to
> > > provide
> > > further explaination about the `goto` line, since each change in kern=
el
> > > should have a reason.
> > > 4. 0x4DF0, 0x0244 is correct. The question is: Will Intel release
> > > products
> > > with same pid+subID but differenct STEP/RF_TYPE/RF_ID etc? If so,
> > > pid+subID
 won't be enough.
> > >=20
> > > To sum up, there will be three patches:
> > > 1. This patch still fixes the BUG introduced by the `goto` change.
> > > 2. Patch 2 should be [PATCH 1/2] in previous email.
> > > 3. Patch 3 reverses every items in this table. Your team can fine-tune
> > > the
> > > order of each items. I won't submit this patch.
> > >=20
> > > If you like my ideas, please merge patch1&2 along with another ident
> > > fix
> > > patch.
> > >=20
> > > BTW, it has been a month since the first email. I'd appreciate if you
> > > reply
 soon.
> > >=20
> > > Cheers,
> > > Aiden
> >=20
> >=20
> > Hi Gregory,
> >=20
> > PING
> >=20
> > You should let us know if you are not actively maintaining the community
> > part=20
 of the driver. If you are only working on the close source
> > firmware, we should have someone else do the open source job.
> > We should not waste our life for months on such a small patch.
> >=20
> > Have a nice day,
> > Aiden
>=20
>=20
> Hi,
>=20
> You=E2=80=99re coming across as rather accusatory and demanding. I=E2=80=
=99d appreciate if
> you could=20
 tone it down a bit. Regarding the table order, we=E2=80=99ve made a
> decision in the code way back to walk the table from the back =E2=80=93 t=
hat may
> not match your personal expectation of =E2=80=9Cclean=E2=80=9D, but that=
=E2=80=99s really your
> problem, not ours.
> Also, we cannot comment on future product releases in general.
>=20
> If you=E2=80=99re willing to work with us to fix the issue you=E2=80=99re=
 encountering
> within the
 framework of how the driver is written now, I can give you a
> patch with more logs to understand why your second patch doesn't fix the
> issue.
>=20
> Regards,
> Gregory

So I'm the bad guy now?
=46ine.
That's funny!
--nextPart6644225.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEENSNFoSpoTSrmxF9vGvlck5mKYvIFAmQNoNYACgkQGvlck5mK
YvK11ggAyuuXpudpYc66FNkzJ9RbqLc5qtv4KqeNXd8m04GtAjxNzcyOwKk9wmec
3abFdLARtf2UwK66XmRXXsCuzOpOsaP9C7tCSbS5SM93NrEg8ioZ9Sa/Q8z79jT9
MKR5pGkdF0EYIID+aHIUmIZOzrt1aicPUjn/KJ8oq67nTYT+Ch2any7WvZWUraF5
V+0Xdv/9TFyiXiN8Er6V2Lq5bxGtczm9JdpmKEzk7euDx4nXmC8Gw2frmfM8gpaL
qLt5xZ4lP9bkQGaDu1EAK8JmTzcpEXuLutJhjT18svkawQUzfRlhX43yAKgGizDV
fFhpR+xSGLg/t/ZFhH6AqKiywyrVeQ==
=E2vk
-----END PGP SIGNATURE-----

--nextPart6644225.lOV4Wx5bFT--



