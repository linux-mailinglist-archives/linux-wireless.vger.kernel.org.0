Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B0010726E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKVMtT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:49:19 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44984 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVMtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:49:19 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY8NB-0003X4-Qj; Fri, 22 Nov 2019 13:49:17 +0100
Message-ID: <cb92bfa0a6dfe4296d221f0bc54b79811148be43.camel@sipsolutions.net>
Subject: Re: [PATCHv8 2/6] nl80211: Add new netlink attribute for TID
 speicific retry count
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 13:49:16 +0100
In-Reply-To: <7a1ad257f052f4218bb4bdc37f4cb90f@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <1572957714-16085-3-git-send-email-tamizhr@codeaurora.org>
         <03dc8fd244558b6c08875be0b497a6d3bdf595c8.camel@sipsolutions.net>
         <7a1ad257f052f4218bb4bdc37f4cb90f@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-11-14 at 12:50 +0530, Tamizh chelvam wrote:
> 
> > I'm almost thinking that these should be a struct with two u8 values
> > instead of two separate attributes, and then renamed to
> > NL80211_TID_CONFIG_ATTR_RETRY, to carry both and really ensure thaty
> > they're always together as a single configuration.
> > 
> This will make mandatory for user to send both values know ? 

Yes.

> I have did 
> it similar to
> NL80211_ATTR_WIPHY_RETRY_SHORT and NL80211_ATTR_WIPHY_RETRY_LONG. This 
> way we can have
> option to configure single parameter know ?

Is it worth it? If you need them to be separate, then you should
actually separate them and let each one be managed per station with
override etc., but that seems a lot of effort?

> > > +	[NL80211_TID_CONFIG_ATTR_RETRY] = { .type = NLA_FLAG },
> > > +	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = { .type = NLA_U8},
> > > +	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = { .type = NLA_U8},
> > 
> > The min value of 1 should be reflected in the policy.
> > 
> Yeah, It was there in the previous patchset and removed due to 
> confusion.
> Do you want to keep MIN value of 1 policy ?

If 0 is invalid, yeah, keep min 1 in the policy.

johannes

