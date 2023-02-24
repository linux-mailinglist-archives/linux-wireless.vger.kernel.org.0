Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D86A19C3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 11:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBXKPx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 05:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBXKPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 05:15:49 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB22689
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tkM+SFdwRaFOFd0Ny9sr17OCmX6BuWzOVwVIIiMjVYo=;
        t=1677233749; x=1678443349; b=q3qY0RmKS2NZbQOxw2fWhDArBQ6gxAXxaWKnwtgIskTv+Bq
        7cCrQNiD5qfgyf+HUaldtMzV/WPp/2Ezss8tyONyEuFbt944knZxf5PbxhJWNhe9qQo4S2cIaOOr0
        soTzRM00bMoqnoFj6zOoYsRy8ZOx8VfXQSQZxmHXZG9SJV43agfKGOWYZ4pvX19i9IyD3imWVDSvb
        ThhghKOlISn+7LyUpD5wu929w8AvlovdcD6LHumQld5u2NuKGKH89FyIbvTRXqynhpjr2zgWyH7tb
        ezrKdw8KGn3FDpzK1J+Zyyyc+SBR98UqAQQoOB/9MtGgPArpvwRnT1NemdrTmI7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pVV76-00498c-2G;
        Fri, 24 Feb 2023 11:15:40 +0100
Message-ID: <56a3651e48ae621afa4c50f1ba0d9fedeefb2c31.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath11k: Optimize 6 GHz scan time
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        James Prestwood <prestwoj@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ilan.peer@intel.com
Date:   Fri, 24 Feb 2023 11:15:39 +0100
In-Reply-To: <10e4b6bf-f375-e50f-063a-b44471359d25@quicinc.com>
References: <20221220043823.20382-1-quic_mpubbise@quicinc.com>
         <5DAEA8B2-2B44-4A91-9E57-12B6C6B6C1FC@holtmann.org>
         <2861463e-a097-7efe-bc75-f13c8faf9547@quicinc.com>
         <378a1d63b3752ace7384c44d6f5184753fa7795d.camel@gmail.com>
         <0b06dea9-d5be-1edc-62ca-576398d1bcd8@quicinc.com>
         <0e7644cbfa9e4ba0d534681166ca467ea1684719.camel@gmail.com>
         <10e4b6bf-f375-e50f-063a-b44471359d25@quicinc.com>
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

On Fri, 2023-02-24 at 15:38 +0530, Manikanta Pubbisetty wrote:
> On 1/10/2023 10:35 PM, James Prestwood wrote:
> > On Tue, 2023-01-10 at 10:49 +0530, Manikanta Pubbisetty wrote:
> > > On 12/29/2022 2:52 AM, James Prestwood wrote:
> > > > Hi Manikanta,
> > > > > By the way, userspace itself selects the frequencies to scan, not
> > > > > the
> > > > > driver.
> > > > >=20
> > > > > If we see the split scan implementation in cfg80211, this is the
> > > > > how
> > > > > it
> > > > > is implemented. If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, it
> > > > > selects
> > > > > all PSC channels and those non-PSC channels where RNR IE
> > > > > information
> > > > > is
> > > > > found in the legacy scan results. If this flag is not set, all
> > > > > channels
> > > > > in 6 GHz are included in the scan freq list. It is upto userspace
> > > > > to
> > > > > decide what it wants.
> > > >=20
> > > >=20
> > > > This isn't your problem, but it needs to be said:
> > > >=20
> > > > The nl80211 docs need and update to reflect this behavior (or
> > > > remove
> > > > the PSC logic). IMO this is really weird that the kernel selects
> > > > PSC's
> > > > based on the co-located flag. The docs don't describe this behavior
> > > > and
> > > > the flag's name is misleading (its not
> > > > SCAN_FLAG_COLOCATED_AND_PSC_6GHZ) :)
> > > >=20
> > >=20
> > > Sorry for the late reply, I was on vacation.
> > >=20
> > > What you said make sense. The existing flag should not add PSC
> > > channels
> > > according to the flag description.
> > >=20
> > > We can add another flag something like you pointed out
> > > SCAN_FLAG_COLOCATED_AND_PSC_6GHZ and include PSC channels if this
> > > flag
> > > is set. What do you say?
> >=20
> > I'm no authority here, just wanted to point this out. This is something
> > that would need to be in mac80211 though, not just a specific driver.
> > It would be up to the maintainers and would require changing the
> > behavior of the existing flag, which then changes behavior in
> > wpa_supplicant/hostapd. So its somewhat intrusive.
> >=20
> > But personally I'd be for it. And just require userspace include PSC's
> > like any other channels if they need those.
> >=20
>=20
> Hi Johannes,
>=20
> What is your opinion on the changes being proposed to the 6 GHz scan in=
=20
> cfg80211 that is being discussed in this thread?
>=20

I don't think we can/should change the semantics of an existing flag
now, but we can certainly update the documentation to match the
implementation, and add more flags to make it more flexible.

johannes
