Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5AA372EDE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhEDR1F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 13:27:05 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59941 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230289AbhEDR1E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 13:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1620149169; x=1651685169;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tELHJYEjlyIrHvp1LCUAoAaqANLGV9YKPvNdul3uko0=;
  b=Njz1UxDMhYsSVjlunpff3y57LyKydDi7PyUHJmmlHHRqCdQsa6qPIsmO
   ECOgD4KYm0AaIO5W4L/nUdX1EulkAnm864Y9aEho7h+XiieGX4Tfqhk69
   gpLztAscOCA8YxqtN7TYNpxg8bASUpVgFH6NO/cnLzW4JMhFOcjuIsBgy
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2021 10:26:09 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 May 2021 10:26:09 -0700
Received: from [10.226.59.216] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May 2021
 10:26:08 -0700
Subject: Re: [PATCH v1 2/6] bus: mhi: core: Set BHI and BHIe pointers to NULL
 in clean-up
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <loic.poulain@linaro.org>,
        <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>,
        <ath11k@lists.infradead.org>
References: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
 <1618598825-18629-3-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Message-ID: <55df55c8-5799-e581-1dbb-8291243bf37d@quicinc.com>
Date:   Tue, 4 May 2021 11:26:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618598825-18629-3-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03a.na.qualcomm.com (10.85.0.103) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/16/2021 12:47 PM, Bhaumik Bhatt wrote:
> Set the BHI and BHIe pointers to NULL as part of clean-up. This
> makes sure that stale pointers are not accessed after powering
> MHI down.
> 
> Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
