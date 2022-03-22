Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6931A4E484B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 22:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbiCVVcx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiCVVct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 17:32:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E635C351
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647984681; x=1679520681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ULo5CplepATrxROPecP3oeLTxp5zxCn9YqvRuZUbyZk=;
  b=JuuVgoBiRKD1aYhG3z8TA6hBLMKCCRn8UuTm2XvioVN3FEWlsspP0tUE
   Z8EdoH+TZhu3S7fxqq6X+ZITconiMQyqEbTgTaPv4ZlQXzopX7LPoExZF
   XHlCLBW4lgq9Ax9GRXks6FmHSoWtuN1R3KznBTzfDsFR7cJLlIhAhhC76
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 14:31:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:31:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 14:31:20 -0700
Received: from [10.110.23.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 22 Mar
 2022 14:31:19 -0700
Message-ID: <5d5cf050-7de0-7bad-2407-276970222635@quicinc.com>
Date:   Tue, 22 Mar 2022 14:31:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [BUG] deadlock in nl80211_vendor_cmd
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <willmcvicker@google.com>, <linux-wireless@vger.kernel.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <0000000000009e9b7105da6d1779@google.com>
 <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <99eda6d1dad3ff49435b74e539488091642b10a8.camel@sipsolutions.net>
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

On 3/21/2022 1:07 PM, Johannes Berg wrote:
[..snip..]

>> I'm not an networking expert. So my main question is if I'm allowed to take
>> the RTNL lock inside the nl80211_vendor_cmd callbacks?
> 
> Evidently, you're not. It's interesting though, it used to be that we
> called these with the RTNL held, now we don't, and the driver you're
> using somehow "got fixed" to take it, but whoever fixed it didn't take
> into account that this is not possible?

On this point I just want to remind that prior to the locking change 
that a driver would specify on a per-vendor command basis whether or not 
it wanted the rtnl_lock to be held via NL80211_FLAG_NEED_RTNL. I'm 
guessing for the command in question the driver did not set this flag 
since the driver wanted to explicitly take the lock itself, otherwise it 
would have deadlocked on itself with the 5.10 kernel.

/jeff
