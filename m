Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF331B8D
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2019 13:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFALNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Jun 2019 07:13:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54402 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbfFALNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Jun 2019 07:13:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hX1xB-0001Dx-DZ; Sat, 01 Jun 2019 14:13:37 +0300
Message-ID: <b810ca2eec6280bc564a60a8d29f972068aef3f6.camel@coelho.fi>
Subject: Re: [PATCH 4/7] iwlwifi: print fseq info upon fw assert
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>
Date:   Sat, 01 Jun 2019 14:13:36 +0300
In-Reply-To: <87pno12ukq.fsf@kamboji.qca.qualcomm.com>
References: <20190529133955.31082-1-luca@coelho.fi>
         <20190529133955.31082-5-luca@coelho.fi>
         <87pno12ukq.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-05-29 at 17:39 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > 
> > Read fseq info from FW registers and print it upon fw assert.
> > The print is needed since the fseq version coming from the TLV might
> > not be the actual version that is used.
> > 
> > Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > +void iwl_fw_error_print_fseq_regs(struct iwl_fw_runtime *fwrt)
> > +{
> > +	struct iwl_trans *trans = fwrt->trans;
> > +	unsigned long flags;
> > +	int i;
> > +	struct {
> > +		u32 addr;
> > +		const char *str;
> > +	} fseq_regs[] = {
> > +		FSEQ_REG(FSEQ_ERROR_CODE),
> > +		FSEQ_REG(FSEQ_TOP_INIT_VERSION),
> > +		FSEQ_REG(FSEQ_CNVIO_INIT_VERSION),
> > +		FSEQ_REG(FSEQ_OTP_VERSION),
> > +		FSEQ_REG(FSEQ_TOP_CONTENT_VERSION),
> > +		FSEQ_REG(FSEQ_ALIVE_TOKEN),
> > +		FSEQ_REG(FSEQ_CNVI_ID),
> > +		FSEQ_REG(FSEQ_CNVR_ID),
> > +		FSEQ_REG(CNVI_AUX_MISC_CHIP),
> > +		FSEQ_REG(CNVR_AUX_MISC_CHIP),
> > +		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM),
> > +		FSEQ_REG(CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR),
> > +	};
> 
> Can fseq_regs be static const?

Yes, they can.  Can we send a fix for -next?

Shahar, can you make this change and send for internal review, please?

--
Cheers,
Luca.

