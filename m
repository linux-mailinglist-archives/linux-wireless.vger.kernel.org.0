Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4863609AE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 14:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhDOMpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 08:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhDOMpZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 08:45:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B30610E8;
        Thu, 15 Apr 2021 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618490702;
        bh=72MVRIYV1IIbtMMgrOAhOPKAlb9z/Qz0MTguLUxR/iA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=A7WhpYZEbg0Md5M3Q91LuP3nTmhYjE4lRNgqT7DPyDTb/QUG0TMmPfwBqf71S243D
         nOsc1stckIk3D4ZcftH3H56iPhqwHAR4+wp9Skru8m1Jjsadb78I9IkdLjvAq4Gt66
         VUE+Hzui6hpIt5oDsUaaEkIFM88WPucTkflWTGelnQIGRJwiqZmNorR2RGB7MzRyqM
         wD3mbJOonOAfxSjGgGp/qVAmB7Ab0SEqBMuKcXiMygTOuGvOUWNcKIIeBLGEqeXSYr
         k5tsvyoxQOanjYruJhhLgBB6KHlmIb2/RIgcbjhm1QptrLLEexYKAL8oYMHU3QRTUJ
         vOR0dVF4fgI8g==
Date:   Thu, 15 Apr 2021 14:44:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Coelho, Luciano" <luciano.coelho@intel.com>
cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lists@colorremedies.com" <lists@colorremedies.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
In-Reply-To: <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
Message-ID: <nycvar.YFH.7.76.2104151444150.18270@cbobk.fhfr.pm>
References: <20210415120447.4424-1-hdegoede@redhat.com>  (sfid-20210415_140503_625209_839D9098) <c70da4aa428625b5261f9f7dbb3904d81a54e694.camel@sipsolutions.net> <80ce3be63eb971682eb8d1c51176c7ddc0117478.camel@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 15 Apr 2021, Coelho, Luciano wrote:

> > I believe Jiri posted the same patch:
> > 
> > https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm/
> > 
> > Not sure where it is now though, I guess Luca can comment.
> 
> Jiri's patch is in 5.12-rc7.

The iwl_pcie_enqueue_hcmd() is. The one referenced above 
(iwl_pcie_gen2_enqueue_hcmd()) is nowhere as far as I can tell.

-- 
Jiri Kosina
SUSE Labs

