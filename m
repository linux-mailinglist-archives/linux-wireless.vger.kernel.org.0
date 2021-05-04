Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD958372EEA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 May 2021 19:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhEDR3X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 May 2021 13:29:23 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19997 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230256AbhEDR3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 May 2021 13:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1620149308; x=1651685308;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZOH1Z1q0t1yZorMN1W7GVEBt1fJx4vC20/fEaSi4LHE=;
  b=PwFtGkUjeUdC2zn8240l8boDhT01TML4ZGuZoD35LuZxo281UbbTZyTj
   EPXnK/Bg4InYS8xZJ62JZ/hKkKV4Ph3rY0FvSZz4XYyg7FOKR5c2BDWnq
   5kp5k7IDM0JwGS6FqBQAiMPjc67n1THdGfJwrf/bnqW9eNLeB+4hhvNcM
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2021 10:28:28 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 May 2021 10:28:27 -0700
Received: from [10.226.59.216] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May 2021
 10:28:27 -0700
Subject: Re: [PATCH v1 3/6] bus: mhi: Add MMIO region length to controller
 structure
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <loic.poulain@linaro.org>,
        <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>,
        <ath11k@lists.infradead.org>
References: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
 <1618598825-18629-4-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Message-ID: <83589a09-e1a0-4611-a844-0ea52ca036b9@quicinc.com>
Date:   Tue, 4 May 2021 11:28:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618598825-18629-4-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03d.na.qualcomm.com (10.85.0.91) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/16/2021 12:47 PM, Bhaumik Bhatt wrote:
> Make controller driver specify the MMIO register region length
> for range checking of BHI or BHIe space. This can help validate
> that offsets are in acceptable memory region or not and avoid any
> boot-up issues due to BHI or BHIe memory accesses.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>   include/linux/mhi.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 944aa3a..ad53b24 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -293,6 +293,7 @@ struct mhi_controller_config {
>    * @mhi_dev: MHI device instance for the controller
>    * @debugfs_dentry: MHI controller debugfs directory
>    * @regs: Base address of MHI MMIO register space (required)
> + * @reg_len: Length of the MHI MMIO region (required)
>    * @bhi: Points to base of MHI BHI register space
>    * @bhie: Points to base of MHI BHIe register space
>    * @wake_db: MHI WAKE doorbell register address
> @@ -375,6 +376,7 @@ struct mhi_controller {
>   	struct mhi_device *mhi_dev;
>   	struct dentry *debugfs_dentry;
>   	void __iomem *regs;
> +	size_t reg_len;

Didn't Mani make sure this struct was packed using pahole when things 
were first upstreamed?  Feels like sticking this in the middle of a 
bunch of void * entries will add some padding.  Am I wrong?

>   	void __iomem *bhi;
>   	void __iomem *bhie;
>   	void __iomem *wake_db;
> 

