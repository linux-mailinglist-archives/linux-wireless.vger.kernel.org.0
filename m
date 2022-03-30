Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EACD4EBC39
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiC3IA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiC3IA4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 04:00:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A83201BA
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 00:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB88B8128F
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 07:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E2EC340EC;
        Wed, 30 Mar 2022 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648627149;
        bh=5+woyzDsfK3hKaCYXH65F2mlggFPnKmyw6YLV2QIotY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KLneqMcStRqDdiHwH8iLShOnJtrp+JCf+NNj9cw+DdNTvncU/pbZQpoogcNlxn6rK
         vsgTcb/VcOH9NlxQa8h73NB8kjYdDfYjyskUpZ/KWN+7RnnJOkIFh+RfIYxDJ7jly5
         JbO2J6cHCo1rBcuwNVjMrDfWnjiXOOnXcee1sZz8ylCFWoi2xsIBOJs2kdirCZzN0n
         0H/2trofY1r2a7riVm2odE9qPG0zfbtzJMCQbZ+c6XYbKqmlx/Qy1MTAUdIgu61TEn
         X5Lwh0QmoeEFE/HEOyD/qDAS+VPI0t1So4S6lTdYpOLp18ea0BuFTocvaASE49Gz+k
         XsLkoJtWvaGUQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] add support for WCN6750
References: <20220328060937.16738-1-quic_mpubbise@quicinc.com>
        <30e22170-fdc4-cf66-a39b-921b5f89c6e8@quicinc.com>
Date:   Wed, 30 Mar 2022 10:59:04 +0300
In-Reply-To: <30e22170-fdc4-cf66-a39b-921b5f89c6e8@quicinc.com> (Manikanta
        Pubbisetty's message of "Wed, 30 Mar 2022 13:20:06 +0530")
Message-ID: <87tubfx453.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 3/28/2022 11:39 AM, Manikanta Pubbisetty wrote:
>> WCN6750 is non-DBS 2x2 11AX chipset. Unlike QCA6390/WCN6855 which
>> are DBS (dual band simultaneous) solutions (2 LMACs), WCN6750 has a
>> single LMAC supporting 2G, 5G and 6G bands. It can be operated only
>> on one band at any given point.
>>
>> WCN6750 is a PCIe device. Unlike other supported ATH11K PCIe devices
>> which are directly attached to APSS (Application Processor SubSystem),
>> WCN6750 is not attached to APSS, it is attached to the WPSS
>> (Wireless Processor SubSystem) Q6 processor, the FW which runs on the
>> Q6 processor will enumerate the PCIe device. Since APSS is unaware of
>> such a device, it has to be registered as a platform device(AHB) to the
>> kernel for device probing. Like other AHB devices, remoteproc APIs are
>> used to boot up or shutdown of WCN6750.
>>
>> WCN6750 uses both AHB and PCIe ATH11K APIs for it's operation.
>> It uses AHB APIs for device probe and booting of the remote processor.
>> Once device is booted up, it uses ATH11K PCIe APIs for initialization
>> and register access. Hence, it is referred as hybrid bus device in
>> the rest of this series.
>>
>> Since the chip is enumerated by WPSS Q6, device information like
>> BAR and BAR size is not known to the APSS processor. A new QMI message
>> called device info QMI request will be sent to the target for fetching
>> these details.
>>
>> STA and AP modes are supported; Basic connectivity and ping are
>> verified in both the modes.
>>
>> An important point to note is that though WCN6750 is a PCIe device,
>> it cannot be attached to any other platform except on Qualcomm
>> Snapdragon SoCs due to the aforementioned reasons.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Manikanta Pubbisetty (12):
>>    dt: bindings: net: add bindings of WCN6750 for ath11k
>>    ath11k: Add HW params for WCN6750
>>    ath11k: Add bus params for WCN6750
>>    ath11k: Add register access logic for WCN6750
>>    ath11k: Fetch device information via QMI for WCN6750
>>    ath11k: Add QMI changes for WCN6750
>>    ath11k: HAL changes to support WCN6750
>>    ath11k: Datapath changes to support WCN6750
>>    ath11k: Do not put HW in DBS mode for WCN6750
>>    ath11k: WMI changes to support WCN6750
>>    ath11k: Update WBM idle ring HP after FW mode on
>>    ath11k: Add support for WCN6750 device
>> ---
>> Note:
>> *	Remoteproc driver changes for WCN6750 which takes care of
>> 	downloading the FW and booting of Q6 processor are under
>> 	upstream review.
>> 	Link: https://patchwork.kernel.org/project/linux-remoteproc/cover/1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com/
>
> Hi Kalle,
>
> It looks like the remoteproc changes have landed in linux-next tree.
> Shall I remove this dependency and resend the series?

Please wait, I want to look at the patchset first and provide comments.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
