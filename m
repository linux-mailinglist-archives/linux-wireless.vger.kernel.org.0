Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7550D126
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbiDXK3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbiDXK3R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 06:29:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348968F95
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 03:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12B45B80E0D
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 10:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FEBC385A7;
        Sun, 24 Apr 2022 10:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650795965;
        bh=JWVZ39Sx4mRPxwSMcZ085+th6rdL6JTEmOQlC+K+Wkw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VoCmgW0EQo2ZldDwXZ6vnNtOuMMgPvibp7qzA0yPUTv5YsPtZ/rq39hZd+2gYhyKN
         1beVhQfpudjgMt7V3TB4rJCkcN+xIRuELfgFAhxuQ+E7fWFwTkT0C/hQ0juRt69+lE
         x0wSiSAq1WCtB++6zWYvJFa055zntJWBoxy3zZfh/Ze+pJnPZqG+yvvcvxFKhz9cgg
         CrdDQMzSZJb9iqJjJkiF3Gsx1qAmK2+GR9Cmjs9C7XugoDiu3ExgkmEqvVx73jsv4C
         GPJb3JkLcInMhpZgiGjxGTJmD7JwJosiuCaBocO/K+HKG9Y6mY+yzxB/XLJtxSxr46
         0Gufdnbv1F+3w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add read country code from SMBIOS for WCN6855/QCA6390
In-Reply-To: <61d2a5aa-c82d-6994-a8f3-0d31e32421be@quicinc.com> (Wen Gong's
        message of "Sun, 24 Apr 2022 14:22:56 +0800")
References: <20220421023501.32167-1-quic_wgong@quicinc.com>
        <8735i4m8hu.fsf@kernel.org>
        <61d2a5aa-c82d-6994-a8f3-0d31e32421be@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sun, 24 Apr 2022 13:26:01 +0300
Message-ID: <87o80qkcau.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 4/23/2022 5:53 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
>>
>>
> ...
>>> +
>>>   struct ath11k_smbios_bdf {
>>>   	struct dmi_header hdr;
>>> -	u32 padding;
>>> +	u8 features_disabled;
>>> +	/* enum ath11k_smbios_cc_type */
>>> +	u8 country_code_flag;
>>> +	/* To set specific country, you need to set country code
>>> +	 * flag=ATH11K_SMBIOS_CC_ISO first, then if country is United States, then country
>>> +	 * code value = 0x5553 ("US",'U' = 0x55, 'S'= 0x53), To set country
>>> +	 * to INDONESIA, then country code value = 0x4944 ("IN", 'I'=0x49, 'D'=0x44).
>>> +	 * If country code flag = ATH11K_SMBIOS_CC_WW, then you can use
>>> +	 * worldwide regulatory setting.
>>> +	 */
>>> +	__le16 cc_code;
>>>   	u8 bdf_enabled;
>>>   	u8 bdf_ext[];
>>> -};
>>> +} __packed;
>> Is cc_code really in little endian? I would expect data in smbios to be
>> in native endian (ie. u16), bios using different endian than the host
>> sounds strange to me. And struct dmi_header also uses native endian:
>>
>> struct dmi_header {
>> 	u8 type;
>> 	u8 length;
>> 	u16 handle;
>> } __packed;
>
> Yes, Kalle,
>
> I agree with you.
>
> need I send new version to change the "__le16 cc_code" to "u16 cc_code"?

I fixed this in the pending branch, compile tested only. Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a6d583e310c70fb93ec7045f0ea38c12632098d8

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
