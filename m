Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56254456EDA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 13:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhKSMeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 07:34:09 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:31944 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhKSMeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 07:34:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637325067; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TFZh9Hncx+RwLUP8/sm4gFsZtAnZ+rgc6Kbset6/D6Q=; b=JHWi3QxeS07pTPTWsjM2ogZvMCac6q8lHfeecQlcgozUkupDFMWIkhnp0grjmCrXE9GoUVle
 mx2TGFTeQqzwpfuWbFaHTOXZIKx3/z7QD/ExK0RhK9vDH07oYJRyv+xUVcVJfJlZ27lneSbO
 RmEPLYDX8ZRhR2wFjCuZ0f6CT7g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6197990af5c956d49e3183ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 12:31:06
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7EEFC4338F; Fri, 19 Nov 2021 12:31:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C9EDC43616;
        Fri, 19 Nov 2021 12:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9C9EDC43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Baochen Qiang <bqiang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/7] ath11k: support one MSI vector
References: <20211026041616.4956-1-bqiang@codeaurora.org>
        <878rxpiudp.fsf@codeaurora.org>
        <72c4443df7de4f6fa4b87d2244766c85@codeaurora.org>
Date:   Fri, 19 Nov 2021 14:31:00 +0200
In-Reply-To: <72c4443df7de4f6fa4b87d2244766c85@codeaurora.org> (Baochen
        Qiang's message of "Tue, 16 Nov 2021 10:50:00 +0800")
Message-ID: <87tug8coor.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <bqiang@codeaurora.org> writes:

> On 2021-11-15 18:30, Kalle Valo wrote:
>> Baochen Qiang <bqiang@codeaurora.org> writes:
>>
>>> This patch set is to support one MSI vector for QCA6390.
>>>
>>> Depends-On:
>>>   1. ath11k: Fix crash caused by uninitialized TX ring
>>>   https://patchwork.kernel.org/project/linux-wireless/patch/20211026011605.58615-1-quic_bqiang@quicinc.com/
>>>
>>> Baochen Qiang (1):
>>>   ath11k: Set IRQ affinity to CPU0 in case of one MSI vector
>>>
>>> Carl Huang (6):
>>>   ath11k: get msi_data again after request_irq is called
>>>   ath11k: add CE and ext IRQ flag to indicate irq_handler
>>>   ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
>>>   ath11k: refactor multiple MSI vector implementation
>>>   ath11k: supports one MSI vector
>>>   ath11k: do not restore ASPM in case of single MSI vector
>>
>> I assume this is v2 of Carl's patchset:
>>
>> https://patchwork.kernel.org/project/linux-wireless/cover/20201223030225.2345-1-cjhuang@codeaurora.org/
>>
>> Can you provide a changelog? No need to resend because of that, just a
>> reply to this thread enough.
>
> Hi Kalle, this is the changelog:
>
> 1. changes by Kalle based on Carl's v1:
>
> * add a log message for MSI vector count
> * add a log message when disabling ASPM
> * patch 1: fix error handling in ath11k_pci_probe()
> * patch 1: simplify ath11k_pci_config_msi_data()
> * patch 2: convert booleans to set_bit() & co for atomic access
> * patch 2:__ath11k_pci_ext_irq_disable(): fix compilation
> * patch 4: bool vectors_32_capability to set_bit() for atomic access
> * patch 4: ath11k_mhi_get_msi(): don't use ? operator
> * improve commits logs a bit
>
> 2. changes by Baochen based on Kalle's version:
>
> * add a new patch: "ath11k: Set IRQ affinity to CPU0 in case of one
> MSI vector"
> * address Jeff's comments on "ath11k: do not restore ASPM in case of
> single MSI vector":
> 	change debug info from "disabling PCI ASPM ..." to "leaving
> PCI ASPM disabled ..."
> * change error handling in patch "ath11k: get msi_data again after
> request_irq is called"
> * address Vasanth's comments on "ath11k: refactor multiple msi vector
> implementation"

Thanks. I shortly tested this patchset (commit 5d9dd5b3db33 in
master-pending) on a NUC x86 box and Dell XPS 13 9310 laptop using
QCA6390 hw2.0, both with 32 MSI vectors (VT-d enabled in BIOS) and 1 MSI
vector (VT-d disabled in BIOS). No issues found, and also suspend works
fine for me. So I think we have solved all the stability issues.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
