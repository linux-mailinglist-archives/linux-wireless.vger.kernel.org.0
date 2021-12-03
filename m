Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1662467704
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 13:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352123AbhLCMI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 07:08:59 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50238 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244024AbhLCMI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 07:08:58 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mt7Jl-0015tF-4N; Fri, 03 Dec 2021 14:05:33 +0200
Message-ID: <26f66cf474aeebc56933faa8ea6fdf81fb439495.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 03 Dec 2021 14:05:31 +0200
In-Reply-To: <iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid>
References: <iwlwifi.20211203140410.1a1541d7dcb5.I606c746e11447fe168cf046376b70b04e278c3b4@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH for v5.16] iwlwifi: mvm: don't crash on invalid rate w/o
 STA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-12-03 at 14:04 +0200, Luca Coelho wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If we get to the WARN_ONCE(..., "Got a HT rate (...)", ...)
> here with a NULL sta, then we crash because mvmsta is bad
> and we try to dereference it. Fix that by printing -1 as the
> state if no station was given.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Fixes: 6761a718263a ("iwlwifi: mvm: add explicit check for non-data frames in get Tx rate")
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

Kalle,

Can you take this one directly to wireless-drivers? This fixes a kernel
crash in some situations.

--
Cheers,
Luca.
