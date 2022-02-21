Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2544BDE12
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbiBUJmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 04:42:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350820AbiBUJlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 04:41:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B33D1DF;
        Mon, 21 Feb 2022 01:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5927ACE0E90;
        Mon, 21 Feb 2022 09:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9BBC340EB;
        Mon, 21 Feb 2022 09:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645435048;
        bh=iJfhffaxaqucqlfWHbQPFYGDjZ9N6RtcLoLdRTMnIyY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W5U/jExpVNMAES/DEUdOWgigHuCG/oVtAsjj8JoBZTk2KEHetUKwb/cFaweqMcNAZ
         Z6kpwWnalZu3uEYgA/hKbYwgNWdczdkAG5opvih6GdxATlVYnbb1hZ94JVrmrJzLCt
         Fij2h2sF3q0hcphj5MGm8M/rEKwxj/Cxcg/O1rq5Vh4894Nx3wCdolR3ZX9srwsl+b
         pazkXtAD5wAfujHr0UukkEKa61if2dhZzzdey4hZ8PjrwItoCeeue6BkvHDyxASYfn
         JkAX8Rh0kpzfmFf/a/tQv96UClGLX1hT+mrObJ1QIOty5JcVw3BAIO6DrLVS6cMwej
         abJ2tgBzjtTQg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 05/19] ath11k: Remove core PCI references from PCI common code
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-6-git-send-email-quic_mpubbise@quicinc.com>
        <87a6fggo0h.fsf@kernel.org>
        <df81787b-3ad4-62b7-7a39-fdca6775bae1@quicinc.com>
Date:   Mon, 21 Feb 2022 11:17:25 +0200
In-Reply-To: <df81787b-3ad4-62b7-7a39-fdca6775bae1@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 21 Feb 2022 12:25:45 +0530")
Message-ID: <875yp8zihm.fsf@kernel.org>
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

> On 1/28/2022 3:50 PM, Kalle Valo wrote:
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>
>>> Remove core PCI and ath11k PCI references(struct ath11k_pci)
>>> from PCI common code. Since, PCI common code will be used
>>> by hybrid bus devices, this code should be independent
>>> from ATH11K PCI references and Linux core PCI references
>>> like struct pci_dev.
>>>
>>> Since this change introduces function callbacks for bus wakeup
>>> and bus release operations, wakeup_mhi HW param is no longer
>>> needed and hence it is removed completely. Alternatively, bus
>>> wakeup/release ops for QCA9074 are initialized to NULL as
>>> QCA9704 does not need bus wakeup/release for register accesses.
>>>
>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>>
>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>
>> [...]
>>
>>> @@ -651,6 +653,13 @@ struct ath11k_bus_params {
>>>   	bool fixed_bdf_addr;
>>>   	bool fixed_mem_region;
>>>   	bool static_window_map;
>>> +	struct {
>>> +		void (*wakeup)(struct ath11k_base *ab);
>>> +		void (*release)(struct ath11k_base *ab);
>>> +		int (*get_msi_irq)(struct ath11k_base *ab, unsigned int vector);
>>> +		void (*window_write32)(struct ath11k_base *ab, u32 offset, u32 value);
>>> +		u32 (*window_read32)(struct ath11k_base *ab, u32 offset);
>>> +	} ops;
>>>   };
>>
>> Please don't use bus_params for this, I'm starting to suspect that we
>> actually need to remove struct ath11k_bus_params altogether. It would be
>> cleaner to have separate 'struct ath11k_pci_ops' or something like that.
>>
>
> Sure, something like 'struct ath11k_bus_ops' in ath11k_base struct
> would be appropriate.

But we have 'struct ath11k_hif_ops' already, and that's basically
ath11k_bus_ops with a confusing name :) (IIRC HIF means Host InterFace,
or something like that.) So having both ath11k_bus_ops and
ath11k_hif_ops would become even more confusing.

You are basically abstracting out PCI functionality, that's why I
suggested ath11k_pci_ops. But yeah, naming is hard :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
