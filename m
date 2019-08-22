Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8998B85
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 08:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfHVGon (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 02:44:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37996 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbfHVGom (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 02:44:42 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0gpo-0003BT-2q; Thu, 22 Aug 2019 09:44:39 +0300
Message-ID: <ef088cbd8b18d10ffe3e5ced20f2457430c1bd52.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Jonas Hahnfeld <hahnjo@hahnjo.de>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 22 Aug 2019 09:44:34 +0300
In-Reply-To: <8402552457c387269d3e535b5f2ef42159e17f91.camel@hahnjo.de>
References: <20190720102545.5952-1-luca@coelho.fi>
         <20190720102545.5952-17-luca@coelho.fi>
         <8402552457c387269d3e535b5f2ef42159e17f91.camel@hahnjo.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 16/16] iwlwifi: mvm: fix version check for
 GEO_TX_POWER_LIMIT support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-01 at 16:07 +0200, Jonas Hahnfeld wrote:
> Am Samstag, den 20.07.2019, 13:25 +0300 schrieb Luca Coelho:
> > From: Luca Coelho <
> > luciano.coelho@intel.com
> > 
> > We erroneously added a check for FW API version 41 before sending
> > GEO_TX_POWER_LIMIT, but this was already implemented in version 38.
> > Additionally, it was cherry-picked to older versions, namely 17, 26
> > and 29, so check for those as well.
> > 
> > Signed-off-by: Luca Coelho <
> > luciano.coelho@intel.com
> > ---
> >  drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > index a837cf40afde..00c89bcfdf6a 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> > @@ -886,9 +886,14 @@ static bool iwl_mvm_sar_geo_support(struct iwl_mvm *mvm)
> >  	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
> >  	 * firmware versions.  Unfortunately, we don't have a TLV API
> >  	 * flag to rely on, so rely on the major version which is in
> > -	 * the first byte of ucode_ver.
> > +	 * the first byte of ucode_ver.  This was implemented
> > +	 * initially on version 38 and then backported to 36, 29 and
> > +	 * 17.
> >  	 */
> > -	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 41;
> > +	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 38 ||
> > +	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 36 ||
> > +	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 29 ||
> > +	       IWL_UCODE_SERIAL(mvm->fw->ucode_ver) == 17;
> >  }
> >  
> >  int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
> 
> After pulling iwlwifi-fixes-for-kvalo-2019-07-30, I still get firmware
> crashes on my "Intel(R) Dual Band Wireless AC 8260" which uses firmware
> version 36. I tried the latest ucode in linux-firmware (36.77d01142.0),
> but it seems GEO_TX_POWER_LIMIT is not yet implemented there.
> 
> Could you let me know which firmware version I need for Linux 5.3? Can
> there be a check in iwl_mvm_sar_geo_support() that the backported
> support is indeed available?

We have some issues detecting whether the FW supports this command or
not.  There is already a bugzilla[1] for this (and a bunch of
duplicates), so let's track it there.

https://bugzilla.kernel.org/show_bug.cgi?id=204151


--
Cheers,
Luca.

