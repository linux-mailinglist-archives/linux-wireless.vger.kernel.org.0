Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393C3565DA
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhDGH5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDGH5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 03:57:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EEFC06174A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 00:56:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lU33S-008Ty0-PO; Wed, 07 Apr 2021 09:56:50 +0200
Message-ID: <5c35de6e8e73fedb58e81919f465fe4038dacbbb.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 07 Apr 2021 09:56:49 +0200
In-Reply-To: <95b6c4b34da1173faf226246ea25b47a8fd395b7.camel@sipsolutions.net> (sfid-20210407_095601_284772_0EEA2A3A)
References: <b71f7f03-fa87-74ab-4f10-5cebe3e70b60@gmail.com>
         <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm>
         (sfid-20210407_095129_306913_82B5BB2F) <95b6c4b34da1173faf226246ea25b47a8fd395b7.camel@sipsolutions.net>
         (sfid-20210407_095601_284772_0EEA2A3A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-04-07 at 09:55 +0200, Johannes Berg wrote:
> On Wed, 2021-04-07 at 09:51 +0200, Jiri Kosina wrote:
> > On Wed, 7 Apr 2021, Heiner Kallweit wrote:
> > 
> > > Same fix as in 2800aadc18a6 ("iwlwifi: Fix softirq/hardirq disabling in
> > > iwl_pcie_enqueue_hcmd()") is needed for iwl_pcie_gen2_enqueue_hcmd.
> > > I get the same lockdep warning on AX210.
> > 
> > Makes sense, it's being called from exactly the same contexts.
> 
> I'm guessing nobody saw this before because the LEDs stuff is not
> supported/used on newer devices :)

Eh, wait, Heiner said he sees the same warning? With LEDs? I was pretty
sure that's not supported by the later firmware, but maybe some other
path? Anyway this fix seems right.

johannes

