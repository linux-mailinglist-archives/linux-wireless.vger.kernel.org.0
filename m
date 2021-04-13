Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5120535D7AE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbhDMGCJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 02:02:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44720 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243829AbhDMGCJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 02:02:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lWC7P-000LPJ-5p; Tue, 13 Apr 2021 09:01:48 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210411124417.b6560a5de0cd.I5dac9c60faed7f48b06d352aa2d65bcf8142c2dc@changeid>
References: <iwlwifi.20210411124417.b6560a5de0cd.I5dac9c60faed7f48b06d352aa2d65bcf8142c2dc@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lWC7P-000LPJ-5p@farmhouse.coelho.fi>
Date:   Tue, 13 Apr 2021 09:01:48 +0300
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

19 patches applied to iwlwifi-next.git, thanks.

e0dd86f0bd69 iwlwifi: remove TCM events
3b3f8821c4c9 iwlwifi: remove remaining software checksum code
026551c60e8e iwlwifi: don't warn if we can't wait for empty tx queues
223ebf2ebf6a iwlwifi: queue: avoid memory leak in reset flow
9bda8492febf iwlwifi: mvm: umac error table mismatch
3e34b44d849d iwlwifi: mvm: remove PS from lower rates.
06c0cf9da5f2 iwlwifi: mvm: don't lock mutex in RCU critical section
9ff251354ce9 iwlwifi: pcie: merge napi_poll_msix functions
00b553eb054c iwlwifi: pcie: add ISR debug info for msix debug
f3e8147496ce iwlwifi: mvm: add support for version 3 of LARI_CONFIG_CHANGE command.
ad68eb03d7af iwlwifi: warn on SKB free w/o op-mode
f133d1cf5a79 iwlwifi: rs-fw: don't support stbc for HE 160
79470344e77d iwlwifi: mvm: don't disconnect immediately if we don't hear beacons after CSA
9c6e322ff5ff iwlwifi: mvm: don't WARN if we can't remove a time event
0fc56a04f96b iwlwifi: bump FW API to 63 for AX devices
6cd6b59b4af3 iwlwifi: trans/pcie: defer transport initialisation
2684e13a1069 iwlwifi: fw: print out trigger delay when collecting data
e8b94b7ede60 iwlwifi: pcie: Change ma product string name
daa13ebd0481 iwlwifi: dbg: disable ini debug in 9000 family and below

