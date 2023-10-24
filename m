Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF07D5CA4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjJXUyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 16:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344067AbjJXUyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 16:54:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50410CE;
        Tue, 24 Oct 2023 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eczaaR5q+CGZ3I8qy3H/FRI3HwlrnLDnYPRKVQMfxDw=;
        t=1698180893; x=1699390493; b=OiXrljXOE0GtZC+BppNsSdVulyWEQ2XZjnTE+VrLHk2Cjwd
        ldNI5DrVw5h3I534dfl6In0+hqaZGstI2x9DwIAhoCYzLWgWG/GgJdhJy2XzrZ8eK3WqOegb06EQB
        wKfF3lIcqvpQn8BSWblJ156GyA/hFn9TlJfbfexhIvhTg979aemGAiefiDDge7ZKUHnynOeFRZCx1
        H46GHV7XZfhaodpXAOQPBh+yCrH5+EKnmwuqGetbX/0xA93LhMsmDVJDH0bzfJ5ZhGDiYtT67P4S0
        4fnTgS94272yIC61vQZa9JZOeep5GcoE6JUenlTCNlczbF8+yZkOJLuIj/U4emOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qvOQM-00000001bj2-3kYI;
        Tue, 24 Oct 2023 22:54:51 +0200
Message-ID: <f53b015defece9c4b29fbecfaa6fc50d2f299a39.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2023-10-24
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Tue, 24 Oct 2023 22:54:50 +0200
In-Reply-To: <20231024135208.3e40b69a@kernel.org>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
         <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
         <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
         <20231024135208.3e40b69a@kernel.org>
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

On Tue, 2023-10-24 at 13:52 -0700, Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 22:25:18 +0200 Johannes Berg wrote:
> > Are you planning to merge net into net-next really soon for some reason=
?
>=20
> Submitting on Wed did cross my mind, but there's no solid plan.
> Unless that changes, Paolo will submit net on Thursday, EU time.
> And we'll cross-merge once Linux pulls.=20

OK, sounds good.

> > If not, I can resolve this conflict and we'll include it in the next
> > (and last) wireless-next pull request, which will be going out Thursday
> > morning (Europe time.)
>=20
> Sounds good! But do you need to do the resolution to put something=20
> on top? Otherwise we can deal with the conflict when pulling.

No, not really, nothing left that's not in wireless-next already (I
think), except maybe some tiny cleanups.

Just trying to make it easier for you, even if it's really not a complex
conflict :)

johannes

