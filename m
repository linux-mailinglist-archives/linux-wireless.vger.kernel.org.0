Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD93F8FB7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbhHZUge (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:36:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33530 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229966AbhHZUge (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:36:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM6B-002XM6-Nf; Thu, 26 Aug 2021 23:35:45 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210805130823.80721fc0fd61.I5a8fbba4e3a9606f700ee41c7a4244dd5e2af935@changeid>
References: <iwlwifi.20210805130823.80721fc0fd61.I5a8fbba4e3a9606f700ee41c7a4244dd5e2af935@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM6B-002XM6-Nf@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:35:44 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: mvm: d3: separate TKIP data from key
 iteration
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> We do a key iteration to program the keys, and while at it
> we also collect the data necessary for TKIP. This code has
> all kinds of dependencies on the firmware API though, so
> take out the TKIP phase 1 key generation and do that in a
> separate key iteration only if necessary.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

0419e5e672d6 iwlwifi: mvm: d3: separate TKIP data from key iteration
398760aa9679 iwlwifi: mvm: d3: remove fixed cmd_flags argument
631ee5120285 iwlwifi: mvm: d3: refactor TSC/RSC configuration
be05fae23d03 iwlwifi: mvm: d3: add separate key iteration for GTK type
af3aab9ce298 iwlwifi: mvm: d3: make key reprogramming iteration optional
79e561f0f05a iwlwifi: mvm: d3: implement RSC command version 5
3df5c0ddcf81 iwlwifi: mvm: silently drop encrypted frames for unknown station
967a39832ebe iwlwifi: mvm: Refactor setting of SSIDs for 6GHz scan
6c608cd6962e iwlwifi: mvm: fix access to BSS elements
248e7e2a1d8d iwlwifi: rename ACPI_SAR_NUM_CHAIN_LIMITS to ACPI_SAR_NUM_CHAINS
81870d138dfe iwlwifi: convert flat SAR profile table to a struct version
dac7171c8132 iwlwifi: remove ACPI_SAR_NUM_TABLES definition

