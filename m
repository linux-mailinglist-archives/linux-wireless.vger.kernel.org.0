Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77DE3B0436
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFVMZL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:25:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48540 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230393AbhFVMZK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:25:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfQa-001awZ-F6; Tue, 22 Jun 2021 15:22:53 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210618105614.7c30f85ed241.Ibc19fdbefca7135f2c4ea83d0aef6b81b5033dcd@changeid>
References: <iwlwifi.20210618105614.7c30f85ed241.Ibc19fdbefca7135f2c4ea83d0aef6b81b5033dcd@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfQa-001awZ-F6@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:22:53 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/10] iwlwifi: mvm: Explicitly stop session protection
 before
 unbinding
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ilan Peer <ilan.peer@intel.com>
> 
> In case of unbinding, the FW would remove the session protection time
> events without sending a notification, so explicitly cancel the
> session protection, so future requests for mgd_prepare_tx() would not
> assume that the session protection is running.
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

10 patches applied to iwlwifi-next.git, thanks.

36ec9b2d888b iwlwifi: mvm: Explicitly stop session protection before unbinding
429fdaf8225c iwlwifi: mvm: don't request mac80211 to disable/enable sta's queues
995567a6e716 iwlwifi: support ver 6 of WOWLAN_CONFIGURATION and ver 10 of WOWLAN_GET_STATUSES
74036b4eee86 iwlwifi: mvm: support LONG_GROUP for WOWLAN_GET_STATUSES version
9a3daf10de54 iwlwifi: pcie: free IML DMA memory allocation
50e5cd79b42b iwlwifi: pcie: fix context info freeing
f34f4bf5e572 iwlwifi: mvm: fill phy_data.d1 for no-data RX
bd2a0cc7707b iwlwifi: pcie: free some DMA memory earlier
a28c4e3dc256 iwlwifi: fix NUM_IWL_UCODE_TLV_* definitions to avoid sparse errors
48effacf61ed iwlwifi: mvm: introduce iwl_proto_offload_cmd_v4

