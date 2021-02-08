Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29AE312C23
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 09:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBHIpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 03:45:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44246 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229821AbhBHImF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 03:42:05 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l925w-00479n-60; Mon, 08 Feb 2021 10:40:32 +0200
Message-ID: <c29802a2acda44fa6368e6703f7dc0c13178ae24.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 08 Feb 2021 10:40:30 +0200
In-Reply-To: <20210208083006.4C609C43461@smtp.codeaurora.org>
References: <iwlwifi.20210206130110.6f0c1849f7dc.I647b4d22f9468c2f34b777a4bfa445912c6f04f0@changeid>
         <20210208083006.4C609C43461@smtp.codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH for v5.11] iwlwifi: add new cards for So and Qu family
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-02-08 at 08:30 +0000, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> wrote:
> 
> > From: Ihab Zhaika <ihab.zhaika@intel.com>
> > 
> > add few PCI ID'S for So with Hr and Qu with Hr in AX family.
> > 
> > Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> Why the urgency? Linus most likely releases v5.11 next Sunday so I would rather
> apply this to -next. You could push it to v5.11 via the stable tree.

The urgency was that there are some OEMs with these devices and they
wanted the patch in v5.11 asap.  But I can certainly push back and we
can send this via -next.  I only promised to *try* to get it in v5.11.
;)

I'll add a Cc: stable and apply to iwlwifi-next.

Thanks, Kalle.

--
Cheers,
Luca.

