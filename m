Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175A849F765
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 11:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiA1Khy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 05:37:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47504 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiA1Khx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 05:37:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C4DDB824E4;
        Fri, 28 Jan 2022 10:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21457C340E0;
        Fri, 28 Jan 2022 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643366271;
        bh=ysNEYwSdpCi6tFVlLx1/q5nHXNJqjoxSYhq3w+gi2so=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=etzYMrTucld4zPDlWJofz0p4FikaxGA2VAIKXeGLTq9Ir6bz488LmszQB7jUb3vWc
         V43tgZ/j/QLiRBY9JkJi7JDrEnmAPzgeUIsABFzU/EnxG+JmwuGsoDmZkJQH6nSkkB
         oGRWWk/t10Yw7cv5Y9lwUBCrEJJ1OlLAAvvMdzTf1PI29biiRhieulgM2cpvVpHqoh
         B/wx7248+5fjXUo1QKvqNTZ1U5BsnUORRu21MTuIG4LmMA0nBFY4kZBvmuxBAd+rtK
         8merRipkzLoMLIgXvNcAmxgo22yHhfm7cXSjag2H63qFLvm0mpoxgFwApPBRVU8Hyy
         zU5UWdhqK+6gQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 05/19] ath11k: Remove core PCI references from PCI common code
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-6-git-send-email-quic_mpubbise@quicinc.com>
        <87a6fggo0h.fsf@kernel.org>
Date:   Fri, 28 Jan 2022 12:37:48 +0200
In-Reply-To: <87a6fggo0h.fsf@kernel.org> (Kalle Valo's message of "Fri, 28 Jan
        2022 12:20:30 +0200")
Message-ID: <871r0sgn7n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>
>> Remove core PCI and ath11k PCI references(struct ath11k_pci)
>> from PCI common code. Since, PCI common code will be used
>> by hybrid bus devices, this code should be independent
>> from ATH11K PCI references and Linux core PCI references
>> like struct pci_dev.
>>
>> Since this change introduces function callbacks for bus wakeup
>> and bus release operations, wakeup_mhi HW param is no longer
>> needed and hence it is removed completely. Alternatively, bus
>> wakeup/release ops for QCA9074 are initialized to NULL as
>> QCA9704 does not need bus wakeup/release for register accesses.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>
> [...]
>
>> @@ -651,6 +653,13 @@ struct ath11k_bus_params {
>>  	bool fixed_bdf_addr;
>>  	bool fixed_mem_region;
>>  	bool static_window_map;
>> +	struct {
>> +		void (*wakeup)(struct ath11k_base *ab);
>> +		void (*release)(struct ath11k_base *ab);
>> +		int (*get_msi_irq)(struct ath11k_base *ab, unsigned int vector);
>> +		void (*window_write32)(struct ath11k_base *ab, u32 offset, u32 value);
>> +		u32 (*window_read32)(struct ath11k_base *ab, u32 offset);
>> +	} ops;
>>  };
>
> Please don't use bus_params for this, I'm starting to suspect that we
> actually need to remove struct ath11k_bus_params altogether. It would be
> cleaner to have separate 'struct ath11k_pci_ops' or something like that.

And after looking at this more it seems .get_msi_irq is the only
function which actually has two different implementations. The other
four are either run or not run, there's no difference in the
implementation. So would it be cleaner to have a some sort check within
the function for these other four, instead using function pointers?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
