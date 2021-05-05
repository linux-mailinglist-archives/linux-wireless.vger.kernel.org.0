Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B24B373DC6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhEEOie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:38:34 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:50960 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233134AbhEEOid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1620225456; x=1651761456;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=r1ksVxU1MUF9GVcZZQBHhXDXhP3gNmg/6hz59OO9qzM=;
  b=t2Jy8YY2Eo8Xz0GEIqaITEbFuVtI0mgyhbyeAXM5VDhxBlFm2jaDE98d
   0dcWGM1lFRbzgR9SfgfkaohEJZI3i8aoINKwzM3nDdXE89dADHD7AjVSh
   r9Kpnt9eIF7k4fvqSkHcu/iwgf6yyXM2pE8XRhR8D6fXnlssSpnao4p+p
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 May 2021 07:37:33 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 May 2021 07:37:33 -0700
Received: from [10.226.59.216] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 May 2021
 07:37:32 -0700
Subject: Re: [PATCH v2 3/6] bus: mhi: Add MMIO region length to controller
 structure
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <hemantk@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <loic.poulain@linaro.org>,
        <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>,
        <ath11k@lists.infradead.org>
References: <1620171478-35679-1-git-send-email-bbhatt@codeaurora.org>
 <1620171478-35679-4-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
Message-ID: <ee188cdb-3edf-816a-c0b2-88a14fd037f3@quicinc.com>
Date:   Wed, 5 May 2021 08:37:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1620171478-35679-4-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/2021 5:37 PM, Bhaumik Bhatt wrote:
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
> index 944aa3a..f6901db 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -293,6 +293,7 @@ struct mhi_controller_config {
>    * @mhi_dev: MHI device instance for the controller
>    * @debugfs_dentry: MHI controller debugfs directory
>    * @regs: Base address of MHI MMIO register space (required)
> + * @reg_len: Length of the MHI MMIO region (required)

I believe this should be moved so that it matches the ordering of the 
struct fields below.

With the adjustment, you can add my reviewed tag to this.

>    * @bhi: Points to base of MHI BHI register space
>    * @bhie: Points to base of MHI BHIe register space
>    * @wake_db: MHI WAKE doorbell register address
> @@ -386,6 +387,7 @@ struct mhi_controller {
>   	size_t rddm_size;
>   	size_t sbl_size;
>   	size_t seg_len;
> +	size_t reg_len;
>   	struct image_info *fbc_image;
>   	struct image_info *rddm_image;
>   	struct mhi_chan *mhi_chan;
> 

