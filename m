Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16E542CB8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiFHKME (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiFHKLQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 06:11:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E20324F25
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654682237; x=1686218237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jcvdHr19a5MLloOAjPLrcRwU31JJoRa6/KY14ZNXZ1E=;
  b=jh3LS7NQMuFSYvbKnMY6k0qCkkVrjcg+Exj7l61fwPr1XbnSDGf164/O
   6FUXuvkJFSPhGx0KCG8p/kC5oY3cQ5JyoyZ6w7TWMV1LQ1S0Wd+rdwB69
   vc/00Qdh/m/TNPg5Tr98kTfnh9JcMqHTjpG+I9dc7G2F9Xgg6NDRHnBpc
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2022 02:57:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 02:57:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 02:57:16 -0700
Received: from [10.216.28.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 02:57:15 -0700
Message-ID: <a0a9d4db-6553-af88-aa71-4424622d1514@quicinc.com>
Date:   Wed, 8 Jun 2022 15:27:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
 <a2cc93f959394a3430755d4664d9f2abeabb3ab7.camel@sipsolutions.net>
 <e75ddf50-348b-eaf2-4033-6a32ef65a41c@quicinc.com>
 <3fa8911111ff380615ca5b3ffcd61644fae5e8ea.camel@sipsolutions.net>
 <2a8e08b3-4c93-4a29-a2ac-8f7c122e1aaa@quicinc.com>
 <f51343d5add4f25582d1ead3346435db960eaecf.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <f51343d5add4f25582d1ead3346435db960eaecf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 6/8/2022 1:41 PM, Johannes Berg wrote:
> On Wed, 2022-06-08 at 13:40 +0530, Veerendranath Jakkam wrote:
>> Now I am thinking we can simply do like this. Sorry,  somehow I made it
>> complex earlier.. :)
>>
>> +	if (cr->status == WLAN_STATUS_SUCCESS) {
>> +		for_each_valid_link(cr, link) {
>> +			if (WARN_ON_ONCE(!cr->links[link].bss))
>> +				break;
>> +		}
>>
> Huh, yeah, nice!
>
> johannes


Thanks, sent updated changes as [PATCH]

--

veeru

