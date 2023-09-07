Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5615797028
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 07:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjIGFkb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIGFka (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 01:40:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8371A4
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 22:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A587FC433C7;
        Thu,  7 Sep 2023 05:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694065226;
        bh=I9zsuRYmffLM0EYhWrlnzmHtKFkhLwFCNBVhQmDXsJs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iBaty8r33cok/YqIQZWOr5yRQ6tst6vd7I2uqVwccJ13r0uai89ZTo6AhqAbh/RbO
         ZUOqoQOVQtIuQaOJQ+4CYoEkmx7ziKVOaM6IgUe1iHioeaCet+Mlf8fXg1ilU4nPdW
         CIfvTDoEO2BOUKIEVNj/YuZOdbIHP8habNYYzu9DRO6dhS4BvGmIQ7s90K1qmSWUDl
         x9R817kkWdt+T57887mLWevuBIFmfuj7diAt9dyf6ong2jq9iM8kAr6z5f/krH+ds8
         uMrWRyEvGKfJr8f8NhQZfcw9FyaqvKz+TQmH5QHwi4ihVOxhIxLcB3JkkRx+DF4LHx
         FtvbcSlpZV6tA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath11k: fix boot failure with one MSI vector
References: <20230907015606.16297-1-quic_bqiang@quicinc.com>
        <ecdcae51-6f31-43f9-a7fd-299f20777263@quicinc.com>
Date:   Thu, 07 Sep 2023 08:40:23 +0300
In-Reply-To: <ecdcae51-6f31-43f9-a7fd-299f20777263@quicinc.com> (Jeff
        Johnson's message of "Wed, 6 Sep 2023 22:06:33 -0700")
Message-ID: <871qfaee2g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 9/6/2023 6:56 PM, Baochen Qiang wrote:
>> Commit 5b32b6dd96633 ("ath11k: Remove core PCI references from
>> PCI common code") breaks with one MSI vector because it moves
>> affinity setting after IRQ request, see below log:
>> [ 1417.278835] ath11k_pci 0000:02:00.0: failed to receive control
>> response completion, polling..
>> [ 1418.302829] ath11k_pci 0000:02:00.0: Service connect timeout
>> [ 1418.302833] ath11k_pci 0000:02:00.0: failed to connect to HTT: -110
>> [ 1418.303669] ath11k_pci 0000:02:00.0: failed to start core: -110
>> The detail is, if do affinity request after IRQ activated,
>> which is done in request_irq(), kernel caches that request and
>> returns success directly. Later when a subsequent MHI interrupt is
>> fired, kernel will do the real affinity setting work, as a result,
>> changs the MSI vector. However at that time host has configured
>> old vector to hardware, so host never receives CE or DP interrupts.
>> Fix it by setting affinity before registering MHI controller
>> where host is, for the first time, doing IRQ request.
>> Tested-on: WCN6855 hw2.0 PCI
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Tested-on: WCN6855 hw2.1 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1

I can fix that in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
