Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87315BD88
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgBMLQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:16:43 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:33016 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgBMLQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:16:43 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2CU5-008W6E-30; Thu, 13 Feb 2020 12:16:41 +0100
Message-ID: <47ba092892a3762f42cac6f69a80622829e84827.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 1/2] cfg80211: skip strict validation for UDPATE_OWE
 command
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 13 Feb 2020 12:16:40 +0100
In-Reply-To: <20200213111300.jgb3kkvwq6am3aj7@bars>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
         <20200213090657.28841-2-sergey.matyukevich.os@quantenna.com>
         <703b19463655cbb8a5ab9469caec5d3936dbe35d.camel@sipsolutions.net>
         <20200213111300.jgb3kkvwq6am3aj7@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-02-13 at 11:13 +0000, Sergey Matyukevich wrote:
> On Thu, Feb 13, 2020 at 10:12:47AM +0100, Johannes Berg wrote:
> > [External Email]: This email arrived from an external source - Please exercise caution when opening any attachments or clicking on links.
> > 
> > On Thu, 2020-02-13 at 09:07 +0000, Sergey Matyukevich wrote:
> > > Do not perform strict validation of UPDATE_OWE command.
> > > Otherwise, kernel rejects command executed by hostapd.
> > 
> > Can't we fix hostapd? I mean, it's a relatively new command, so why
> > shouldn't we validate it strictly?
> 
> That is why this patch is RFC: see cover email :)

Ah, was on the phone and hadn't read that yet ...

> Sure, I can fix hostapd instead. Could you point me at some good
> starting point to look at ? Are there any user-space tools that
> started to use strict validation ?

It's not really opt-in or not, it's entirely a kernel choice.

> P.S.
> If you are ok with the second patch, then could you just take it
> from this series ? Or should I resubmit ?

I can just take it.

johannes

