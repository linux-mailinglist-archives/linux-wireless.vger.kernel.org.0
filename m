Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6953746DE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhEERcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbhEERVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 13:21:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD6CC0611A9
        for <linux-wireless@vger.kernel.org>; Wed,  5 May 2021 09:48:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1leKhT-004ZgZ-BU; Wed, 05 May 2021 18:48:39 +0200
Message-ID: <333ba6b138390ca1f45b8ac2aab1152397c41bd7.camel@sipsolutions.net>
Subject: Re: Possible bug in iwlwifi
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Michael Yartys <michael.yartys@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 05 May 2021 18:48:38 +0200
In-Reply-To: <0IuWBg5tqXtBE836_CvCmwVzEXWDOGZ4dyETg5_WBWUC8bMDR9vFORGkgY6_WBqSi61GYW07WwH6aVzkc2-zhqWYp5JugyjWU_Bg1leD0vk=@protonmail.com> (sfid-20210505_150701_630699_48CDE0E4)
References: <qnvkj7tfHuYKasegaKViuXD0K4KlchNwXkLn4NUZu_KWsp7nEBa4LyQm7SNRm27eQLALJTyi1-xIYXMChMeuZAKS5F_q-rhb0DVVGqv0oUc=@protonmail.com>
         <7a5d0173cbfdef24b1e74c0bfc8f7410ff044817.camel@sipsolutions.net>
         <_p2InUu49ZKWc_249MDFWW8bre6iNHIJDvsoV6Rsb3oLyWj7wat48aLpnqIDVeKZKwSq-uZ1Fy_wlDwHMYJ5-JacdxF75NL5fLvpWrNCUO8=@protonmail.com>
         <E3bg7aVzJHQEHxAd21kjOlTrLqG0U3Jt7iBCDDTVCI4FYSdGROu-UKmRuM05cl8pxTBlo4pjeoYkTtKFFFYiezrdXVybrKs-6qBCAkZJ-sU=@protonmail.com>
         <0IuWBg5tqXtBE836_CvCmwVzEXWDOGZ4dyETg5_WBWUC8bMDR9vFORGkgY6_WBqSi61GYW07WwH6aVzkc2-zhqWYp5JugyjWU_Bg1leD0vk=@protonmail.com>
         (sfid-20210505_150701_630699_48CDE0E4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-05-05 at 13:06 +0000, Michael Yartys wrote:
> Sorry for being a bit spammy here, but I forgot that I could simply
> run "iw scan" on one of my two routers to see how it sees the network
> on the other router:
> 
> $ iw dev wlan1 scan -u
> BSS redacted(on wlan1)

Hm. That looks fine.

Can you do it again with --debug? But then it's hard to redact things,
so maybe send it to me in private.

Thanks,
johannes

