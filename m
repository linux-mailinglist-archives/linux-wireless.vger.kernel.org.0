Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A451BF3E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355067AbiEEMaS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiEEMaQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 08:30:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453A4E3B1
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bxhplObq1dgPCl9SBs+XRfgFIWsy41N7X9TE2jdN/04=; b=P3RM3x1ZYtolI635ErGpNPQW9G
        53tVRiX1GoD1wXHMHQFdJMVebi3sAlTqY8c04vxjzmFXZS8s3H5HGCWuc+CV52DO4Mxij2OZY2T+P
        MIGvRMB4s1B99xjoIy+PHC9teHB9QinK8eqKAux7cHA69s/t+4LB3ydpOJT12ZwUoWWg=;
Received: from p200300daa70ef200412f484bca3869cd.dip0.t-ipconnect.de ([2003:da:a70e:f200:412f:484b:ca38:69cd] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nmaYx-000180-1O; Thu, 05 May 2022 14:26:31 +0200
Message-ID: <95289bf7-005f-acb7-e45f-a8ea284ef160@nbd.name>
Date:   Thu, 5 May 2022 14:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] mt76: mt7915: reject duplicated twt flows
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Cc:     Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220505082554.16656-1-chui-hao.chiu@mediatek.com>
 <20220505082554.16656-3-chui-hao.chiu@mediatek.com>
 <YnPBaw1d3nA791PP@lore-desk>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <YnPBaw1d3nA791PP@lore-desk>
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


On 05.05.22 14:22, Lorenzo Bianconi wrote:
>> Reject twt flows with the same parameters to prevent some potential issues
>> causing by duplicated establishment.
>> 
>> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
>> Reviewed-by: Shayne Chen <shayne.chen@mediatek.com>
>> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
>> ---
>>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 31 +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> index 94a1871fbf43..ff60a3d2d26d 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> @@ -2601,6 +2601,34 @@ static int mt7915_mac_check_twt_req(struct ieee80211_twt_setup *twt)
>>  	return 0;
>>  }
>>  
>> +static inline bool
>> +mt7915_mac_twt_param_equal(struct mt7915_sta *msta,
>> +			   struct ieee80211_twt_params *twt_agrt)
> 
> nit: please do not use inline in .c files.
I applied the patch already, so I folded in a fix for this.

- Felix
