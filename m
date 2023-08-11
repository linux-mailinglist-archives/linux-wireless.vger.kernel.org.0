Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4350B7789AC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjHKJ1n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjHKJ1l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:27:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195992D5B
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zmfVfOKd0cmYZ9LiURywzOadDhZw5drhnkJZBl9fPMM=;
        t=1691746061; x=1692955661; b=PsqAhDoLlhYmoPeXOEHopP5L1pXllLIMHQZc31lU2ENk3Wi
        NkmNuxCLWG32LtLVaFemi2iiqVLLdImI58fioWlOGSKZOok0L8aSJndEM+0o2kNvp8AntL9mSW/GY
        FsX67o5iRoqJkA4nTrrOrHKLFBjVI7Qzto8AiQMc6ZCIcRf2M6tMVWrwsrLR4nDX44k8RaSreyTeg
        K7/HTCWKtafUCqU/4Z6/StJBfbVdQUGD02qPAAE1YrUt0z6utbwavWSpWjk8TUASVtKSS/pl2/ISN
        LT0Qvir3/DF9OUV1rnyVphHJmZ5qUnU+9MBznW9fDa9Ce6ARRKm3oWOflbVedfGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUOQk-000pjM-0I;
        Fri, 11 Aug 2023 11:27:38 +0200
Message-ID: <1ec93eca79a7bc96c1498b771c3b6ea2ebc78d95.camel@sipsolutions.net>
Subject: Re: [PATCH 61/76] wifi: nl80211: add EML/MLD capabilities to
 per-iftype capabilities
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org, quic_rkaliapp@quicinc.com
Date:   Fri, 11 Aug 2023 11:27:37 +0200
In-Reply-To: <29ab2b41-0adf-3a04-6eb9-3d5666253eb9@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
         <20220713114426.4dfc9ebd0461.Ice7b841051cfeb23da17bb2caa0e45191b34c4db@changeid>
         <d2f17799-6d90-9d72-a389-565163d723d2@quicinc.com>
         <f577425e2d4fd6141c29bcbfbea919565da9326d.camel@sipsolutions.net>
         <cc6b83eb-ac30-34fc-4827-290a9ae25378@quicinc.com>
         <8627bb8a3dddc33be7f1f97f30fc0f716328ff81.camel@sipsolutions.net>
         <29ab2b41-0adf-3a04-6eb9-3d5666253eb9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-08-11 at 17:24 +0800, Wen Gong wrote:
> >=20
> > And again, what would you do with it? Not advertise EML when you have
> > selected links that are not in the map? And if the links change
> > dynamically in the future? You'd probably need a bunch of validation fo=
r
> > that.
> For example, for station, NOT support EML on 2 GHz, support EML on 5=20
> GHz/6 GHz.
>=20
> When connect to 2/3 links AP, then EML should NOT add in assoc req while=
=20
> connect to AP which is 2 GHz+5 GHz or 2 GHz+6 GHz or 2 GHz+5 GHz+6 GHz.
>=20
> EML should add in assoc req while connect to AP which is 5 GHz+6 GHz.

OK, at least that answers the question what you'd want to do with it :)

> For dynamic link change, it is another new topic, so I have not good advi=
se
> for that.=F0=9F=98=81

But everyone's looking at that?

Honestly I'm not even sure - and you might know better - what the EML
capabilities matter for if you never enable EML.

So almost feels like if you never send the EML OMN frame (thanks for the
name!) the AP wouldn't really care, and that's something you could do
very easily without changing it, i.e. you pretend that your 2.4 GHz
actually has EML, you just never enable it in case 2.4 GHz is active?

johannes
