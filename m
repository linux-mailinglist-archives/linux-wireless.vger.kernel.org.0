Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E38AC9244B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHSNIG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 09:08:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36738 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726987AbfHSNIG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 09:08:06 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzhOG-0007qK-LG; Mon, 19 Aug 2019 16:08:05 +0300
Message-ID: <a0e14be145093c69c6746c46dfc8d7f0b495c21b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 16:08:03 +0300
In-Reply-To: <87y2zqa7ye.fsf@kamboji.qca.qualcomm.com>
References: <20190817065200.9701-1-luca@coelho.fi>
         <20190817065200.9701-13-luca@coelho.fi>
         <87y2zqa7ye.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 12/22] iwlwifi: mvm: start to remove the code for d0i3
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-08-18 at 17:01 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > 
> > This is only the very start, much more work is needed.
> > Remove the places where we check iwl_mvm_is_d0i3_supported
> > but leave all the refs, those will be removed in a different
> > patch.
> > 
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> It would be good to explain _why_ you are removing d0i3 support. Basend
> on the cover letter apparently it's broken but there's no detailed
> information.

Okay, I'll expand this commit log to explain our reasoning behind
removing this code.

--
Luca.

