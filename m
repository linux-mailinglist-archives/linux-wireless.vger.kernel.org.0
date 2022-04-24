Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE09450D1A0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 14:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiDXMOj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDXMOg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 08:14:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E53135D
        for <linux-wireless@vger.kernel.org>; Sun, 24 Apr 2022 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650802296; x=1682338296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dMNiOiLzChr/7IMjjJyhXX+Ew+uWRVB1fgb0yHCKV3Y=;
  b=KrYC2d8ZcXr6vc1uTr6qO9ondIjB6hFmDaojyOtb6Ajo62dW5jPFia7E
   ylL3ZH2/nD0SkLkWnNskAURuuNItXTWRY2nG+hJdhzQlgcfTCQWPpFIO6
   ezSKMisRXh7pmR9D256DLMKNeMqmYkgi6pFO+McLNfA4WlMQjh/5uPVDe
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Apr 2022 05:11:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 05:11:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Apr 2022 05:11:35 -0700
Received: from [10.253.33.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 24 Apr
 2022 05:11:34 -0700
Message-ID: <a97692be-d1a6-266d-6876-3716923aceb0@quicinc.com>
Date:   Sun, 24 Apr 2022 20:11:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ath11k: add read country code from SMBIOS for
 WCN6855/QCA6390
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220421023501.32167-1-quic_wgong@quicinc.com>
 <8735i4m8hu.fsf@kernel.org>
 <61d2a5aa-c82d-6994-a8f3-0d31e32421be@quicinc.com>
 <87o80qkcau.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87o80qkcau.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/24/2022 6:26 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> On 4/23/2022 5:53 PM, Kalle Valo wrote:
>>> Wen Gong <quic_wgong@quicinc.com> writes:
>>>
>>>
>> ...
...
>> Yes, Kalle,
>>
>> I agree with you.
>>
>> need I send new version to change the "__le16 cc_code" to "u16 cc_code"?
> I fixed this in the pending branch, compile tested only. Please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a6d583e310c70fb93ec7045f0ea38c12632098d8
yes, it is OK after check.
>
