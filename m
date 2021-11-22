Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E70C4587E2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 03:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhKVCGa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 21:06:30 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:15634 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhKVCG3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 21:06:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637546604; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AQFxkZProo07+TWCM6E8Dtsd0v8dLsmpW22oQG9wnu0=;
 b=ubK48l+D9p/XI8k8zCOWmqk20pluN7v6t0kRlmUjbfLrVCLbist+n6L1F8e5mZdQpmBTxI8A
 CL6FkIL9+0H8cKxyYd0A48wfpMxiIeuX/At2NABCYscQ2tZHG/kPk6jcxKXaM66FaO7DG/2Q
 arOJ9bSb4LJFWLBXoFCLa4+TFXQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 619afa6a0a5410021b4548bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 02:03:22
 GMT
Sender: bqiang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E90FC4360D; Mon, 22 Nov 2021 02:03:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bqiang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BADB8C4338F;
        Mon, 22 Nov 2021 02:03:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Nov 2021 10:03:20 +0800
From:   Baochen Qiang <bqiang@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/7] ath11k: support one MSI vector
In-Reply-To: <87tug8coor.fsf@codeaurora.org>
References: <20211026041616.4956-1-bqiang@codeaurora.org>
 <878rxpiudp.fsf@codeaurora.org>
 <72c4443df7de4f6fa4b87d2244766c85@codeaurora.org>
 <87tug8coor.fsf@codeaurora.org>
Message-ID: <58ccb58c0b1576f121fcf98fecf391d5@codeaurora.org>
X-Sender: bqiang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-19 20:31, Kalle Valo wrote:
> Baochen Qiang <bqiang@codeaurora.org> writes:
> 
>> On 2021-11-15 18:30, Kalle Valo wrote:
>>> Baochen Qiang <bqiang@codeaurora.org> writes:
>>> 
>>>> This patch set is to support one MSI vector for QCA6390.
>>>> 
>>>> Depends-On:
>>>>   1. ath11k: Fix crash caused by uninitialized TX ring
>>>>   
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20211026011605.58615-1-quic_bqiang@quicinc.com/
>>>> 
>>>> Baochen Qiang (1):
>>>>   ath11k: Set IRQ affinity to CPU0 in case of one MSI vector
>>>> 
>>>> Carl Huang (6):
>>>>   ath11k: get msi_data again after request_irq is called
>>>>   ath11k: add CE and ext IRQ flag to indicate irq_handler
>>>>   ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
>>>>   ath11k: refactor multiple MSI vector implementation
>>>>   ath11k: supports one MSI vector
>>>>   ath11k: do not restore ASPM in case of single MSI vector
>>> 
>>> I assume this is v2 of Carl's patchset:
>>> 
>>> https://patchwork.kernel.org/project/linux-wireless/cover/20201223030225.2345-1-cjhuang@codeaurora.org/
>>> 
>>> Can you provide a changelog? No need to resend because of that, just 
>>> a
>>> reply to this thread enough.
>> 
>> Hi Kalle, this is the changelog:
>> 
>> 1. changes by Kalle based on Carl's v1:
>> 
>> * add a log message for MSI vector count
>> * add a log message when disabling ASPM
>> * patch 1: fix error handling in ath11k_pci_probe()
>> * patch 1: simplify ath11k_pci_config_msi_data()
>> * patch 2: convert booleans to set_bit() & co for atomic access
>> * patch 2:__ath11k_pci_ext_irq_disable(): fix compilation
>> * patch 4: bool vectors_32_capability to set_bit() for atomic access
>> * patch 4: ath11k_mhi_get_msi(): don't use ? operator
>> * improve commits logs a bit
>> 
>> 2. changes by Baochen based on Kalle's version:
>> 
>> * add a new patch: "ath11k: Set IRQ affinity to CPU0 in case of one
>> MSI vector"
>> * address Jeff's comments on "ath11k: do not restore ASPM in case of
>> single MSI vector":
>> 	change debug info from "disabling PCI ASPM ..." to "leaving
>> PCI ASPM disabled ..."
>> * change error handling in patch "ath11k: get msi_data again after
>> request_irq is called"
>> * address Vasanth's comments on "ath11k: refactor multiple msi vector
>> implementation"
> 
> Thanks. I shortly tested this patchset (commit 5d9dd5b3db33 in
> master-pending) on a NUC x86 box and Dell XPS 13 9310 laptop using
> QCA6390 hw2.0, both with 32 MSI vectors (VT-d enabled in BIOS) and 1 
> MSI
> vector (VT-d disabled in BIOS). No issues found, and also suspend works
> fine for me. So I think we have solved all the stability issues.

Great to hear that. But one more thing Kalle, have you met the issue 
which is originally reported here 
https://jira-dc.qualcomm.com/jira/browse/LUW-3 ?
