Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0866C3277
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCUNUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCUNUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 09:20:22 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABC71BE9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 06:20:16 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 34DC0280072;
        Tue, 21 Mar 2023 13:20:15 +0000 (UTC)
Received: from [172.20.5.3] (unknown [67.201.77.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4C69D13C2B0;
        Tue, 21 Mar 2023 06:20:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4C69D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1679404814;
        bh=bdgUfXrt48DVpfv0j6N7E6QaZ4LVFlm2gKmy8MCK9j0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hgrWph/Hmx+El+e6oE//5mXcQ+fW6Ht5YU4ybGbvf190OSmeb7V0jJ9ONAOo1I0re
         IMXYylMOhys3uBUT1gXbmzQeEEEKn4cFaFI1oLUf2vIybawxNHaPu9pYT1loqOEHSt
         bBDoqC4sCodPVeUgrlgptj9D55Sp9XsSg6K8Zwt4=
Message-ID: <8f3fce81-dae7-9850-87ac-ed2b869c9dfd@candelatech.com>
Date:   Tue, 21 Mar 2023 06:20:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Content-Language: en-MW
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230308175832.2394061-1-greearb@candelatech.com>
 <ZBl/vVj3wiaZl+du@lore-desk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ZBl/vVj3wiaZl+du@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1679404815-MraHORHsAJ3V
X-MDID-O: us5;ut7;1679404815;MraHORHsAJ3V;<greearb@candelatech.com>;0161bc757c83381a5b931166ef547186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/21/23 02:58, Lorenzo Bianconi wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Stop referencing 'features' memory after release_firmware is called.
>>
>> Fixes this crash:
>>
>> RIP: 0010:mt7921_check_offload_capability+0x17d
>> mt7921_pci_probe+0xca/0x4b0
>> ...
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7921/init.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> index 38d6563cb12f..d2bb8d02ce0a 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> @@ -165,12 +165,12 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
>>   
>>   u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
>>   {
>> -	struct mt7921_fw_features *features = NULL;
>>   	const struct mt76_connac2_fw_trailer *hdr;
>>   	struct mt7921_realease_info *rel_info;
>>   	const struct firmware *fw;
>>   	int ret, i, offset = 0;
>>   	const u8 *data, *end;
>> +	u8 offload_caps = 0;
>>   
>>   	ret = request_firmware(&fw, fw_wm, dev);
>>   	if (ret)
>> @@ -197,12 +197,19 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
>>   	data += sizeof(*rel_info);
>>   	end = data + le16_to_cpu(rel_info->len);
>>   
>> +	/* TODO:  This needs better sanity checking I think.
>> +	 * Likely a corrupted firmware with bad rel_info->len, for instance,
>> +	 * would blow this up.
>> +	 */
> 
> can you please repost dropping this comment?

Why?  Looks to me like this portion of mtk driver logic assumes firmware is
never corrupted on accident or on purpose.  It should be fixed at some point.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
