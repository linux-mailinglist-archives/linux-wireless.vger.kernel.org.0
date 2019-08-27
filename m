Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655DA9E8B0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH0NKQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 09:10:16 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58734 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfH0NKQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 09:10:16 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i2bEj-0000mJ-Li; Tue, 27 Aug 2019 15:10:13 +0200
Message-ID: <ac3fa1160afc5f4ccb1b41bd0b2e6dd165448180.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Josef Miegl <josef@miegl.cz>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 27 Aug 2019 15:10:12 +0200
In-Reply-To: <21433c24-4860-be12-8d79-11e954e0bf9d@newmedia-net.de>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
         <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
         <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
         <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
         <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz>
         <5ee160209eb1f9e70f6224c393389266280d7d80.camel@sipsolutions.net>
         <0452a0cbb36bcffa8371a58dfd931864c1f79eef.camel@sipsolutions.net>
         <68A3B9AF-8864-4C0F-A50B-71CCB76AE81D@miegl.cz>
         <21433c24-4860-be12-8d79-11e954e0bf9d@newmedia-net.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-27 at 15:08 +0200, Sebastian Gottschall wrote:
> Am 22.08.2019 um 23:06 schrieb Josef Miegl:
> > On August 22, 2019 10:08:13 PM GMT+02:00, Johannes Berg <johannes@sipsolutions.net> wrote:
> > > On Thu, 2019-08-22 at 09:00 +0200, Johannes Berg wrote:
> > > > Perhaps it expects the 4-way-HS to already be in 4-addr frame format,
> > > or
> > > > something else special in the 4-way-HS if you have WDS?
> > > I think this is actually the right guess.
> > Yes, it indeed it! Thank you so much Johannes!

> good finding. my idea here is if we parse the wds flags field from mtik 
> ie within mac80211 we could also support this special handing without 
> any workaround

The same holds true if we parse it in hostapd, and add a flag to the
EAPOL to control the encapsulation, which is way more general, so much
preferable IMHO.

johannes

