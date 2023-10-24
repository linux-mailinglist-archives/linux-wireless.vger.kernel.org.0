Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746AA7D5CDC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 23:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbjJXVDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 17:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXVDd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 17:03:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9F10CE;
        Tue, 24 Oct 2023 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=U6f71o0M8j67PJk0jApPuiTvaRlL6vkWjyyB+z+T3ss=;
        t=1698181411; x=1699391011; b=QH2Ig5DCPYpmPrdBXvw2+qP34j5AYNlUF7EwT0qStk2gkIR
        NosE8Gv43zzB9/NGHUzI/WvEAReVJ50UvKUluNKnyOgkoPQGDSjmJS6L5J3JN09U5QDL3jrAzc5CT
        qfNDdRM2ZpI5BVBQs7OLau/IWB7M8p3ayaHfWm51b8dge08sAolA8yANpxuoD5A7qmCg2H9wmnOfg
        0O3t+hyEthwvkT3txrfaKJ8VS2Qdd2Zx4X/5BMirEYv43TM62Pr7WMjTNPUxE7DPlNTFGJEI+sKNT
        qpg5t6Ki74uFmmxqMRhJw+9W93MWH9y7R2iO66Wyu687l4UUHdQZOtjlj7bEM/3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvOYj-00000001bwn-0gTI;
        Tue, 24 Oct 2023 23:03:29 +0200
Message-ID: <03a72c1e38a8967e477ea3edeaff3839c6149899.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2023-10-24
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Tue, 24 Oct 2023 23:03:28 +0200
In-Reply-To: <20231024140146.0d756a96@kernel.org>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
         <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
         <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
         <20231024135208.3e40b69a@kernel.org>
         <f53b015defece9c4b29fbecfaa6fc50d2f299a39.camel@sipsolutions.net>
         <20231024140146.0d756a96@kernel.org>
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

On Tue, 2023-10-24 at 14:01 -0700, Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 22:54:50 +0200 Johannes Berg wrote:
> > > > If not, I can resolve this conflict and we'll include it in the nex=
t
> > > > (and last) wireless-next pull request, which will be going out Thur=
sday
> > > > morning (Europe time.) =20
> > >=20
> > > Sounds good! But do you need to do the resolution to put something=
=20
> > > on top? Otherwise we can deal with the conflict when pulling. =20
> >=20
> > No, not really, nothing left that's not in wireless-next already (I
> > think), except maybe some tiny cleanups.
> >=20
> > Just trying to make it easier for you, even if it's really not a comple=
x
> > conflict :)
>=20
> I think "Linus rules" would dictate that cross-merges to hide conflicts
> are a bad thing. We don't have much to win so let's stick to that :)

Fair enough :)

> Hopefully I can deal with the resolution, but if you want to be 100%
> sure - you can drop a git-rerere resolution somewhere I can fetch it.

No need I think, just the return codes changed in the -next version for
better skb drop reasons :)

johannes
