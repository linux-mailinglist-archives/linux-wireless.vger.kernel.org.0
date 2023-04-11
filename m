Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB476DDA74
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDKMLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDKMLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 08:11:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618FE10DC;
        Tue, 11 Apr 2023 05:11:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B99D21A08;
        Tue, 11 Apr 2023 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681215078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awrM0twElR2GFpnUMmmK4nW6q2DbcrSONhHrLs0bNXU=;
        b=MMv0nE7gH4JQ2Micu5UO8u/074KTYIK8ljEVuy0eGTlEcJxHXxHAY+4pnXIe0EIpqwvtpK
        qmna6gurx4t5DWFMBwarQIDqWfsBNcLouBQu9UuobiBBmk+iu+3CNCVfSTGkiWsGoY0SUw
        hh02U9amAeP0vGKHrQob4vnL+FYMQbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681215078;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awrM0twElR2GFpnUMmmK4nW6q2DbcrSONhHrLs0bNXU=;
        b=gYp9VUlq0sWxD3YCUeBeG7w4FVKOcLFzLfKeOIqWwECrNGhKYFtJGbtKo7P+/75I/ue1LA
        UmAcZhsszyOEs3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF82313638;
        Tue, 11 Apr 2023 12:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bpvyMWVONWTPCAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 11 Apr 2023 12:11:17 +0000
Date:   Tue, 11 Apr 2023 14:11:17 +0200
Message-ID: <874jpm39ga.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: cfg: Add missing MODULE_FIRMWARE() for *.pnvm
In-Reply-To: <147d12620126c651c2487d731b82783b2c352452.camel@sipsolutions.net>
References: <20230405063546.12439-1-tiwai@suse.de>
        <147d12620126c651c2487d731b82783b2c352452.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 11 Apr 2023 13:10:34 +0200,
Johannes Berg wrote:
>=20
> [removing Luca, he no longer works on wifi]
>=20
> Hi,
>=20
> On Wed, 2023-04-05 at 08:35 +0200, Takashi Iwai wrote:
> > A few models require *.pnvm files while we don't declare them via
> > MODULE_FIRMWARE().  This resulted in the breakage of WiFi on the
> > system that relies on the information from modinfo (e.g. openSUSE
> > installer image).
> >=20
> > This patch adds those missing MODULE_FIRMWARE() entries for *.pnvm
> > files.
>=20
> Makes sense. They (may) also exist the previous generation of devices,
> but weren't strictly required then.
>=20
> > The fix is obviously ad hoc.
>=20
> Yeah. Maybe we'll merge it anyway though? Do you think this should still
> go to 6.3? Pretty close I guess.

It's a long-standing issue, so no urgent fix is needed.
It can be postponed to 6.4 merge.

> > Here I added the lines with the explicit string since *_PRE definition
> > contains the tailing dash and can't be used for *.pnvm file.
>=20
> Yeah, we thought about changing that - but I have a larger set of rework
> in this area just done a short while ago, which would make it a bit hard
> to do. Hence maybe we should merge this for 6.3/6.4 and do the larger
> rework plus getting rid of the dash in the *_PRE definitions in 6.5,
> what do you think?

Agreed.

> > Alternatively, we may put a single line
> >  MODULE_FIRMWARE("iwlwifi-*.pnvm");
> > to catch all, too.
> >=20
>=20
> Unrelated discussion, but ... I didn't even know that was possible.
>=20
> Maybe this gives us a way out of something else I was thinking about
> recently - the MODULE_FIRMWARE() here in iwlwifi usually only states the
> latest version that the driver accepts, however:
>=20
>  * the driver might be ahead of the firmware releases - in fact that's
>    how it usually should be, just due to various issues we haven't been
>    upstreaming as quickly as we'd like
>  * sometimes we (have to) skip firmware releases due to other issues
>  * etc.
>=20
> So it could be that 6.4 kernel will state e.g. the max version is 78,
> but we end up never even releasing 78 firmware. The MODULE_FIRMWARE()
> would then state 78, but that file would never exist.
>=20
> Have we just been very lucky with never running into any of these
> issues, and the distro kernels being "old enough" that usually all the
> max version firmware was already released by the time it was used? Or
> did you work around this in some other way?

Heh, we had occasionally a "hot fix" patch for avoiding to point to
the non-existing versions for distro kernels.

> Anyway, if we can use wildcards, maybe instead of stating the max API
> version number of the filename, we should have a wildcard there for the
> number? OTOH, iwlwifi *already* comes with a *lot* of firmware files for
> all the various families of devices and radios, and making the API
> version a wildcard would make it much bigger again, to the point where
> we might as well state something like
>=20
>   MODULE_FIRMWARE("iwlwifi-*")
>=20
> which is a lot of files ...

Right, this may end up with too many files.
Although there were recent actions in linux-firmware tree to drop the
unused versions, there are still quite many in total, and iwlwifi
firmware files are relatively large, unfortunately.

> Did you see any issues with this versioning thing in the past? And what
> would you think (from a distro POV) about making this a wildcard on the
> version, i.e. having, in things like
>=20
> #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
>         IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
>=20
>=20
> "*" instead of __stringify(api).
>=20
>=20
> Some input on this would be nice.
>=20
> Thanks,
> johannes

As of now, using the wildcard for matching all iwlwifi firmware files
would be worse for us, as it'll lead to drag all those files into the
openSUSE/SUSE installer image and grow the image size significantly.
=46rom that POV, the current MODULE_FIRMWARE() has been working "good
enough"; as already mentioned, we occasionally fix in the downstream
side to point to the existing firmware version, but that's OK-ish.


thanks,

Takashi
