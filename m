Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD974E46D0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 20:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiCVTjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiCVThw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 15:37:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C278A339
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 12:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C884B81D12
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 19:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C3C340EC;
        Tue, 22 Mar 2022 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647977782;
        bh=UhFppCXtAzXQVadyNVtg7U6obhEZAUcuQufsLBLC/3s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T53CgwmPSQ+DapVtILqCGntKyaXveIJJNV+c1VuAND1Rn8LOyvFFhb56fpOF/jUqD
         w+fzRHPaP9klBKLwMrJITdE8EaM3fSBKC6VBaJWMjCtvTij+r37YGSZ1tUrVUPHG/1
         T2kkTG6kZNdfd/65YjgNiyGvq9jNwQHtAsgLx1IxOzqDYv/1ETJE+58BiPuR6LLx0Q
         g4s79qBxJrqCu3nxPApqBn/BTOMtLbVOvgI5DXAY0tWVio6Nc9WuuzaFaC88wSbKb8
         dMdQ+YTEh74ZsNpkYxxRsw+OSmY9ttP99jl88xBGCpo3yym7yBSnCOaVtJUkt9GHjK
         KnkXOs5jzV/bw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     johannes@sipsolutions.net, socketcan@hartkopp.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: mvm: Don't fail if PPAG isn't supported
References: <iwlwifi.20220322173828.fa47f369b717.I6a9c65149c2c3c11337f3a802dff22f514a3a436@changeid>
        <3166a024cd5bef43bf192418e95d3c75409a861f.camel@coelho.fi>
Date:   Tue, 22 Mar 2022 21:36:16 +0200
In-Reply-To: <3166a024cd5bef43bf192418e95d3c75409a861f.camel@coelho.fi> (Luca
        Coelho's message of "Tue, 22 Mar 2022 17:43:31 +0200")
Message-ID: <87a6dhwzin.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> On Tue, 2022-03-22 at 17:39 +0200, Luca Coelho wrote:
>> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>> 
>> When we're copying the PPAG table into the cmd structure we're failing
>> if the table doesn't exist in ACPI or is invalid, or if the FW doesn't
>> support PPAG setting etc.
>> 
>> This is wrong because those are valid scenarios.  Fix this by not
>> failing in those cases.
>> 
>> Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>>  drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
>> index 4632d3ad1a2b..e842816134f1 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
>> @@ -1015,8 +1015,9 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
>>  	int ret, cmd_size;
>>  
>>  	ret = iwl_read_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
>> +	/* Not supporting PPAG table is a valid scenario */
>>  	if(ret < 0)
>> -		return ret;
>> +		return 0;
>>  
>>  	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
>>  	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
>
> Hi,
>
> Jakub, this is the fix for the PPAG regression that we talked about
> earlier.  If it's fine with Kalle, you can apply it directly to net-
> next to expedite it.

You didn't CC netdev though so it's not visible on their patchwork.

> Kalle can you ack?

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
