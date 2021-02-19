Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA631FF9A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBST7F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 14:59:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:46412 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229555AbhBST7E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 14:59:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lDBug-004I4b-1Q; Fri, 19 Feb 2021 21:58:09 +0200
Message-ID: <5a81b6289a2242ae32b46f012aad2f94a232e595.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Andy Lavr <andy.lavr@gmail.com>
Date:   Fri, 19 Feb 2021 21:58:03 +0200
In-Reply-To: <87eehcglgy.fsf@tynnyri.adurom.net>
References: <20210219133506.ecabe285bc7d.I73d230d555c595fa2d9bf284f80078729fe18aa4@changeid>
         <87eehcglgy.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH] iwlwifi: avoid crash on unsupported debug collection
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-02-19 at 16:50 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > If the opmode doesn't support debug collection (DVM) then don't
> > crash, but just skip the callback.
> > 
> > Fixes: d01293154c0a ("iwlwifi: dbg: add op_mode callback for collecting debug data.")
> > Reported-by: Andy Lavr <andy.lavr@gmail.com>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> Should I take this to wireless-drivers?

Yes, please take this to wireless-drivers.  As Johannes said, this
breaks all DVM (older) devices.

--
Luca.

