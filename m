Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD266978C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbjAMMlb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 07:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbjAMMku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 07:40:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2C840AA
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 04:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345FA6150E
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 12:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F53DC433EF;
        Fri, 13 Jan 2023 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673613259;
        bh=XP7ELr/LV2NXiee4p7xuSDJGbblVNPXN0TlgLpZgcIE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Bn0w/TnJdLBor9PQDumi9Q23SdCu6qt+3gH3kLnq72WrlX4vmxEGjLKpxRp57/PkK
         y5icRNwk0UW/cOAh7FTETakjRTshPjttLpPVGNb533fEHkcfXTOt0g29OxiUNEK17p
         6Cr4/xO1Wzz/UkYoPhprsGEFKUReT8Zr1MjD/D8CMGO+3PXvctZNJvrW33uyLs5h83
         u6wLRgwOiqeW/n9Q3qMuiihbpXBUOmOw9t+NkEFBA9h0UVYM9Ll69+FjkNLbO+gPfQ
         ZzFWDFUhoyJ6kkeL1P9sxB8DS8ojUYpRamIG4+JOyjkZx+4yB/k2eSYA8vNfp7hn30
         o6VShmEMZAF6A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     ath11k@lists.infradead.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, robert.marko@sartura.hr
Subject: Re: [PATCH RFC] ath11k: Add multiple QCN9074 devices support
References: <20230111170033.32454-1-kvalo@kernel.org>
        <20230112103824.GD4782@thinkpad>
Date:   Fri, 13 Jan 2023 14:34:15 +0200
In-Reply-To: <20230112103824.GD4782@thinkpad> (Manivannan Sadhasivam's message
        of "Thu, 12 Jan 2023 16:08:24 +0530")
Message-ID: <87edryd35k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Wed, Jan 11, 2023 at 07:00:33PM +0200, Kalle Valo wrote:
>> From: P Praneesh <quic_ppranees@quicinc.com>
>> 
>> On platforms with two or more QCN9074 devices, the QMI service will run with
>> identical QRTR ids. qmi_add_lookup() is called with same qmi.service_ins_id.
>
> identical QRTR instance ID.

Will fix.

>> Kalle's comments:
>> 
>> Depends on: https://patchwork.kernel.org/project/linux-wireless/list/?series=710862&order=date
>> 
>> It's also possible to do a simple test by just changing the test
>> "test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)" to true, no
>> extra patches should be needed.
>> 
>> I don't have a test setup for this so compile tested only. But I assume Praneesh has tested this.
>> 
>> This is alternative approach to Robert's patchset:
>> 
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=692423&state=*&order=date
>> 
>
> For what devices the compatible firmware is available?

Currently only recent QCN9074 firmware releases support this, but I
don't from which release onwards.

> Any plan to fix the devices with old firmware?

In my opinion all ath11k PCI firmwares should support this, but AFAIK
they do not. I'll push the firmware teams to implement this but it's
another story if I succeed :)

>> +static void ath11k_pci_update_qrtr_node_id(struct ath11k_base *ab)
>
> The function name says update node_id but instance_id is what getting
> updated.

Will fix.

Thanks for the review!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
