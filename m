Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522D928075F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgJATDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:03:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53686 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729418AbgJATDT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:03:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3rI-002NDh-M4; Thu, 01 Oct 2020 22:03:17 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200930191738.1c22d1bc0a88.I24e57317bdddc6c72f69725e1d95683a935e893d@changeid>
References: <iwlwifi.20200930191738.1c22d1bc0a88.I24e57317bdddc6c72f69725e1d95683a935e893d@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3rI-002NDh-M4@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 22:03:16 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/12] iwlwifi: mvm: remove redundant log in
 iwl_mvm_tvqm_enable_txq()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> We are printing the same thing twice, "Enabling TXQ #%d".  Previously
> the second print was including more information, but now it only
> prints the queue number, which is already in the first print.  Remove
> the redundant one.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

abd16a58a011 iwlwifi: mvm: remove redundant log in iwl_mvm_tvqm_enable_txq()
e365e7de63e5 iwlwifi: align RX status flags with firmware
bc68163ccd7d iwlwifi: mvm: d3: parse wowlan status version 11
20e671998cf3 iwlwifi: mvm: clear all scan UIDs
0179bfff9780 iwlwifi: pcie: make iwl_pcie_txq_update_byte_cnt_tbl bus independent
4bf3d7cfea3c iwlwifi: dbg: add debug host notification (DHN) time point
3ac13d56ec8c iwlwifi: mvm: ignore the scan duration parameter
9422b978355e iwlwifi: support version 5 of the alive notification
b4248c08f743 iwlwifi: use correct group for alive notification
eb95a26c11a1 iwlwifi: api: fix u32 -> __le32
16b2afe07ace iwlwifi: yoyo: add support for internal buffer allocation in D3
870f39bc9deb iwlwifi: bump FW API to 57 for AX devices

