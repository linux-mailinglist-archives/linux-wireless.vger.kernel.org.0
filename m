Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8986251A592
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353498AbiEDQeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiEDQeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 12:34:13 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663164666B
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651681837; x=1683217837;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/qBtQZWMA2L7faezufYuvu02cZEmCyrdBXZuae/DfDw=;
  b=XBlSO8YH7oLMbm/UXUco1n3hSNePwV/kkiFRdjPTlKkutzOrLPpU1BR9
   IkPMtz6szlGPuYX3nGC5uK4+2Jo5L3J/Vi8nKSAasVCA5Chpg9vl88lbh
   QKi4il9aNY9W9WxEXvil09SBzOje1U8SN8bNN1dE3nqZrYsZ+Z5fxceeK
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 09:30:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 09:30:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 09:30:36 -0700
Received: from [10.110.89.220] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 4 May 2022
 09:30:36 -0700
Message-ID: <1615688c-fb7d-261a-7b01-fe47c74b9597@quicinc.com>
Date:   Wed, 4 May 2022 09:30:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] ath11k: mac: fix too long line
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220503060415.24499-1-kvalo@kernel.org>
 <f2f27831-03eb-3788-5855-649c0f33c785@quicinc.com>
 <87y1zhalfy.fsf@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87y1zhalfy.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/3/2022 10:58 PM, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
pe>> is there a reason to not declare deflink here?
>> then its scope of definition would equal the scope of usage
> 
> In ath10k and ath11k I have tried to avoid that and instead declare all
> variables in the beginning of the function, this is to keep the code
> simple. Of course there are few cases where a variable is declared in
> the middle of the function, but that's just sloppy review on my part. I
> feel that it's better to refactor the function into smaller functions
> than start declaring variables in the middle of functions. Does that
> make sense?
> 

This is really an academic question.

In the larger kernel community I'm seeing a push to reduce the scope of 
identifiers in some cases:
1) declaring loop control variables within the actual loop control operation
2) prohibiting the access to list iterators outside the list iteration loop

 From a software engineering perspective limiting scope can prevent some 
coding errors by preventing new code from being introduced which tries 
to access an identifier which has not been initialized.

To that end, I fully support the guidance to refactor into small 
functions where variable scope is not an issue.

Also consistency is extremely important, so I totally embrace having a 
consistent approach.

/jeff
