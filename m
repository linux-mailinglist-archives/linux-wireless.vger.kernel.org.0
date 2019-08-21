Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE50E973BA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfHUHlP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:41:15 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56814 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfHUHlP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:41:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0LF1-0004ut-Hd; Wed, 21 Aug 2019 09:41:11 +0200
Message-ID: <d37c085c66fd4703f324c5576000a16fe469d3b1.camel@sipsolutions.net>
Subject: Re: [PATCHv6 2/9] nl80211: Add new netlink attribute for TID
 speicific retry count
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 09:41:10 +0200
In-Reply-To: <66f9219ed5bd03f96f23947c2bb6f990@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
         <1560835632-17405-3-git-send-email-tamizhr@codeaurora.org>
         <6351a05f5c205db47740116b4bec5a6476317792.camel@sipsolutions.net>
         <66f9219ed5bd03f96f23947c2bb6f990@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-08-10 at 17:36 +0530, Tamizh chelvam wrote:
> 
> > > +	[NL80211_TID_ATTR_CONFIG_RETRY] = { .type = NLA_FLAG },
> > > +	[NL80211_TID_ATTR_CONFIG_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 0),
> > > +	[NL80211_TID_ATTR_CONFIG_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 0),
> > 
> > min of 0 doesn't make sense, maybe you meant 1? otherwise just don't 
> > set
> > anything here.
> > 
> The min value changed to 0 from 1 as per the previous discussions, since 
> this is a retry count and not a tx count.
> Or Shall I remove this min value to avoid the confusion ?

Yeah, I think then you should just remove the min value. Perhaps a max
value is needed, but I don't know.

> > > +			tid_conf->retry_short = -1;
> > > +
> > 
> > I guess you should document that -1 means no changes? Not sure how the
> > IEEE80211_TID_CONF_RETRY comes in, you're always setting it, so that's
> > useless - better remove that and document that -1 means no changes?
> > 
> The value -1 is to notify the driver to use default value by removing 
> peer specific retry count.

Oh. So I think that's slightly different, please document that.

johannes

