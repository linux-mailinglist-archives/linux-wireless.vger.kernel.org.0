Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA81CF79
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfENS5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 14:57:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:51394 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfENS5k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 14:57:40 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hQccN-0005yL-6A; Tue, 14 May 2019 20:57:39 +0200
Message-ID: <ea87337c24666355059488b42d97ee22711ce7b8.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: remove warning message
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Date:   Tue, 14 May 2019 20:57:38 +0200
In-Reply-To: <730d3664-488d-7d57-04d5-1a57e91fa070@candelatech.com>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
         <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
         <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
         <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
         <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
         <4d013893-3302-14f0-c957-b3771f4b6b82@candelatech.com>
         <8eacb8e107c854b64a0c6116fca9731ddd99dcac.camel@sipsolutions.net>
         <730d3664-488d-7d57-04d5-1a57e91fa070@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-05-14 at 11:54 -0700, Ben Greear wrote:
> 
> Here is the info I have in my commit that changed this to WARN_ON_ONCE.
> I never posted it because I had to hack ath10k to get to this state, so maybe
> this is not a valid case to debug.
> 
> 
> Maybe Yibo Zhao has a better example.
> 
>      mac80211: don't spam kernel logs when chantx is null.
> 
>      I set up ath10k to be chandef based again in order to test
>      WDS.  My WDS stations are not very functional yet, and
>      when ethtool stats are queried, there is a WARN_ON splat
>      generated.  Change this to WARN_ON_ONCE so that there is
>      less kernel spam.

I'm totally fine with WARN_ON_ONCE, FWIW.

Sounds like different bugs though. You're talking about WDS here, and
Yibo was talking about something with AP interfaces prematurely
accepting frames or so.

johannes

