Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0F6B8C20
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 08:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCNHnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNHnM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 03:43:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42358DCD8
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OPErrmfX7RzbPKHNnUerrbkZQJ7vI3D1tDNrwx/mxMs=;
        t=1678779791; x=1679989391; b=IEz9rW9gSSQS5ZRP0108/rOryf6bCJIWtP5GFHNlvGTN7gW
        r+E4spskH/9DseSiSILPtHB6QVV0fHnaBBJ9RcBFIHQNsEXfB7oxz/1NhXp0Y6B2Y797grgfxaR+1
        0OA4nkzbuJPteosC+BOYcEgQpWDl9ilVZBSfeylSZd6Njxhze12H34jH4/+eX8j4dSLa26YWMMtSr
        WGeSBc+r5w2fDBETeP2zpGwoP9y9Ecw6PLtqKW2Id7xtHup4It5G4nM621KuVjg+Ewjd7Erx8NloC
        dNbh9IrMe83Ve9/gDZlNLpDyo8fN8abUUre9FMx9LGJPfCSVZkQcV1NceG9O4bBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pbzJH-0033bi-1W;
        Tue, 14 Mar 2023 08:43:04 +0100
Message-ID: <386c21d475215c95966bbac6b0853e2715081789.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: check the control channel before
 downgrading the bandwidth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?= 
        <Michael-cy.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?= 
        <Evelyn.Tsai@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Shayne Chen =?UTF-8?Q?=28=E9=99=B3=E8=BB=92=E4=B8=9E=29?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?= 
        <Money.Wang@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Date:   Tue, 14 Mar 2023 08:42:59 +0100
In-Reply-To: <70f19f86043750c8f164c316496a8690709fc062.camel@mediatek.com>
References: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
         <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
         <70f19f86043750c8f164c316496a8690709fc062.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> To deal with such an error case, Extender=E2=80=99s STA interface would
> downgrade the channel bandwidth (from 80MHz) and run
> ieee80211_link_use_channel to check again until the bandwidth becomes
> the minimum 20MHz.=20

Correct, and then it fails.

> Since the control channels are different, downgrading the bandwidth
> cannot make ieee80211_link_use_channel to return 0.

Right.

> Finally, Extender=E2=80=99s
> STA interface bandwidth (ifmgd->flags) would use 20MHz afterward. (In
> the current kernel version, the flag is link->u.mgd.conn_flags)

Also correct, but does it matter?

> At this moment, a hostapd_cli channel switch command might be issued,
> making Extender's AP interface switch to RootAP's channel (ch36).
> Because the control channel now synchronizes, Extender's STA
> association attempt succeeds. However, Extender=E2=80=99s STA ifmgd->flag=
s
> remains in the fallback state and thus the operating bandwidth is 20MHz
> instead of 80MHz we expect.

So ... still not sure I understand.

Are you saying that

 1) you have a race, and hostapd switches channels while the client-side
    code is in the middle of this loop?

or

 2) the ifmgd->flags are not reset correctly for a new association?


johannes
