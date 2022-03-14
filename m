Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92CA4D7FF2
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 11:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbiCNKgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 06:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiCNKgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 06:36:49 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331381A388
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647254140; x=1678790140;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yrAhA7rZrfkRkH2MZvw5SyfcOkFW8WQs/9q3Un5jU44=;
  b=W5KynayTJ+Sje/hdK11AMzL9FJ+ZnsmViYPfMhnZtPCZcWAkXxqmoHtt
   tsnIuoqwRgLHqyhhN4YIoWiMjSeInd0w0DhPDf7IwbMDyaiBvRHpaUwTn
   X3fDl+cwW/IlQ1+LwjwJAoJjf2H3R4xhBnaevQOJXvDiGD6r4ecNzkUl9
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Mar 2022 03:35:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:35:39 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 03:35:39 -0700
Received: from [10.253.10.5] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 14 Mar
 2022 03:35:37 -0700
Message-ID: <b545dace-7dd2-3d40-0171-a85f90e606b9@quicinc.com>
Date:   Mon, 14 Mar 2022 18:35:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/2] ath11k: add fallback board name without variant
 while searching board-2.bin
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211220064829.17557-1-quic_wgong@quicinc.com>
 <20211220064829.17557-2-quic_wgong@quicinc.com> <871qzas0dw.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <871qzas0dw.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/10/2022 4:00 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>
...
>> @@ -722,7 +734,7 @@ static int ath11k_core_fetch_board_data_api_n(struct ath11k_base *ab,
>>   
>>   out:
>>   	if (!bd->data || !bd->len) {
>> -		ath11k_err(ab,
>> +		ath11k_dbg(ab, ATH11K_DBG_BOOT,
>>   			   "failed to fetch board data for %s from %s\n",
>>   			   boardname, filepath);
>>   		ret = -ENODATA;
> This error message was useful as it made easy to find out what board
> data file we are missing. An example:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=215586#c0
>
> So I'm worried it will become more difficult if the message is changed
> to a debug message. But I don't know what's a good solution either, we
> shouldn't print an error message while we are searching for the board
> file and print it only after we could not find any. One idea I have was
> to print every boardname we tried to find or just print the first
> boardname, but don't know really what's the best.
>
> But to summarise, we need to think carefully how to handle the missing
> board file case. It's very common for users that a board file is missing
> in board-2.bin so the error message should be informative enough.

Yes,

I think we can change to print the error message after we could not find 
any, I will change it in next version patch.

