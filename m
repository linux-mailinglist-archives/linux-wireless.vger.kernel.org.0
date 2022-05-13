Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE8526725
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356212AbiEMQeU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344683AbiEMQeS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 12:34:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DCF657A
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652459658; x=1683995658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qJeqjbAbxk/6LO0rIbKxJ8Ik7oHXCMijeyXxuUIAvpQ=;
  b=byIv2F+liyNuheTtRjYTasKl9pmd8jPvQT2X8ulHQYBBEsvzsJyM6Ufu
   EGqN4imXxSMRiG8MwgB6PlSAyvVkokIMD8Z1rc0Kyj+AGGhWB6LCiL59w
   PZK/iEyXhdYiudkHdIftDgIff+XYZL7ZN2Qc4ih5BoOpCHzaA4x2YALsY
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 May 2022 09:34:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 09:34:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 13 May 2022 09:34:17 -0700
Received: from [10.110.47.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 09:34:17 -0700
Message-ID: <548d2149-f47a-6afb-92e5-124abcecfe51@quicinc.com>
Date:   Fri, 13 May 2022 09:34:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/6] rtw89: convert rtw89_band to nl80211_band precisely
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
References: <20220513054224.16902-1-pkshih@realtek.com>
 <20220513054224.16902-6-pkshih@realtek.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220513054224.16902-6-pkshih@realtek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/12/2022 10:42 PM, Ping-Ke Shih wrote:
> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Before 6G band was supported, i.e. only 2G and 5G, they were the same
> from the numerical point of view. However, after 6G band support, we
> need to do this conversion logically.

In the ath drivers we've been trying to avoid using the terms 2G/5G/6G 
to describe frequencies since that usage conflicts with the cellular use 
of similar terms to describe generations of the technology, and further 
could cause confusion now that WFA is also defining generations of Wi-Fi 
by number instead of by IEEE 802.11 amendment.

To that end it would be nice if we could universally adopt using proper 
SI terminology when referring to Wi-Fi frequencies:
2 GHz (or 2.4 GHz), 5 GHz, & 6 GHz
