Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2496B8DA9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 09:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCNIlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCNIlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 04:41:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415E44AD
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dVb4gAO71J8MtLsBZxF7wSZshBDUDV57ylAGv5kkjak=;
        t=1678783258; x=1679992858; b=vWR3aFsBWfk6LpEV17uk9Ev/sDO9lxAuuH3abTnCoy4Axh2
        ujSoeLUVueqnIOrh+NExggKdAOrMd1WohW3MSHiX0TgPUPAUgAD4aCyFTlOykE1zw6kAao2/1hPUV
        eYNrOTdzPwof5NAMlQY0zKRhGKnocqu5RyWu4bCZl1FodPg92HSZghrkBuEgu7xXuZnfAGsn5L2Pv
        yZZLAaEK7/l5Ne1TiRCiv8FnTFe9KBqwM3qM7bvy/rzdbwt1D6uxUkTf2Gn0dDpgesFFqvavCnEdN
        Hqoy/2HMg7lZf4dWOHTBLQSLd+SUrdwiPGUhi++OKccpjVnJaEv6mBPC0aP5kFwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pc0DF-0034dy-2g;
        Tue, 14 Mar 2023 09:40:53 +0100
Message-ID: <6528ceb761b7be9862dfc5e404031e832f086cb3.camel@sipsolutions.net>
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
Date:   Tue, 14 Mar 2023 09:40:52 +0100
In-Reply-To: <c9a31a6c06fe7a48df1d7871ac563b6f71cd4436.camel@mediatek.com>
References: <20221222091354.14050-1-michael-cy.lee@mediatek.com>
         <277f8db1f790931aaac0f94ba0ea69efcb6ba3ac.camel@sipsolutions.net>
         <70f19f86043750c8f164c316496a8690709fc062.camel@mediatek.com>
         <386c21d475215c95966bbac6b0853e2715081789.camel@sipsolutions.net>
         <c9a31a6c06fe7a48df1d7871ac563b6f71cd4436.camel@mediatek.com>
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

> It matters because Extender's STA interface's ifmgd->flags is changed
> during bandwidth downgrading and remains changed to the next
> association.

OK but then _that_ seems like the problem here, no?

> Since there is no way to reset ifmgd->flags after bandwidth
> downgrading, we check the control channel before downgrading the
> bandwidth. If the control channels are different, we directly fail the
> association.
>=20

Right, but what if you had an association to some other AP, or two
chanctxes were allowed, or something else?

I feel we should probably instead just reset these ifmgd->flags before
association, or so?

johannes
