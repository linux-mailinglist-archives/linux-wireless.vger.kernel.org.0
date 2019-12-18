Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1FB12444D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 11:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLRKSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 05:18:55 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:38774 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRKSy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 05:18:54 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ihWPs-007ote-MF; Wed, 18 Dec 2019 11:18:52 +0100
Message-ID: <c126d2ff0866faf9ac50b12920f0497b03b031f7.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] mac80211: fix issue in loop scenario
From:   Johannes Berg <johannes@sipsolutions.net>
To:     yiboz@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Date:   Wed, 18 Dec 2019 11:18:51 +0100
In-Reply-To: <6f092bd44cfc581a219bd0f0506cc636@codeaurora.org>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org>
         <1576221593-1086-3-git-send-email-yiboz@codeaurora.org>
         (sfid-20191213_082426_564220_0827923D) <94471b2381bee394f9708eae8ba47129f3facd03.camel@sipsolutions.net>
         <6f092bd44cfc581a219bd0f0506cc636@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-12-18 at 18:12 +0800, yiboz@codeaurora.org wrote:
> 
> Yes, this is a fix to the first patch. Actually, the rest of two patches 
> are also serve the same. So, are you suggesting to merge them to the 
> first patch?

Yes.

> Previouly, I had added Toke's signature in this patch but Toke advised 
> to delete it. I feel a little bit confused about how to handle it. 
> Appreciate any detail guide.

I guess that you have to discuss that with Toke, how he wants to handle
it ... If he gave you a patch with his signed-off-by, then you should
probably keep it? There's also "Co-developed-by" tag to give some sort
of non-author developer credits.

johannes

