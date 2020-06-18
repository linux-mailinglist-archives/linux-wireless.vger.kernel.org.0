Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613D01FF597
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgFROsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgFROsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 10:48:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76FC06174E
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2020 07:48:21 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jlvq0-007l0e-5k; Thu, 18 Jun 2020 16:48:20 +0200
Message-ID: <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <Shay.Bar@celeno.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 18 Jun 2020 16:48:19 +0200
In-Reply-To: <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
         (sfid-20200618_113627_790574_4007E613) <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
         <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
         <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
         <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-06-18 at 14:45 +0000, Shay Bar wrote:
> > So... why would you ever do that? :)
> > johannes
> 
> :)
> Is it illegal to do "ifconfig <if> down" or kill hostapd
> while STA's are still associated?
> There are some vendors/users that are doing that.

It's not really *illegal* per se, but it would be weird if both did it
... But I do tend to think that if you're using hostapd or such to
control it, you shouldn't do another out-of-band control.

> Regarding Ben's proposal of using 11k/v, I couldn’t find such
> "going down" single frame in the standard (although sounds trivial)

Broadcast deauth :)

johannes

