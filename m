Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8F2D4D63
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 23:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbgLIWP5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 17:15:57 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:36008 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388265AbgLIWP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 17:15:57 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn7jq-003E5e-HB; Thu, 10 Dec 2020 00:15:10 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20201209231352.a9dba2daca59.I2b18bccf0d409f1517c3e2841b667014f9dafc24@changeid>
References: <iwlwifi.20201209231352.a9dba2daca59.I2b18bccf0d409f1517c3e2841b667014f9dafc24@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1rc1
Message-Id: <E1kn7jq-003E5e-HB@farmhouse.coelho.fi>
Date:   Thu, 10 Dec 2020 00:15:10 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2 13/47] iwlwifi: enable sending/setting debug host event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> This is used for BT node and for any user that wants to
> control what events would be send from FW to the driver.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

21 patches applied to iwlwifi-next.git, thanks.

87f1283b6ae4 iwlwifi: enable sending/setting debug host event
861bae42e1f1 iwlwifi: avoid endless HW errors at assert time
52b155214be8 iwlwifi: mvm: remove the read_nvm from iwl_run_unified_mvm_ucode
cdaba917268d iwlwifi: follow the new inclusive terminology
d295a898c2f5 iwlwifi: fix typo in comment
7b2829f315d0 iwlwifi: sort out the NVM offsets
c6bae2169071 iwlwifi: mvm: iterate active stations when updating statistics
efc0ec5afb6e iwlwifi: validate MPDU length against notification length
df72138de4bc iwlwifi: pcie: validate RX descriptor length
59fa61f3fd4e iwlwifi: remove sw_csum_tx
e20a5c9f768b iwlwifi: mvm: clear up iwl_mvm_notify_rx_queue() argument type
cf5b46276847 iwlwifi: mvm: move iwl_mvm_stop_device() out of line
3fa965c2dd4e iwlwifi: pcie: change 12k A-MSDU config to use 16k buffers
9e8338ad17eb iwlwifi: mvm: fix 22000 series driver NMI
2f7a04c7b03b iwlwifi: mvm: do more useful queue sync accounting
94631b56422d iwlwifi: mvm: clean up scan state on failure
aa7fd94687b2 iwlwifi: pcie: remove MSIX_HW_INT_CAUSES_REG_IML handling
97b4f859543d iwlwifi: fw: file: fix documentation for SAR flag
69d6cfc491f0 iwlwifi: pcie: remove unnecessary setting of inta_mask
152fdc0f6988 iwlwifi: trans: consider firmware dead after errors
58a1c9f9a9b6 iwlwifi: dbg-tlv: fix old length in is_trig_data_contained()

