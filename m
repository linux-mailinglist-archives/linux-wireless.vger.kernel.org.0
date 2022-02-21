Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741194BE67B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 19:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351162AbiBUJsi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 04:48:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352896AbiBUJsA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 04:48:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BC17A9F;
        Mon, 21 Feb 2022 01:21:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4444A60B1E;
        Mon, 21 Feb 2022 09:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD11C340EB;
        Mon, 21 Feb 2022 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645435268;
        bh=G9qsOIaU98YL4dvaSW0KBRUIIJZ5fR+aEheIpSP0fSU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YopDpMVtruprOaV/SZ/FMFShUXL8Hjwbo0vMR12S3RDVmQTEfu+fKqiHzmU3/zkYz
         UGxCl8MwUZIKXLUBGsYaWUiQab+v3I5Sz4dStrOAg7B/V+Sl/Gts/wW428RZ3htYES
         v8nYZdwN61GyoUVwnnR0G6LPdiKX4QP7MaaBz4F3FWDd2sQTJSigCZFHqdMTuNuIFB
         EGqG4xh7qdHn9fICcVWCtFeIuxlNELucANaysdqKUIzHqDrqoSGokhIHloWOL7cLwm
         YOi/FD20HkWz/sUshQmkQU6Q7oYk1fipT710V3gArlPuzU5FFBnguKeZEI9moMs94U
         3PWzatYZl25/w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 05/19] ath11k: Remove core PCI references from PCI common code
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-6-git-send-email-quic_mpubbise@quicinc.com>
        <87a6fggo0h.fsf@kernel.org> <871r0sgn7n.fsf@kernel.org>
        <3b8b03ba-c6a1-d794-79e5-f244bc1dffae@quicinc.com>
Date:   Mon, 21 Feb 2022 11:21:04 +0200
In-Reply-To: <3b8b03ba-c6a1-d794-79e5-f244bc1dffae@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 21 Feb 2022 12:37:41 +0530")
Message-ID: <87wnhoy3r3.fsf@kernel.org>
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

> On 1/28/2022 4:07 PM, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>
>>>> Remove core PCI and ath11k PCI references(struct ath11k_pci)
>>>> from PCI common code. Since, PCI common code will be used
>>>> by hybrid bus devices, this code should be independent
>>>> from ATH11K PCI references and Linux core PCI references
>>>> like struct pci_dev.
>>>>
>>>> Since this change introduces function callbacks for bus wakeup
>>>> and bus release operations, wakeup_mhi HW param is no longer
>>>> needed and hence it is removed completely. Alternatively, bus
>>>> wakeup/release ops for QCA9074 are initialized to NULL as
>>>> QCA9704 does not need bus wakeup/release for register accesses.
>>>>
>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>>
>>> [...]
>>>
>>>> @@ -651,6 +653,13 @@ struct ath11k_bus_params {
>>>>   	bool fixed_bdf_addr;
>>>>   	bool fixed_mem_region;
>>>>   	bool static_window_map;
>>>> +	struct {
>>>> +		void (*wakeup)(struct ath11k_base *ab);
>>>> +		void (*release)(struct ath11k_base *ab);
>>>> +		int (*get_msi_irq)(struct ath11k_base *ab, unsigned int vector);
>>>> +		void (*window_write32)(struct ath11k_base *ab, u32 offset, u32 value);
>>>> +		u32 (*window_read32)(struct ath11k_base *ab, u32 offset);
>>>> +	} ops;
>>>>   };
>>>
>>> Please don't use bus_params for this, I'm starting to suspect that we
>>> actually need to remove struct ath11k_bus_params altogether. It would be
>>> cleaner to have separate 'struct ath11k_pci_ops' or something like that.
>>
>> And after looking at this more it seems .get_msi_irq is the only
>> function which actually has two different implementations. The other
>> four are either run or not run, there's no difference in the
>> implementation. So would it be cleaner to have a some sort check within
>> the function for these other four, instead using function pointers?
>>
>
> WCN6750 has it's own wakeup() and release(), I'll send that patch
> separately. QCN9074 doesn't need wakeup() and release() functions.
>
> The intention of the patch was to remove all Linux and ATH11K PCI
> reference like struct pci_dev and ath11k_pci in the common code.
> TBH, WCN6750 doesn't need these references since it is a AHB device
> in ATH11K. If we have these references in common code, first thing is
> the code will look kind of messed up and another aspect is we need to
> enable CONFIG_PCI unnecessarily. This was the reason behind defining
> other two callbacks window_write32() and read32().

Ah, makes sense.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
