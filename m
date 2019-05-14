Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF21C5B9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfENJMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 05:12:13 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40626 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 05:12:13 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hQTTn-0007VU-CC; Tue, 14 May 2019 11:12:11 +0200
Message-ID: <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: remove warning message
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Date:   Tue, 14 May 2019 11:12:10 +0200
In-Reply-To: <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
         (sfid-20190514_110314_752671_7E53E9A2) <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
         <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-05-14 at 17:10 +0800, Yibo Zhao wrote:
> On 2019-05-14 17:05, Johannes Berg wrote:
> > On Tue, 2019-05-14 at 17:01 +0800, Yibo Zhao wrote:
> > > In multiple SSID cases, it takes time to prepare every AP interface
> > > to be ready in initializing phase. If a sta already knows everything 
> > > it
> > > needs to join one of the APs and sends authentication to the AP which
> > > is not fully prepared at this point of time, AP's channel context
> > > could be NULL. As a result, warning message occurs.
> > > 
> > 
> > Err, what was the point in sending v2 without any changes?
> > 
> > johannes
> 
> Hi Johannes,
> 
> I was planning to use WARN_ON_ONCE() in the first place to replace 
> WARN_ON() then after some discussion, we think removing it could be 
> better. So the first patch was based on my first version which is sent 
> incorrectly. Please check again.

Oops, I didn't pay attention to the - code.

I guess changing it to WARN_ON_ONCE() makes sense, but as per my earlier
email I'm really not sure about removing it entirely, it doesn't seem
like a valid scenario and we should take steps elsewhere to prevent it.

johannes

