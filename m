Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2E4EBC17
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiC3Hv7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiC3Hv5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 03:51:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721CB39
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648626612; x=1680162612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u/nT8YVsKsmr7Ini2Bd+sBRW7SVZCd1ouseI9s1ePh8=;
  b=Q58/w90b+S57h7h6vUqdk3TRgL8NcrvndGJZ8oR81GuDS+q/A6BvwE4o
   R+ipB3lHdAwDTN3NiwMmKayIC3xlQ0LmAYEyHeH6+4Iw0KINyaN3Mpcu7
   +RNpI625yLbK7CrUQY2q4HwauryGG1BFXFwY0IG07GL0qIqZlzAquDOwu
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Mar 2022 00:50:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 00:50:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 30 Mar 2022 00:50:11 -0700
Received: from [10.50.50.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 00:50:09 -0700
Message-ID: <30e22170-fdc4-cf66-a39b-921b5f89c6e8@quicinc.com>
Date:   Wed, 30 Mar 2022 13:20:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 00/12] add support for WCN6750
Content-Language: en-US
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220328060937.16738-1-quic_mpubbise@quicinc.com>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <20220328060937.16738-1-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On 3/28/2022 11:39 AM, Manikanta Pubbisetty wrote:
> WCN6750 is non-DBS 2x2 11AX chipset. Unlike QCA6390/WCN6855 which
> are DBS (dual band simultaneous) solutions (2 LMACs), WCN6750 has a
> single LMAC supporting 2G, 5G and 6G bands. It can be operated only
> on one band at any given point.
> 
> WCN6750 is a PCIe device. Unlike other supported ATH11K PCIe devices
> which are directly attached to APSS (Application Processor SubSystem),
> WCN6750 is not attached to APSS, it is attached to the WPSS
> (Wireless Processor SubSystem) Q6 processor, the FW which runs on the
> Q6 processor will enumerate the PCIe device. Since APSS is unaware of
> such a device, it has to be registered as a platform device(AHB) to the
> kernel for device probing. Like other AHB devices, remoteproc APIs are
> used to boot up or shutdown of WCN6750.
> 
> WCN6750 uses both AHB and PCIe ATH11K APIs for it's operation.
> It uses AHB APIs for device probe and booting of the remote processor.
> Once device is booted up, it uses ATH11K PCIe APIs for initialization
> and register access. Hence, it is referred as hybrid bus device in
> the rest of this series.
> 
> Since the chip is enumerated by WPSS Q6, device information like
> BAR and BAR size is not known to the APSS processor. A new QMI message
> called device info QMI request will be sent to the target for fetching
> these details.
> 
> STA and AP modes are supported; Basic connectivity and ping are
> verified in both the modes.
> 
> An important point to note is that though WCN6750 is a PCIe device,
> it cannot be attached to any other platform except on Qualcomm
> Snapdragon SoCs due to the aforementioned reasons.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> Manikanta Pubbisetty (12):
>    dt: bindings: net: add bindings of WCN6750 for ath11k
>    ath11k: Add HW params for WCN6750
>    ath11k: Add bus params for WCN6750
>    ath11k: Add register access logic for WCN6750
>    ath11k: Fetch device information via QMI for WCN6750
>    ath11k: Add QMI changes for WCN6750
>    ath11k: HAL changes to support WCN6750
>    ath11k: Datapath changes to support WCN6750
>    ath11k: Do not put HW in DBS mode for WCN6750
>    ath11k: WMI changes to support WCN6750
>    ath11k: Update WBM idle ring HP after FW mode on
>    ath11k: Add support for WCN6750 device
> ---
> Note:
> *	Remoteproc driver changes for WCN6750 which takes care of
> 	downloading the FW and booting of Q6 processor are under
> 	upstream review.
> 	Link: https://patchwork.kernel.org/project/linux-remoteproc/cover/1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com/

Hi Kalle,

It looks like the remoteproc changes have landed in linux-next tree. 
Shall I remove this dependency and resend the series?

Thanks,
Manikanta
