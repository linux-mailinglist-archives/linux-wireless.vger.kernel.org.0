Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AE437314
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 09:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhJVHxG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 03:53:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57032 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231773AbhJVHxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 03:53:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mdpKB-000bhS-F2; Fri, 22 Oct 2021 10:50:47 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20211017113927.8e992a3beee2.I4231ac8a7ae8f844e35a1ec221baf3e2b676e765@changeid>
References: <iwlwifi.20211017113927.8e992a3beee2.I4231ac8a7ae8f844e35a1ec221baf3e2b676e765@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.7
Message-Id: <E1mdpKB-000bhS-F2@farmhouse.coelho.fi>
Date:   Fri, 22 Oct 2021 10:50:47 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 01/10] iwlwifi: mvm: fix ieee80211_get_he_iftype_cap()
 iftype
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> We should consider the P2P interface type, which isn't in
> vif->type due to mac80211's special handling of that. Use
> ieee80211_vif_type_p2p() to convert appropriately.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

40 patches applied to iwlwifi-next.git, thanks.

4e6b69ec9a9e iwlwifi: mvm: fix ieee80211_get_he_iftype_cap() iftype
e5322b9ab5f6 iwlwifi: mvm: disable RX-diversity in powersave
5667ccc2a387 iwlwifi: mvm: add lmac/umac PC info in case of error
ee02e598019e iwlwifi: add vendor specific capabilities for some RFs
8a2c15162316 iwlwifi: mvm: add support for 160Mhz in ranging measurements
57b7b345d279 iwlwifi: mvm: Remove antenna c references
e79b2fc938f4 iwlwifi: add some missing kernel-doc in struct iwl_fw
3d563f1290c4 iwlwifi: api: remove unused RX status bits
e0e0d16641cd iwlwifi: remove MODULE_AUTHOR() statements
854fe828e58c iwlwifi: remove contact information
98c8bd77e624 iwlwifi: fix fw/img.c license statement
34c4eca167ae iwlwifi: api: fix struct iwl_wowlan_status_v7 kernel-doc
4634b1768104 iwlwifi: mvm: correct sta-state logic for TDLS
fdb70083dd28 iwlwifi: fw dump: add infrastructure for dump scrubbing
fad92a1d11f6 iwlwifi: parse debug exclude data from firmware file
12d60c1efc29 iwlwifi: mvm: scrub key material in firmware dumps
48c6ebc13c1c iwlwifi: mvm: update definitions due to new rate & flags
179354a6637f iwlwifi: mvm: add definitions for new rate & flags
9998f81e4ba5 iwlwifi: mvm: convert old rate & flags to the new format.
82cdbd11b60a iwlwifi: mvm: Support version 3 of tlc_update_notif.
bd8b5f30fa2c iwlwifi: mvm: Support new version of ranging response notification
f21baf244112 iwlwifi: yoyo: fw debug config from context info and preset
44b2dd4098be iwlwifi: BZ Family BUS_MASTER_DISABLE_REQ code duplication
1b6598c3dc35 iwlwifi: BZ Family SW reset support
d35d95ce8b0a iwlwifi: mvm: Add support for new rate_n_flags in tx_cmd.
cd2c46a7eb59 iwlwifi: mvm: Support new version of BEACON_TEMPLATE_CMD.
dc52fac37c87 iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions
ce712478a458 iwlwifi: mvm: Support new rate_n_flags for REPLY_RX_MPDU_CMD and RX_NO_DATA_NOTIF
544ab2a9a875 iwlwifi: mvm: remove csi from iwl_mvm_pass_packet_to_mac80211()
ebd935987800 iwlwifi: mvm: Add RTS and CTS flags to iwl_tx_cmd_flags.
425d66d8ddfc iwlwifi: remove redundant iwl_finish_nic_init() argument
6b1259d1046c iwlwifi: mvm: remove session protection after auth/assoc
e5f1cc98cc1b iwlwifi: allow rate-limited error messages
75da590ffae7 iwlwifi: mvm: reduce WARN_ON() in TX status path
2fd8aaaeb874 iwlwifi: pcie: try to grab NIC access early
c0ad5c492521 iwlwifi: mvm: set inactivity timeouts also for PS-poll
33c99471b086 iwlwifi: add new killer devices to the driver
d41cdbcd7118 iwlwifi: dbg: treat dbgc allocation failure when tlv is missing
8b75858c2e21 iwlwifi: mvm: set BT-coex high priority for 802.1X/4-way-HS
c3eae059fcab iwlwifi: mvm: improve log when processing CSA

