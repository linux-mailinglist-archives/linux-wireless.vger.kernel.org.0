Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46754360A14
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDONHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhDONHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 09:07:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0D9C061574
        for <linux-wireless@vger.kernel.org>; Thu, 15 Apr 2021 06:06:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lX1hl-00C6sS-Az; Thu, 15 Apr 2021 15:06:45 +0200
Message-ID: <1746cb4269284094fa075ffba89b6416c67f6f84.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "jikos@kernel.org" <jikos@kernel.org>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Date:   Thu, 15 Apr 2021 15:06:44 +0200
In-Reply-To: <2967a7b509e72b604e144df1dbd504d203b9ba46.camel@intel.com>
References: <20210415120447.4424-1-hdegoede@redhat.com>
         (sfid-20210415_140503_625209_839D9098) <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net>
         <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
         <nycvar.YFH.7.76.2104151444150.18270@cbobk.fhfr.pm>
         <2967a7b509e72b604e144df1dbd504d203b9ba46.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-04-15 at 13:04 +0000, Coelho, Luciano wrote:
> On Thu, 2021-04-15 at 14:44 +0200, Jiri Kosina wrote:
> > On Thu, 15 Apr 2021, Coelho, Luciano wrote:
> > 
> > > > I believe Jiri posted the same patch:
> > > > 
> > > > https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/
> > > > 
> > > > Not sure where it is now though, I guess Luca can comment.
> > > 
> > > Jiri's patch is in 5.12-rc7.
> > 
> > The iwl_pcie_enqueue_hcmd() is. The one referenced above 
> > (iwl_pcie_gen2_enqueue_hcmd()) is nowhere as far as I can tell.
> 
> Right, sorry, I confused the two.
> 
> In that same thread Johannes sent a third patch (which we have in our
> internal tree).  Johannes, with your patch, the gen2 version is also
> needed right?

Yes, they're independent.

johannes

