Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE33E7ACFD1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 08:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjIYGDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 02:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIYGDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 02:03:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F406C83
        for <linux-wireless@vger.kernel.org>; Sun, 24 Sep 2023 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zw24tugM7M/nEem/0NDnpLanNWqkrDxhCrpjoswWIZg=;
        t=1695621793; x=1696831393; b=fuNm78DQKSySSDn9hEk9UA8/cciiUuPt/jUhdW3+Ce9E1vE
        Jzh98QEwvkGL1xSNbNP19agqE3rVXXvoOPZZWQAGetgN/TQ6hip34UvwBx9jGf25EZdqXkMAaRpwE
        s1I4SPmXoK2ZuIRhIar7xlzzibofTzvbbOSC34BQVGW9XCCZ1R65LvaIAIccDoOC9tcCg0OzWSoPi
        mbLQn3EyTNlzQGDzwSxpsj7CN/ynK3qNMF9MUu2LKqF5Pix+ltmZxpc+WV0yeVHyIt+XL3qCJABaI
        HorricQzXRvTIZbEIVYshYMMQmKFQU9x+/3U5uQkmYSg5K+5AXbzhMyjrYVMHxQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qkegY-003Bek-07;
        Mon, 25 Sep 2023 08:03:10 +0200
Message-ID: <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
Subject: Re: Microcode SW error since Linux 6.5
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Antoine =?ISO-8859-1?Q?Beaupr=E9?= <anarcat@debian.org>,
        linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>, ilan.peer@intel.com
Date:   Mon, 25 Sep 2023 08:03:09 +0200
In-Reply-To: <87jzsf9dme.fsf@angela.anarc.at>
References: <87ttrncuc8.fsf@angela.anarc.at>
         <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
         <87jzsf9dme.fsf@angela.anarc.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2023-09-24 at 22:43 -0400, Antoine Beaupr=C3=A9 wrote:
>=20
> Interestingly, for the above fault, there's no wpa_supplicant line just
> *before*. There's this *after*:
>=20
> sep 21 09:33:14 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-SCAN-FAILE=
D ret=3D-5

Yeah I saw this, just wasn't sure where it was scanning, hence the
question. But I don't think it mattered.

> But an earlier one is preceeded by:
>=20
> sep 21 09:32:45 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-SCAN-FAILE=
D ret=3D-5
> sep 21 09:32:45 angela kernel: iwlwifi 0000:a6:00.0: Microcode SW error d=
etected. Restarting 0x0.
> [...]

Well I guess there was just another scan before that one :)

>=20
> > I think something like this, perhaps:
> >=20
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> > @@ -2342,7 +2342,7 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_m=
vm *mvm,
> >  	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
> >  		gp->num_of_fragments[SCAN_HB_LMAC_IDX] =3D IWL_SCAN_NUM_OF_FRAGS;
> > =20
> > -	if (version < 12) {
> > +	if (version < 12 || !iwl_mvm_has_mld_api(mvm->fw)) {
> >  		gp->scan_start_mac_or_link_id =3D scan_vif->id;
> >  	} else {
> >  		struct iwl_mvm_vif_link_info *link_info;
>=20
> Interesting! In any case, the firmware is certainly out of date in
> Debian stable, and I guess it's to be expected that having it out of
> sync with the running kernel is a Bad Idea, it's just not something I've
> thought of before. :)

Did that patch help?

> Thanks for the debugging, I'll make sure to keep the firmware and kernel
> in better lockstep in the future!

Yes, you can ... but I mean, we still do want to consider this a bug, I
think, since we explicitly built the thing to load the older firmware.
It just gets _far_ less testing.

johannes
