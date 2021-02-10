Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737D23174C7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 00:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhBJXx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 18:53:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45472 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234206AbhBJXxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 18:53:25 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9zHh-004ACX-DN; Thu, 11 Feb 2021 01:52:37 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210210171218.2cea55a09bc7.I634b79795abad499ce442631d6672ffef8fc6d41@changeid>
References: <iwlwifi.20210210171218.2cea55a09bc7.I634b79795abad499ce442631d6672ffef8fc6d41@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l9zHh-004ACX-DN@farmhouse.coelho.fi>
Date:   Thu, 11 Feb 2021 01:52:37 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/12] iwlwifi: mvm: add RFI-M support
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Gregory Greenman <gregory.greenman@intel.com>
> 
> RF Interference Mitigation is a new feature targeted to handle the
> problem of interference between DDR memory and WiFi. The role of
> the driver is to configure FW with the table holding a mapping
> between problematic channels/bands and the corresponding frequencies.
> 
> This patch adds RFI infrastructure and adds two debugfs hooks:
> - send RFI configuration command (currently with a default table) which
>   will reset feature in the FW
> - read the table, used by the FW (which can be a subset of the table
>   that driver sent).
> 
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

21254908cbe9 iwlwifi: mvm: add RFI-M support
4e8fe214f7c0 iwlwifi: acpi: add support for DSM RFI
46ad1ff977e7 iwlwifi: mvm: register to mac80211 last
8c082a99edb9 iwlwifi: mvm: simplify iwl_mvm_dbgfs_register
aacee681e355 iwlwifi: mvm: isolate the get nvm flow
e1900bceab6a iwlwifi: mvm: Support SCAN_CFG_CMD version 5
b8a86164454a iwlwifi: mvm: don't check if CSA event is running before removing
9ce505feb17a iwlwifi: mvm: Check ret code for iwl_mvm_load_nvm_to_nic
eebe75d1659c iwlwifi: remove max_vht_ampdu_exponent config parameter
edba17ad85bb iwlwifi: remove max_ht_ampdu_exponent config parameter
ee1a02d7604b iwlmvm: set properly NIC_NOT_ACK_ENABLED flag
13b5fa9582f5 iwlwifi: mvm: get NVM later in the mvm_start flow

