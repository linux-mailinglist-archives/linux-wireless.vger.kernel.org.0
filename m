Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C36742B8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjASTXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 14:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjASTX1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 14:23:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFF268C
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lPcw3wh42izqPHhmTuOAkPASEaPRFwadcy3FCBLeprQ=;
        t=1674156153; x=1675365753; b=FV1g6PezaBcCUhe+Lo+jhePQI/Z6fAAfmLAEDRHGFIx9UYC
        WeXtHcTasOMq/oNlHn3DEyg81avzM+8CS9UIeYkYHbyUy04wvGEroXKtrYxNj8cgiGVrGV9H1I+ys
        teN/OfzzJ7WgJsA9mV3TPXheWayT6lgfLQ/lCva+e1x5QM0JQdqUwlDEI8JaCyVhIDoQI9uQ/pLt7
        9W+X5lQXCQqclO8WnCBNOntQZfOYOWZpwIxYRzu8HV1tu5xxldpTTy2AXLpb63ccfoH/UqNGwl8U/
        xiHGLhNxK3SdOAIxqoCuN+jfKC+5x2dChAa74c3untTl7saH6/0OHCN+DKYPO4vw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIaUX-006coq-29;
        Thu, 19 Jan 2023 20:22:29 +0100
Message-ID: <1592b9b4354d67c104d2782915e1a66d0a972b92.camel@sipsolutions.net>
Subject: Re: every other wireless scan shows bogus (too low) signal strengths
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bruno Dantas <dantas@airpost.net>,
        Julian Calaby <julian.calaby@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 20:22:28 +0100
In-Reply-To: <90bb34e9-4e83-dcc2-91f2-e6f28ddbcc73@airpost.net>
References: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
         <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net>
         <9093c08e-302d-578c-3e16-619d238b4022@airpost.net>
         <CAGRGNgVGsii7+jdN3PnMWdCSeRyCDF96ivVOfxzi8xDufUigNw@mail.gmail.com>
         <90bb34e9-4e83-dcc2-91f2-e6f28ddbcc73@airpost.net>
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

On Fri, 2022-12-02 at 10:21 -0500, Bruno Dantas wrote:
>=20
> Maybe doing a wifi network scan requires more power than just
> authenticating with an AP and using the network? And maybe my after-
> market 802.11ac adapter requires a bit more power than the 802.11n
> adapters that were around when this laptop was made? If so, maybe it
> takes this old laptop's PCI bus two attempts before the 802.11ac
> adapter has enough power to do an accurate network scan? That's a lot
> of maybes, but it's my best guess given the behavior I'm observing.
>=20

FWIW - and sorry I didn't get around to answering here earlier - that
doesn't really make a lot of sense - we're talking about the report of
"received signal strength", which is pretty much unrelated to the power
you need to actually receive.

But as to what's actually going on I still have no clue either, sorry.

johannes
