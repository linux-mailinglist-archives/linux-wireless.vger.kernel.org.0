Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698C77E9D1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjHPTkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 15:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbjHPTkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 15:40:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6561FE1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gmGBxIVo6beVUeWlJXTEJPUznlJM4Ddgo8w/TdYTkwo=;
        t=1692214808; x=1693424408; b=s6/S4vlAlMnvtRsjh0tWaRYjKPR/JttQLvi/3o1TGIzukDB
        q374huXbVWkqkzWbiuJEYI8nvTw29qmKnxqctt6mUHlegjWsXPQgdno+3KO0mtQn22bOBTXJJ8L1I
        6KQPlY8vj3cpf5roktwmEyEnlRHBhRDFbCqqM/IeU+z8eH7L4kTNvIIei4i6ifyHCfVpAHsGzf7je
        Y5fEe5t6tceCoU4Vgh0fdSvPd4wkieFvg59W5bBEUpXCvxBBZWAqlG77X418XHRIxwJH2WLygi971
        iglpR5jAdby3D9wH2LVWETXk82vTd3taTIU5aGVs1d6nZ7FSQubbUTrsg0/bw3BQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qWMNA-00BKS4-1L;
        Wed, 16 Aug 2023 21:40:04 +0200
Message-ID: <42f54a7b9c1442fa2ff4ee98bf20f9c62657b482.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix puncturing bitmap handling in CSA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 16 Aug 2023 21:40:03 +0200
In-Reply-To: <29ee491a-a713-ae91-db00-a5306c340a97@quicinc.com>
References: <20230816100412.e2677a05ffd3.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
         <29ee491a-a713-ae91-db00-a5306c340a97@quicinc.com>
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

On Wed, 2023-08-16 at 10:22 -0700, Aloka Dixit wrote:
>=20
> Looks okay, though I remember there was a reason I had put it at the=20
> top.

Odd. I wonder why? It seems wrong here - in some cases it might apply it
before it even goes to the new channel?

To be fair, we should maybe split this work and not use it for the whole
"once reservation is complete" part?

> If this causes any issue I will send a follow-up later.

Oh, I can wait with this too - clearly puncturing with CSA isn't really
even on my list - I was just trying to make sense of this code due to
some other (syzbot maybe, I was looking at those a bit) issue, and this
stood out as "looks wrong".

So if you have any tests you'd like to run with the patch first, just
let me know and I can just hold off applying this.

johannes
