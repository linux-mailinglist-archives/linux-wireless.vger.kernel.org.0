Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD84F8647
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiDGRfO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 13:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbiDGRfN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 13:35:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B9137F64
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649352787; x=1680888787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IXVWcl0hnhxIEQ4QyqAnU5kjLopkZrcK3GhuSZDQtD8=;
  b=jeE7VPyJ6xN7dUYDQoy176reK9A1o29Ym0HwEStv5HdjCO+/62L6MQzZ
   hxvly9aOIah7fzWGRqT0JFYFCTeN/e0qaha+Zzz+a6Jj4/k9aAjBXcgy0
   wYBg7+xlc9YppabY5MtkjJYjg4y2dHbIOyT7Euj2dXV1rKkxJir2l6O5I
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Apr 2022 10:33:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 10:33:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Apr 2022 10:33:00 -0700
Received: from [10.234.232.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Apr 2022
 10:32:59 -0700
Message-ID: <50aa9416-6e7f-2793-5a8b-bdcf28f5a49e@quicinc.com>
Date:   Thu, 7 Apr 2022 10:32:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [bug report] ath11k: add debugfs for TWT debug calls
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     <john@phrozen.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20220301074905.GA13071@kili> <8735isrmvi.fsf@kernel.org>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <8735isrmvi.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/5/2022 12:49 AM, Kalle Valo wrote:
> + aloka
> 
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
>> Hello John Crispin,
>>
>> The patch fe98a6137d03: "ath11k: add debugfs for TWT debug calls"
>> from Jan 31, 2022, leads to the following Smatch static checker
>> warning:
>>
> 
> Aloka, you submitted this patch. Please take a look and fix the issues.
> 

Will send a fix. Thanks.
