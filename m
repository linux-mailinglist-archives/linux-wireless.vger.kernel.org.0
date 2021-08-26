Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055313F8FAA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhHZUdh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:33:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33510 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229916AbhHZUdh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:33:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM3K-002XL5-M3; Thu, 26 Aug 2021 23:32:48 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210802170640.0108f3e322b6.Ib25a91b5c48ff1fb2185b86a9e4bf5eec637df90@changeid>
References: <iwlwifi.20210802170640.0108f3e322b6.Ib25a91b5c48ff1fb2185b86a9e4bf5eec637df90@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM3K-002XL5-M3@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:32:47 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: iwl-nvm-parse: set STBC flags for HE phy
 capabilities
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> Our HW supersets STBC for HE but never set it in assoc IE, fix it by
> setting it and enable using it.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

f2d1bdf053d0 iwlwifi: iwl-nvm-parse: set STBC flags for HE phy capabilities
1269ba1ce35d iwlwifi: mvm: set BROADCAST_TWT_SUPPORTED in MAC policy
0eb5a554bb49 iwlwifi: nvm: enable IEEE80211_HE_PHY_CAP10_HE_MU_M1RU_MAX_LTF
2f308f008f1c iwlwifi: mvm: avoid FW restart while shutting down
95fe8d89bb8c iwlwifi: pcie: optimise struct iwl_rx_mem_buffer layout
6ac5720086c8 iwlwifi: pcie: free RBs during configure
b8221b0f750a iwlwifi: prepare for synchronous error dumps
e63aafea7439 iwlwifi: pcie: dump error on FW reset handshake failures
2a1d2fcf2bed iwlwifi: print PNVM complete notification status in hexadecimal
deedf9b97cd4 iwlwifi: mvm: Do not use full SSIDs in 6GHz scan
16cff731a3a1 iwlwifi: mvm: Add support for hidden network scan on 6GHz band
8fc3015d0d35 iwlwifi: iwl-dbg-tlv: add info about loading external dbg bin

