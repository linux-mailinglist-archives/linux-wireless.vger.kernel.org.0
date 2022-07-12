Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD65712EE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGLHRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiGLHRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 03:17:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AE76EB2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=W503xk0Pd1/X8fJaBuGoRely4zQTWmvKCLjhiwUgMA0=;
        t=1657610271; x=1658819871; b=BuKVqt6qx7VLt2VF5NxzQmZDMoQSQ67a0IhY1WRmQ8jbPsX
        eTgRnjDA1wy87EAuDoOOFFBI3vrFU0IZUpDRVAz622Cc3OTc772VXldAhFJf12X0Apfi0dbb1uXD3
        Wg6P1h/Z08iMUQRvEcoTW25OdYXfuYk6kTanzfRj0iTy3AVrgZmlzpV/gdP0g0YARxWcydjv4TzLp
        qsQbBLolG8xNHUZoXWKtCUBVdg0ad2PG5+e0KJvwlHvYa7Lhe97BFkMhF+ZngN3zBp2KxU7Lr5G4i
        0hKcxIALtRsfi9x7afae8T5demMSV6LVxTGvmENYjU0rUwoeq8nINYzBRfz5j51A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBA9G-00DddQ-FB;
        Tue, 12 Jul 2022 09:17:34 +0200
Message-ID: <9803367be1f2e1a16c79dc6c413717db769941bf.camel@sipsolutions.net>
Subject: Re: [RFC v2 59/96] cl8k: add rates.h
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Viktor Barna <viktor.barna@celeno.com>
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com
Date:   Tue, 12 Jul 2022 09:17:33 +0200
In-Reply-To: <20220711231755.2955984-1-viktor.barna@celeno.com>
References: <79365d0387a73baa82cf07c81637a622492ed9d6.camel@sipsolutions.net>
         <20220711231755.2955984-1-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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

On Tue, 2022-07-12 at 02:17 +0300, Viktor Barna wrote:
> On Thu, 26 May 2022 21:54:36 +0200, johannes@sipsolutions.net wrote:
> > that makes it sound like these are firmware things and should be endian
> > safe?=20
>=20
> Yes, it should, thanks! PS: can you, please, clarify whether it is ok to =
reply
> with =E2=80=9CACK=E2=80=9D for all comments, those does not imply anythin=
g special in response?
> Just to show, that we saw the comment and will take it into account. Or =
=E2=80=A6is it
> enough to mention that in RFCv3 changelist? We are grateful for the revie=
w!
>=20

From my POV, it's sufficient to list in the version changelog "addressed
comments from <person>" or so, not like in gerrit where you have to mark
as "ack"/"done" for each comment :-)

Of course if there's something where you disagree or want to solve it in
another way, it's probably easier to continue the discussion with that
comment instead.

johannes
