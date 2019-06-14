Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5A455B9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 09:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFNHWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 03:22:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36734 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNHWn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 03:22:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbgXn-0001W8-Cm; Fri, 14 Jun 2019 09:22:40 +0200
Message-ID: <30365971038fd772ea766bb3c429f218648f6547.camel@sipsolutions.net>
Subject: Re: [PATCH v2] mac80211: remove warning message
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Date:   Fri, 14 Jun 2019 09:22:37 +0200
In-Reply-To: <143d044082b54b2be41ba3760390d97f@codeaurora.org>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
         <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
         <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
         <e2a6596b99085541a5886c0d0d6393c849ac2d57.camel@sipsolutions.net>
         <34f72d5db336b9898618bf1c5c15ec41094d7d06.camel@perches.com>
         <4d013893-3302-14f0-c957-b3771f4b6b82@candelatech.com>
         <8eacb8e107c854b64a0c6116fca9731ddd99dcac.camel@sipsolutions.net>
         <730d3664-488d-7d57-04d5-1a57e91fa070@candelatech.com>
         <ea87337c24666355059488b42d97ee22711ce7b8.camel@sipsolutions.net>
         <bbfd69ccb4289ba3f1767c1066f61ee1@codeaurora.org>
         <143d044082b54b2be41ba3760390d97f@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 10:52 +0800, Yibo Zhao wrote:
> 
> May I know if it is fine that WARN_ON_ONCE() to be applied in kernel in 
> the future? If a separate patch for it is needed, please let me know so 
> that I can raise a new one.

Please do send a new patch.

johannes

