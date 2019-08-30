Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 852C7A310F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 09:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfH3HcN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 03:32:13 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59810 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfH3HcN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 03:32:13 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3bOF-00007y-3r; Fri, 30 Aug 2019 09:32:11 +0200
Message-ID: <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Ramon Fontes <ramonreisfontes@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 30 Aug 2019 09:32:10 +0200
In-Reply-To: <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com> (sfid-20190829_210601_376380_DF9028CF)
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
         <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
         <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
         <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
         <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
         (sfid-20190829_210601_376380_DF9028CF)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-30 at 00:35 +0530, Krishna Chaitanya wrote:
> 
> Is this supposed to work at all? AFAICS, in hwsim channel matching
> checks are only done in non-mediumd path (no_nl), and wmediumd also
> doesn't have any checks? So, hostapd responds to all probe requests in all
> channels. Am I missing something?

Hmm. Interesting observation, I wasn't aware of that.

That certainly explains the situation though - on 2.4 GHz we'd prefer
using the DS Element, and thus not use the scan result, while on 5 GHz
we assume that the reported RX frequency is correct (there's no channel
overlap).

Still doesn't explain why it should work in 4.17 and not in 4.18, there
aren't a lot of wifi changes there at all.

I guess we should fix that in hwsim, anyone esle want to? :-)

johannes

