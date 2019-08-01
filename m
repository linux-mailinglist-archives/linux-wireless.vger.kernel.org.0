Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547CB7DCCC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHANtg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 09:49:36 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34010 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfHANtg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 09:49:36 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1htBSY-0007e1-RS; Thu, 01 Aug 2019 15:49:34 +0200
Message-ID: <023cd67f2f0b540bd9921f725be8c36f9ab4a531.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Thu, 01 Aug 2019 15:49:31 +0200
In-Reply-To: <8a445e39175f1aaf7cc3eaa6c4474619@codeaurora.org>
References: <1563194767-4817-1-git-send-email-ailizaro@codeaurora.org>
         <1563194767-4817-2-git-send-email-ailizaro@codeaurora.org>
         <4deeee0289e706d5e594d00d987c233fb8fb25b5.camel@sipsolutions.net>
         <8a445e39175f1aaf7cc3eaa6c4474619@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-01 at 16:15 +0300, Alexei Lazar wrote:
> On 2019-07-26 16:29, Johannes Berg wrote:
> > Hi Alexei,
> > 
> > I'm not exactly sure why, but this breaks practically all connectivity
> > on 2.4 and 5 GHz channels (at least in hwsim tests).
> > 
> > Please check and resubmit.
> 
> Sorry for this issue, we have run hwsim test through wpa_supplicant and
> catch small issue that caused the tests to fail - fix raised.
> Can you please share with us how you run the hwsim, you also used the
> wpa_supplicant unit tests or some other tool?

Yes, I keep saying "hwsim tests" when really I mean the hostap hwsim-
based tests...

johannes

