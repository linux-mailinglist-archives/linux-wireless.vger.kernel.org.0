Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBB2D4D5E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 23:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbgLIWMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 17:12:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35992 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388268AbgLIWMc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 17:12:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn7gT-003E58-WE; Thu, 10 Dec 2020 00:11:42 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20201209231351.69231238667c.I04c6d012d9244a73261685f8fc797a26e5c961d6@changeid>
References: <iwlwifi.20201209231351.69231238667c.I04c6d012d9244a73261685f8fc797a26e5c961d6@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1rc1
Message-Id: <E1kn7gT-003E58-WE@farmhouse.coelho.fi>
Date:   Thu, 10 Dec 2020 00:11:42 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2 01/47] iwlwifi: remove all queue resources before free
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> Currently calling iwl_txq_dyn_free only deletes the queue memory/DMA
> but any active timers are not dealt with.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

10 patches applied to iwlwifi-next.git, thanks.

2f8cfcc43dae iwlwifi: remove all queue resources before free
b34872bc831d iwlwifi: yoyo: add the ability to dump phy periphery
cc598782d7c0 iwlwifi: yoyo: align the write pointer to DWs
846067693fc8 iwlwifi: mvm: fix sar profile printing issue
a44509805895 iwlwifi: move reclaim flows to the queue file
525791354706 iwlwifi: d3: do not send the WOWLAN_CONFIGURATION command for netdetect
486e93ef3e1c iwlwifi: mvm: Init error table memory to zero
3b25f1aff503 iwlwifi: mvm: remove the read_nvm from iwl_run_init_mvm_ucode
4adfaf9b2de3 iwlwifi: pcie: remove obsolete pre-release support code
d43ab298efc6 iwlwifi: copy iwl_he_capa for modifications

