Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C03F8FBA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbhHZUhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:37:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33536 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243505AbhHZUhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:37:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM6z-002XMS-Mf; Thu, 26 Aug 2021 23:36:35 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210805141826.905b54c398f8.I9bac8c3bc3b1b6bbe813de53746daee33e53fc86@changeid>
References: <iwlwifi.20210805141826.905b54c398f8.I9bac8c3bc3b1b6bbe813de53746daee33e53fc86@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM6z-002XMS-Mf@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:36:34 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: pass number of chains and sub-bands to
 iwl_sar_set_profile()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The number of chains and sub-bands read from the ACPI tables varies
> depending on the revision.  Pass these numbers to the
> iwl_sar_set_profile() function in order to make using different
> revisions easier.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

8ecf0477b990 iwlwifi: pass number of chains and sub-bands to iwl_sar_set_profile()
2a8084147bff iwlwifi: acpi: support reading and storing WRDS revision 1 and 2
51266c11cecc iwlwifi: support reading and storing EWRD revisions 1 and 2
de95c9288ae1 iwlwifi: remove unused ACPI_WGDS_TABLE_SIZE definition
5bf7a9edddbb iwlwifi: convert flat GEO profile table to a struct version
058b94dc9bf8 iwlwifi: mvm: support version 11 of wowlan statuses notification
19426d54302e iwlwifi: skip first element in the WTAS ACPI table
e6344c060209 iwlwifi: fw: correctly limit to monitor dump
b537ffb6ea16 iwlwifi: mvm: trigger WRT when no beacon heard
78a19d5285d9 iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage
eb09ae93dabf iwlwifi: mvm: load regdomain at INIT stage
664c011b763e iwlwifi: acpi: support reading and storing WGDS revision 2

