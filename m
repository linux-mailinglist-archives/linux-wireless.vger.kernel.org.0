Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15C03166ED
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhBJMlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:41:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45160 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231171AbhBJMix (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:38:53 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9okp-0049c5-VE; Wed, 10 Feb 2021 14:38:00 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210210135352.71da7ce27261.I0d96fe7b799527c49f1270ddf9acdb152bdd4841@changeid>
References: <iwlwifi.20210210135352.71da7ce27261.I0d96fe7b799527c49f1270ddf9acdb152bdd4841@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l9okp-0049c5-VE@farmhouse.coelho.fi>
Date:   Wed, 10 Feb 2021 14:38:00 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2 01/12] iwlwifi: pcie: add a few missing entries for So
 with
 Hr
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Some devices were missing from the So with Hr section.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

806832c9651b iwlwifi: pcie: add a few missing entries for So with Hr
874020f8adce iwlwifi: pcie: don't disable interrupts for reg_lock
f9a78edb2881 iwlwifi: acpi: fix PPAG table sizes
5a6842455c11 iwlwifi: mvm: fix the type we use in the PPAG table validity checks
551d793f6536 iwlwifi: mvm: store PPAG enabled/disabled flag properly
659844d39182 iwlwifi: mvm: send stored PPAG command instead of local
b06b598664da iwlwifi: mvm: enhance a print in CSA flows
34b79fcf1e39 iwlwifi: mvm: remove useless iwl_mvm_resume_d3() function
28db1862067c iwlwifi: mvm: assign SAR table revision to the command later
9cf671d60fdb iwlwifi: pcie: NULLify pointers after free
004272bc8d9d iwlwifi: when HW has rate offload don't look at control field
1c094e5e2b02 iwlwifi: pcie: Change Ma device ID

