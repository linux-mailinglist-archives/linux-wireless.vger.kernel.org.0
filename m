Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E092446
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfHSNHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 09:07:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36730 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726987AbfHSNHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 09:07:36 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzhNm-0007q6-Bq; Mon, 19 Aug 2019 16:07:35 +0300
Message-ID: <1a9aac709aef29b2515bbfb29c99f91ed83619bb.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 16:07:32 +0300
In-Reply-To: <877e7abmsh.fsf@kamboji.qca.qualcomm.com>
References: <20190817065200.9701-1-luca@coelho.fi>
         <20190817065200.9701-10-luca@coelho.fi>
         <877e7abmsh.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 09/22] iwlwifi: remove iwl-constants.h
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-08-18 at 16:55 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > 
> > This file is included in a few source files, but its content
> > is never used. Remove it.
> > 
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> > index bf0b9ee05c44..2aa5320e9d1a 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
> > @@ -414,6 +414,7 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
> >  	HCMD_NAME(SCAN_ITERATION_COMPLETE),
> >  	HCMD_NAME(D0I3_END_CMD),
> >  	HCMD_NAME(LTR_CONFIG),
> > +	HCMD_NAME(LDBG_CONFIG_CMD),
> >  };
> >  
> >  /* Please keep this array *SORTED* by hex value.
> 
> The commit log does not seem to match with the actual patch.

Hmmm... somehow a different commit message creeped in.  I'll fix it.

--
Luca.

