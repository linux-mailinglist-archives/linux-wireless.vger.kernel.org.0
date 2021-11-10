Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DB44C1D4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 14:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhKJNIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 08:08:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:41356 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231998AbhKJNIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 08:08:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mknHv-000ogV-2K; Wed, 10 Nov 2021 15:05:16 +0200
Message-ID: <1e1d3a7ee2abe2612a0120024a483590d050b3bf.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Nov 2021 15:05:13 +0200
In-Reply-To: <iwlwifi.20211110150132.57514296ecab.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
References: <iwlwifi.20211109192950.486dfa9c4f35.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
         <iwlwifi.20211110150132.57514296ecab.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2] iwlwifi: mvm: retry init flow if failed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-11-10 at 15:01 +0200, Luca Coelho wrote:
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
> In v2: fixed a missing brace.

Kalle, sorry, I had a rebase damage in the previous version.  Fixed in
v2.  I marked v1 as superseded and assigned v2 to you.

--
Cheers,
Luca.
