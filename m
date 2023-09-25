Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579867ADF23
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjIYSjw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjIYSjr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 14:39:47 -0400
Received: from marcos.anarc.at (marcos.anarc.at [64.18.183.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA411C
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1695667172;
        bh=XOeQh7WzBXg0Q+S6ZDn6MhxCdXk3yu8QmXyl9qWvMvY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ctwDlSU8Y0oy5MuX+F66Aa3QXr5C/jPtbAkxXdb2wdknWrv6TYbQRYAtJrk7y/Znj
         HeK8urDjdl4hT+B62bBPDIRSLeDdbJK6GOI2z6UjPBAcrHEpaKc0QpzvoHb3G605c/
         N+hzG2m86tXFneb1PopSqf/iikRRx/GcPw7iINqz6j9b+tSDESxelk0oF+WdB+ipIH
         TD0yPxeEWI3zHABGs6u8i9KQLk3XlAazzqAa96HUH/eJZt7tF+M2FSuQBCj9/sIe0E
         QwG8HtnDmnfOLScOxUvRjTaYuQkQDXt/piylRrjDCP9SRRueuka1lVpj7yM06jwbh3
         14v1/PJ7xzskw==
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id C12A510E0F3; Mon, 25 Sep 2023 14:39:32 -0400 (EDT)
Received: by angela.localdomain (Postfix, from userid 1000)
        id 1F751E0207; Mon, 25 Sep 2023 14:39:32 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>, ilan.peer@intel.com
Subject: Re: Microcode SW error since Linux 6.5
In-Reply-To: <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
Organization: Debian
References: <87ttrncuc8.fsf@angela.anarc.at>
 <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
 <87jzsf9dme.fsf@angela.anarc.at>
 <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
Autocrypt: addr=anarcat@debian.org; prefer-encrypt=nopreference;
 keydata=xjMEZHZPzhYJKwYBBAHaRw8BAQdAWdVzOFRW6FYVpeVaDo3sC4aJ2kUW4ukdEZ36UJLAHd7NJUFudG9pbmUgQmVhdXByw6kgPGFuYXJjYXRAZGViaWFuLm9yZz7ClgQTFggAPhYhBLu2zUyY104TWKdSpgIpOm+k5TRzBQJkdmCVAhsDBQkB4TOABQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAIpOm+k5TRz+w8BANbRA+AMH0LN7trugVhaWe4wDpg94UVJloHPL+adJMK/AQCh39hyQXk3ivS2cK7xKZUgK0dBsbtJ2I2XBXvL9dS3Cc44BGR2UM4SCisGAQQBl1UBBQEBB0CYZha2IMY54WFXMG4S9/Smef54Pgon99LJ/hJ885p0ZAMBCAfCdwQYFggAIBYhBLu2zUyY104TWKdSpgIpOm+k5TRzBQJkdlDOAhsMAAoJEAIpOm+k5TRzBg0A+IbcsZhLx6FRIqBJCdfYMo7qovEo+vX0HZsUPRlq4HkBAIctCzmH3WyfOD/aUTeOF3tY+tIGUxxjQLGsNQZeGrQI
Date:   Mon, 25 Sep 2023 14:39:32 -0400
Message-ID: <8734z29jx7.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023-09-25 08:03:09, Johannes Berg wrote:
> On Sun, 2023-09-24 at 22:43 -0400, Antoine Beaupr=C3=A9 wrote:

[...]

>> > I think something like this, perhaps:
>> >=20
>> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
>> > @@ -2342,7 +2342,7 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_=
mvm *mvm,
>> >  	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
>> >  		gp->num_of_fragments[SCAN_HB_LMAC_IDX] =3D IWL_SCAN_NUM_OF_FRAGS;
>> >=20=20
>> > -	if (version < 12) {
>> > +	if (version < 12 || !iwl_mvm_has_mld_api(mvm->fw)) {
>> >  		gp->scan_start_mac_or_link_id =3D scan_vif->id;
>> >  	} else {
>> >  		struct iwl_mvm_vif_link_info *link_info;
>>=20
>> Interesting! In any case, the firmware is certainly out of date in
>> Debian stable, and I guess it's to be expected that having it out of
>> sync with the running kernel is a Bad Idea, it's just not something I've
>> thought of before. :)
>
> Did that patch help?

I haven't tried, to be honest. It's been years since I compiled a
kernel, so I haven't actually seriously considered it. But I can
definitely put that on my list if it would be useful for you!

Quite a bit of scaffolding to build to get back down there though...

>> Thanks for the debugging, I'll make sure to keep the firmware and kernel
>> in better lockstep in the future!
>
> Yes, you can ... but I mean, we still do want to consider this a bug, I
> think, since we explicitly built the thing to load the older firmware.
> It just gets _far_ less testing.

Got it, happy to play guinea pig a little further if that's useful.

a.

--=20
The desire to sacrifice an entire lifetime to the noblest of ideals
serves no purpose if one works alone.
                        - Che Guevara
