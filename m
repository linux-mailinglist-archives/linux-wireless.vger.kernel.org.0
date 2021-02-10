Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9B3174D6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 00:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhBJX6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 18:58:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45480 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231564AbhBJX6m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 18:58:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9zMo-004ACu-Pt; Thu, 11 Feb 2021 01:57:55 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210210172142.dfd423b2b2ef.Icd576dc3e2e7174d3ed9c1c32f48ea0013699e72@changeid>
References: <iwlwifi.20210210172142.dfd423b2b2ef.Icd576dc3e2e7174d3ed9c1c32f48ea0013699e72@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l9zMo-004ACu-Pt@farmhouse.coelho.fi>
Date:   Thu, 11 Feb 2021 01:57:54 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 1/8] iwlwifi: mvm: reduce the print severity of failing
 getting NIC temp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Golan Ben Ami <golan.ben.ami@intel.com>
> 
> Currently, for all devices and families, failing getting the temp
> from the fw is indicated in the log as ERR.
> This is too severe for two reasons:
> 1. The driver has a fall back - and schedules the next temp
> read immediately after failing to read temp from the fw.
> 2. The temp read implementation in the fw is different between
> HWs, and on older devices the flow is a-sync and may timeout.
> 
> Reducing the print severity from ERR to WARN will allow to
> track the issue if it will appear many times, but not frighten users
> if it appears once.
> 
> Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

6 patches applied to iwlwifi-next.git, thanks.

c61734a69caf iwlwifi: mvm: reduce the print severity of failing getting NIC temp
11dd729afa48 iwlwifi: mvm: global PM mode does not reset after FW crash
4a81598f0f39 iwlwifi: pnvm: set the PNVM again if it was already loaded
25df65ae8a92 iwlwifi: pcie: define FW_RESET_TIMEOUT for clarity
ff11a8ee2d2d iwlwifi: pnvm: increment the pointer before checking the TLV
cdda18fbbefa iwlwifi: pnvm: move file loading code to a separate function

