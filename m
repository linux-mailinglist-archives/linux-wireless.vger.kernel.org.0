Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129293B0457
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhFVM3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:29:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48546 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231181AbhFVM3p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:29:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfUz-001awl-PD; Tue, 22 Jun 2021 15:27:27 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210621103449.73eceb822890.I37347afbc01497a8a9e4d4afe4fa9a965abd31ac@changeid>
References: <iwlwifi.20210621103449.73eceb822890.I37347afbc01497a8a9e4d4afe4fa9a965abd31ac@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfUz-001awl-PD@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:27:26 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 1/9] iwlwifi: mvm: update iwl_wowlan_patterns_cmd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> We need to pass the station id to tell the firmware
> on which station we want to configure the patterns.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

9 patches applied to iwlwifi-next.git, thanks.

d9444014885d iwlwifi: mvm: update iwl_wowlan_patterns_cmd
df39ebbb89a5 iwlwifi: mvm: introduce iwl_wowlan_kek_kck_material_cmd_v4
1bb8e49cbe10 iwlwifi: mvm: introduce iwl_wowlan_get_status_cmd
805059d6018a iwlwifi: move UEFI code to a separate file
2f703c60a50f iwlwifi: support loading the reduced power table from UEFI
5f4fda58c705 iwlwifi: move error dump to fw utils
67bae0bfe733 iwlwifi: add 9560 killer device
e9e483e5fe6d iwlwifi: fw: dump TCM error table if present
daeeadc4f8f4 iwlwifi: bump FW API to 64 for AX devices

