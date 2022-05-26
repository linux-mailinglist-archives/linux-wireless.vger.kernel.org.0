Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716AE535614
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 00:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiEZWbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 18:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEZWbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 18:31:06 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0709D05B
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653604265; x=1685140265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tN2K/qTQa2PBgFum7VLRKOtgtqFCoA+gLm/pxJC0OZU=;
  b=oLKX0wlcUxXwanPZbF2+jCkc222+K83pKJwEDrgZijOb9HxuFRFG418r
   G8BmhR2Y7oKjC7MdTQydsMM18skwIqX4vji5hRg2NItB/cJqthzP8Hcbe
   TmSTleYmYc7LgmfAn9gZF3UucAetzwBpNWAXg0XeSjca8mqCFpbK+tEnF
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 15:31:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 15:31:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 15:31:04 -0700
Received: from [10.110.93.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 26 May
 2022 15:31:03 -0700
Message-ID: <17620927-df81-142b-8d19-03bb386fbb7c@quicinc.com>
Date:   Thu, 26 May 2022 15:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 40/96] cl8k: add mac_addr.c
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
 <20220524113502.1094459-41-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-41-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2022 4:34 AM, viktor.barna@celeno.com wrote:
[snip]

> +	/* Determine the bits necessary to cover the number of BSSIDs. */
> +	u8 num_bits_to_mask[ARRAY_SIZE(cl_hw->addresses) * TCV_MAX] = {

is there a reason this isn't static const?

> +		0, /* 0 : 00:1C:51:BD:FB:(0b 0000 0000) -> 0-bit diff (no LAM, original MAC) */
> +		0, /* 1 : 02:1C:51:BD:FB:(0b 0000 0000) -> 0-bit diff (LAM) */
> +
> +		1, /* 2 : 02:1C:51:BD:FB:(0b 0000 0001) -> 1-bit diff (LAM, between address #1) */
> +
> +		2, /* 3 : 02:1C:51:BD:FB:(0b 0000 0011) -> 2-bit diff (LAM) */
> +		2, /* 4 : 02:1C:51:BD:FB:(0b 0000 0010) -> 2-bit diff (LAM) */
> +
> +		3, /* 5 : 02:1C:51:BD:FB:(0b 0000 0111) -> 3-bit diff (LAM) */
> +		3, /* 6 : 02:1C:51:BD:FB:(0b 0000 0100) -> 3-bit diff (LAM) */
> +		3, /* 7 : 02:1C:51:BD:FB:(0b 0000 0101) -> 3-bit diff (LAM) */
> +		3, /* 8 : 02:1C:51:BD:FB:(0b 0000 0110) -> 3-bit diff (LAM) */
> +
> +		4, /* 9 : 02:1C:51:BD:FB:(0b 0000 1111) -> 4-bit diff (LAM) */
> +		4, /* 10: 02:1C:51:BD:FB:(0b 0000 1000) -> 4-bit diff (LAM) */
> +		4, /* 11: 02:1C:51:BD:FB:(0b 0000 1001) -> 4-bit diff (LAM) */
> +		4, /* 12: 02:1C:51:BD:FB:(0b 0000 1010) -> 4-bit diff (LAM) */
> +		4, /* 13: 02:1C:51:BD:FB:(0b 0000 1100) -> 4-bit diff (LAM) */
> +		4, /* 14: 02:1C:51:BD:FB:(0b 0000 1110) -> 4-bit diff (LAM) */
> +		4, /* 15: 02:1C:51:BD:FB:(0b 0000 1011) -> 4-bit diff (LAM) */
> +	};
> +

[snip]

> +	u8 lam_bit_mask[ARRAY_SIZE(cl_hw->addresses) * TCV_MAX] = {

static const?

> +		0b0000, /* 1 addr,  0-bit diff between MAC addrs, LAM is not affecting it */
> +		0b0000, /* 2 addrs, 0-bit diff between MAC addrs, first differs by LAM !!! */
> +		0b0001, /* 3 addrs, 1-bit diff */
> +		0b0011, /* 4 addrs, 2-bit diff */
> +		0b0011, /* 5 addrs, 2-bit diff */
> +
> +		0b0111, /* 6 addrs, 3-bit diff */
> +		0b0111, /* 7 addrs, 3-bit diff */
> +		0b0111, /* 8 addrs, 3-bit diff */
> +		0b0111, /* 9 addrs, 3-bit diff */
> +
> +		0b1111, /* 10 addrs, 4-bit diff */
> +		0b1111, /* 11 addrs, 4-bit diff */
> +		0b1111, /* 12 addrs, 4-bit diff */
> +		0b1111, /* 13 addrs, 4-bit diff */
> +		0b1111, /* 14 addrs, 4-bit diff */
> +		0b1111, /* 15 addrs, 4-bit diff */
> +		0b1111, /* 16 addrs, 4-bit diff */
> +	};
