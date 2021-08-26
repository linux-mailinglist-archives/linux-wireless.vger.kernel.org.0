Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87F03F8FBB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbhHZUiU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:38:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33542 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243505AbhHZUiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:38:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJM7t-002XMl-8z; Thu, 26 Aug 2021 23:37:30 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210819183728.1cb15b015485.I2818924b772d7518f4d9fc38b4caab3494ab11f9@changeid>
References: <iwlwifi.20210819183728.1cb15b015485.I2818924b772d7518f4d9fc38b4caab3494ab11f9@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1mJM7t-002XMl-8z@farmhouse.coelho.fi>
Date:   Thu, 26 Aug 2021 23:37:30 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/11] iwlwifi: bump FW API to 65 for AX devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Start supporting API version 65 for AX devices.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

11 patches applied to iwlwifi-next.git, thanks.

a6a39ab2645c iwlwifi: bump FW API to 65 for AX devices
c5b42c674ad8 iwlwifi: acpi: fill in WGDS table with defaults
40063f602868 iwlwifi: acpi: fill in SAR tables with defaults
59a6ee97e0d4 iwlwifi: pcie: avoid dma unmap/remap in crash dump
4246465edb16 iwlwifi: fix __percpu annotation
394f41929672 iwlwifi: api: remove datamember from struct
8a433cb64ec5 iwlwifi: fw: fix debug dump data declarations
4e110e799cb5 iwlwifi: add 'Rx control frame to MBSSID' HE capability
89639e06d0f3 iwlwifi: yoyo: support for new DBGI_SRAM region
a76b57311b1a iwlwifi: mvm: don't schedule the roc_done_wk if it is already running
7e47f41648b2 iwlwifi: allow debug init in RF-kill

