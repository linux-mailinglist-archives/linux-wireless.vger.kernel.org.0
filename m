Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7F3A34AA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFJUSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhFJUSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 16:18:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F95C061574
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 13:16:09 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lrR5z-0050XM-Ek; Thu, 10 Jun 2021 22:16:07 +0200
Message-ID: <0bbe620b0b078f2fde3521a3778d1d84a3b35813.camel@sipsolutions.net>
Subject: Re: iwlwifi: understanding potential firmware regression
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mark Nelson <mark.a.nelson@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 10 Jun 2021 22:16:06 +0200
In-Reply-To: <de4c5734-f9f6-b492-0e3d-4ff814a4b6cf@gmail.com> (sfid-20210525_020247_490502_A14ED5B3)
References: <de4c5734-f9f6-b492-0e3d-4ff814a4b6cf@gmail.com>
         (sfid-20210525_020247_490502_A14ED5B3)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> 
> iwlwifi 0000:03:00.0: Failed to set soc latency: -110
> 
> but potentially also:
> 
> iwlwifi 0000:03:00.0: PHY ctxt cmd error. ret=-110

Can you report a bug on bugzilla.kernel.org, per 

https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#how_to_report

Also, I think in this case tracing might be useful, see

https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#tracing

but then take note of

https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#privacy_aspects


johannes

