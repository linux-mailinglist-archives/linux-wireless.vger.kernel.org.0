Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48788372ED6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 19:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEDRXZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 13:23:25 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32672 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhEDRXY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 13:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1620148950; x=1651684950;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ssj0HmLsFhXdKgRKpNyTTL8WYgWUKhN0JFV+gJMwx80=;
  b=A2mLppbz75bcLILmVHWirLq2CaiKR0AzwDGKIA4F95aXgFgVSNbKgH4S
   HxjBdyuM5UKeYPdV8cWKUsazQh9fwJ0pnk7x4a09FG3HCMA6RQuqPiX9L
   Z2PYhORglP/N4ePD4cEi/rdl24ChErvWH27m6VGKEIuNfJuFD9DOpRvyl
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 May 2021 10:22:29 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 May 2021 10:22:29 -0700
Received: from [10.226.59.216] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May 2021
 10:22:29 -0700
Subject: Re: [PATCH v1 1/6] bus: mhi: core: Set BHI/BHIe offsets on power up
 preparation
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <loic.poulain@linaro.org>,
        <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>,
        <ath11k@lists.infradead.org>
References: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
 <1618598825-18629-2-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Message-ID: <5f0001da-bc1a-5649-ef72-1fbadd5b44ec@quicinc.com>
Date:   Tue, 4 May 2021 11:22:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618598825-18629-2-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/16/2021 12:47 PM, Bhaumik Bhatt wrote:
> Set the BHI and/or BHIe offsets in mhi_prepare_for_power_up(),
> rearrange the function, and remove the equivalent from
> mhi_async_power_up(). This helps consolidate multiple checks
> in different parts of the driver and can help MHI fail early on
> before power up begins if the offsets are not read correctly.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

