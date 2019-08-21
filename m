Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7E0973BE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfHUHmK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:42:10 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56832 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHUHmK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:42:10 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0LFu-0004x4-OY; Wed, 21 Aug 2019 09:42:06 +0200
Message-ID: <82bff92e6fa9ccc968566d30195cd3cd29e17a1d.camel@sipsolutions.net>
Subject: Re: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 09:42:05 +0200
In-Reply-To: <be096df17632b1a71441a23a373682bf@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
         <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
         <ea1f9969b52fed2da8b0e88ed8b06527bfc272aa.camel@sipsolutions.net>
         <be096df17632b1a71441a23a373682bf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-08-10 at 18:10 +0530, Tamizh chelvam wrote:
> On 2019-07-31 14:55, Johannes Berg wrote:
> > On Tue, 2019-06-18 at 10:57 +0530, Tamizh chelvam wrote:
> > >  /**
> > > + * enum nl80211_tid_config - TID config state
> > > + * @NL80211_TID_CONFIG_DEFAULT: Default config for the TID
> > > + * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
> > > + * NL80211_TID_CONFIG_DISABLE: Disable config for the TID
> > > + */
> > > +enum nl80211_tid_config {
> > > +	NL80211_TID_CONFIG_DEFAULT,
> > > +	NL80211_TID_CONFIG_ENABLE,
> > > +	NL80211_TID_CONFIG_DISABLE,
> > > +};
> > 
> > Hmm. Looking at this in more detail in patch 3, I don't understand.
> > 
> > How is DEFAULT different from "attribute not present", i.e. "no
> > changes"?
> > 
> This DEFAULT is used to notify the driver to use default configuration 
> value of driver/vif.
> This will be used when the attribute is not present.

Hm, but then why is it valid in the nl80211 attribute? That seems
confusing. Maybe there should rather be a validity bit somewhere in the
internal API, so the nl82011 API doesn't need to be concerned with this?

johannes

