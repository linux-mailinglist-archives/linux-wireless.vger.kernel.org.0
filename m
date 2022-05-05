Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E14751BF40
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355478AbiEEMcK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiEEMcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 08:32:09 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA34E3B1
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l9mYgL4Ih0Yrkw4dha3tbuPVN2YYKfqSw+M0+XnKe/c=; b=Y6ttzwXghX0dur3EIohKOXTOcl
        Cf91TuaDvT8o+R2KUlGxL+2JpWgietScqpJ2O/A3479E8gPG5X3IVQEmaAwL391QNB2Hv1J5bf87q
        9P5ztXIHKVBL+hsNpUIoatAouqd55hfbuJjDKkC6ierJ34JpsUy4St3bUqquLw+ysqh8=;
Received: from p200300daa70ef200412f484bca3869cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:412f:484b:ca38:69cd] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmaan-0001Ds-UU; Thu, 05 May 2022 14:28:25 +0200
Message-ID: <f8502bac-9b02-ac0d-3d0c-759fbddfa1fc@nbd.name>
Date:   Thu, 5 May 2022 14:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] mt76: mt7915: limit minimum twt duration
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
 <20220505082554.16656-4-chui-hao.chiu@mediatek.com>
 <YnPBz8uB6A5kAPRs@lore-desk>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <YnPBz8uB6A5kAPRs@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 05.05.22 14:23, Lorenzo Bianconi wrote:
>> The minimum twt duration supported by mt7915 is 64 according to hardware
>> design. Reply station with TWT_SETUP_CMD_DICTATE if min_twt_dur smaller
>> than 64.
>> 
>> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> index ff60a3d2d26d..e912ecacb578 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> @@ -2633,6 +2633,7 @@ void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
>>  			      struct ieee80211_sta *sta,
>>  			      struct ieee80211_twt_setup *twt)
>>  {
>> +#define MT7915_MIN_TWT_DUR 64
> 
> nit: can you please move MT7915_MIN_TWT_DUR in mt7915.h since we have other twt
> defs there?
Fixed in my tree.

- Felix
