Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6355E7197
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 03:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIWBxu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 21:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIWBxt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 21:53:49 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 18:53:48 PDT
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C210BB16
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 18:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663898028; x=1695434028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=56P1Ub0+ik13tMcQKH15COHthy7QBLkDpcZ+w9V1b1I=;
  b=p1BWkp9VAo7t7SEgSF5lc6/N/qrni5w3WVT0gWGpEchSWmH3EMmdOIYx
   ed6lB73MbUt85LfqEX/hcx+qt7u6ot8sNYDywQzJ7kNxLvtkOtROgPUiu
   Ip9jjK1PzeLMt+8ShzfYyJNHsCHfsZaA89F8Wpsqy9MxMAtMuAj4P4fom
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="142461621"
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="142461621"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:52:43 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 23 Sep 2022 03:52:43 +0200 (CEST)
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 03:52:43 +0200
Received: from [10.234.36.68] (10.234.36.68) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 03:52:40 +0200
Message-ID: <d390462d-1cd2-fc3f-5b0c-bdcd332ed0bc@infineon.com>
Date:   Fri, 23 Sep 2022 09:52:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/5] brcmfmac: Update SSID of hidden AP while informing
 its bss to cfg80211 layer
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
References: <20220914033620.12742-1-ian.lin@infineon.com>
 <20220914033620.12742-5-ian.lin@infineon.com> <87tu506mre.fsf@kernel.org>
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>
In-Reply-To: <87tu506mre.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.234.36.68]
X-ClientProxiedBy: MUCSE822.infineon.com (172.23.29.53) To
 MUCSE835.infineon.com (172.23.7.107)
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/22/2022 12:44 PM, Kalle Valo wrote:
> Ian Lin <ian.lin@infineon.com> writes:
>
>> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>
>> cfg80211 layer on DUT STA is disconnecting ongoing connection attempt after
>> receiving association response, because cfg80211 layer does not have valid
>> AP bss information. On association response event, brcmfmac communicates
>> the AP bss information to cfg80211 layer, but SSID seem to be empty in AP
>> bss information, and cfg80211 layer prints kernel warning and then
>> disconnects the ongoing connection attempt.
>>
>> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
>> updating the SSID for hidden AP while informing its bss information
>> to cfg80211 layer.
>>
>> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@infineon.com>
> Syed's email address in From does not match with s-o-b.
>
>> @@ -3032,6 +3033,12 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>>        notify_ielen = le32_to_cpu(bi->ie_length);
>>        bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>>
>> +     ssid = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
>> +     if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
>> +             /* Update SSID for hidden AP */
>> +             memcpy((u8 *)ssid->data, bi->SSID, bi->SSID_len);
>> +     }
> memcpy() takes a void pointer so the cast is not needed.
There should be a type casting since 'ssid' is a const pointer.
As you saw there will be build warning in PATCH v2 (sorry I didn't 
notice that locally)
I will send PATCH v3 to restore type casting, is that ok?

