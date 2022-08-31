Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DDA5A8002
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiHaOWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiHaOWO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 10:22:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40441B2CE6
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Ehnarzbpxd7Ftbfec2OohmHqgzlPomf9Q0fvWcDKozA=;
        t=1661955733; x=1663165333; b=vNw9a4mvpx9MDXbyt4XOud7livxAdsp/GomY4AgjMB8g90u
        feCSySnl8j++S1R+p8GnwZpmnZgtIpOMtwXKtXsB6DPMUCkchnjvRDFQyiNvT7hYRDpXapKBnZzkw
        qaB0iugXiGuSCwxP9Q8aZoJtC6oEAA0cGo4mGwKV3CnEOgJwCjoyjf4Tbp6g+bUyW0MTkZaQf8zAN
        Ic031U1atG9aLUsDZPsrkL20g5uGSlP2Fgs7zOzmMjjN+0QQnoHtKrXLAyljHg0WfESclp9nXADSz
        ZMw2OfwcS6sIUJ7IlqtgcSWUTgmzg5xVNo1sp4U6DdNMhTod7456zMjaZV4xrjwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oTOba-004YWr-1i;
        Wed, 31 Aug 2022 16:22:10 +0200
Message-ID: <c9befe233be586eb2c949f7301784e948c3a6683.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        Thomas =?ISO-8859-1?Q?H=FChn?= <thomas.huehn@hs-nordhausen.de>
Date:   Wed, 31 Aug 2022 16:22:09 +0200
In-Reply-To: <7CFDCFCC-A369-4F41-90E1-A26591C20D92@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
         <467218ec220ea6e36b4222efc5c46e4e350fe1ea.camel@sipsolutions.net>
         <CE871D89-B996-4D8B-8C65-7C53382C30D8@gmail.com>
         <7CFDCFCC-A369-4F41-90E1-A26591C20D92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry I dropped out of the thread - busy with other stuff. I'll reply to
other mails later.

> I am working on the hwsim support right now, tpc support in hwsim=E2=80=
=99s
> control path is implemented.
> However I encountered a problem in the status path. Hwsim seems to
> hand over to mac80211
> tx-status asynchronously via ieee80211_tx_status_irqsafe only. There,
> the skb is added to
> ieee80211_local->skb_queue and then dequeued in
> =E2=80=98ieee80211_tasklet_handler=E2=80=99 to be passed
> to =E2=80=98ieee80211_tx_status=E2=80=99. For tx rates this is sufficient=
, but there
> is no space left in=20
> ieee80211_tx_info->status to pass the tx-power per packet.
> Please correct me if I missed something in the code.
>=20
> My idea to solve this may be: to use the SKB extension (struct skb_ext
> *extensions) to pass the=20
> tx-power information (and maybe more) for each SKB. Could this be an
> appropriate approach or=20
> do I miss something here? Maybe someone who is much more aware of the
> mac80211 layer=20
> design does have a better idea for this?

Is it even an issue to switch to ieee80211_tx_status_ext()? The context
here looks OK, although it might lead to (too?) deep call stacks.

I don't like the _irqsafe() versions anyway ...

johannes
