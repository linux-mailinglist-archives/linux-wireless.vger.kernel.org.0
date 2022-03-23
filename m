Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1A4E4EB8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 09:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiCWIyb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 04:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiCWIy3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 04:54:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59825E9E
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648025579; x=1679561579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sDeRRsmRpuViwjigGYPiNv2eAp0jI1SP6C9suZ9+Qik=;
  b=oYLv9eoyoY3k2Q+6JWH8OgMWqHGvfUoqZH5kpcC3JOjSJ9RdzAXyXk++
   nAZ6KT6vReURMlO/jfCcelwlJa7sx4up5fk9iex28ZyIRFQvWeAT3T2HL
   utwr96/rLj8NSidJs4JSBeRTVx8qjF1h+2T0ViwjIi5Opo5cw7b2H4bcm
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Mar 2022 01:52:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:52:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 01:52:47 -0700
Received: from [10.253.72.173] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 01:52:46 -0700
Message-ID: <1c4230e0-f01e-0db1-af95-65aa2d3ac508@quicinc.com>
Date:   Wed, 23 Mar 2022 16:52:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] ath11k: add read variant from SMBIOS for download
 board data
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
 <20220315104721.26649-3-quic_wgong@quicinc.com> <87r16tkqbx.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87r16tkqbx.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 3/23/2022 4:47 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> This is to read variant from SMBIOS such as read from DT, the variant
>> string will be used to one part of string which used to search board
>> data from board-2.bin.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> [...]
>
>> +struct ath11k_smbios_bdf {
>> +	struct dmi_header hdr;
>> +	u32 padding;
>> +	u8 bdf_enabled;
>> +	u8 bdf_ext[1];
>> +};
> I was about to commit this but noticed bdf_ext[1], is there a reason for
> that? Use of [1] in arrays is deprecated nowadays:

Kalle,

no reason for it, please change bdf_ext[1] to bdf_ext[0] or bdf_ext[]. 
It will also work well.

thanks.

>
> https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
>
