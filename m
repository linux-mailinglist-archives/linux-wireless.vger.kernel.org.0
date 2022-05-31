Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A424A53991D
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbiEaVyl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348256AbiEaVyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 17:54:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAA28D6B7
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654034076; x=1685570076;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9g4xZbawLpWQZKW41WMiZEFe2c36xDWwNHOb05AC28w=;
  b=qc6+uc3M910+veQYRDRP3YrjT7aKqg74F/Lw41uHG6cZ/uGDhc8LKn5k
   q4PhrnsE5begQjdzwLhbIRZSy6YXk+gJD6yGJcggfidkHPFvSg8JjhSja
   QyzOhshn1XvCOEK0vC7SG/cwq7D2i9YnwO9aGSPBZm8lRyGqMPpkx4XHd
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 31 May 2022 14:54:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 14:54:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 14:54:35 -0700
Received: from [10.110.67.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 14:54:35 -0700
Message-ID: <70eb7484-a524-add3-ec49-c389f3a59145@quicinc.com>
Date:   Tue, 31 May 2022 14:54:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] initial interface-related MLO work
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220520113242.129546-1-johannes@sipsolutions.net>
 <ed095171-3617-3066-e3df-8091f84078a2@quicinc.com>
 <8392dbd0cc395258dc55b2a2c5a3b863e8fbcb70.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <8392dbd0cc395258dc55b2a2c5a3b863e8fbcb70.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/31/2022 9:33 AM, Johannes Berg wrote:
> On Tue, 2022-05-31 at 09:31 -0700, Jeff Johnson wrote:
>>
>> Thanks Johannes,
>> This is a great start, and looks good to me and my team!
>>
> 
> Awesome, thanks for taking a look!
> 
> I should note that I've got WAY more stuff brewing in the MLD branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/log/?h=mld
> 
> so I guess I should send that out soon ...

Yes, please :)
