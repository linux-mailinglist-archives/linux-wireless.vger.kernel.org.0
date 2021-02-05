Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60503108A7
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 11:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBEKEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 05:04:08 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230296AbhBEKAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 05:00:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7xtM-0044mK-Cz; Fri, 05 Feb 2021 11:59:08 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210131201907.4a802b308a0f.I77855abbf6dc1a6edf9c914f3313a87bd78de4df@changeid>
References: <iwlwifi.20210131201907.4a802b308a0f.I77855abbf6dc1a6edf9c914f3313a87bd78de4df@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.1+
Message-Id: <E1l7xtM-0044mK-Cz@farmhouse.coelho.fi>
Date:   Fri, 05 Feb 2021 11:59:08 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/12] iwlwifi: mvm: add IML/ROM information for other HW
 families
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> This makes it easier to debug IML/ROM errors for other HW families
> as well.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

5226cecbc6c8 iwlwifi: mvm: add IML/ROM information for other HW families
119c2a13a3e8 iwlwifi: mvm: add triggers for MLME events
1db5c3472b2a iwlwifi: fwrt: add suspend/resume time point
0d65ce900d11 iwlwifi: mvm: add tx fail time point
9dbb62a29042 iwlwifi: mvm: add debugfs entry to trigger a dump as any time-point
efaa85cf2294 iwlwifi: mvm: set enabled in the PPAG command properly
a2ac0f48a07c iwlwifi: mvm: implement approved list for the PPAG feature
ca176eddeba2 iwlwifi: mvm: add HP to the PPAG approved list
dd158ed674ed iwlwifi: mvm: add Samsung to the PPAG approved list
4a76553c88b4 iwlwifi: mvm: add Microsoft to the PPAG approved list
a7abc1eae7e4 iwlwifi: mvm: add Asus to the PPAG approved list
df8ba77ef4cc iwlwifi: bump FW API to 61 for AX devices

