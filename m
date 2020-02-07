Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75657155E8F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGTTb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 14:19:31 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:52846 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 14:19:31 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j099z-0095E1-OH; Fri, 07 Feb 2020 20:19:27 +0100
Message-ID: <3c6bdd85a2d476d9ca7268803c03d0ae417a7560.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: Fix setting txpower to zero.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 07 Feb 2020 20:19:26 +0100
In-Reply-To: <5E3DA498.20505@candelatech.com>
References: <20191217183057.24586-1-greearb@candelatech.com>
                 (sfid-20191217_193103_026347_235EB2CE) <27b64bd26e7d8c13d22a3a9b950eb3db16b630a2.camel@sipsolutions.net>
         <5E3DA498.20505@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-02-07 at 09:55 -0800, Ben Greear wrote:
> On 02/07/2020 04:03 AM, Johannes Berg wrote:
> > On Tue, 2019-12-17 at 10:30 -0800, greearb@candelatech.com wrote:
> > >   drivers/net/wireless/ath/ath10k/mac.c | 3 ++-
> > >   drivers/net/wireless/ath/ath9k/main.c | 3 +++
> > >   drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
> > 
> > All these driver changes worry me a bit - wouldn't that affect other
> > drivers as well?

> The goal was to NOT adversely affect the drivers when the default (not-set)
> value changed.

Right.

> I changed the name of the variable and then touched every driver that used it
> as a way of making sure that I found everything in the tree.
> 
> Hopefully that found everything...  I did not specifically test ath9k, only ath10k
> driver with this change.
> 
> (I then changed the variable name back before submitting the patch).

OK, great, thanks :)

johannes

