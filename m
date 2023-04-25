Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199526EE78C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjDYScn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjDYScm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 14:32:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413D146CC
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=B4GkkT9hoo+4X/ogt33pFxtJeMbZvpg8GDMZTtnLqqw=;
        t=1682447561; x=1683657161; b=qvxOsXe9wIXEDl/L3lw+f5cJ4RtdJBFACzJSHGcReRRi6hm
        rBbfiobrvI+xHY8+UD5wijydvyl0nnDhl95wxA5tqJqR89kEDtoGxVFlfQq+8KrJgOzOZmB53wWE7
        bbB7l52vSusayVcJyfdsLOa2qT2tyRw3sxrg3hebUf33o4ryfyVy9wysHkwV31ca1/TX0SPqWPDqZ
        7jIpFoenMUUsEx6zrLh37v3rFJJNgQ3f842UnBf6OUZ7L9Mqwrvw2q6N84SPMT5zyvhIqy/xA/aEr
        7NQNThc16E/P0/I6GgJeW4rnJPTy5eYCew+glsKI7f6Jz7tilDi8PSE+ydp9Steg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1prNSx-008JlW-0t;
        Tue, 25 Apr 2023 20:32:39 +0200
Message-ID: <1c2667ea4e668c53cca4d0a1663f7a9fcfc0fb20.camel@sipsolutions.net>
Subject: Re: Question on why ieee80211_prep_channel clears the
 IEEE80211_CONN_DISABLE_160MHZ flag.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 25 Apr 2023 20:32:38 +0200
In-Reply-To: <dab721af-4f9b-20b8-94da-fb1913ff4095@candelatech.com>
References: <451c423b-4d0b-c2e6-7f39-0dc7da3e8080@candelatech.com>
         <e247d0832435218fcdb78f3b81a66306b8873946.camel@sipsolutions.net>
         <dab721af-4f9b-20b8-94da-fb1913ff4095@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-04-24 at 12:58 -0700, Ben Greear wrote:
> > >=20
> > > 	*conn_flags &=3D ~(IEEE80211_CONN_DISABLE_40MHZ |
> > > 			 IEEE80211_CONN_DISABLE_80P80MHZ |
> > > 			 IEEE80211_CONN_DISABLE_160MHZ);
> > >=20
> >=20
> > I'm guessing - I don't really remember right now - that this is so we
> > can make a new decision to set these flags? We don't really clear them
> > in any other place, I guess?

Looks like this goes back to my commit 24398e39c8ee ("mac80211: set HT
channel before association"). But looking at it briefly now, I'm not
really sure why. I mean, it _looks_ like it needs to be preserved to not
flip around the channel type between auth and assoc, but ... why this
way?

> > But honestly I don't know. There's a lot of state and maybe we should
> > just memset() it all whenever we disconnect (get into some kind of idle
> > state), just like we do with the links now that we free...
>=20
> We have been running this patch below for 3 or so weeks, and have not not=
iced any problems.

:)

I'll note that we've also not added 320 MHz here and not seen any
issues, but that may not mean all that much.

> I am personally worried about making bigger changes to this sort of logic=
 (ie, memset),
> as the over all code is convoluted and hard to think through all of the c=
hanges
> and use cases.
>=20
> The MLO changes seem to have done a better job of splitting up
> the configured vs current settings.  I think that split is key to better
> architecture over all.  Conn-flags is 'configured' as I understand it, so
> probably removing mac80211 code that changes it (as opposed to changing i=
t from
> user-space or other configured input) is in the right direction.

Well my point here was that for the links that aren't deflink we already
now reset them to 0 because we completely free them and reallocate new
ones, and expect that to work. So if that doesn't work for the deflink
we have a problem with the others as well, most likely.

So seems to me we should also reset this data, and see what falls out.
Maybe we'll find bugs that apply to both cases, but hopefully not that
much will break?

> @@ -4762,9 +4762,13 @@ static int ieee80211_prep_channel(struct ieee80211=
_sub_if_data *sdata,
>=20
>   	sband =3D local->hw.wiphy->bands[cbss->channel->band];
>=20
> +	/* This makes our logic to disable 160Mhz (at least) not work.
> +	 * I am not sure it is useful in any case, so commenting out for now.
> +	 * --Ben
>   	*conn_flags &=3D ~(IEEE80211_CONN_DISABLE_40MHZ |
>   			 IEEE80211_CONN_DISABLE_80P80MHZ |
>   			 IEEE80211_CONN_DISABLE_160MHZ);
> +	*/
>=20
>   	/* disable HT/VHT/HE if we don't support them */
>   	if (!sband->ht_cap.ht_supported && !is_6ghz) {
>=20
> I can send a patch to just remove those three lines if you think that is =
good approach?

I wish I knew :)

Clearly we eventually still call ieee80211_determine_chantype(), which
should result in the same calculations again, right? And while it gets
the input conn_flags, it anyway doesn't check the bandwidth bits
there...

So _seems_ safe? Maybe we were trying to be able to upgrade a connection
to 40 MHz later on assoc, originally?

johannes
