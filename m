Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852268E2B2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 22:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBGVPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 16:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGVPB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 16:15:01 -0500
Received: from out28-38.mail.aliyun.com (out28-38.mail.aliyun.com [115.124.28.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CF37555
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 13:14:55 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07514376|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0663572-0.00554589-0.928097;FP=0|0|0|0|0|0|0|0;HT=ay29a033018047212;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.REjomz7_1675804491;
Received: from eq59.localnet(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.REjomz7_1675804491)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 05:14:52 +0800
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
Date:   Wed, 08 Feb 2023 05:14:50 +0800
Message-ID: <5815091.MhkbZ0Pkbq@eq59>
In-Reply-To: <51e9eeb2cd84f0f8ff92981b47a8e77e11047847.camel@intel.com>
References: <20230119175657.9205-1-aiden.leong@aibsd.com>
 <51e9eeb2cd84f0f8ff92981b47a8e77e11047847.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1763909.VLH7GnMWUR";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1763909.VLH7GnMWUR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Aiden Leong <aiden.leong@aibsd.com>
Date: Wed, 08 Feb 2023 05:14:50 +0800
Message-ID: <5815091.MhkbZ0Pkbq@eq59>
MIME-Version: 1.0

On Wednesday, February 8, 2023 1:44:39 AM CST Greenman, Gregory wrote:
> On Fri, 2023-01-20 at 01:56 +0800, Aiden Leong wrote:
> 
> > Fix a bug introduced by:
> > commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
> >  config table"), so now we pick the FIRST matching config.
> > 
> > Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
 index
> > 99768d6a6032..05764eef15a7 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
> > @@ -1456,7 +1456,7 @@ iwl_pci_find_dev_info(u16 device, u16
> > subsystem_device,
 if (!num_devices)
> >                 return NULL;
> >  
> > -       for (i = num_devices - 1; i >= 0; i--) {
> > +       for (i = 0; i < num_devices; i++) {
> >                 const struct iwl_dev_info *dev_info =
> > &iwl_dev_info_table[i];
 
> >                 if (dev_info->device != (u16)IWL_CFG_ANY &&
> 
> 
> It failed or internal testing, so it's more complicated. To traverse this
> table
 from the beginning to the end requires some changes to the table
> itself and the "goto" wasn't omitted by a mistake, but for a reason...
> For the device that you have (device id 0x4DF0, sub-device id 0x0244,
> right?)
 is it enough to have the first fix (disable
> tx_with_siso_diversity)?

Hi Gregory,
That's exactly why I put a warning in previous emails.
My opinion will be a little different than yours in this situation.
1. We SHOULD traverse this table from top to bottom to keep our source tree as 
clean as possible.
2. One simple option is to reverse every config items in this table so the 
logic keep the same.
3. Your team(I assume Luca Coelho is your colleague) may need to provide 
further explaination about the `goto` line, since each change in kernel should 
have a reason.
4. 0x4DF0, 0x0244 is correct. The question is: Will Intel release products 
with same pid+subID but differenct STEP/RF_TYPE/RF_ID etc? If so, pid+subID 
won't be enough.

To sum up, there will be three patches:
1. This patch still fixes the BUG introduced by the `goto` change.
2. Patch 2 should be [PATCH 1/2] in previous email.
3. Patch 3 reverses every items in this table. Your team can fine-tune the 
order of each items. I won't submit this patch.

If you like my ideas, please merge patch1&2 along with another ident fix patch.

BTW, it has been a month since the first email. I'd appreciate if you reply 
soon.

Cheers,
Aiden
--nextPart1763909.VLH7GnMWUR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEENSNFoSpoTSrmxF9vGvlck5mKYvIFAmPiv0oACgkQGvlck5mK
YvJNVAf/bGJRVFmGGGYOUfYy6ptLUn3WRSMoQ80pcse0jZ/79iN+pcIaM0K8Nwrb
mbUuZ3z0NY3toM9DVO3/tXbjwZyo+80lt2c4MO/aYBhIaBUikryMkQXvpMRVHgf2
HxRRJ0qqL3p+mBBlZhHKRFafBZTfNQLsY0P/Z+uuvRPbHGr66PKoYPCLwTwx8QwN
ZpBz2USbKFZXo5QkeqPHT4XCRkHyZh6wsJIRyitV2lLDZ4UWO3MiuEgfm4S5z8z8
0Q3E5UrYPzAl3wK/VEVE4bC7rEZvZDPOhJ56H/OJV2/J7r0AjfKU9hPHgajSdgtQ
nMEAM+ZCDe8kCWI/eo7alKSvUu+Khw==
=NOBh
-----END PGP SIGNATURE-----

--nextPart1763909.VLH7GnMWUR--



