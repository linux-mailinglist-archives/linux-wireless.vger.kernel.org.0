Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71785ED3E1
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 06:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiI1E0Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiI1E0X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 00:26:23 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252110E5EC
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 21:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664339182; x=1695875182;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GapK3jCYzSTns9wyR6nd44f+6U1hYYtoHrt43eJR7PM=;
  b=PJSiXXb9gHmqsF31+u50B8wMVFh43+BlHzX7EzU5vPnQS8aMHIrk2fXO
   RH4hxbikBbkztQp3Xwgyap0TU5b7yWD8nztTga1RVPgbSCRsP5cek/cc1
   +y5MIzgQM/qTbnta/jCL+/x25aVMr8cRoSNvEuiR5rn40UMAE0KrPf22r
   g=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="143095346"
X-IronPort-AV: E=Sophos;i="5.93,351,1654552800"; 
   d="scan'208";a="143095346"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 06:26:19 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 28 Sep 2022 06:26:18 +0200 (CEST)
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 06:26:18 +0200
Received: from [10.234.36.216] (10.234.36.216) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 06:26:16 +0200
Message-ID: <fad7c4ab-fff2-0bc8-52fe-ab33468f82eb@infineon.com>
Date:   Wed, 28 Sep 2022 12:26:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/3] brcmfmac: Support DPP feature
Content-Language: en-US
To:     Franky Lin <franky.lin@broadcom.com>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <hante.meuleman@broadcom.com>,
        <kvalo@kernel.org>, <Double.Lo@infineon.com>
References: <20220921015951.16178-1-ian.lin@infineon.com>
 <20220921015951.16178-2-ian.lin@infineon.com>
 <CA+8PC_fN+bqfpmQapYqJMyO3kouS9-u_Dwvo_FH8nGhhDP5V5A@mail.gmail.com>
 <0b102940-0175-7b66-d3c7-822e41ffa1e8@infineon.com>
 <CA+8PC_dcK1TkJXcBzunJpjSKds5=iA3mVNxgC3fC_i6opzQDPw@mail.gmail.com>
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>
In-Reply-To: <CA+8PC_dcK1TkJXcBzunJpjSKds5=iA3mVNxgC3fC_i6opzQDPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.234.36.216]
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE835.infineon.com (172.23.7.107)
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/24/2022 12:36 AM, Franky Lin wrote:
>
>>>>    };
>>>>
>>>>    s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced);
>>>> @@ -170,7 +171,8 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
>>>>                                           void *data);
>>>>    bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>>>>                                    struct net_device *ndev,
>>>> -                                struct brcmf_fil_af_params_le *af_params);
>>>> +                                struct brcmf_fil_af_params_le *af_params,
>>>> +                                struct brcmf_cfg80211_vif *vif);
>>>>    bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
>>>>                                              struct brcmf_bss_info_le *bi);
>>>>    s32 brcmf_p2p_notify_rx_mgmt_p2p_probereq(struct brcmf_if *ifp,
>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
>>>> index 7552bdb91991..3a9cad3730b8 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
>>>> @@ -233,6 +233,11 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
>>>>
>>>>    #define WPA3_AUTH_SAE_PSK      0x40000 /* SAE with 4-way handshake */
>>>>
>>>> +#define WFA_AUTH_DPP           0x200000 /* WFA DPP AUTH */
>>> This is incompatible with Broadcom's bit definitions. Please use a per
>>> vendor approach.
>> We had extended the bit definition.
>> The authentication mode will be set to our FW so it's FW-dependent.
>> Do you suggest I change the name? like CY_WFA_AUTH_DPP?
> Being firmware dependent is exactly the problem here. The user
> functions of this macro are in common code path so this bit could go
> to firmware from any vendor. A mechanism should be in place to only
> set this bit when the driver is working with a infineon/cypress
> firmware.
>
> Regards,
> - Franky
>

Currently we don't have such mechanism.
Please abandon this review series.
Thank you.




