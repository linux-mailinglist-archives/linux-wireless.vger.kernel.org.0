Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D75280751
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgJATA0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:00:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53670 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729412AbgJATAH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:00:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3oC-002NCy-S1; Thu, 01 Oct 2020 22:00:05 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200928121852.4f0bea9fe077.Ib3b540a8288af32d6fa213448e13f82763f85bc9@changeid>
References: <iwlwifi.20200928121852.4f0bea9fe077.Ib3b540a8288af32d6fa213448e13f82763f85bc9@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3oC-002NCy-S1@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 22:00:04 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/12] iwlwifi: add a common struct for all
 iwl_tx_power_cmd
 versions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Create a common structure to contain all different versions of the
> tx_power_cmd instead of making a union of the different structs
> everywhere we need them.  Also move the common part of these structs
> into a separate structure (instead of reusing v3) and leave the
> per_chain_restriction part out of the common part, because this will
> change in version 6 of the command (which will be added soon).
> 
> While at it, rename per_chain_restriction to per_chain to shorten it.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

216cdfb5225f iwlwifi: add a common struct for all iwl_tx_power_cmd versions
9c08cef87048 iwlwifi: acpi: prepare SAR profile selection code for multiple sizes
fbb7957d28ac iwlwifi: support REDUCE_TX_POWER_CMD version 6
dd2a1256e6a8 iwlwifi: acpi: rename geo structs to contain versioning
0ea788ed0f3b iwlwifi: support version 3 of GEO_TX_POWER_LIMIT
9e3c39361a30 iwlwifi: mvm: support new KEK KCK api
507a13f5c9c9 iwlwifi: rs: set RTS protection for all non legacy rates
4795983b8704 iwlwifi: acpi: in non acpi compilations remove iwl_sar_geo_init
e80bfd117d89 iwlwifi: fw: add default value for iwl_fw_lookup_cmd_ver
0a8159cbd11a iwlwifi: remove wide_cmd_header field
1c096d8935c1 iwlwifi: mvm: add support for range request command ver 11
3830a01c3bfa iwlwifi: mvm: add support for responder dynamic config command version 3

