Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3151C8A6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 21:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384808AbiEETIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384818AbiEETID (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 15:08:03 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A54ECF9
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651777463; x=1683313463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cii21deJ1sHe+d2ofzjVw0a1GqBD8b0nDHlZCPjX5F8=;
  b=aNiBAZ/KULUvtMEfWEfBPH7GHUy1XAY3TOzfuxL7af077MtcPYzTF/4/
   MxegEQbbNCg3bMcC9hVAlrZhxpfVz1CeuH319hqwRF8VTS3lmoG2r3WgR
   1TO79KVOgorSoK6M3W/V0hqC96y4ZvISqz35pz99EIynkE7R/bSa3tgT/
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 12:04:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 12:04:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 12:04:22 -0700
Received: from [10.110.125.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 12:04:22 -0700
Message-ID: <f270b2fb-a1c4-9c6b-6eda-c2d0a8c8c190@quicinc.com>
Date:   Thu, 5 May 2022 12:04:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ath11k: Handle keepalive during wowlan suspend and resume
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220505014657.1549947-1-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220505014657.1549947-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/2022 6:46 PM, Baochen Qiang wrote:
> With wowlan enabled and after sleeping for a rather long time,

nit: s/wowlan/WoWLAN/ to conform to common usage (also in subject)

> we are seeing that with some APs, it is not able to wake up
> the STA though the correct wake up pattern has been configured.
> This is because the host doesn't send keepalive command to
> firmware, thus firmware will not send any packet to the AP and
> after a specific time the AP kicks out the DUT.
> 
> Fix this issue by enabling keepalive before going to suspend
> and disabling it after resume back.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---

[...]

> +
> +enum wmi_sta_keepalive_method {
> +	WMI_STA_KEEPALIVE_METHOD_NULL_FRAME = 1, /* 802.11 NULL frame */
> +	WMI_STA_KEEPALIVE_METHOD_UNSOLICITED_ARP_RESPONSE = 2, /* ARP response */
> +	WMI_STA_KEEPALIVE_METHOD_ETHERNET_LOOPBACK = 3, /*ETHERNET LOOPBACK*/
> +	WMI_STA_KEEPALIVE_METHOD_GRATUITOUS_ARP_REQUEST = 4, /* gratuitous ARP req*/

nit: for the two above consistently have space separating comment from 
/* and */

> +	WMI_STA_KEEPALIVE_METHOD_MGMT_VENDOR_ACTION = 5, /* vendor action frame */
> +};
[...]
