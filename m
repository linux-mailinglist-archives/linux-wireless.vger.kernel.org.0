Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FC7AD13B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 09:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjIYHR6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 03:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYHR6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 03:17:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506BB8
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mUEtdsdi5l9p1Tkurxb/UUSNB97kEQMrvAebiAr0dtU=;
        t=1695626271; x=1696835871; b=Mkr8iNZtqzh5GO61H4sZJK0uENb5l6vtsu/Z60a5dzLkK+E
        eKUj6yX8/7WYSLWg+zsF3pb+2npQ2cDczRt0dZB8/TtHd7WN7pGIdebsRijeQyoiGcAguQYBFbvkz
        iQgT9OeWDgM4tV0tApaEO2Scoc5Nm82YOO4JpJqQt7F6I7RqIpnXty9sqcx4+tfrDG0mLmxP943wD
        q2hVbcHPLwVVH8SvPFBEKp1IIu7UoIRGgRI/I4aJgq+bku9nPF+/krzbbr53Y2Xex1r+EKw+yewbi
        kdtP2kZJUu8V9fJvqDvfpd5647qaYd/3s1Q86h+PqSGLGdlKa5I3pSmlntjTwWiQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qkfqm-003G6K-25;
        Mon, 25 Sep 2023 09:17:48 +0200
Message-ID: <7fd041470156c1e5da921d74c87fccac01aec4a7.camel@sipsolutions.net>
Subject: Re: [PATCH v8 0/5] Additional processing in beacon updates (v8)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 Sep 2023 09:17:47 +0200
In-Reply-To: <53c81779-d423-c266-c8bd-f9583538c2e5@quicinc.com>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
         <46340c48-285e-4e2a-b6e9-802f922f0c2c@quicinc.com>
         <759fb125-7bfc-7d85-5c71-0a134030a9b9@quicinc.com>
         <6e680b33-55f5-2c49-3458-6baa4d8cff52@quicinc.com>
         <1912863dcd17aa50b09d1ddfc889478eb323f901.camel@sipsolutions.net>
         <53c81779-d423-c266-c8bd-f9583538c2e5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-09-18 at 15:29 -0700, Aloka Dixit wrote:
> > Alternatively, maybe we should indeed change the prototype again and
> > introduce a new struct cfg80211_ap_update that contains only the
> > parameters that change?
> >=20
> > That feels a bit harder, but really it isn't by that much - in mac80211
> > ieee80211_set_fils_discovery() etc. already take the sub-parameters
> > (&params->fils_discovery), so not a problem there, and in nl80211 we
> > could as well pass struct cfg80211_fils_discovery directly to
> > nl80211_parse_fils_discovery() rather than the entire struct
> > cfg80211_ap_settings, which wouldn't be a massive change.
> >=20
> >=20
> > I think maybe I even prefer the latter if I'm looking at it now, but I'=
m
> > not sure I'm not missing something from earlier discussions on this.
>=20
> The second option will take couple of weeks due to current work load.=20

Since you didn't seem to be opposed, I just did the second thing myself
now, it wasn't really hard. :)

johannes
