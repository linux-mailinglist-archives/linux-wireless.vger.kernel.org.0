Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041C4360B0E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhDONxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 09:53:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44906 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231549AbhDONxH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 09:53:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lX2Q7-000Mfx-Pl; Thu, 15 Apr 2021 16:52:37 +0300
Message-ID: <bab37babea4f2972ef222e1dcaff7ab966ab15a8.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     jikos@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
Date:   Thu, 15 Apr 2021 16:52:35 +0300
In-Reply-To: <iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid>
References: <iwlwifi.20210415164821.d0f2edda1651.I75f762e0bed38914d1300ea198b86dd449b4b206@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH for -next] iwlwifi: pcie: don't enable BHs with IRQs
 disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-04-15 at 16:48 +0300, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> After the fix from Jiri that disabled local IRQs instead of
> just BHs (necessary to fix an issue with submitting a command
> with IRQs already disabled), there was still a situation in
> which we could deep in there enable BHs, if the device config
> sets the apmg_wake_up_wa configuration, which is true on all
> 7000 series devices.
> 
> To fix that, but not require reverting commit 1ed08f6fb5ae
> ("iwlwifi: remove flags argument for nic_access"), split up
> nic access into a version with BH manipulation to use most
> of the time, and without it for this specific case where the
> local IRQs are already disabled.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Kalle, I'm going to assign this one to you too, but this time for -next
and not for -fixes.

This is related to the fix Jiri made, but to avoid some conflicts and a
broken v5.13-rc, we want to get it into v5.13 if still possible.

So can you please take this on top of my latest pull request?
Additionally, can you tag it for stable?

Thanks!

--
Cheers,
Luca.

