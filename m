Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93D2333B2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgG3OA1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3OA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:00:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDDC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:00:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k196Y-00DZ2W-E2; Thu, 30 Jul 2020 16:00:18 +0200
Message-ID: <5bee074dbf19ab71e3cdc90769dbec0c8ada5274.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <shay.bar@celeno.com>,
        Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 30 Jul 2020 16:00:17 +0200
In-Reply-To: <90ea9478-a42e-be89-0ee1-9e05c2ef8cc9@celeno.com>
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
         <2a607392179a76f0f6fc3cef2e6e141f25dc0254.camel@sipsolutions.net>
         <90ea9478-a42e-be89-0ee1-9e05c2ef8cc9@celeno.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-06-25 at 13:29 +0300, Shay Bar wrote:
> On 25/06/2020 12:51, Johannes Berg wrote:
> > External Email
> > 
> > 
> > On Sun, 2020-06-21 at 10:12 +0000, Shay Bar wrote:
> > > Hi Johannes and Ben,
> > > 
> > > To conclude this thread, hostapd doesn’t send any deauth/disassoc
> > > upon AP stop (when hostapd is killed _or_ when "ifconfig down" the
> > > AP interface).
> > 
> > Right. I'm sort of suggesting you just shouldn't be doing this, and it
> > doesn't seem like most people actually do, otherwise we'd have seen this
> > issue before?
> > 
> I shouldn't kill hostapd? Isn't this a very basic action?
> What is the alternative for stopping the AP?

I guess I would say to use hostapd_cli first to "disable" the
interfaces?

johannes

