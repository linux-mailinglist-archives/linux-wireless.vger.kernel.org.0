Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BA44B208
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 18:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbhKIRgp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 12:36:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40818 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241098AbhKIRgo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 12:36:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mkV0P-000o6f-0J; Tue, 09 Nov 2021 19:33:57 +0200
Message-ID: <f71f2e3ef060b9e5cdfec89c18f55d22055492f6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 09 Nov 2021 19:33:55 +0200
In-Reply-To: <iwlwifi.20211109192950.486dfa9c4f35.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
References: <iwlwifi.20211109192950.486dfa9c4f35.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] iwlwifi: mvm: retry init flow if failed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-11-09 at 19:30 +0200, Luca Coelho wrote:
> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> In some very rare cases the init flow may fail.  In many cases, this is
> recoverable, so we can retry.  Implement a loop to retry two more times
> after the first attempt failed.
> 
> This can happen in two different situations, namely during probe and
> during mac80211 start.  For the first case, a simple loop is enough.
> For the second case, we need to add a flag to prevent mac80211 from
> trying to restart it as well, leaving full control with the driver.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Hi Kalle,

Can you take this to v5.16?

It fixes a rare but critical issue that causes the NIC to become
unusable until the next reboot...

I'll assign it to you in patchwork.

Thanks!

--
Cheers,
Luca.
