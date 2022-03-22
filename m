Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5EA4E434A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 16:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiCVPpL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiCVPpJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 11:45:09 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ABD1C911
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 08:43:41 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nWgfU-000d8O-8Q;
        Tue, 22 Mar 2022 17:43:34 +0200
Message-ID: <3166a024cd5bef43bf192418e95d3c75409a861f.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, socketcan@hartkopp.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org
Date:   Tue, 22 Mar 2022 17:43:31 +0200
In-Reply-To: <iwlwifi.20220322173828.fa47f369b717.I6a9c65149c2c3c11337f3a802dff22f514a3a436@changeid>
References: <iwlwifi.20220322173828.fa47f369b717.I6a9c65149c2c3c11337f3a802dff22f514a3a436@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.3-1+b1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] iwlwifi: mvm: Don't fail if PPAG isn't supported
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-03-22 at 17:39 +0200, Luca Coelho wrote:
> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> 
> When we're copying the PPAG table into the cmd structure we're failing
> if the table doesn't exist in ACPI or is invalid, or if the FW doesn't
> support PPAG setting etc.
> 
> This is wrong because those are valid scenarios.  Fix this by not
> failing in those cases.
> 
> Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> index 4632d3ad1a2b..e842816134f1 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
> @@ -1015,8 +1015,9 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
>  	int ret, cmd_size;
>  
>  	ret = iwl_read_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
> +	/* Not supporting PPAG table is a valid scenario */
>  	if(ret < 0)
> -		return ret;
> +		return 0;
>  
>  	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
>  	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,

Hi,

Jakub, this is the fix for the PPAG regression that we talked about
earlier.  If it's fine with Kalle, you can apply it directly to net-
next to expedite it.

Kalle can you ack?

Thanks!

--
Cheers,
Luca.
