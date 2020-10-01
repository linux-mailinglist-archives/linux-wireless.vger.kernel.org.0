Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B359B280754
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbgJATBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 15:01:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53678 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729418AbgJATBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 15:01:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[127.0.1.1])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kO3pY-002NDR-Rp; Thu, 01 Oct 2020 22:01:29 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20200930161256.48a9cec2081b.Iaec1e29f738232adfe9e2ea8e9eb9b6ff0323ae1@changeid>
References: <iwlwifi.20200930161256.48a9cec2081b.Iaec1e29f738232adfe9e2ea8e9eb9b6ff0323ae1@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.8.6
Message-Id: <E1kO3pY-002NDR-Rp@farmhouse.coelho.fi>
Date:   Thu, 01 Oct 2020 22:01:28 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 01/12] iwlwifi: mvm: Add FTM initiator RTT smoothing logic
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Ilan Peer <ilan.peer@intel.com>
> 
> The overcome instabilities in the RTT results add smoothing logic
> to the reported results. In short, the smoothing logic tracks the
> RTT average of each responder for a period of time, and in case
> a new RTT results is found to be a spur, the tracked RTT average
> is reported instead of the current RTT measurement.
> 
> Smooth logic debug configuration using iwl-dbg-cfg.ini:
> 
> - MVM_FTM_INITIATOR_ENABLE_SMOOTH: Set to 1 to enable smoothing logic
>  (default=0).
> - MVM_FTM_INITIATOR_SMOOTH_ALPHA: A value between 0 - 100, defining
>   the weight of the current RTT results vs. the RTT average tracked
>   based on the previous results. A value of 100 means use only the
>   current RTT results.
> - MVM_FTM_INITIATOR_SMOOTH_AGE_SEC: The maximal time in seconds in which
>   the RTT average tracked based on previous results is considered valid.
> - MVM_FTM_INITIATOR_SMOOTH_UNDERSHOOT: if the current RTT is positive
>   and below the RTT average by at least this value, report the average
>   RTT instead of the current one. In units of picoseconds.
> - MVM_FTM_INITIATOR_SMOOTH_OVERSHOOT: if the current RTT is positive
>   and above the RTT average by at least this value, report the average
>   RTT instead of the current one. In units of picoseconds.
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

b68bd2e3143a iwlwifi: mvm: Add FTM initiator RTT smoothing logic
890d814b1837 iwlwifi: mvm: location: set the HLTK when PASN station is added
68ad24742f17 iwlwifi: mvm: responder: allow to set only the HLTK for an associated station
0739a7d70e00 iwlwifi: mvm: initiator: add option for adding a PASN responder
0cd1ad2d7fd4 iwlwifi: move all bus-independent TX functions to common code
2a42aea79531 iwlwifi: mvm: support more GTK rekeying algorithms
c7f996eb894e iwlwifi: mvm: d3: support GCMP ciphers
bfdb157127da iwlwifi: dbg: remove no filter condition
19d9fa7ab9f3 iwlwifi: mvm: add d3 prints
42f8a2735cc2 iwlwifi: dbg: run init_cfg function once per driver load
762c523f95b8 iwlwifi: thermal: support new temperature measurement API
a86821069e87 iwlwifi: phy-ctxt: add new API VER 3 for phy context cmd

