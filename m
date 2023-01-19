Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09239673B5C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 15:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjASOKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 09:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjASOJd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 09:09:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5F83849
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Vg98+z3KlQLhMsCxPD/EknR28tFPmQ5uogHA2s4brM8=;
        t=1674137320; x=1675346920; b=Z/eyuqS8eZqyi4fil+xh3067bhKG6kKq6+jYJQK/3ECWhnw
        mPQ1mcjAZq9GXYrbnzEW+6znlJrv7BkZ0ZtKYFLE3boiMqAxh3XWwXikdvcxuL8R6/ZNKyXvFve78
        be4HVciy3637BbwldP4Xk+y+K/gbR6XkMRCU7WUzu5b+m+vHS5DTkmXw1NUsRFzl9gp81ZECkHKjg
        TLK9mR5j70lAE63VvDo2g+mM04f74f/Dwg/Jr+YyOG1KspenA4tjkIDdqHnhxyejW157zyecQJAZF
        YxmNRJ7Du0z/MHbT1oMzvpbwokScKHfBz1fNN+OFQLLF2BSj4xAw2EzVAhHKr5ng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIVaZ-006XDj-0J;
        Thu, 19 Jan 2023 15:08:23 +0100
Message-ID: <fa3b3668a845078023997b22a9003486f5623919.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] wifi: mac80211: Radar bitmap support during radar
 detection
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 15:08:22 +0100
In-Reply-To: <20221216070918.5969-1-quic_nmaran@quicinc.com>
References: <20221216070918.5969-1-quic_nmaran@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Fri, 2022-12-16 at 12:39 +0530, Nagarajan Maran wrote:
> With the current implementation when radar is detected, the whole
> configured DFS channels are moved to "unavailable" state(NOL).

OK, sure.

> However to move only the radar affected channels alone to NOL,
> introducing two unsigned 16bit variables "cf1_radar_bitmap" and
> "cf2_radar_bitmap" which denotes the radar(with a granularity of
> 20 MHz) in the first and the second part of the channel respectively.

Where do they come from? It's not really clear to me, you just have them
in the chandef... passing them indirectly like that seems like a really
problematic idea to me? I really don't think they should be in a
chandef. They have no meaning on configuration ... similar (but worse in
a way) to the discussion we had for puncturing.

Also, as far as cfg80211 is concerned, this information originally comes
in via __cfg80211_radar_event(). Why not just call
__cfg80211_radar_event() for each sub-channel separately (yes that might
need some better handling of the work structs etc. there, possibly with
a queue of events rather than just "memcpy(&rdev->radar_chandef, ...)")?

I can't say I like the way you've handled this here. If we really need
to have a single "radar event" rather than multiple (but then explain
why) then these could be extra arguments to __cfg80211_radar_event() I
guess, but right now I'm not sure I see any reason for that vs. just
calling __cfg80211_radar_event() multiple times for each affected 20 MHz
channel?

johannes
