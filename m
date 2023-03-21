Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29B6C3390
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 15:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCUOBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCUOBU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 10:01:20 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D078A6C
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 07:01:19 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3C301100082;
        Tue, 21 Mar 2023 14:01:16 +0000 (UTC)
Received: from [172.20.5.3] (unknown [67.201.77.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 99B7413C2B0;
        Tue, 21 Mar 2023 07:01:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 99B7413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1679407274;
        bh=kzvvXBoMtJjJ3IrixOpeBB4CdNA3EnYZ/1s7KV/C+aw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SMknb7i8FOm6wLt0K/RRokPhoo6bB0QlTVEqeU0VpapXyLQui2oeJAw+PfUeMPMJC
         PDdD8qN2yQx53j9dHgOC7rTEywtotd/zDTo5gClSKEYzu5R82cHguY3IVPNiBXdd7N
         UtovtFQrN5Xe5VKt0ESGs2Wjajw3QsWuOpRIlcsM=
Message-ID: <98c35dc6-580b-d877-4124-93d98f2a163c@candelatech.com>
Date:   Tue, 21 Mar 2023 07:01:13 -0700
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
 <8f3fce81-dae7-9850-87ac-ed2b869c9dfd@candelatech.com>
 <ZBmw+uTa+CiV/KKJ@lore-desk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ZBmw+uTa+CiV/KKJ@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1679407277-fkupqb7K8Mnt
X-MDID-O: us5;ut7;1679407277;fkupqb7K8Mnt;<greearb@candelatech.com>;0161bc757c83381a5b931166ef547186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/21/23 06:28, Lorenzo Bianconi wrote:
>> On 3/21/23 02:58, Lorenzo Bianconi wrote:
>>>> From: Ben Greear <greearb@candelatech.com>
>>>>
>>>> Stop referencing 'features' memory after release_firmware is called.
>>>>
>>>> Fixes this crash:
>>>>
>>>> RIP: 0010:mt7921_check_offload_capability+0x17d
>>>> mt7921_pci_probe+0xca/0x4b0
>>>> ...
>>>>
>>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>>> ---
>>>>    drivers/net/wireless/mediatek/mt76/mt7921/init.c | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>>>> index 38d6563cb12f..d2bb8d02ce0a 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>>>> @@ -165,12 +165,12 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 band)
>>>>    u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
>>>>    {
>>>> -	struct mt7921_fw_features *features = NULL;
>>>>    	const struct mt76_connac2_fw_trailer *hdr;
>>>>    	struct mt7921_realease_info *rel_info;
>>>>    	const struct firmware *fw;
>>>>    	int ret, i, offset = 0;
>>>>    	const u8 *data, *end;
>>>> +	u8 offload_caps = 0;
>>>>    	ret = request_firmware(&fw, fw_wm, dev);
>>>>    	if (ret)
>>>> @@ -197,12 +197,19 @@ u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
>>>>    	data += sizeof(*rel_info);
>>>>    	end = data + le16_to_cpu(rel_info->len);
>>>> +	/* TODO:  This needs better sanity checking I think.
>>>> +	 * Likely a corrupted firmware with bad rel_info->len, for instance,
>>>> +	 * would blow this up.
>>>> +	 */
>>>
>>> can you please repost dropping this comment?
>>
>> Why?  Looks to me like this portion of mtk driver logic assumes firmware is
>> never corrupted on accident or on purpose.  It should be fixed at some point.
> 
> even if this is a theoretical issue, this does not seem the right way to track
> it and it is not related to this patch.

There is no better way I know to track such problems, it is not like random OSS developers will
read kernel bugzilla for this sort of thing, and email bug report about it will be buried in days
and never seen again.

And it is related to crazy memory corruption bugs since a corrupted firmware could cause similar
memory corruption.  So next time someone is working on this code, maybe they will see the
comment and code it more defensively.

Anyway, if you insist, I can re-spin the patch against 6.2 and repost.  I also hear that it will not
apply to 6.3, but I'm not yet working on 6.3.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
