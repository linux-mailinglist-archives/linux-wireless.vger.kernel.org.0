Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD92F472AC8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 12:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhLMLAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 06:00:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51086 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231363AbhLMLAZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 06:00:25 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mwj48-001H5Q-DN; Mon, 13 Dec 2021 13:00:21 +0200
Message-ID: <9f7d720988c7aa113b70386bae80dbcd46b9b274.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 13 Dec 2021 13:00:19 +0200
In-Reply-To: <87czm0kce3.fsf@codeaurora.org>
References: <20211210091245.289008-1-luca@coelho.fi>
         <iwlwifi.20211210110539.4b397e664d44.Ib98004ccd2c7a55fd883a8ea7eebd810f406dec6@changeid>
         <87czm0kce3.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 05/10] iwlwifi: mvm: fix 32-bit build in FTM
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-12-13 at 12:49 +0200, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > On a 32-bit build, the division here needs to be done
> > using do_div(), otherwise the compiler will try to call
> > a function that doesn't exist, thus failing to build.
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> Fixes tag? And should this go to wireless-drivers?

I just checked the patch that this claims to fix internally and it's
rather old.  It went into v5.10:

commit b68bd2e3143adbcbc7afd2bc4974c1b988b87211
Author:     Ilan Peer <ilan.peer@intel.com>
AuthorDate: Wed Sep 30 16:31:12 2020 +0300
Commit:     Luca Coelho <luciano.coelho@intel.com>
CommitDate: Thu Oct 1 22:00:55 2020 +0300

    iwlwifi: mvm: Add FTM initiator RTT smoothing logic


So, if nobody caught this before, I think neither a Fixes tag nor
taking it to wireless-drivers is necessary.

What do you think?

--
Cheers,
Luca.
