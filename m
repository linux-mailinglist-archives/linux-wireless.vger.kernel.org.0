Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736B045D902
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhKYLUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 06:20:40 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:40930 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240480AbhKYLSn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 06:18:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637838932; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ybWbO2btPoiyPmYyb5PkhLLFjl5iFBWusufUlbMUxwk=;
 b=E6iZe+rLGi0k5Y3SeKx1hB87xFck9FylllPbIODfCNjvL50Eb6gf5l5Mf+w2fhAzYWFYEDI6
 L6Z35MPfOYmqwybIZJPDj9b9kiFL5OhAs/XuoYQMfQSx3/uF9UiL1ngQQk5NEXH0Uf+ViJo6
 AQ7JO6+C/xMQMUGq9J/gvgWvHMM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 619f704fe7d68470aff1009a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Nov 2021 11:15:27
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65129C43618; Thu, 25 Nov 2021 11:15:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F09DCC4338F;
        Thu, 25 Nov 2021 11:15:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Nov 2021 16:45:25 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v5 2/2] ath11k: Use reserved host DDR addresses from DT
 for PCI devices
In-Reply-To: <74442923.uYUSDj6SXF@ripper>
References: <1637666940-30548-1-git-send-email-akolli@codeaurora.org>
 <1637666940-30548-2-git-send-email-akolli@codeaurora.org>
 <74442923.uYUSDj6SXF@ripper>
Message-ID: <e91487019f490b35940da8813c79cf40@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-23 18:31, Sven Eckelmann wrote:
> On Tuesday, 23 November 2021 12:29:00 CET Anilkumar Kolli wrote:
>> +                       ret = of_property_read_u32(dev->of_node, 
>> "memory-region",
>> +                                                  &hremote_phandle);
>> +                       if (ret) {
>> +                               ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +                                          "qmi fail to get hremote 
>> phandle\n");
>> +                               return ret;
>> +                       }
>> +
>> +                       hremote_node = 
>> of_find_node_by_phandle(hremote_phandle);
>> +                       if (!hremote_node) {
>> +                               ath11k_dbg(ab, ATH11K_DBG_QMI,
>> +                                          "qmi fail to get 
>> hremote_node\n");
>> +                               return ret;
>> +                       }
> 
> Afaik, this can be combined via
> 
>     hremote_node = of_parse_phandle(dev->of_node, "memory-region", 0);
> 
Yes Sven, I will update in next version.

Thanks
Anil.
