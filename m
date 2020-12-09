Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F122D4D67
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 23:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgLIWRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 17:17:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:36024 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727853AbgLIWRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 17:17:21 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn7lC-003E63-KK; Thu, 10 Dec 2020 00:16:35 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20201209231352.6207fdcc91a9.Ia71e766ead7560262f4bc6ad3da6f1117c498cd6@changeid>
References: <iwlwifi.20201209231352.6207fdcc91a9.Ia71e766ead7560262f4bc6ad3da6f1117c498cd6@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1rc1
Message-Id: <E1kn7lC-003E63-KK@farmhouse.coelho.fi>
Date:   Thu, 10 Dec 2020 00:16:34 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH v2 35/47] iwlwifi: pcie: clean up some rx code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> We don't need the sequence/index/cmd_index unless we're doing
> reclaim, they're not even valid in the other cases. Move the
> variables and their assignments into the right if statement
> and combine the two if statements into a single one as well.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

13 patches applied to iwlwifi-next.git, thanks.

e4475583b5c4 iwlwifi: pcie: clean up some rx code
b570e5b0592a iwlwifi: mvm: validate firmware sync response size
caf463771295 iwlwifi: mvm: fix a race in CSA that caused assert 0x3420
b2ed841ed070 iwlwifi: add an extra firmware state in the transport
906d4eb84408 iwlwifi: support firmware reset handshake
87d9564e14cf iwlwifi: mvm: disconnect if channel switch delay is too long
ac1a98e1e924 iwlwifi: Add a new card for MA family
b8aba27cdc0e iwlwifi: tighten RX MPDU bounds checks
8a59d39033c3 iwlwifi: mvm: hook up missing RX handlers
27eeb03784b3 iwlwifi: mvm: add size checks for range response notification
c0f46dca0019 iwlwifi: mvm: check that statistics TLV version match struct version
d3d9b4fca363 iwlwifi: mvm: purge the BSS table upon firmware load
fd1c3318f4e7 iwlwifi: mvm: validate notification size when waiting

