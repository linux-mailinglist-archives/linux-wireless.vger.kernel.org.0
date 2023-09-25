Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5626F7ACE6A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 04:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjIYCni (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Sep 2023 22:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjIYCnh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Sep 2023 22:43:37 -0400
Received: from marcos.anarc.at (marcos.anarc.at [64.18.183.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB9E3
        for <linux-wireless@vger.kernel.org>; Sun, 24 Sep 2023 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1695609802;
        bh=Lpgf+5zb2xEq+3GqibTFin1mh+BOT7DFZR4/yJoIFEI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mmHgwlU23+sQD+ou1KN0jnQGJ2M9+VzvI39pVd8ba1F35aPeRoqBQRrD9ew/SYnAR
         2g6NfdWLddgjVIJGF5/FD40/+1AN1z3MQx0VIBktHocTLHXcs2H99h63Pj2ZVDHerq
         79za0UMVmx42nMe472j8TpD/8VetFd3DbqsqIA/BbhWjPk3g+M6isS35M56XX4woBZ
         vyMbSt+ZMFP7yyS8m2hT1NCPk9/c/Usu/v8R3m6nmKeG3rCx0r+S/ch0ek1OLrQ3Fa
         ij7d9Z3aIJLqUtBWp9PhPZ3PpFIl6Fxc623mm6BRgw61KZcbBXJ2kd7814IkR4ITr0
         DEwL4yiIhVDQg==
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id 2664010E0F3; Sun, 24 Sep 2023 22:43:22 -0400 (EDT)
Received: by angela.localdomain (Postfix, from userid 1000)
        id 6CE83E0207; Sun, 24 Sep 2023 22:43:21 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Gregory Greenman <gregory.greenman@intel.com>, ilan.peer@intel.com
Subject: Re: Microcode SW error since Linux 6.5
In-Reply-To: <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
Organization: Debian
References: <87ttrncuc8.fsf@angela.anarc.at>
 <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
Autocrypt: addr=anarcat@debian.org; prefer-encrypt=nopreference;
 keydata=xjMEZHZPzhYJKwYBBAHaRw8BAQdAWdVzOFRW6FYVpeVaDo3sC4aJ2kUW4ukdEZ36UJLAHd7NJUFudG9pbmUgQmVhdXByw6kgPGFuYXJjYXRAZGViaWFuLm9yZz7ClgQTFggAPhYhBLu2zUyY104TWKdSpgIpOm+k5TRzBQJkdmCVAhsDBQkB4TOABQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAIpOm+k5TRz+w8BANbRA+AMH0LN7trugVhaWe4wDpg94UVJloHPL+adJMK/AQCh39hyQXk3ivS2cK7xKZUgK0dBsbtJ2I2XBXvL9dS3Cc44BGR2UM4SCisGAQQBl1UBBQEBB0CYZha2IMY54WFXMG4S9/Smef54Pgon99LJ/hJ885p0ZAMBCAfCdwQYFggAIBYhBLu2zUyY104TWKdSpgIpOm+k5TRzBQJkdlDOAhsMAAoJEAIpOm+k5TRzBg0A+IbcsZhLx6FRIqBJCdfYMo7qovEo+vX0HZsUPRlq4HkBAIctCzmH3WyfOD/aUTeOF3tY+tIGUxxjQLGsNQZeGrQI
Date:   Sun, 24 Sep 2023 22:43:21 -0400
Message-ID: <87jzsf9dme.fsf@angela.anarc.at>
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

On 2023-09-21 21:29:27, Johannes Berg wrote:
> On Thu, 2023-09-21 at 13:24 -0400, Antoine Beaupr=C3=A9 wrote:
>> Hi,
>>=20
>> I've found what I feel might be a regression between Linux 6.1 and
>> 6.5. For other reasons, I upgraded the kernel on my Debian 12
>> ("bookworm", stale) laptop from the distribution 6.1.52 to the unstable
>> ("sid") version, 6.5.3.
>>=20
>> After the upgrade, I started to notice stuttering in my audio player, I
>> tracked it down and managed to correlate it with some kernel errors
>> related to the iwlwifi driver.
>>=20
>> What's interesting is that this happens regardless of whether or not the
>> NIC is connected to a network. In at least one of the traces, the
>> computer was connected over a wire and wireless was not associated in
>> Network Manager.
>
> This happens when scanning.

Ah, that makes sense!

>> Here's an example of the problem:
>>=20
>> sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: Microcode SW error =
detected. Restarting 0x0.
>
> Can you give a few wpa_supplicant lines (there were some below) above
> this? Just want to make sure it really is scanning on wlan0, not
> something with P2P device.

Interestingly, for the above fault, there's no wpa_supplicant line just
*before*. There's this *after*:

sep 21 09:33:14 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-SCAN-FAILED =
ret=3D-5
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: WFPM_UMAC_PD_NOTIFICAT=
ION: 0x1f
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: WFPM_LMAC2_PD_NOTIFICA=
TION: 0x1f
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: WFPM_AUTH_KEY_0: 0x80
sep 21 09:33:15 angela kernel: iwlwifi 0000:a6:00.0: CNVI_SCU_SEQ_DATA_DW9:=
 0x0
sep 21 09:33:15 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-REGDOM-CHANG=
E init=3DDRIVER type=3DWORLD

But an earlier one is preceeded by:

sep 21 09:32:45 angela wpa_supplicant[1563]: wlan0: CTRL-EVENT-SCAN-FAILED =
ret=3D-5
sep 21 09:32:45 angela kernel: iwlwifi 0000:a6:00.0: Microcode SW error det=
ected. Restarting 0x0.
[...]

>> sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x20103600 | ADVANC=
ED_SYSASSERT
>
>> sep 21 09:33:14 angela kernel: iwlwifi 0000:a6:00.0: 0x000000FF | umac d=
ata1
>
> This means that somehow scan_start_mac_or_link_id in the driver ended up
> 0xff which is invalid, but I'm not sure I see immediately how that
> happened, since it looks like in 6.5.3 we do assign it reasonably. I
> guess somehow in the code link_info->fw_link_id must be 0xff (invalid
> ID), but I'm not sure I see how that could happen.
>
> *thinks*
>
> Oh.. This is an older firmware, so it doesn't have
> IWL_UCODE_TLV_CAPA_MLD_API_SUPPORT! Hah. I feel like I had some concerns
> in this area before ... but maybe the other way around.
>
> I think something like this, perhaps:
>
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
> @@ -2342,7 +2342,7 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm=
 *mvm,
>  	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
>  		gp->num_of_fragments[SCAN_HB_LMAC_IDX] =3D IWL_SCAN_NUM_OF_FRAGS;
>=20=20
> -	if (version < 12) {
> +	if (version < 12 || !iwl_mvm_has_mld_api(mvm->fw)) {
>  		gp->scan_start_mac_or_link_id =3D scan_vif->id;
>  	} else {
>  		struct iwl_mvm_vif_link_info *link_info;

Interesting! In any case, the firmware is certainly out of date in
Debian stable, and I guess it's to be expected that having it out of
sync with the running kernel is a Bad Idea, it's just not something I've
thought of before. :)

Thanks for the debugging, I'll make sure to keep the firmware and kernel
in better lockstep in the future!

a.

--=20
Lorsque l'on range des objets dans des tiroirs, et que l'on a plus
d'objets que de tiroirs, alors un tiroir au moins contient deux
objets.
                        - Lejeune-Dirichlet, Peter Gustav
