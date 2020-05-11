Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1D1CD95F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgEKMIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 08:08:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60548 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727873AbgEKMIJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 08:08:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jY7E7-000YP2-4a; Mon, 11 May 2020 15:08:07 +0300
Message-ID: <6ce59a07ac639402685303b0954f0dfd6faa3876.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 11 May 2020 15:08:06 +0300
In-Reply-To: <874ksm66cw.fsf@kamboji.qca.qualcomm.com>
References: <20200508140802.558267-1-luca@coelho.fi>
         <iwlwifi.20200508170402.37266bcfa0a8.Iac74a6ffe45aff887cea13ee1d31b100ca11e249@changeid>
         <874ksm66cw.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: Re: [PATCH 05/11] iwlwifi: acpi: evaluate dsm to enable 5.2 bands
 in Indonesia
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-11 at 14:47 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Gil Adam <gil.adam@intel.com>
> > 
> > Evaluate the appropriate DSM from ACPI to enable 5.15,5.35 GHz
> > bands in Indonesia. If enabled send LARI_CONFIG_CHANGE cmd to fw.
> > 
> > Signed-off-by: Gil Adam <gil.adam@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > +static int iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
> > +{
> > +	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
> > +				      DSM_FUNC_ENABLE_INDONESIA_5G2);
> > +
> > +	IWL_DEBUG_RADIO(mvm,
> > +			"Evaluated DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
> > +			ret);
> > +
> > +	return ret == 1 ? 1 : 0;
> 
> Ugh. If it's _really_ important not to return anything bigger than 1
> maybe "!!ret"? Or maybe even just change the function to return boolean?

Ugh, indeed.  Guess who was not paying attention? Sorry.

I'll fix it.

--
Luca.

