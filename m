Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50178C99D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjH2QZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjH2QY5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 12:24:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9027C1BD
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YiIkLfGA64bAJkLi8lO+yyhz0oBQ1+K9RpSFcbjV4CI=;
        t=1693326293; x=1694535893; b=pfBAgU/lIr0M5VyFWxJvvsLmh4+81ZPNVjXjN8noCvRJ6vo
        pgF0mRN2r54jBaCUhawY5AD84WZoNVF277VdHDz3VPWmM9nJ9hHadODW+kD8vShu+6Iuq68Fks9yW
        9PMfurwjV8n1N7J3lEU1S3gjmkXUG+gIxwJsXt6cdw6aMor7lZCIf0Mb243Q/mpxARW0eAI9Cwkl1
        +q4L2gFXwidgL1QDnNYw5ZRxE8ozc3phbB+cDgyEzXYUqJ3Ot/5vcCLaaD0WlrtvNWXVyLIe1azhb
        C1Lu1x3MfbdeXeeBv4ByJ/GCbPaWWnmqUMgvGPmSC1kTcxCw9qW5ZItyZXeQCm4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qb1WM-001LW6-1H;
        Tue, 29 Aug 2023 18:24:50 +0200
Message-ID: <50d2dd83079d01e1c260590cd5470e3a534b4a66.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: remove scan_width support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     Xinyue Ling <quic_xinyling@quicinc.com>
Date:   Tue, 29 Aug 2023 18:24:49 +0200
In-Reply-To: <5b809506-7fea-4598-b6ae-39ea94cc2849@quicinc.com>
References: <20230829121742.634a0631eaf3.I38b5dcce8b130f93743a2d43ab9d89269b937b5d@changeid>
         <5b809506-7fea-4598-b6ae-39ea94cc2849@quicinc.com>
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

On Tue, 2023-08-29 at 09:21 -0700, Jeff Johnson wrote:
> Just want to remind that there were two proposals given to allow setting=
=20
> this from upstream:
> <https://lore.kernel.org/all/20230301090242.1613672-1-quic_xinyling@quici=
nc.com/>
>=20
> In the thread you asked for additional information:
> <https://lore.kernel.org/all/6796c3c209a071983d330ca145d7ab8b929d53c6.cam=
el@sipsolutions.net/>

Yes, I know. I figured it was long enough ago :P

> So to see if there is any update on that request Cc: Xinyue Ling=20
> <quic_xinyling@quicinc.com>

Sure.

> Would hate to see this ripped out just to need to replace it later.

I actually wouldn't mind that much. I have a gut feeling that at least
the mac80211 part will actually not be of any use to Qualcomm since most
of the things I see these days are for non-upstream drivers anyway.

Therefore, it would actually make sense to understand how this could be
done properly _without_ supporting it in mac80211, because it's clear
that just adding support for it as proposed in those patches will break
in mac80211 pretty badly.

If we even decide to go that route, because honestly, I'm getting pretty
upset about the whole Qualcomm adding various APIs that we never see any
users for, then not maintaining it, _and_ complaining that we don't fix
things upstream quickly enough.

johannes
