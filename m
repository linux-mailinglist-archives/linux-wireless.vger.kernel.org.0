Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3135C36E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhDLKME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 06:12:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44582 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238630AbhDLKKV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 06:10:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVtW2-000KvW-KU; Mon, 12 Apr 2021 13:10:00 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <iwlwifi.20210330162204.eb4f2ff1b863.Ib16238106b33d58b2b7688dc6297018b915ecef4@changeid>
References: <iwlwifi.20210330162204.eb4f2ff1b863.Ib16238106b33d58b2b7688dc6297018b915ecef4@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lVtW2-000KvW-KU@farmhouse.coelho.fi>
Date:   Mon, 12 Apr 2021 13:09:59 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH 01/12] iwlwifi: mvm: enable TX on new CSA channel before
 disconnecting
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Sara Sharon <sara.sharon@intel.com>
> 
> When moving to the new channel, we block TX until we hear the
> first beacon. if it is not heard, we proceed to disconnect.
> Since TX is blocked (without mac80211 being aware of it) the frame
> is stuck, resulting with queue hang.
> 
> Instead, reenable TX before reporting on the connection loss.
> As we are on the new channel, there is no problem with that,
> even if the original CSA had quiet mode.
> 
> Signed-off-by: Sara Sharon <sara.sharon@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

12 patches applied to iwlwifi-next.git, thanks.

89155fd1be13 iwlwifi: mvm: enable TX on new CSA channel before disconnecting
9c1d5a542af4 iwlwifi: pcie: avoid unnecessarily taking spinlock
15067411ad2f iwlwifi: pcie: normally grab NIC access for inflight-hcmd
b060bcc81557 iwlwifi: mvm: don't allow CSA if we haven't been fully associated
0c845f9c9584 iwlwifi: pcie: Add support for Bz Family
2d23d815f958 iwlwifi: change step in so-gf struct
cb10926a0a13 iwlwifi: change name to AX 211 and 411 family
b1d5eb429c8d iwlwifi: add 160Mhz to killer 1550 name
8b06b7eda055 iwlwifi: pcie: clear only FH bits handle in the interrupt
77c07024bd4c iwlwifi: pcie: make cfg vs. trans_cfg more robust
0c5de88265be iwlwifi: mvm: support range request command version 12
1d558311f67a iwlwifi: mvm: responder: support responder config command version 8

