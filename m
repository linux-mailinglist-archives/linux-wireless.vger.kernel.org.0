Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F43535C5D0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhDLL6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbhDLL6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:58:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F2C061574
        for <linux-wireless@vger.kernel.org>; Mon, 12 Apr 2021 04:58:26 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lVvCu-00AgOd-S7; Mon, 12 Apr 2021 13:58:21 +0200
Message-ID: <9b98d8c441d2ef26edc716d8c49c13a01c7c9bea.camel@sipsolutions.net>
Subject: Re: pull-request: iwlwifi-next 2021-04-12
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luca Coelho <luca@coelho.fi>, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Mon, 12 Apr 2021 13:58:20 +0200
In-Reply-To: <4c0f9851ad0f7b74843d800de9b35844ce463bac.camel@coelho.fi>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
         <87v98rlod8.fsf@codeaurora.org>
         (sfid-20210412_134346_942971_4D7B456F) <4cef9f24f371506df01b8afbdc1e0d47afa8e3e0.camel@sipsolutions.net>
         (sfid-20210412_134950_435631_8D1F22F1) <7a2cec50e39aa7d33220a9248f9de53cff4b963d.camel@sipsolutions.net>
         <4c0f9851ad0f7b74843d800de9b35844ce463bac.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-04-12 at 14:56 +0300, Luca Coelho wrote:
> On Mon, 2021-04-12 at 13:50 +0200, Johannes Berg wrote:
> > On Mon, 2021-04-12 at 13:49 +0200, Johannes Berg wrote:
> > > On Mon, 2021-04-12 at 14:43 +0300, Kalle Valo wrote:
> > > > 
> > > > >  include/net/cfg80211.h                                 |   11 +-
> > > > >  net/wireless/core.c                                    |    7 +-
> > > > 
> > > > Why are you changing cfg80211? Has this been checked with Johannes, at
> > > > least I don't see any acks from him? I prefer making cfg80211 changes
> > > > via Johannes' tree, smaller risk of conflicts that way.
> > > 
> > > Hm. I believe I even have that commit already in my tree. Maybe we
> > > talked about it and said you could include it and I forgot? But in any
> > > case, it's in my tree now, so probably shouldn't go through iwlwifi as
> > > well.
> > 
> > commit 6f779a66dc84 ("cfg80211: allow specifying a reason for
> > hw_rfkill")
> 
> Ah, so you applied it without the backport stuff I left there.  Thanks!
> 
> But this is not in net-next yet, right? So we still need to wait till
> that reaches net-next and Kalle pulls from there...

Yeah, apparently I got side-tracked after doing mac80211 and forgot
mac80211-next ...

johannes

