Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B83193F67
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZNDe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:03:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbgCZNDd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:03:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSAR-00043w-Ri; Thu, 26 Mar 2020 15:03:28 +0200
Message-ID: <c622c5a13d3fc7288d68090e5cec8d845b90ddb1.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:03:26 +0200
In-Reply-To: <87o8sjp94q.fsf@tynnyri.adurom.net>
References: <20200326120042.578777-1-luca@coelho.fi>
         <20200326120042.578777-2-luca@coelho.fi>
         <87o8sjp94q.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/12] mac80211: implement Operating Mode Notification
 extended NSS support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-26 at 14:56 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Somehow we missed this for a long time, but similar to the extended
> > NSS support in VHT capabilities, we need to have this in Operating
> > Mode notification.
> > 
> > Implement it by
> >  * parsing the 160/80+80 bit there and setting the bandwidth
> >    appropriately
> >  * having callers of ieee80211_get_vht_max_nss() pass in the current
> >    max NSS value as received in the operating mode notification in
> >    order to modify it appropriately depending on the extended NSS
> >    bits.
> > 
> > This updates all drivers that use it, i.e. only iwlwifi/mvm.
> > 
> > Change-Id: I4e8c25d3288441759c2793247197229f0696a37d
> 
> All patches have Change-Id tag.

Argh, sorry, I didn't install the send-email script to convert them
into a message-id... I'll resend.

--
Luca.

