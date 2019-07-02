Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E51515CC0E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2019 10:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGBIdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Jul 2019 04:33:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:49866 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfGBIdV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Jul 2019 04:33:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 01:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; 
   d="scan'208";a="174499498"
Received: from unknown (HELO redipa) ([10.252.28.236])
  by orsmga002.jf.intel.com with ESMTP; 02 Jul 2019 01:03:52 -0700
Message-ID: <7cc05c6313c40484b0801228a2762ccfac35a02a.camel@intel.com>
Subject: Re: [PATCH 3/3] iwlwifi: add support for quz firmwares
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Date:   Tue, 02 Jul 2019 11:03:51 +0300
In-Reply-To: <87k1el8ql9.fsf@miraculix.mork.no>
References: <20190322124744.17924-1-luca@coelho.fi>
         <20190322124744.17924-4-luca@coelho.fi> <87k1el8ql9.fsf@miraculix.mork.no>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-05-20 at 10:42 +0200, Bjørn Mork wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > --- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
> > +++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
> > @@ -549,6 +549,7 @@ extern const struct iwl_cfg iwl22000_2ac_cfg_hr;
> >  extern const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb;
> >  extern const struct iwl_cfg iwl22000_2ac_cfg_jf;
> >  extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
> > +extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
> >  extern const struct iwl_cfg iwl22000_2ax_cfg_hr;
> >  extern const struct iwl_cfg iwl_ax200_cfg_cc;
> >  extern const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0;
> > diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
> > index aea6d03e545a..e539bc94eff7 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
> > +++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
> > @@ -327,6 +327,7 @@ enum {
> >  #define CSR_HW_REV_TYPE_NONE		(0x00001F0)
> >  #define CSR_HW_REV_TYPE_QNJ		(0x0000360)
> >  #define CSR_HW_REV_TYPE_QNJ_B0		(0x0000364)
> > +#define CSR_HW_REV_TYPE_QUZ		(0x0000354)
> >  #define CSR_HW_REV_TYPE_HR_CDB		(0x0000340)
> >  #define CSR_HW_REV_TYPE_SO		(0x0000370)
> >  #define CSR_HW_REV_TYPE_TY		(0x0000420)
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > index 1d6f3053f233..79c1dc05f948 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > @@ -3543,6 +3543,10 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
> >  		}
> >  	} else if (cfg == &iwl_ax101_cfg_qu_hr) {
> >  		if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
> > +		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
> > +		    trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) {
> > +			trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
> > +		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
> >  		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
> >  			trans->cfg = &iwl_ax101_cfg_qu_hr;
> >  		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
> 
> Did you intend to use CSR_HW_REV_TYPE_QUZ and iwl_cfg
> iwl_ax101_cfg_quz_hr here, or am I misunderstanding something?
> 
> Must admit that I didn't actually read the code.  Just happend to look
> at this patch briefly while glancing through linux-wireless...  Sorry if
> I'just adding noise.

Sorry for the late reply! But yes, you are right, this was a merge
damage.  I'll send a patch fixing it.

Thanks a lot for the attentive eyes!

--
Cheers,
Luca.

