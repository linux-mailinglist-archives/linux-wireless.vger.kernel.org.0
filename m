Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524BE539A5D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 02:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346797AbiFAA1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 20:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiFAA1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 20:27:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7534451307
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 17:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654043261; x=1685579261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MzVto5JifBCcRpXWLop2l1aIQWQ2PohzEiDsbqbZdrs=;
  b=gCH18Qa5uTRPe69+95CTWvDQ2bfR9JaowAAZLg5bYjSFgJkDkRsDMtOX
   EaKZh6IhJomdgGgjLNW1LTnuyylXzO6KLIsYBHZsSQQg+eYEHTFd5AXh1
   U3BvBdyYsnPf1/jvNtMYn3lLnkr3NcrEkvKMHhDg4fDIbQWsO42T6BEam
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 May 2022 17:27:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 17:27:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 17:27:39 -0700
Received: from [10.110.67.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 17:27:37 -0700
Message-ID: <51843710-a1ec-b1f6-8d1a-972ca5b40af4@quicinc.com>
Date:   Tue, 31 May 2022 17:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 50/96] cl8k: add phy.c
Content-Language: en-US
To:     <viktor.barna@celeno.com>, <linux-wireless@vger.kernel.org>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        "Maksym Kokhan" <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
 <20220524113502.1094459-51-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-51-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2022 4:34 AM, viktor.barna@celeno.com wrote:
> From: Viktor Barna <viktor.barna@celeno.com>
> 
> (Part of the split. Please, take a look at the cover letter for more
> details).
> 
> Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
> ---
>   drivers/net/wireless/celeno/cl8k/phy.c | 9648 ++++++++++++++++++++++++
>   1 file changed, 9648 insertions(+)
>   create mode 100644 drivers/net/wireless/celeno/cl8k/phy.c
> 
> diff --git a/drivers/net/wireless/celeno/cl8k/phy.c b/drivers/net/wireless/celeno/cl8k/phy.c
> new file mode 100644
> index 000000000000..dfc7f5a95d3d
> --- /dev/null
> +++ b/drivers/net/wireless/celeno/cl8k/phy.c
> @@ -0,0 +1,9648 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
> +
> +#include "tx.h"
> +#include "reg/reg_defs.h"
> +#include "radio.h"
> +#include "dsp.h"
> +#include "rfic.h"
> +#include "e2p.h"
> +#include "phy.h"
> +
> +#define FEM_LUT_EMPTY 0x0
> +
> +const struct common_lut_line athos_lut_6g_40_mhz[ATHOS_LUT_CHAN_6G_MAX] = {

in this file and in power.c you have multiple lookup tables that look 
like they could/should be static to limit their scope to the current file
