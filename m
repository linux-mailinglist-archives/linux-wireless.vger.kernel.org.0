Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD6215BDA2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgBML00 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:26:26 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:33500 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBML00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:26:26 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2CdU-008XIs-Hf; Thu, 13 Feb 2020 12:26:24 +0100
Message-ID: <98f7590498a7173e933f70c85208735a13f51792.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 13 Feb 2020 12:26:23 +0100
In-Reply-To: <20200213112123.elwoei3nnk5mzkht@bars>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
         <20200213090657.28841-2-sergey.matyukevich.os@quantenna.com>
         <703b19463655cbb8a5ab9469caec5d3936dbe35d.camel@sipsolutions.net>
         <20200213111300.jgb3kkvwq6am3aj7@bars>
         <47ba092892a3762f42cac6f69a80622829e84827.camel@sipsolutions.net>
         <20200213112123.elwoei3nnk5mzkht@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-02-13 at 11:21 +0000, Sergey Matyukevich wrote:
> > 
> > > Sure, I can fix hostapd instead. Could you point me at some good
> > > starting point to look at ? Are there any user-space tools that
> > > started to use strict validation ?
> > 
> > It's not really opt-in or not, it's entirely a kernel choice.
> 
> I mean, I don't know what userspace is supposed to do in the case,
> when kernel is doing strict validation. So I was asking about any
> pointers to docs or userspace tools that already do netlink
> machinery appropriately.

Userspace is just supposed to create well-formed messages :-)

But ... it really is a kernel bug. The nl80211_policy is missing an
entry for NL80211_ATTR_STATUS_CODE, so for *strict* commands, it's
assumed to not be supported. Need to add something like

	[NL80211_ATTR_STATUS_CODE] = { .type = NLA_U16, },

to the nl80211_policy, or perhaps with a range indicating that 0 isn't
valid or something.

johannes

