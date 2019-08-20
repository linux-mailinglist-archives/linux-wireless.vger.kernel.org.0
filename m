Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1E95E4C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfHTMWN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 08:22:13 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35282 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMWN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 08:22:13 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i039P-0005y9-2J; Tue, 20 Aug 2019 14:22:11 +0200
Message-ID: <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Josef Miegl <josef@miegl.cz>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 20 Aug 2019 14:22:08 +0200
In-Reply-To: <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 13:53 +0200, Sebastian Gottschall wrote:

> i was talking about a different scenario. its not about adding a 
> element, but to read it back for gui for instance. this is why i made a 
> patch which parses this special ie
> and adds the radioname as extra element to the station table. this works 
> for ap as well of course. so iw ath0 station dump will print out the 
> radio name if available

Oh. That's something I'd argue should just be implemented in hostapd
then? No need to do anything in the kernel for that.

johannes

