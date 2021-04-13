Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1F35D792
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 07:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbhDMF4b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 01:56:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44714 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229778AbhDMF42 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 01:56:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lWC1t-000LPA-PI; Tue, 13 Apr 2021 08:56:07 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210330162204.eb4f2ff1b863.Ib16238106b33d58b2b7688dc6297018b915ecef4@changeid>
References: <iwlwifi.20210330162204.eb4f2ff1b863.Ib16238106b33d58b2b7688dc6297018b915ecef4@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lWC1t-000LPA-PI@farmhouse.coelho.fi>
Date:   Tue, 13 Apr 2021 08:56:06 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [01/12] iwlwifi: mvm: enable TX on new CSA channel before
 disconnecting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Sara Sharon <sara.sharon@intel.com>
> 
> When moving to the new channel, we block TX until we hear the
> first beacon. if it is not heard, we proceed to disconnect.
> Since TX is blocked (without mac80211 being aware of it) the frame
> is stuck, resulting with queue hang.
> 
> Instead, reenable TX before reporting on the connection loss.
> As we are on the new channel, there is no problem with that,
> even if the original CSA had quiet mode.
> 
> Signed-off-by: Sara Sharon <sara.sharon@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

23 patches applied to iwlwifi-next.git, thanks.

e50a3224d5b9 iwlwifi: mvm: enable TX on new CSA channel before disconnecting
d583a96c20de iwlwifi: pcie: avoid unnecessarily taking spinlock
adedb902b4c3 iwlwifi: pcie: normally grab NIC access for inflight-hcmd
c0bb606bd2c6 iwlwifi: mvm: don't allow CSA if we haven't been fully associated
f8f6cb35b440 iwlwifi: pcie: Add support for Bz Family
abab8a17a411 iwlwifi: change step in so-gf struct
a7c74adb6933 iwlwifi: change name to AX 211 and 411 family
727e0c990a82 iwlwifi: add 160Mhz to killer 1550 name
25122919dbbb iwlwifi: pcie: clear only FH bits handle in the interrupt
8866c3ee14d6 iwlwifi: pcie: make cfg vs. trans_cfg more robust
d30732924dee iwlwifi: mvm: support range request command version 12
d7c97205df0c iwlwifi: mvm: responder: support responder config command version 8
5422db22b508 iwlwifi: mvm: write queue_sync_state only for sync
bdbb8ce0fc69 iwlwifi: mvm: clean up queue sync implementation
87e03392c341 iwlwifi: mvm: when associated with PMF, use protected NDP ranging negotiation
c45f3b5f2f5a iwlwifi: add ax201 killer device
59bb220d560c iwlwifi: mvm: Add support for 6GHz passive scan
4070cea0ff1e iwlwifi: mvm: enable PPAG in China
f4ee09ce14dc iwlwifi: add new so-gf device
0fab0784ed2e iwlwifi: move iwl_configure_rxq to be used by other op_modes
8e8f466f6ed2 iwlwifi: mvm: support BIOS enable/disable for 11ax in Ukraine
115ed30b64fa iwlwifi: mvm: refactor ACPI DSM evaluation function
a5e43bf62387 iwlwifi: mvm: Use IWL_INFO in fw_reset_handshake()

