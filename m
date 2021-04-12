Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358B535C3E9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 12:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhDLK0j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 06:26:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44600 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237753AbhDLK0j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 06:26:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVtlr-000KwM-4n; Mon, 12 Apr 2021 13:26:20 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210411124417.b6560a5de0cd.I5dac9c60faed7f48b06d352aa2d65bcf8142c2dc@changeid>
References: <iwlwifi.20210411124417.b6560a5de0cd.I5dac9c60faed7f48b06d352aa2d65bcf8142c2dc@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lVtlr-000KwM-4n@farmhouse.coelho.fi>
Date:   Mon, 12 Apr 2021 13:26:20 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: remove TCM events
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> Nobody uses that in the user space.
> 
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

8244069894aa iwlwifi: remove TCM events
01bc923760e3 iwlwifi: remove remaining software checksum code
0923ac03cba9 iwlwifi: don't warn if we can't wait for empty tx queues
c6ad19352b1e iwlwifi: queue: avoid memory leak in reset flow
816a94733982 iwlwifi: mvm: umac error table mismatch
ed4698185bda iwlwifi: mvm: remove PS from lower rates.
1b5b54d5b003 iwlwifi: mvm: don't lock mutex in RCU critical section
19a979a0bfb7 iwlwifi: pcie: merge napi_poll_msix functions
50a8bc609b07 iwlwifi: pcie: add ISR debug info for msix debug
5ed4a2ae4fdc iwlwifi: mvm: add support for version 3 of LARI_CONFIG_CHANGE command.
be6c1c10b43d iwlwifi: warn on SKB free w/o op-mode
5f8432c8f45d iwlwifi: rs-fw: don't support stbc for HE 160

