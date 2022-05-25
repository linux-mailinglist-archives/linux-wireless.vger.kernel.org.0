Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9C53432C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 20:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiEYSjM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 14:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiEYSjL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 14:39:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D42CB2244
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653503950; x=1685039950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TUjhZkuJ9SFIaTZlcYvWfiS/PMTXFcnrVnb8B+HkwUo=;
  b=mov8fhW7HZhMfhDr4UJ7gfRo5l/A1fqM6tzfoBB+G2beNMifBfB2uacr
   Mn/YUBYgxAs6LhA6knIOV2zdiCjDiPPQ7UAc4sUvpg/+XKw5+E3/73nAT
   wV8jYuLkjXcAISbJugY03xsUQkKCVMUzFmBCjkRnSZBtCP3BFkVZmd82I
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 May 2022 11:39:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 11:39:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 11:39:08 -0700
Received: from [10.110.85.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 25 May
 2022 11:39:07 -0700
Message-ID: <720c910a-9237-9229-901c-fd8f374a13cc@quicinc.com>
Date:   Wed, 25 May 2022 11:39:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 19/96] cl8k: add def.h
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
 <20220524113502.1094459-20-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-20-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2022 4:33 AM, viktor.barna@celeno.com wrote:
> From: Viktor Barna <viktor.barna@celeno.com>
[snip]
> +#define ASSERT_ERR(condition) \
> +	do { \
> +		if (unlikely(!(condition))) \
> +			cl_dbg_err(cl_hw, ":ASSERT_ERR(" #condition ")\n"); \
> +	} while (0)
> +
> +#define ASSERT_ERR_CHIP(condition) \
> +	do { \
> +		if (unlikely(!(condition))) \
> +			cl_dbg_chip_err(chip, ":ASSERT_ERR(" #condition ")\n"); \
> +	} while (0)

Again you have macros with magic names cl_hw & chip

