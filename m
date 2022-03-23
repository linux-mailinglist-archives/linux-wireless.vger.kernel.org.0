Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCB14E5A09
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbiCWUqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344780AbiCWUqf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 16:46:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0B0E0F5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648068304; x=1679604304;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=akxUDbVJ934mdte3EiQmz/nvXI8A79eAvp4WYVt3+uc=;
  b=ti4x4yOMaPRvfsFrKVjqTzk59kDhy2sVm7fbYj6q7rXtnGNSiGudr97B
   RMCGFIg6z3GcUP1jFRbIg5hR/hR2jPrEI49s5jZbE9mI7nf7slNEQz0qR
   9UBE+2xLkWn8iPvQdDxTXamN71MMu+lFJ2Bmtyih+mqzbbcyR6c3jWdlA
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 13:45:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 13:45:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 13:45:03 -0700
Received: from [10.111.183.2] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 23 Mar
 2022 13:45:03 -0700
Message-ID: <e2faf5ac-ee71-3ed4-7598-70f083a5996c@quicinc.com>
Date:   Wed, 23 Mar 2022 13:45:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/4] nl80211: advertise RU puncturing support to
 userspace
Content-Language: en-US
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
References: <20220323191640.31230-1-quic_alokad@quicinc.com>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <20220323191640.31230-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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

On 3/23/2022 12:16 PM, Aloka Dixit wrote:
> RU preamble puncturing is allowed for bandwidths more that 80 MHz
> except 80+80. Drivers may not support puncturing at all or have
> restrictions for a minimum bandwidth.
> Add new attribute NL80211_ATTR_RU_PUNCT_SUPP_BW to advertise the
> driver support to the userspace. Default value (0) will indicate that
> RU puncturing is not supported.
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> ---
> v2: Moved boundary check for ru_punct_supp_bw to wiphy_register().
> 

These patches depend on EHT support from
https://patchwork.kernel.org/project/linux-wireless/list/?series=614176&state=%2A&archive=both 
which are not yet present in mac80211-next tree.
But found those in wireless-next tree hence I used the same repository.
