Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0683E28074D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJAS6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 14:58:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53662 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729047AbgJAS6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 14:58:49 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3mx-002NCi-BB; Thu, 01 Oct 2020 21:58:47 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200926002540.019a64e96d44.I609a995611ac5286e442cd54f764eaf4a7249ac0@changeid>
References: <iwlwifi.20200926002540.019a64e96d44.I609a995611ac5286e442cd54f764eaf4a7249ac0@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3mx-002NCi-BB@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 21:58:47 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 06/15] iwlwifi: mvm: Don't install CMAC/GMAC key in AP
 mode
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> 
> Due to a missing break, the management multicast key was installed even
> though we don't really support it. Fix that, so mac80211 would know that
> it should protect frames in software.
> 
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

10 patches applied to iwlwifi-next.git, thanks.

a1c2ff302413 iwlwifi: mvm: Don't install CMAC/GMAC key in AP mode
870bde78576c iwlwifi: mvm: add support for new version of WOWLAN_TKIP_SETTING_API_S
2b3eb122342c iwlwifi: mvm: process ba-notifications also when sta rcu is invalid
090a5d7c8b19 iwlwifi: don't export acpi functions unnecessarily
ee3ae3a18a74 iwlwifi: mvm: add support for new WOWLAN_TSC_RSC_PARAM version
cfa5d0ca0f61 iwlwifi: mvm: remove redundant support_umac_log field
59ca9572dee9 iwlwifi: mvm: use CHECKSUM_COMPLETE
f604324eefec iwlwifi: remove iwl_validate_sar_geo_profile() export
f961e9fc35cc iwlwifi: acpi: remove dummy definition of iwl_sar_set_profile()
38cb52dd4e86 iwlwifi: add new card for MA family

