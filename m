Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D9327BEDE
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgI2IJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 04:09:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52960 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725786AbgI2IJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 04:09:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNAhJ-002LQw-P5; Tue, 29 Sep 2020 11:09:18 +0300
Message-ID: <d3b1e59c4becafa1dd03523744b8e35696a78bb1.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 29 Sep 2020 11:09:15 +0300
In-Reply-To: <87sgb1dnq5.fsf@codeaurora.org>
References: <20200925213053.454459-1-luca@coelho.fi>
         <iwlwifi.20200926002540.c76108b9c476.Ib06008665e7bf1199c360aa92691d9c74fb84990@changeid>
         <87sgb1dnq5.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 05/15] iwlwifi: mvm: split a print to avoid a WARNING in
 ROC
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-29 at 10:52 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > 
> > A print in the remain on channel code was too long and caused
> > a WARNING, split it.
> > 
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Fixes: 758cba88d008 ("iwlwifi: mvm: ROC: Extend the ROC max delay duration & limit ROC duration")
> 
> Is the commit id correct?
> 
> $ git show 758cba88d008
> fatal: ambiguous argument '758cba88d008': unknown revision or path not in the working tree.

Hmmm, very weird.  Must be something wrong with my script.  It took the
internal SHA1... It works with some other patches.

I'll fix this and investigate what's wrong with the script.

Sorry about the trouble.

--
Cheers,
Luca.

