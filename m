Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4AB360998
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhDOMi2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOMi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 08:38:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F6DC061574
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 05:38:02 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lX1Fu-00C6Ig-RF; Thu, 15 Apr 2021 14:37:58 +0200
Message-ID: <3a0ee5f64003b6d76f2eeae3c62cf73ee9cc03d1.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>
Date:   Thu, 15 Apr 2021 14:37:57 +0200
In-Reply-To: <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
References: <20210415120447.4424-1-hdegoede@redhat.com>
         (sfid-20210415_140503_625209_839D9098) <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
         <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-04-15 at 12:37 +0000, Coelho, Luciano wrote:
> 
> > I also had another fix in this area too.
> 
> Your patch was not sent out yet.  Is this serious enough to justify
> trying to get it into 5.12 so late in the series? Maybe it makes more
> sense to wait for stable...

It *is* pretty serious, and given that Linus is contemplating rc8 I'd
probably say we could try?

johannes

