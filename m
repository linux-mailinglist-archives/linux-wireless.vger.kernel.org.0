Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAFF63EAB3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLAH7A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 02:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLAH6Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 02:58:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C5AE7D
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 23:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ow8C1FqQ2+KSeNUY/9D0bM7AIYgRt3TKkgCpElpsLkU=;
        t=1669881460; x=1671091060; b=q+xGnSjaWUKYjFfTD/3hhIwHeWSepU1izJGLDGaK3uAyqVL
        sGos98/V7Yn+uyKw3bQffDRcmlariAAU91+Sdq30D1Wl572KRZq7/rHc2/+5CDwcYEnP9fPXuNQKI
        GQAmN6vHVUI2UZCnQmuOx9CkhONjrvu0XMd/YYX0CabP0EDIsOC391O/B+G2irRQlX6hIxHs1DUMv
        THDo7+4k5QjKFG7wy94WvwITj1rShH81eNE+pPSQftwYpIDGyx2CQ9j4rm5MijpSPZocLl8HnySx+
        CXx31OwT1i1oQob3pL/u6JyGpCg7scWTcj8rZWszfnEzTMvJAyxi0faqXC9ybu1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1p0eRs-00DygG-2o;
        Thu, 01 Dec 2022 08:57:37 +0100
Message-ID: <80556c56e69405d7c8f8bc3d57e2ba697074c660.camel@sipsolutions.net>
Subject: Re: every other wireless scan shows bogus (too low) signal strengths
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bruno Dantas <dantas@airpost.net>, linux-wireless@vger.kernel.org
Date:   Thu, 01 Dec 2022 08:57:35 +0100
In-Reply-To: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
References: <b48efa92-9eee-d491-1149-a7cee08300c0@airpost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Wed, 2022-11-30 at 16:19 -0500, Bruno Dantas wrote:
> I have an X230 ThinkPad with coreboot and Intel Dual Band Wireless-AC
> 7265 card, which uses the iwlwifi kernel module. Module's wifi power
> saving is off (the default setting).
>=20
> When I scan for wifi hotspots at the command line, every other scan
> gives me bogus (too low) signal strengths and every other scan gives
> me expected signal strengths:

> [...]

> Does anyone know why this happens and how to fix it so that every scan sh=
ows the expected signal strengths?
>=20

I think this NIC might be switching antennas for scan every time.

If you're able to open it, it might be a good idea to check if they're
both connected well, almost seems like one might not be connected quite
correctly?

Not sure I have any better idea.

You could record debug data with trace-cmd [1] and then at least we
could confirm this is the case.

johannes

[1]
https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#tracing
