Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7134E3B042D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhFVMXb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:23:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48534 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231272AbhFVMXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:23:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfOy-001awN-95; Tue, 22 Jun 2021 15:21:13 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210617100544.223090c509c4.If03cb5393607ae494041b6187bcec134d6a1e06d@changeid>
References: <iwlwifi.20210617100544.223090c509c4.If03cb5393607ae494041b6187bcec134d6a1e06d@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfOy-001awN-95@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:21:13 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 12/12] iwlwifi: mvm: Read acpi dsm to get unii4
 enable/disable
 bitmap.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Abhishek Naik <abhishek.naik@intel.com>
> 
> Read the UNII4 setting from the ACPI table and use it in the
> LARI_CONFIG_CHANGE_CMD accordingly.
> 
> This setting allows OEMs to enable or disable UNII4, bypassing the FW
> defaults.
> 
> Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to iwlwifi-next.git, thanks.

a434399e019f iwlwifi: mvm: Read acpi dsm to get unii4 enable/disable bitmap.

