Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4A35F5236
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJEKGm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJEKGk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 06:06:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611DB5D10E;
        Wed,  5 Oct 2022 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=v1KJYpoUfZ6Dr+qSFvFuVv2/mO9RxeKlK+hFafb4EDE=;
        t=1664964399; x=1666173999; b=HhaRbK+8yxeflrm5BIXuGNwA58uijVwzMzM2EmUgIQij+U0
        +C6ir4on/5LyYproMnsAJiRVe95HKfJOLmrl7W86ovgDgxnhUy1Y0YgYRT6SVFlYW49sZdl5GX67Y
        BPfD7iEkz7kPadb24Uq0L8wBB0sRd02Ldk/Veu105YaYKSWSz9vylYA6/5nekKU0KgMH3oCNV2eix
        YFRxH5Lh1e4JkfUmuoVj/pMIwyHxoFKPk5ujCmGVlubSiU57oz4MlIXakMDPWkP7zMHJQc2VUIPh8
        1yy46vpetzDOZ4pmt48mWFL/duKImODRoODN4HgrQ8b2xUK1MWvyYsYLdxnROwPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og1IR-00Fyo4-15;
        Wed, 05 Oct 2022 12:06:35 +0200
Message-ID: <5c47143aea07c34dbe95fdb2cab677f2a7a753fb.camel@sipsolutions.net>
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
Date:   Wed, 05 Oct 2022 12:06:34 +0200
In-Reply-To: <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
References: <CACT4oucG2z14214jWGJj9XZ5cYMnQpw9CACHvPZ09cbL7m9z_g@mail.gmail.com>
         <100b06a944de88a4b80119c5a2024e0e59cf5243.camel@sipsolutions.net>
         <CACT4oufKgUG5n6Ocgi6r-Z=+Nt9vNVK1e5dJDccogmd8h7xM8Q@mail.gmail.com>
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

On Wed, 2022-10-05 at 11:50 +0200, =C3=8D=C3=B1igo Huguet wrote:
> On Wed, Oct 5, 2022 at 11:35 AM Johannes Berg <johannes@sipsolutions.net>=
 wrote:
> >=20
> > On Fri, 2022-09-09 at 12:41 +0200, =C3=8D=C3=B1igo Huguet wrote:
> > > With an AC9560 installed on a system with Quasar (11th gen processor,
> > > in my case) we're getting a firmware crash as soon as you try to do
> > > something with the card. The problem doesn't happen with the card
> > > installed in older platforms (8th / 9th gen), and it neither happens
> > > with firmware iwlwifi-QuZ-a0-jf-b0-55 version, but yes with any other
> > > newer version.
> > >=20
> > > I've tried different versions of kernel and firmware, including the
> > > latest kernel and linux-firmware available today, and all of them fai=
l
> > > unless I remove all fw files above version 55.
> > >=20
> >=20
> > I believe this is a duplicate of
> >=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D214343
> >=20
> > which was supposed to be fixed in firmware, but evidently that fix was
> > never backported to older images.
> >=20
> > Internally, FW commit d8887278 fixed this, so FW version 69 should be
> > OK?
>=20
> I don't think so, we've reproduced it with iwlwifi-QuZ-a0-jf-b0-71.ucode
>=20

Indeed, my git-fu was bad. Looks like 74 only fixes it (or will, since
it hasn't been released, apparently).

We could do some awful workaround like this I guess:

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wir=
eless/intel/iwlwifi/fw/acpi.c
index 009a4074d062..0c0a28d748f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1119,6 +1119,11 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt,=
 union iwl_ppag_table_cmd *c
         int i, j, num_sub_bands;
         s8 *gain;
=20
+	/* many firmware images for JF lie about this */
+	if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) =3D=3D
+	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
+		return -EOPNOTSUPP;
+
         if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPA=
G)) {
                 IWL_DEBUG_RADIO(fwrt,
                                 "PPAG capability not supported by FW, comm=
and not sent.\n");


johannes
