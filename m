Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075013B03F6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFVMPL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:15:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48508 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231193AbhFVMPJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:15:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfGs-001ava-7K; Tue, 22 Jun 2021 15:12:51 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210612142637.a705f7cedff8.I580f1021cabcc37e88f5ec5e9a6bbf00aae514b6@changeid>
References: <iwlwifi.20210612142637.a705f7cedff8.I580f1021cabcc37e88f5ec5e9a6bbf00aae514b6@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfGs-001ava-7K@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:12:51 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: mvm: support BIOS enable/disable for 11ax
 in
 Russia
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> 
> Read the new BIOS DSM and Pass to FW if to disable\enable
> 11ax for Russia according to the BIOS key. This is
> needed to enable OEMs to control enable/disable 11ax in Russia.
> Also add support for future "enable 11ax in country X" features.
> 
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

20 patches applied to iwlwifi-next.git, thanks.

7119f02b5d34 iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia
c4ae8b9d0f32 iwlwifi: mvm: pass the clock type to iwl_mvm_get_sync_time()
e348b8a62c14 iwlwifi: mvm: fix indentation in some scan functions
7a9a44456d74 iwlwifi: remove unused REMOTE_WAKE_CONFIG_CMD definitions
8835a64f74c4 iwlwifi: mvm: don't change band on bound PHY contexts
f00c3f9e2cfc iwlwifi: pcie: handle pcim_iomap_table() failures better
5cc816ef9db1 iwlwifi: increase PNVM load timeout
7e2c14372bd8 iwlwifi: pcie: Add support for AX231 radio module with Ma devices
57e6492cf0fd iwlwifi: pcie: print interrupt number, not index
163c36150179 iwlwifi: pcie: remove CSR_HW_RF_ID_TYPE_CHIP_ID
7e10d7ae9602 iwlwifi: remove duplicate iwl_ax201_cfg_qu_hr declaration
a451b823074c iwlwifi: yoyo: support region TLV version 2
aa899e683fe5 iwlwifi: pcie: identify the RF module
46d1da21d0cb iwlwifi: mvm: don't request SMPS in AP mode
a171399fd687 iwlwifi: mvm: apply RX diversity per PHY context
2a7ce54ccc23 iwlwifi: mvm: honour firmware SMPS requests
976ac0af7ba2 iwlwifi: mvm: fix error print when session protection ends
b26d4996c862 iwlwifi: mvm: Call NMI instead of REPLY_ERROR
1381eb5c8ed5 iwlwifi: correct HE capabilities
5c1f09422e66 iwlwifi: mvm: support LMR feedback

