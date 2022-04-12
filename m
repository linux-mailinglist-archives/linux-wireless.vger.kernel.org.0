Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2374FE953
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiDLULi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 16:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiDLULK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 16:11:10 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0F8BF71
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649793939; x=1681329939;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=u5erdwa+38LR1RUr9kyFdjiU/EvYeKIRW1N8qsw7oeY=;
  b=hq61g4w+jVA5FsQYGfUPZqqJcffdgYTYsdB8suxAzEOpyDZUdpONTYeM
   VIJV1u2JPHF/110F3SrNpZJZSbb1BU7Ioh8nDRKKrjzHoUODqsod7mK4b
   CcUB1f9oTaLAg7dh66gc7gnMDAmx1rYB2AOvzP7ELJaoZYJDjfGWH4Usu
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Apr 2022 13:03:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 13:03:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 13:03:07 -0700
Received: from [10.110.51.171] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 13:03:07 -0700
Message-ID: <031931ec-e14b-2b36-2f9c-73b4b9a2e462@quicinc.com>
Date:   Tue, 12 Apr 2022 13:03:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: What's required for WiFi 6 Certified Location service?
Content-Language: en-US
To:     Philip Prindeville <philipp_subx@redfish-solutions.com>,
        <linux-wireless@vger.kernel.org>
References: <D6C016DA-086E-4CB1-80DA-A40839B714AE@redfish-solutions.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <D6C016DA-086E-4CB1-80DA-A40839B714AE@redfish-solutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/12/2022 12:40 PM, Philip Prindeville wrote:
> Is anyone in the Linux kernel community working on an FTM implementation?

Start by looking at the usage of struct cfg80211_pmsr_request_peer and 
you'll find an in-tree Intel implementation.

Also I expect that every Android vendor has an out-of-tree implementation.
