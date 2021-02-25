Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE646324B15
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBYHN3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Feb 2021 02:13:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:46980 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233077AbhBYHLd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Feb 2021 02:11:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lFAnH-004LOD-QT; Thu, 25 Feb 2021 09:10:40 +0200
Message-ID: <b5749996ac7defbdb277bb3520467db707b905dc.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     rdunlap@infradead.org
Date:   Thu, 25 Feb 2021 09:10:38 +0200
In-Reply-To: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
References: <1614236661-20274-1-git-send-email-kvalo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 5.12] iwlwifi: pcie: fix iwl_so_trans_cfg link error
 when CONFIG_IWLMVM is disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-02-25 at 09:04 +0200, Kalle Valo wrote:
> Randy reported an error on his randconfig builds:
> 
> ERROR: modpost: "iwl_so_trans_cfg" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
> 
> The problem was that when CONFIG_IWLMVM was disabled we were still accessing
> iwl_so_trans_cfg. Fix it by moving IS_ENABLED() check before the access.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> ---

Thanks for the fix, Kalle! Please take it directly to wireless-drivers.

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Cheers,
Luca.

