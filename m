Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B115B534360
	for <lists+linux-wireless@lfdr.de>; Wed, 25 May 2022 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiEYS6z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 May 2022 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiEYS6z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 May 2022 14:58:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646334BA7
        for <linux-wireless@vger.kernel.org>; Wed, 25 May 2022 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653505133; x=1685041133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BnwJaH37X3htVt45pLN0Ls+I+oYD06TfiuEYxjzJzD0=;
  b=dR7UFKfhED0tNvoEwbcnm0wzjsE95I4eVMm0zkhLwPdCnxDOjtcDBMkC
   l2OAE6vWiCSKD5wKgF3evwVZT26yxyKODNnSIQqGRvMJBOh8Z9qYGHOcK
   lxRpFR+jfdzjkOTZkQMiN47IUwQo0Rp7cy8SLfYaO3gt0CABuQ45bUh99
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 May 2022 11:58:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 11:58:52 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 11:58:52 -0700
Received: from [10.110.85.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 25 May
 2022 11:58:51 -0700
Message-ID: <1e7d525f-b080-1ee4-3446-c29d1278ffae@quicinc.com>
Date:   Wed, 25 May 2022 11:58:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2 32/96] cl8k: add fw.h
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
 <20220524113502.1094459-33-viktor.barna@celeno.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220524113502.1094459-33-viktor.barna@celeno.com>
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
[snip]

> +/* Message structure. */
> +struct cl_fw_msg {
> +	__le16 msg_id;  /* Message ID. */
> +	u8 dst_kern_id; /* Destination kernel ID. */
> +	u8 dst_task_id; /* Destination task ID. */
> +	u8 src_kern_id; /* Source kernel ID. */
> +	u8 src_task_id; /* Source task ID. */
> +	__le16 param_len;  /* Parameter embedded struct length. */
> +	__le32 param[1];   /* Parameter embedded struct - must be word-aligned. */

use of [1] is deprecated and this usage will potentially break with 
upcoming "fortify source" kernel changes

see 
<https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays>

when you change to use just [] make sure that any code that uses 
sizeof(the current struct) is modified to account for the removal of one 
__le32 from the struct
