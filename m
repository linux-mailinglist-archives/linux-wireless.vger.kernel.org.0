Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3735C3D7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbhDLKYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 06:24:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44594 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238685AbhDLKYd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 06:24:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVtjp-000KwB-2t; Mon, 12 Apr 2021 13:24:14 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210331121101.d11c9bcdb4aa.I0772171dbaec87433a11513e9586d98b5d920b5f@changeid>
References: <iwlwifi.20210331121101.d11c9bcdb4aa.I0772171dbaec87433a11513e9586d98b5d920b5f@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lVtjp-000KwB-2t@farmhouse.coelho.fi>
Date:   Mon, 12 Apr 2021 13:24:14 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: mvm: write queue_sync_state only for sync
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> We use mvm->queue_sync_state to wait for synchronous queue sync
> messages, but if an async one happens inbetween we shouldn't
> clear mvm->queue_sync_state after sending the async one, that
> can run concurrently (at least from the CPU POV) with another
> synchronous queue sync.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

11 patches applied to iwlwifi-next.git, thanks.

ac2d58b34dc9 iwlwifi: mvm: write queue_sync_state only for sync
d96fbcbb5040 iwlwifi: mvm: clean up queue sync implementation
35d261a2d9fa iwlwifi: mvm: when associated with PMF, use protected NDP ranging negotiation
920484e82ea5 iwlwifi: add ax201 killer device
f05a69e2c7d7 iwlwifi: mvm: Add support for 6GHz passive scan
7143a6771d2c iwlwifi: mvm: enable PPAG in China
4eedace3b6d6 iwlwifi: add new so-gf device
c3e599ec1757 iwlwifi: move iwl_configure_rxq to be used by other op_modes
bc0411c5b1f8 iwlwifi: mvm: support BIOS enable/disable for 11ax in Ukraine
d4eb23d659d3 iwlwifi: mvm: refactor ACPI DSM evaluation function
86817a2ea413 iwlwifi: mvm: Use IWL_INFO in fw_reset_handshake()

