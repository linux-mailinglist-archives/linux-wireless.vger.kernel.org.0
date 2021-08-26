Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397043F8FB6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbhHZUfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:35:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33524 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243515AbhHZUfh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:35:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM5H-002XLs-5d; Thu, 26 Aug 2021 23:34:48 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210802215208.8535203d0ef7.Ib1695ce5de921b0472d0b1052e729e071573b863@changeid>
References: <iwlwifi.20210802215208.8535203d0ef7.Ib1695ce5de921b0472d0b1052e729e071573b863@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM5H-002XLs-5d@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:34:48 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/10] iwlwifi: yoyo: cleanup internal buffer allocation
 in D3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> 
> With recent changes in the firmware SRAM debug during D3 is
> enabled by default and need not be enabled by driver.
> cleaning the code to align the same.
> 
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

10 patches applied to iwlwifi-next.git, thanks.

e75bc5f3f110 iwlwifi: yoyo: cleanup internal buffer allocation in D3
d98cee05e3fd iwlwifi: split off Bz devices into their own family
d01408ee3a2b iwlwifi: give Bz devices their own name
7e6dffda95d0 iwlwifi: read MAC address from correct place on Bz
9ce041f5966f iwlwifi: pcie: implement Bz device startup
6c0795f1a524 iwlwifi: implement Bz NMI behaviour
9de168a01279 iwlwifi: pcie: implement Bz reset flow
35fc5feca7b2 iwlwifi: mvm: Fix umac scan request probe parameters
199d895f4760 iwlwifi: mvm: support new station key API
95a62c331f6a iwlwifi: mvm: simplify __iwl_mvm_set_sta_key()

