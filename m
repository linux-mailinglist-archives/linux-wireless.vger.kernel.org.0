Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C265710CA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfGWFHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 01:07:37 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46958 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbfGWFHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 01:07:37 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hpn1Q-0006JY-Jl; Tue, 23 Jul 2019 07:07:32 +0200
Message-ID: <262fc08905febd29f9abd0870dbe674fcc5bfb3e.camel@sipsolutions.net>
Subject: Re: nl80211 wlcore regression in next
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Date:   Tue, 23 Jul 2019 07:07:31 +0200
In-Reply-To: <20190722130213.GN5447@atomide.com>
References: <20190625073837.GG5447@atomide.com>
         <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
         <20190625080019.GH5447@atomide.com>
         <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
         <20190722130213.GN5447@atomide.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> Looks like this one crept back as the fix is missing from v5.3-rc1.
> 
> Forgot to include in the pull request?

More like forgot to send the pull request, my bad. I eventually realized
a couple of days ago and it'll be coming upstream soon. Sorry about
that.

johannes

