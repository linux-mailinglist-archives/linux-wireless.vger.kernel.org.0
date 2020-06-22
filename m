Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3195120309C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgFVH1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgFVH1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 03:27:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808DAC061794
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 00:27:00 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jnGr3-009w7B-Hu; Mon, 22 Jun 2020 09:26:57 +0200
Message-ID: <11e817f5fd8b5042b281d4e575c24a8433d07d8a.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: fix 6ghz starting frequency
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Amar Singhal <asinghal@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 22 Jun 2020 09:26:41 +0200
In-Reply-To: <ef5ead91d87183cdc02e6b5bb717b7ba@codeaurora.org>
References: <1592807869-781-1-git-send-email-pradeepc@codeaurora.org>
         <ef5ead91d87183cdc02e6b5bb717b7ba@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-06-22 at 00:20 -0700, Pradeep Kumar Chitrapu wrote:
> On 2020-06-21 23:37, Pradeep Kumar Chitrapu wrote:
> > Fixes channel to frequency mappings per latest specification
> > IEEE P802.11ax/D6.1
> > 
> > Fixes: d1a1646c ("cfg80211: adapt to new channelization of the 6GHz 
> > band")
> > Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> > ---
> Please ignore this patch..
> Just observed similar patch which is already in review
> https://patchwork.kernel.org/patch/11615085/

I also already merged

https://lore.kernel.org/r/edf07cdd-ad15-4012-3afd-d8b961a80b69@broadcom.com

If any further changes are needed, please base them on mac80211-next...

johannes

