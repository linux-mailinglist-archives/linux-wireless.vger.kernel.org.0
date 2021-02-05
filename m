Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58B310883
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 10:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhBEJ4i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:56:38 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43832 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230209AbhBEJyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:54:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7xo7-0044lj-JG; Fri, 05 Feb 2021 11:53:44 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210117130510.3e155d5e5f90.I2121fa4ac7cd7eb98970d84b793796646afa3eed@changeid>
References: <iwlwifi.20210117130510.3e155d5e5f90.I2121fa4ac7cd7eb98970d84b793796646afa3eed@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l7xo7-0044lj-JG@farmhouse.coelho.fi>
Date:   Fri, 05 Feb 2021 11:53:43 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/11] iwlwifi: mvm: add notification size checks
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> We shouldn't trust the firmware with the sizes (or contents)
> of notifications, accessing too much data could cause page
> faults if the data doesn't fit into the allocated space. This
> applies more on older NICs where multiple notifications can
> be in a single RX buffer.
> 
> Add a general framework for checking a minimum size of any
> notification in the RX handlers and use it for most. Some RX
> handlers were already checking and I've moved the checks,
> some more complex checks I left and made them _NO_SIZE for
> the RX handlers.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

11 patches applied to iwlwifi-next.git, thanks.

afc857bc2a71 iwlwifi: mvm: add notification size checks
1e1a58bec773 iwlwifi: mvm: check more notification sizes
88181e6e21c4 iwlwifi: mvm: remove debugfs injection limitations
96a603803deb iwlwifi: mvm: scan: fix scheduled scan restart handling
f7d6ef33a779 iwlwifi: mvm: handle CCA-EXT delay firmware notification
d4e3a341b87b iwlwifi: mvm: add support for new flush queue response
25edc8f259c7 iwlwifi: pcie: properly implement NAPI
3161a34d659b iwl-trans: iwlwifi: move sync NMI logic to trans
fcc2622cb237 iwlwifi: dbg: dump paged memory from index 1
6275c77e77b2 iwlwifi: remove TRANS_PM_OPS
00520b7a2a13 iwlwifi: mvm: don't check system_pm_mode without mutex held

