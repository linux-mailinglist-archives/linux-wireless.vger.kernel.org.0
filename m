Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4E280745
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 20:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgJASxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 14:53:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53622 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729047AbgJASxd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 14:53:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3hq-002NBS-WB; Thu, 01 Oct 2020 21:53:31 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200911204056.523f5eca82ce.Ic0cd9cc86a91b1f23a5a54921736332be9abac29@changeid>
References: <iwlwifi.20200911204056.523f5eca82ce.Ic0cd9cc86a91b1f23a5a54921736332be9abac29@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3hq-002NBS-WB@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 21:53:31 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/11] iwlwifi: mvm: rs-fw: handle VHT extended NSS
 capability
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> If extended NSS capability is used, the NSS for 160 may be
> lower than for 80.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

11 patches applied to iwlwifi-next.git, thanks.

3d70247d34fc iwlwifi: mvm: rs-fw: handle VHT extended NSS capability
bbb95d37b74f iwlwifi: mvm: add PROTECTED_TWT firmware API
659ac93d7ced iwlwifi: mvm: set PROTECTED_TWT in MAC data policy
9c11d8a9d41c iwlwifi: mvm: set PROTECTED_TWT feature if supported by firmware
7e0ca7230b98 iwlwifi: sta: defer ADDBA transmit in case reclaimed SN != next SN
0cd38f4d0529 iwlwifi: msix: limit max RX queues for 9000 family
02d31e9b626a iwlwifi: acpi: evaluate dsm to disable 5.8GHz channels
d14f499dd2ed iwlwifi: wowlan: adapt to wowlan status API version 10
79946ee77428 iwlwifi: fw: move assert descriptor parser to common code
64564669e1a5 iwlwifi: add new cards for AX201 family
be82ecd3a5c8 iwlwifi: mvm: add an option to add PASN station

