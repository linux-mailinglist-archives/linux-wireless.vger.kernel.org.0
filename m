Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701EA775EAD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Aug 2023 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHIMSR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHIMSR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 08:18:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA011702
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DQLHThCaayDo78KE2Hy9nCESygQGK76URhOSoh3WTjc=;
        t=1691583496; x=1692793096; b=pU6hyJLpZP0FCdDv2sabPymWn44WlFyWvl3AodzWKM+e+3u
        CXvkv85/z3nyz8y1NdmuITJysDYYe9mQ0NZKe/ojQZCbuLTEGqAqw//ML32UJLNHiwEnCDqLnojTu
        x9rupUqqAsGVm2EFWUr/GQkcBP1lfc3tghbCRCT86c0E59RYuocvKa9BZwZeNo7YFuGHDLmaqhM4e
        k/Gb9rLOJL1qyWIbAOhgsS+aUxCsMefm7bW/rNmnBv+0nHrLUScwTaT3XzvORPduv+n2/UrThd1P1
        q2ZRJX+SLWTRpvQamtJfbcbEUZBkFXmY2LKOZ0PpL4c8xUGsnO8Ra+bKfO3rQSaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTi8f-00Ecco-1U;
        Wed, 09 Aug 2023 14:18:09 +0200
Message-ID: <7b27fa9f59bec600069bba9c2acd9f28dd753923.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: ath12k: fix undefined behavior with __fls in
 dp
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Harshitha Prem <quic_hprem@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 09 Aug 2023 14:18:08 +0200
In-Reply-To: <5cabcc57acd781e90c35fcc9b3c6a8aa8fbaa581.camel@sipsolutions.net>
References: <20230809042738.13394-1-quic_hprem@quicinc.com>
         <20230809042738.13394-3-quic_hprem@quicinc.com>
         <5cabcc57acd781e90c35fcc9b3c6a8aa8fbaa581.camel@sipsolutions.net>
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

On Wed, 2023-08-09 at 14:17 +0200, Johannes Berg wrote:
> On Wed, 2023-08-09 at 09:57 +0530, Harshitha Prem wrote:
> >=20
> > During the crash, the fragment id of that packet was 0 and
> > __fls returned a junk value. Hence, it was identified that "__fls"
> > would have an undefined behavior if the argument is passed as "0".
> > Therefore, add changes to handle the same.
>=20
> Umm. That makes it sound like you are surprised by this behaviour of
> __fls() and expected something else?! Please go read the documentation,
> and then rewrite the commit message. You really shouldn't be surprised
> by this.
>=20

Also, btw, "Fixes:" tags would be nice for fixes. I'm sure Kalle has
brought that up a million times before ;)

johannes
