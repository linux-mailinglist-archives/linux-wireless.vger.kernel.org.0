Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EAE36093A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 14:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDOMWH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDOMWG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 08:22:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5065C061574
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 05:21:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lX103-00C5RA-8P; Thu, 15 Apr 2021 14:21:35 +0200
Message-ID: <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Chris Murphy <lists@colorremedies.com>
Date:   Thu, 15 Apr 2021 14:21:34 +0200
In-Reply-To: <20210415120447.4424-1-hdegoede@redhat.com> (sfid-20210415_140503_625209_839D9098)
References: <20210415120447.4424-1-hdegoede@redhat.com>
         (sfid-20210415_140503_625209_839D9098)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-04-15 at 14:04 +0200, Hans de Goede wrote:
> This fixes the same locking problem fixed by commit 2800aadc18a6 ("iwlwifi:
> Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()") but then for
> the gen2 variant of enqueue_hcmd().
> 
> It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs
> disabled (e.g. from LED core). We can't enable BHs in such a situation.
> 
> Turn the unconditional BH-enable/BH-disable code into
> hardirq-disable/conditional-enable.
> 
> This fixes the warning below.

I believe Jiri posted the same patch:

https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/

Not sure where it is now though, I guess Luca can comment.

I also had another fix in this area too.

johannes

