Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2447A289
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 23:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhLSWGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 17:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhLSWGh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 17:06:37 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E8C061574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=p5kWG5nCNbBaUPp/o9AO0JfyQ6GNjO+8i4r2fGpnHSs=; b=b7Jss7ijmlJ6cEcZXxIl2zLdrU
        rjjkG+YuKGSlxYWaXuhKW+sWH3k0Rq1YBWgaq84fCTL62jNYy3HV+n6LRdhhBDFl8faI6DaJcrwab
        EWsr+7KFT1dDt4zQDv+9IZLKuvZazdXQCGB59NLF09U13gDKl/Mhyys0k7UFBRBN4rPw=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mz4K9-0003QQ-UG; Sun, 19 Dec 2021 23:06:34 +0100
Message-ID: <9cc88e5a-95b1-e6e6-cbce-724fcb54f803@nbd.name>
Date:   Sun, 19 Dec 2021 23:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v2 2/9] mt76: connac: fix broadcast muar_idx in
 alloc_sta_req
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
References: <cover.1639935477.git.lorenzo@kernel.org>
 <fe60489b1aea76a7f3f61b2f42431ba424ceb9a1.1639935477.git.lorenzo@kernel.org>
 <82bb897f-ef61-e7d8-44ca-0bbd825953d2@nbd.name>
Content-Language: en-US
In-Reply-To: <82bb897f-ef61-e7d8-44ca-0bbd825953d2@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-12-19 21:50, Felix Fietkau wrote:
> 
> On 2021-12-19 18:40, Lorenzo Bianconi wrote:
>> Set muar_idx for broadcast wcid to 0xe in mt76_connac_mcu_alloc_sta_req
>> routine.
>> 
>> Fixes: d0e274af2f2e4 ("mt76: mt76_connac: create mcu library")
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> index 5664f119447b..b150c7f2f005 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>> @@ -271,7 +271,7 @@ mt76_connac_mcu_alloc_sta_req(struct mt76_dev *dev, struct mt76_vif *mvif,
>>   {
>>   	struct sta_req_hdr hdr = {
>>   		.bss_idx = mvif->idx,
>> -		.muar_idx = wcid ? mvif->omac_idx : 0,
>> +		.muar_idx = wcid && wcid->sta ? mvif->omac_idx : 0xe,
> I took another look at the driver code, and I think this part is wrong.
> I think it should be like this instead:
> When deleting an entry (sta or vif wcid), we should set muar_idx to 0xe
> When not deleting, it should be mvif->omac_idx if we have a vif, and 0xe
> otherwise.
After some more discussion with Lorenzo and taking a fresh look at the 
vendor code, it seems to me that the existing code in mt76_connac_mcu.c 
is fine, and 7915 can use it as-is. I will drop this patch.

- Felix


