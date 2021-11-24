Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEF45B2DE
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 04:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhKXDyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 22:54:45 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62000 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236364AbhKXDyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 22:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637725896; x=1669261896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9IATbaAqXDyxifJBztg8aaiCcMMHzxxiFrSoM7G6xgs=;
  b=GAlg0NYXh3CHScWToltk3pIxrhSv45v5MFC1STR9tZE8Pl7n6ijGnqfO
   YIhhjspas461oYbT88/d2wM9LU13Ut003nw405UcbgbJToToSW2OT6vtb
   NQfSxXYgPf46QoL8r8lV6iJ8AEWB+3U+OB/N/zNviqJ/uaCsSNDjVlZl8
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 19:51:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 19:51:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 19:51:35 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 23 Nov
 2021 19:51:33 -0800
Message-ID: <0fb4fec3-4fd0-6e92-b1d9-5bffc0958e97@quicinc.com>
Date:   Wed, 24 Nov 2021 11:50:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 2/3] ath11k: Refactor update channel list function
Content-Language: en-US
To:     P Praneesh <ppranees@codeaurora.org>, <ath11k@lists.infradead.org>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
References: <1634906227-22028-1-git-send-email-ppranees@codeaurora.org>
 <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <1634906227-22028-3-git-send-email-ppranees@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/22/2021 8:37 PM, P Praneesh wrote:

...

> ---
> ...
> -			ch->maxpower = channel->max_power * 2;
> -			ch->maxregpower = channel->max_reg_power * 2;
> -			ch->antennamax = channel->max_antenna_gain * 2;
> ...
>   
> +int ath11k_wmi_update_scan_chan_list(struct ath11k *ar,
> +				     struct scan_req_params *arg)
> ...
> +			ch->maxpower = channel->max_power;
> +			ch->maxregpower = channel->max_reg_power;
> +			ch->antennamax = channel->max_antenna_gain;
> +
> ...
I see it also have another patch to remove the "*2" for power.
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=9212c1b9e80a869e732769a4fe7f82d392b219be

ath11k: send proper txpower and maxregpower values to firmware.

so are you the same reason to remove "*2" ?

