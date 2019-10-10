Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3559FD2D82
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2019 17:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJJPSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 11:18:05 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42124 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJPSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 11:18:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iIaCZ-000734-Ae; Thu, 10 Oct 2019 17:18:03 +0200
Message-ID: <bbe3369418b948de0d54aefa16e2bf77693351bd.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 10 Oct 2019 17:18:02 +0200
In-Reply-To: <cc2cee76-2a83-17ad-0e7a-ba71075e1497@gmail.com> (sfid-20191008_225601_596382_1D893268)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
         <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
         <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com>
         <6530a6b06176790c5a6949d6ffccf37b506975bd.camel@sipsolutions.net>
         <864267ec-9158-940d-6e0e-db84a395888e@gmail.com>
         <f02b81f6dac29da911f8793b952a9efb6a1fdb62.camel@sipsolutions.net>
         <1bb5450b-bc4e-8c83-f99e-fc7e739b08f0@gmail.com>
         <fbb287a82656dd3f89817590e86b23d6968a2822.camel@sipsolutions.net>
         <193168d4-6466-60a4-bc89-c4a44e84ac46@gmail.com>
         <9c49ec27489333d7f27831de19e9d1c9cd65eeee.camel@sipsolutions.net>
         <cc2cee76-2a83-17ad-0e7a-ba71075e1497@gmail.com>
         (sfid-20191008_225601_596382_1D893268)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-08 at 15:55 -0500, Denis Kenzior wrote:

> Right, so you're talking in the context of this implementation which 
> performs a remove/add interface.  You're right about that.
> 
> But I was asking more in general terms.  If all we're doing is scanning, 
> can we just change the mac?  Anyway, not important.  Maybe I bring this 
> up once this set is accepted.

Maybe, but honestly, I'm not convinced the complexity would be worth it.
You'd have to push this all the way through to the driver, so it knows
to do it, or defer it until the scan is done, or something? Not
something you'd want to do on all hardware while a non-randomized scan
is running, for example (iwlwifi might actually be OK).

Or you could perhaps cache the MAC address change in mac80211 and apply
it at the next possible point in time - but then again you have to be
really careful to actually apply it and block all further operations,
even if a bunch of remain-on-channel's are active and you request a new
scan, that has to be blocked until the remain-on-channel is done *and*
the MAC address change is applied?

Seems rather complex for very little value.

johannes

