Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75A99715C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 07:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHUFES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 01:04:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:55993 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHUFER (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 01:04:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 22:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="178395485"
Received: from pkacprow-mobl.ger.corp.intel.com ([10.252.30.96])
  by fmsmga008.fm.intel.com with ESMTP; 20 Aug 2019 22:04:15 -0700
Message-ID: <eaf2a4bee9a925b02c711bf006949ab25bd0e5fb.camel@intel.com>
Subject: Re: PROBLEM: 5.3.0-rc* causes iwlwifi failure
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Stuart Little <achirvasub@gmail.com>
Cc:     Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>
Date:   Wed, 21 Aug 2019 08:04:14 +0300
In-Reply-To: <20190820233734.GA1406@chirva-slack.chirva-slack>
References: <20190817041258.GA1641@chirva-slack.chirva-slack>
         <87y2zsf9ps.fsf@depni.sinp.msu.ru>
         <20190817214448.GB1070@chirva-slack.chirva-slack>
         <1b1e573e6502c97851838a3b27ac0b272198926c.camel@intel.com>
         <20190820233734.GA1406@chirva-slack.chirva-slack>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 19:37 -0400, Stuart Little wrote:
> On Tue, Aug 20, 2019 at 01:45:37PM +0300, Luciano Coelho wrote:
> > I'll have to look into all NIC/FW-version combinations that we have
> > and
> > update the iwl_mvm_sar_geo_support() function accordingly, which
> > is,
> > BTW, the easier place for you to change if you want to workaround
> > the
> > issue.
> 
> Thanks!
> 
> I didn't quite know how to interpret this suggestion (i.e. what the
> change should be), so I was poking around in there out of curiosity.
> One simple-minded thing that worked was to just pretend that that
> function always returns false:
> 
> --- cut here ---
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 5de54d1559dd..8c0160e5588f 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -925,7 +925,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm
> *mvm)
>                 .data = { data },
>         };
>  
> -       if (!iwl_mvm_sar_geo_support(mvm))
> +       /*if (!iwl_mvm_sar_geo_support(mvm))*/
>                 return -EOPNOTSUPP;
>  
>         ret = iwl_mvm_send_cmd(mvm, &cmd);
> @@ -953,7 +953,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm
> *mvm)
>         int ret, i, j;
>         u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP,
> GEO_TX_POWER_LIMIT);
>  
> -       if (!iwl_mvm_sar_geo_support(mvm))
> +       /*if (!iwl_mvm_sar_geo_support(mvm))*/
>                 return 0;
>  
>         ret = iwl_mvm_sar_get_wgds_table(mvm);
> 
> --- cut here ---

Yeah, I meant more or less to return false for your NIC.  You could
have just forced that function return false.

--
Cheers,
Luca.

