Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E098D3B042C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFVMXQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 08:23:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48528 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229912AbhFVMXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 08:23:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvfOf-001awB-EH; Tue, 22 Jun 2021 15:20:54 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210617110647.5f5764e04c46.I4d5de1929be048085767f1234a1e07b517ab6a2d@changeid>
References: <iwlwifi.20210617110647.5f5764e04c46.I4d5de1929be048085767f1234a1e07b517ab6a2d@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lvfOf-001awB-EH@farmhouse.coelho.fi>
Date:   Tue, 22 Jun 2021 15:20:54 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH v2 11/12] iwlwifi: pcie: remove TR/CR tail allocations
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> The TR/CR tail data are meant to be per-queue-arrays, however,
> we allocate them completely wrong (we have a separate allocation
> per queue).
> 
> Looking at this more closely, it turns out that the hardware
> never uses these - we have a separate free list per RX queue
> and maintain a write pointer for that in a register, and the
> RX itself is indicated in the RB status (rb_stts) DMA region.
> 
> Despite nothing using the tail pointers, the hardware will
> unconditionally access them to write updates, even when we aren't
> using CRs/TRs.
> 
> Give it dummy values that we never use/update so it can do that
> without causing trouble.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to iwlwifi-next.git, thanks.

a5575a54df00 iwlwifi: pcie: remove TR/CR tail allocations

