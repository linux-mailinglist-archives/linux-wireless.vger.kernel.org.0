Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B1435C5C5
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhDLL42 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:56:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238121AbhDLL41 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:56:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVvAh-000L01-9O; Mon, 12 Apr 2021 14:56:04 +0300
Message-ID: <4c0f9851ad0f7b74843d800de9b35844ce463bac.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Mon, 12 Apr 2021 14:56:02 +0300
In-Reply-To: <7a2cec50e39aa7d33220a9248f9de53cff4b963d.camel@sipsolutions.net>
References: <ee6d5faebc25c8fa447cf870cbc80b4236178756.camel@coelho.fi>
         <87v98rlod8.fsf@codeaurora.org>
         (sfid-20210412_134346_942971_4D7B456F) <4cef9f24f371506df01b8afbdc1e0d47afa8e3e0.camel@sipsolutions.net>
         (sfid-20210412_134950_435631_8D1F22F1) <7a2cec50e39aa7d33220a9248f9de53cff4b963d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: pull-request: iwlwifi-next 2021-04-12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-04-12 at 13:50 +0200, Johannes Berg wrote:
> On Mon, 2021-04-12 at 13:49 +0200, Johannes Berg wrote:
> > On Mon, 2021-04-12 at 14:43 +0300, Kalle Valo wrote:
> > > 
> > > >  include/net/cfg80211.h                                 |   11 +-
> > > >  net/wireless/core.c                                    |    7 +-
> > > 
> > > Why are you changing cfg80211? Has this been checked with Johannes, at
> > > least I don't see any acks from him? I prefer making cfg80211 changes
> > > via Johannes' tree, smaller risk of conflicts that way.
> > 
> > Hm. I believe I even have that commit already in my tree. Maybe we
> > talked about it and said you could include it and I forgot? But in any
> > case, it's in my tree now, so probably shouldn't go through iwlwifi as
> > well.
> 
> commit 6f779a66dc84 ("cfg80211: allow specifying a reason for
> hw_rfkill")

Ah, so you applied it without the backport stuff I left there.  Thanks!

But this is not in net-next yet, right? So we still need to wait till
that reaches net-next and Kalle pulls from there...

--
Luca.

