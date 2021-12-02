Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4346647C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 14:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358210AbhLBNba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Dec 2021 08:31:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50172 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346690AbhLBNb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Dec 2021 08:31:29 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1msm7t-0015Iv-P6; Thu, 02 Dec 2021 15:27:54 +0200
Message-ID: <30616f3f467f7af0729efa5d63b4332e911ee230.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Date:   Thu, 02 Dec 2021 15:27:52 +0200
In-Reply-To: <87bl20saht.fsf@tynnyri.adurom.net>
References: <20211129133248.83829-1-luca@coelho.fi>
         <iwlwifi.20211129152938.faf291271590.I40ad9372a47cbad53b4aae7b5a6ccc0dc3fddf8b@changeid>
         <87bl20saht.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 16/16] cfg80211: Acquire wiphy mutex on regulatory work
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-12-01 at 15:47 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Ilan Peer <ilan.peer@intel.com>
> > 
> > The function cfg80211_reg_can_beacon_relax() expects wiphy
> > mutex to be held when it is being called. However, when
> > reg_leave_invalid_chans() is called the mutex is not held.
> > Fix it by acquiring the lock before calling the function.
> > 
> > Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> > Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> > Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
> 
> Duplicate Fixes tags.

Thanks for noticing!

My script adds the tag automatically, but it doesn't check (yet)
whether the tag was already there... I'll send v2 without it.

--
Cheers,
Luca.
