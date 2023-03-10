Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835AD6B3602
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Mar 2023 06:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCJFOM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Mar 2023 00:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCJFOK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Mar 2023 00:14:10 -0500
Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCADE9F2C
        for <linux-wireless@vger.kernel.org>; Thu,  9 Mar 2023 21:14:07 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07446568|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.106-0.00820318-0.885797;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047206;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.RjAWW6O_1678425243;
Received: from eq59.localnet(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.RjAWW6O_1678425243)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 13:14:04 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>, kvalo@kernel.org
Subject: Re: [PATCH v3] wifi: iwlwifi: pcie: fix the order of scanning
 iwl_dev_info_table
Date:   Fri, 10 Mar 2023 13:14:03 +0800
Message-ID: <4811051.31r3eYUQgx@eq59>
In-Reply-To: <5815091.MhkbZ0Pkbq@eq59>
References: <20230119175657.9205-1-aiden.leong@aibsd.com>
 <51e9eeb2cd84f0f8ff92981b47a8e77e11047847.camel@intel.com>
 <5815091.MhkbZ0Pkbq@eq59>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4465706.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart4465706.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Aiden Leong <aiden.leong@aibsd.com>
Date: Fri, 10 Mar 2023 13:14:03 +0800
Message-ID: <4811051.31r3eYUQgx@eq59>
In-Reply-To: <5815091.MhkbZ0Pkbq@eq59>
MIME-Version: 1.0

On Wednesday, February 8, 2023 5:14:50 AM CST Aiden Leong wrote:
> On Wednesday, February 8, 2023 1:44:39 AM CST Greenman, Gregory wrote:
> > On Fri, 2023-01-20 at 01:56 +0800, Aiden Leong wrote:
> > > Fix a bug introduced by:
> > > commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
> > > 
> > >  config table"), so now we pick the FIRST matching config.
> > > 
> > > Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
> > > ---
> > > 
> > >  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> 
>  index
> 
> > > 99768d6a6032..05764eef15a7 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > > @@ -1456,7 +1456,7 @@ iwl_pci_find_dev_info(u16 device, u16
> > > subsystem_device,
> 
>  if (!num_devices)
> 
> > >                 return NULL;
> > > 
> > > -       for (i = num_devices - 1; i >= 0; i--) {
> > > +       for (i = 0; i < num_devices; i++) {
> > > 
> > >                 const struct iwl_dev_info *dev_info =
> > > 
> > > &iwl_dev_info_table[i];
> > > 
> > >                 if (dev_info->device != (u16)IWL_CFG_ANY &&
> > 
> > It failed or internal testing, so it's more complicated. To traverse this
> > table
> 
>  from the beginning to the end requires some changes to the table
> 
> > itself and the "goto" wasn't omitted by a mistake, but for a reason...
> > For the device that you have (device id 0x4DF0, sub-device id 0x0244,
> > right?)
> 
>  is it enough to have the first fix (disable
> 
> > tx_with_siso_diversity)?
> 
> Hi Gregory,
> That's exactly why I put a warning in previous emails.
> My opinion will be a little different than yours in this situation.
> 1. We SHOULD traverse this table from top to bottom to keep our source tree
> as clean as possible.
> 2. One simple option is to reverse every config items in this table so the
> logic keep the same.
> 3. Your team(I assume Luca Coelho is your colleague) may need to provide
> further explaination about the `goto` line, since each change in kernel
> should have a reason.
> 4. 0x4DF0, 0x0244 is correct. The question is: Will Intel release products
> with same pid+subID but differenct STEP/RF_TYPE/RF_ID etc? If so, pid+subID
> won't be enough.
> 
> To sum up, there will be three patches:
> 1. This patch still fixes the BUG introduced by the `goto` change.
> 2. Patch 2 should be [PATCH 1/2] in previous email.
> 3. Patch 3 reverses every items in this table. Your team can fine-tune the
> order of each items. I won't submit this patch.
> 
> If you like my ideas, please merge patch1&2 along with another ident fix
> patch.
> 
> BTW, it has been a month since the first email. I'd appreciate if you reply
> soon.
> 
> Cheers,
> Aiden

Hi Gregory,

PING

You should let us know if you are not actively maintaining the community part 
of the driver. If you are only working on the close source firmware, we should 
have someone else do the open source job.
We should not waste our life for months on such a small patch.

Have a nice day,
Aiden

--nextPart4465706.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEENSNFoSpoTSrmxF9vGvlck5mKYvIFAmQKvJsACgkQGvlck5mK
YvJldwf/bSXgDTEvj3JaIKg6pquvZIVrvW1EnCtZwTyAuamj3VeuZh8+VPV6wmmU
CIcilafmPRrAJJCmgmaNygy+jE3ROHY0YBVbE/oaVyOC2SQYPrvArF2zNisEigz+
tg/ZB1jMNLwdhc2pMXZqo3WwRcQgtDgaW9xU/LsgcYfZz03+x4NQHTjtvQB+eK2U
MsO67eyA20giaQhPNp8lbV5u7hHHPHRJkUSUBEKAkk/3yrvEha0zvnUwkfGyogSq
dZzvDItK2Gq1FYxscME4Q/LFobBo2IvuocOf5ZasqOkur4ccNU4Dzz2dL85wQ0vP
oWl6/uxUrWUqZ8GjcTF+87x6NHNB5w==
=t1PK
-----END PGP SIGNATURE-----

--nextPart4465706.LvFx2qVVIh--



