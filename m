Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7D3F8FAB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhHZUej (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:34:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33518 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229916AbhHZUej (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:34:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM4L-002XLW-4Q; Thu, 26 Aug 2021 23:33:50 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210802172232.2ff350d85eab.I02c5b5d29c0d5c2e014bd1081b07ed33772ae04d@changeid>
References: <iwlwifi.20210802172232.2ff350d85eab.I02c5b5d29c0d5c2e014bd1081b07ed33772ae04d@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM4L-002XLW-4Q@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:33:50 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: mvm: remove trigger EAPOL time event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> EAPOL failure results in deauthentication with various reasons, not
> related to AUTH failure specifically, so we just merge AUTH failure
> with failed to assoc to AP.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

1a81bddf7f47 iwlwifi: mvm: remove trigger EAPOL time event
a6dfbd040e26 iwlwifi: mvm: set replay counter on key install
de34d1c1d30d iwlwifi: mvm: restrict FW SMPS request
02289645a085 iwlwifi: pcie: remove spaces from queue names
c1868c0b7889 iwlwifi: mvm: remove check for vif in iwl_mvm_vif_from_mac80211()
cd7ae5493448 iwlwifi: mvm: fix old-style static const declaration
0f5d44ac6e55 iwlwifi: mvm: fix a memory leak in iwl_mvm_mac_ctxt_beacon_changed
2b06127df02f iwlwifi: remove trailing semicolon in macro definition
5993c90ccb56 iwlwifi: use DEFINE_MUTEX() for mutex lock
c6ce1c74ef29 iwlwifi: mvm: avoid static queue number aliasing
366fc672d625 iwlwifi: mvm: clean up number of HW queues
105167830d5f iwlwifi: mvm: treat MMPDUs in iwl_mvm_mac_tx() as bcast

