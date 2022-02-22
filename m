Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA6F4C0361
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 21:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiBVUxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 15:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiBVUwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 15:52:54 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A2A27B3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 12:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645563149; x=1677099149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RGf7UYwot34BV0nM/N1ZCdlnYIzevn7iRlhfia03PL0=;
  b=EBxfewEzbmI98CI2JhmMqMtMo0dZKReb2emRkjYXv2cZTcBX7H3v+zeZ
   HzVniN+mshAj5gMdWt/1Pi4u7WgcS5z6GQxntQfOvaMym7Qynq7Wdk4gX
   7twwCRgIlohM0u0V6CMFSYwqwvQXdzEIEDKinYihjGmnxsnMmM8boNUdw
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Feb 2022 12:52:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 12:52:28 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 12:52:28 -0800
Received: from [10.48.243.226] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 22 Feb
 2022 12:52:27 -0800
Message-ID: <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
Date:   Tue, 22 Feb 2022 12:52:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] ath10k: fix pointer arithmetic error in trace call
Content-Language: en-US
To:     Francesco Magliocca <franciman12@gmail.com>,
        <ath10k@lists.infradead.org>
CC:     <dan.carpenter@oracle.com>, <rmanohar@qti.qualcomm.com>,
        <linux-wireless@vger.kernel.org>
References: <20220221122638.7971-1-franciman12@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220221122638.7971-1-franciman12@gmail.com>
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

On 2/21/2022 4:26 AM, Francesco Magliocca wrote:
> Reading through the commit history, it looks like
> there is no special need why we must skip the first 4 bytes
> in this trace call:
> 
> trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
> 			 hw->rx_desc_ops->rx_desc_size - sizeof(u32));
> 
> found in the function ath10k_htt_rx_amsdu_pop in the file htt_rx.c
> 
> i think the original author
> (who is also the one who added rx_desc tracing capabilities
> in a0883cf7e75a) just wanted to trace the rx_desc contents,
> ignoring the fw_rx_desc_base info field
> (which is the part being skipped over).
> But the trace_ath10k_htt_rx_desc later added
> don't care about skipping it, so it may be good
> to uniform this call to the others in the file.
> But this would change the output of the trace and
> thus it may be a problem for tools that rely on it.
> Therefore I propose until further discussion
> to just keep it as it is and just fix the pointer arithmetic bug.
> 
> Add missing void* cast to rx descriptor pointer in order to
> properly skip the initial 4 bytes of the rx descriptor
> when passing it to trace_ath10k_htt_rx_desc trace function.
> 
> This fixes the pointer arithmetic error detected
> by Dan Carpenter's static analysis tool.
> 
> Fixes: 6bae9de622d3 ("ath10k: abstract htt_rx_desc structure")
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
> Link: https://lore.kernel.org/ath10k/20220201130900.GD22458@kili/
> ---
>   drivers/net/wireless/ath/ath10k/htt_rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> index 9ad64ca84beb..e01efcd2ce06 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -429,7 +429,7 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,
>   				RX_MSDU_END_INFO0_LAST_MSDU;
>   
>   		/* FIXME: why are we skipping the first part of the rx_desc? */
> -		trace_ath10k_htt_rx_desc(ar, rx_desc + sizeof(u32),
> +		trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),

since void pointer arithmetic is undefined in C99 would it be "better" 
to cast as u8 *? I realize that gcc has an extension to support this 
[1], but this usage will cause a warning when -Wpointer-arith is used.

[1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
