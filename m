Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963857650F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGZMCR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 08:02:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47982 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfGZMCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 08:02:16 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqyvP-0002Nq-1Q; Fri, 26 Jul 2019 14:02:15 +0200
Message-ID: <9e95c120de95c9f5f64ea8e589f036a1d338ad96.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Fri, 26 Jul 2019 14:02:10 +0200
In-Reply-To: <20190726101150.lykay6apgzvsb4ov@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
         <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
         <20190712092716.ywnkns473s5rtoku@bars>
         <43055be7b2d7ff0f8dbadd19443fc73f30f93bb6.camel@sipsolutions.net>
         <20190712105212.clf77zne6i4gh5ti@bars>
         <2efa83ab8120e29d1eb1be8295d59568b4eacc9a.camel@sipsolutions.net>
         <20190726101150.lykay6apgzvsb4ov@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sergey,

> Yes, this is the use-case that I tried to address in the last revision
> of the patch.

OK! I didn't see it here and I guess I didn't look at the latest version
yet, or I missed it.

> If you take a look at the top of new cfg80211_update_assoc_bss_entry
> function:
> 
> +       /* use transmitting bss */
> +       if (cbss->pub.transmitted_bss)
> +               cbss = container_of(cbss->pub.transmitted_bss,
> +                                   struct cfg80211_internal_bss,
> +                                   pub);

Right, makes sense!

> Actually one of the major concerns is the lack of testing for the 'multi-BSSID'
> scenario. I verified the 'normal' scenario using both mac80211 (iwlwifi) and
> FullMAC (qtnfmac) cards. But at the moment I don't have any mac80211 card
> supporting multi-BSSID.

You might be able to do that with hwsim? There are multi-bssid test
cases in the hostap repository, and CSA test cases as well, so I guess
it'd be possible to come up with a combined one.

I'm not *too* worried about this though - we're still all testing and
developing this.

johannes

