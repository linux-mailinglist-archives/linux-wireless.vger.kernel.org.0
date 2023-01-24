Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371D6792D2
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jan 2023 09:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjAXIPf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 03:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXIPe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 03:15:34 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4567DC
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 00:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=h5P/w6x891psTS2y2uhkCXgAj+J7UHFjwE56OO7boPY=;
        t=1674548133; x=1675757733; b=GC+eR1I02rKSdAPUHf1A8adLVwlm8NHtfF7WKxKSo4VvOk/
        jUmiE0e+eeLIHDY0VpdpuvpABJXw2uqHWjDvE+ctosifXF5cX4MLSCw9/LE/SzTAJ3NRGfdM6ZvNY
        OQjdJbSdF0V0CPI3QNdylc59bjf2QMn52NIqHHEZFwu3VBxzevl6sJEqv0u6hjEelaUGQQq0qSjpv
        BdKfV2We7QvK95etAhak4+iERJX2W9l2mooHBPwvkvBs72+cf/gu39MDvPQU9KtfuQEfakW24gjJW
        Y/JhEGsfDfliNWUd0s8GgSGixHQtFjmA70eY7ZsIHtCj+I5nRW/wjxbcFODF6Hwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pKESo-00An6w-0f;
        Tue, 24 Jan 2023 09:15:30 +0100
Message-ID: <8f6ef579e218a77cef08926f5472e5534d457e8a.camel@sipsolutions.net>
Subject: Re: BUG: KASAN: use-after-free in ieee80211_mgd_auth
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Tue, 24 Jan 2023 09:15:29 +0100
In-Reply-To: <c80f04d2-8159-a02a-9287-26e5ec838826@wetzel-home.de>
References: <20230112173808.6205-1-alexander@wetzel-home.de>
         <1d2ac266daf0e68d60d5a7074f96b2962c733a41.camel@sipsolutions.net>
         <c80f04d2-8159-a02a-9287-26e5ec838826@wetzel-home.de>
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

On Mon, 2023-01-23 at 22:50 +0100, Alexander Wetzel wrote:
> >=20
> Ancient bug. The problematic code was added with
> 'commit fffd0934b939 ("cfg80211: rework key operation")'
> in 2009, kernel 2.6.32.
>=20
> The fix is trivial, I'll probably just zero key and key-len when not=20
> using wext. But maybe I find a more wext-only solution.
>=20

Is that actually good enough - what if you have wext and then wext
again, but didn't use it or something?

johannes
