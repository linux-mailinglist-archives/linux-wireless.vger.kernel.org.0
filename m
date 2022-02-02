Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087634A7B52
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 23:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiBBWy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 17:54:57 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:1194 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236831AbiBBWy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 17:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643842496; x=1675378496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fsvp8nQn++8KMwiHAngOAty1fTyj7nrCgipTrE7ZBLc=;
  b=ojyysdwaW7Mt+pONzk72ZZIleIwYGlyY6F5HKagiNNWaMLwNRNdkSXqq
   NEmzxFpKiy/KpZ25FhpOUnpZtht5jTS8NXM4Gc4/+8cCi+1G/i6UJuzKC
   EhmZa3pzVh8jKMb9n6HGmXmdj1qvzWirnDndv2mvDyrCwioO7mBajbbzx
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Feb 2022 14:54:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 14:54:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 2 Feb 2022 14:54:55 -0800
Received: from [10.48.243.21] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 2 Feb 2022
 14:54:55 -0800
Message-ID: <de395fa7-6906-bdef-19c7-dbc229bd35e9@quicinc.com>
Date:   Wed, 2 Feb 2022 14:54:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3] ath11k: Add peer rhash table support
Content-Language: en-US
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <1643787194-31355-1-git-send-email-quic_periyasa@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1643787194-31355-1-git-send-email-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/1/2022 11:33 PM, Karthikeyan Periyasamy wrote:
> + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.

should now be 2021-2022 in all copyrights?
