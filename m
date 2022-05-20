Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0652EB00
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 13:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbiETLkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348758AbiETLjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 07:39:40 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACFF1611C9
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653046770; x=1684582770;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Pv2nxfGb1bx8vNAqXjWYsb+UiPolOxyiBUFCykpom9A=;
  b=w0tRoYQJSDm5FIlAowGBDhvdoeIypaFi6wQaApk7GWHz44TLNN429ooB
   J8FNxNdO01IJ7QZExqVL/8VDpcHcEc2aeV3vye7uuHIyyFyWHvUTl2VdZ
   TieLh3RcgVrVLKsTmydOUcJBRQDmEd/9e2bhImKcFLt+xvXR+54ipRRWG
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 04:39:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 04:39:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 04:39:30 -0700
Received: from [10.253.36.213] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 04:39:27 -0700
Message-ID: <079a7e10-6304-a0bd-2feb-dd9512978738@quicinc.com>
Date:   Fri, 20 May 2022 19:39:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] mac80211: add support for 6 GHz channels and regulatory
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        <linux-wireless@vger.kernel.org>
References: <1638775571-24366-1-git-send-email-quic_adisi@quicinc.com>
 <a86cae34b3b60ab60bc8c456812e7a115f192e56.camel@sipsolutions.net>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <a86cae34b3b60ab60bc8c456812e7a115f192e56.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2022 4:02 PM, Johannes Berg wrote:
> Hi,
>
> On Mon, 2021-12-06 at 12:56 +0530, Aditya Kumar Singh wrote:
>
...
> I think you and Wen should go work together and figure out the story as
> you think it should be - I don't have a lot of opinion on it, and thus
> I'm not sure it's reasonable to ask me to figure out all the different
> things.
>
> Please work together and come up with a coherent story of how to handle
> this, hopefully including multi-interface scenarios and maybe regulatory
> database, internal data structures, etc.
>
> johannes

Yes, I plan to give the "cfg80211: save power spectral density(psd) of 
regulatory rule" to Aditya,

and put them together as a patch set and like this:

[PATCH 1/2] cfg80211: save power spectral density(psd) of regulatory rule
[PATCH 2/2] mac80211: add support for 6 GHz channels and regulatory

