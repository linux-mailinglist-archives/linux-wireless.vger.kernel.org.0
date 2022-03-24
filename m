Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D84E671E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Mar 2022 17:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiCXQhH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351726AbiCXQhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 12:37:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2B939AE
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648139729; x=1679675729;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2J4PgJ1a5/7ztFT+xARxoHKZycXYJXqDU7KaePGH8Ug=;
  b=BkBGlnXBFvIGXP2lmkYQDzKjC5FMPGXPdqiWO+MhKlVJMXJAUCyQukAB
   wlvjVXMqUYSfi2quCv5cOyFo6TnH6rLzr4HiO1fMDrdWzIUXjnGT+0WnA
   oalZGGRJRdLha2VvDdBDf8PEBg3TkzWusFkKOxXGedkqBIVHztyN6ezRK
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Mar 2022 09:35:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 09:35:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 09:35:29 -0700
Received: from [10.111.183.2] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 09:35:28 -0700
Message-ID: <224a3fb3-df3f-7da3-8130-416a80f116f3@quicinc.com>
Date:   Thu, 24 Mar 2022 09:35:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/4] cfg80211: validate RU puncturing bitmap
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220323191640.31230-1-quic_alokad@quicinc.com>
 <20220323191640.31230-2-quic_alokad@quicinc.com>
 <1b1976bd936be8530cac9a55726382450f691e3f.camel@sipsolutions.net>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <1b1976bd936be8530cac9a55726382450f691e3f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
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

On 3/24/2022 3:37 AM, Johannes Berg wrote:
> 
> (and also, you included all kinds of random other things in these
> patches, specifically in nl80211.h, so there's no way I can apply them
> as is anyway)
> 

I had added the other nl80211 parts to match local user-space
nl80211 order during testing, forgot to take it out.

Let's discuss once your client side version is sent out.

Thanks.
