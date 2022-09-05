Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49E5AD861
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Sep 2022 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiIER10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Sep 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIER1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Sep 2022 13:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01C54670
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 10:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A59E61369
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 17:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECAEC433D6;
        Mon,  5 Sep 2022 17:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662398843;
        bh=fJpAOfJekN2R/5hBZo84bD//9tKTsWRdDFtRLRiqM9g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Pd34kc6GWu5jRr99i7Y6M5PaRdRSR7joIuJ08yM6veDktvVCm0phfNbZy51iE+c+b
         KfJN++OszYQJqm45UK6ECO4KhGu1rJhR3X8IBvP6qHpg8K6pdXyejlkuY87mBrG0uz
         KPsGzAdaOMefYxrfYW7m3xxfvABzkW2k32pmh/l+uO3feOofJZ5z5CW4Lzl8JMAqUs
         xl1p9PMJmGuAoklfyjKg8OjUDb2VHxr4Hg/XEfo1kGC51zjDQwN+GrS5moPCEjvbcK
         PtNREKN3ZLej7obmybSMdW80+9atGuTxnXghB4hU+szSwqS5DRnIIl03apJsKw6hHE
         gRnjjvBHxepRA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k\@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 12/50] wifi: ath12k: add dp.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-13-kvalo@kernel.org>
        <0eabd6c1b3ca4d8a8152ad5b4f3efee6@realtek.com>
Date:   Mon, 05 Sep 2022 20:27:20 +0300
In-Reply-To: <0eabd6c1b3ca4d8a8152ad5b4f3efee6@realtek.com> (Ping-Ke Shih's
        message of "Mon, 15 Aug 2022 01:56:29 +0000")
Message-ID: <87leqxag07.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Saturday, August 13, 2022 12:09 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: ath12k@lists.infradead.org
>> Subject: [PATCH 12/50] wifi: ath12k: add dp.h
>> 
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/dp.h | 2017 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 2017 insertions(+)
>> 
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.h
>> b/drivers/net/wireless/ath/ath12k/dp.h
>> new file mode 100644
>> index 000000000000..cf9610dffbb8
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/dp.h
>
> [...]
>
>> +
>> +struct htt_srng_setup_cmd {
>> +	u32 info0;
>> +	u32 ring_base_addr_lo;
>> +	u32 ring_base_addr_hi;
>> +	u32 info1;
>> +	u32 ring_head_off32_remote_addr_lo;
>> +	u32 ring_head_off32_remote_addr_hi;
>> +	u32 ring_tail_off32_remote_addr_lo;
>> +	u32 ring_tail_off32_remote_addr_hi;
>> +	u32 ring_msi_addr_lo;
>> +	u32 ring_msi_addr_hi;
>> +	u32 msi_data;
>> +	u32 intr_info;
>> +	u32 info2;
>> +} __packed;
>> +
>
> Should they be '__le32' instead of 'u32'?
>
> This struct is used to fill data of ath12k_htc_send(), and the fields of
> htc header are __le32: 
>
> struct ath12k_htc_hdr {
> 	__le32 htc_info;
> 	__le32 ctrl_info;
> } __packed __aligned(4);
>
> If above is correct, some struct(s) related to ath12k_htc_send() have
> similar problems:
> struct htt_ver_req_cmd
> struct htt_ppdu_stats_cfg_cmd
> struct htt_rx_ring_selection_cfg_cmd
> struct htt_ext_stats_cfg_cmd
> struct htt_tx_ring_selection_cfg_cmd  (miss __packed)

Good catch, we'll fix those and the missing __packed. Thanks for the review!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
