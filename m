Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A645707CD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiGKP7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiGKP7T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 11:59:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2B186D9
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657555159; x=1689091159;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=73KWiQCbfAIztqE3Md2Ipz2HerlPjELzLg4N430zFLM=;
  b=mLboL0xLDDnEr/tEcI4R++p46ksvoJOutVKb0noOB1Q96Z6KmBnfu87h
   kCf9bYUFZWFsPfMKgYT3psJ6iJPrROsw4mJ9eYsVgWrtsVVDZuVmQkOTC
   +zKTTqHT0wCzWs/YXBPVA++CAnylaZz5AxZxz4VCB61ioTHzMGS/29UCP
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Jul 2022 08:59:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 08:59:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Jul 2022 08:59:17 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Jul
 2022 08:59:16 -0700
Message-ID: <0d61898f-f17a-d8e5-a35d-8da85d7c973d@quicinc.com>
Date:   Mon, 11 Jul 2022 08:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nl80211: Fix reading NL80211_ATTR_MLO_LINK_ID in
 nl80211_pre_doit
Content-Language: en-US
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1657517683-5724-1-git-send-email-quic_vjakkam@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1657517683-5724-1-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/10/2022 10:34 PM, Veerendranath Jakkam wrote:
> nl80211_pre_doit() using nla_get_u16() to read u8 attribute

I would be more explicit and say:
nl80211_pre_doit() is incorrectly using ...

> NL80211_ATTR_MLO_LINK_ID. Fix this by using nla_get_u8() to
> read NL80211_ATTR_MLO_LINK_ID attribute.
> 
> Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
> ---
>   net/wireless/nl80211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index eda2ad0..e20d0fc 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -15835,7 +15835,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>   		/* MLO -> require valid link ID */
>   		if (wdev->valid_links &&
>   		    (!link_id ||
> -		     !(wdev->valid_links & BIT(nla_get_u16(link_id))))) {
> +		     !(wdev->valid_links & BIT(nla_get_u8(link_id))))) {
>   			err = -EINVAL;
>   			goto out_unlock;
>   		}

