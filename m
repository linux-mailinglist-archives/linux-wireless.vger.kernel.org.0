Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4925209C4B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390262AbgFYJvy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389744AbgFYJvx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 05:51:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AECC061573
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2020 02:51:53 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1joOXr-00BnlL-VR; Thu, 25 Jun 2020 11:51:48 +0200
Message-ID: <2a607392179a76f0f6fc3cef2e6e141f25dc0254.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <Shay.Bar@celeno.com>,
        Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 25 Jun 2020 11:51:47 +0200
In-Reply-To: <AM0P192MB0468ED699FC0BE6431812B03E7960@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
References: <20200618093609.16514-1-shay.bar@celeno.com>
         <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
         <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
         <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
         <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
         <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
         <f0b038b4-fbd8-0b9b-2c2e-6337f0d408ea@candelatech.com>
         <AM0P192MB0468ED699FC0BE6431812B03E7960@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-06-21 at 10:12 +0000, Shay Bar wrote:
> Hi Johannes and Ben,
> 
> To conclude this thread, hostapd doesn’t send any deauth/disassoc
> upon AP stop (when hostapd is killed _or_ when "ifconfig down" the
> AP interface).

Right. I'm sort of suggesting you just shouldn't be doing this, and it
doesn't seem like most people actually do, otherwise we'd have seen this
issue before?

> This is causing a situation where stations keep sending unicast frames
> to a down AP interface as it doesn’t know it's gone down.
> I tried your suggestion and sent 1 deauth/disassoc as broadcast
> (instead of unicast to each STA), but some stations (e.g. Samsung S8)
> Ignore this broadcast (while it will not ignore unicast deauth/disassoc).
> Although not indicated in the standard, I think it's better to let STA
> Know AP gone down by sending this unicast deauth to each STA
> (as this patch does).

I'm not really sure. That's a _lot_ of frames and potentially quite a
long time. In the patch, as written, I'm not even convinced you can be
sure that they will all make it out to the air?

johannes

