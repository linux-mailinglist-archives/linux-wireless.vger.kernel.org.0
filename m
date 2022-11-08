Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C766218A6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 16:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiKHPnk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 10:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiKHPnj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 10:43:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01DC1C0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AB238CE1BCD
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 15:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21077C433D6;
        Tue,  8 Nov 2022 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922213;
        bh=lf76joayZHy975MeL79OQav4d1JzUMNm/feIr0Fw8K8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=pTNwuTkNEyRjWxqmKl5jQ7Mj/DFAAoFKbyLMVV71m/zmG0iBjliCbYvwenVvhcBOX
         o5yEa9Zucic1J9+X2nMiX/NbW+4qvEXNtd4knBsg1u+vatuTal4Cxu4GojH1K4FT2l
         FOwddKo1Zlonk3HmdNyQLvo+g294BU74+Ah4eH7g4pGTdmF59vqqSbsxzs4r163XFn
         aYfbz0oT8Bp5DD6VRgoqb41dCfLy/xhAxFQFqOLd+aeX7zC84cB5yWSbDAwBNv9oya
         kXLw3LSV5Ct7dVLFuLjLsmCvmjUXynFXQ7N6dsiu+Z0Hz4ft+M+fNMbBsOJwt1WkLf
         4PN1haYYhzj1A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 47/50] wifi: ath12k: add wmi.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-48-kvalo@kernel.org>
        <5460619d-38e3-9960-5bc7-63854bd01b46@quicinc.com>
Date:   Tue, 08 Nov 2022 17:43:27 +0200
In-Reply-To: <5460619d-38e3-9960-5bc7-63854bd01b46@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 18:11:52 -0700")
Message-ID: <87h6z9cuzk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:10 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/wmi.h | 4796 +++++++++++++++++++++++++++++++++
>>   1 file changed, 4796 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h
>> b/drivers/net/wireless/ath/ath12k/wmi.h
> [...]
>> +/* defines to set Packet extension values whic can be 0 us, 8 usec or 16 usec */
>
> s/whic/which/

Fixed.

>> +enum {
>
> naming the enum allows you to reference the enum in code and comments
>
>> +	WMI_HOST_WLAN_2G_CAP	= 0x1,
>> +	WMI_HOST_WLAN_5G_CAP	= 0x2,
>> +	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
>> +};

Renamed to enum WMI_HOST_WLAN_BAND.

>> +#define WMI_CMD_UNSUPPORTED 0
>
> why not just add this to enum wmi_tlv_cmd_id?

Added.

>> +#define WMI_PEER_MIMO_PS_STATE                          0x1
>> +#define WMI_PEER_AMPDU                                  0x2
>> +#define WMI_PEER_AUTHORIZE                              0x3
>> +#define WMI_PEER_CHWIDTH                                0x4
>> +#define WMI_PEER_NSS                                    0x5
>> +#define WMI_PEER_USE_4ADDR                              0x6
>> +#define WMI_PEER_MEMBERSHIP                             0x7
>> +#define WMI_PEER_USERPOS                                0x8
>> +#define WMI_PEER_CRIT_PROTO_HINT_ENABLED                0x9
>> +#define WMI_PEER_TX_FAIL_CNT_THR                        0xA
>> +#define WMI_PEER_SET_HW_RETRY_CTS2S                     0xB
>> +#define WMI_PEER_IBSS_ATIM_WINDOW_LENGTH                0xC
>> +#define WMI_PEER_PHYMODE                                0xD
>> +#define WMI_PEER_USE_FIXED_PWR                          0xE
>> +#define WMI_PEER_PARAM_FIXED_RATE                       0xF
>> +#define WMI_PEER_SET_MU_WHITELIST                       0x10
>> +#define WMI_PEER_SET_MAX_TX_RATE                        0x11
>> +#define WMI_PEER_SET_MIN_TX_RATE                        0x12
>> +#define WMI_PEER_SET_DEFAULT_ROUTING                    0x13
>
> perhaps create an enum for these?

Added enum wmi_peer_param.

>> +#define WMI_VDEV_SLOT_TIME_LONG         0x1
>> +#define WMI_VDEV_SLOT_TIME_SHORT        0x2
>
> another enum?

enum wmi_slot_time

>> +#define WMI_VDEV_PREAMBLE_LONG          0x1
>> +#define WMI_VDEV_PREAMBLE_SHORT         0x2
>
> another enum?

enum wmi_preamble

>> +/* Regaulatory Rule Flags Passed by FW */
>
> s/Regaulatory/Regulatory/

Fixed.

>> +#define WMI_KEY_PAIRWISE 0x00
>> +#define WMI_KEY_GROUP    0x01
>
> create an enum?

enum wmi_key_type

>> +#define WMI_CIPHER_NONE     0x0 /* clear key */
>> +#define WMI_CIPHER_WEP      0x1
>> +#define WMI_CIPHER_TKIP     0x2
>> +#define WMI_CIPHER_AES_OCB  0x3
>> +#define WMI_CIPHER_AES_CCM  0x4
>> +#define WMI_CIPHER_WAPI     0x5
>> +#define WMI_CIPHER_CKIP     0x6
>> +#define WMI_CIPHER_AES_CMAC 0x7
>> +#define WMI_CIPHER_ANY      0x8
>> +#define WMI_CIPHER_AES_GCM  0x9
>> +#define WMI_CIPHER_AES_GMAC 0xa
>
> create an enum?

enum wmi_cipher_type

Jeff, thank you so much for all the review comments. Very much
appreciated!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
