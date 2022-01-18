Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1209E491F69
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 07:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiARGdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 01:33:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43198 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiARGdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 01:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F25096122F
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jan 2022 06:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D75DC00446;
        Tue, 18 Jan 2022 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642487599;
        bh=AuLR7KOtcoYyPTyis6hGqGcPXpIpOlMrvosPBEfyGcE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lz7XSH5wdHFEmpG7085rBsUL7EzhNuGDGx23AlZ2TaN8dPQT/FHtHuvwm+X4kREpc
         /T2WlYOu/zgJWSXsfncvzaj/BVaTkfyoKas6yKnWAevm1TdcCVhfdE3J/jxcM50UfA
         nJf6ALhiuikQKaCbDykIZqG+24cuqH43JsDmDTN3om7XLg8/jy6ZRRhxdSGPAenBJY
         T1g8exfcQxVIQBYJ7uMwsVX712NPFhpxCj6vaFkb4I1mg3Rqmzu367TMeyRgmMgtnA
         0qjFDOBg+q2fiEcO3Tr+iI8MpXn2Km/E0qt4FsJYLHwQ84AIVoLO79P3UobwVHog0j
         eAUvT1j4ZUHjw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: set WMI_PEER_40MHZ while peer assoc for 6 GHz
In-Reply-To: <6ac56fa1-b369-831f-2b1d-9a188b7cbacc@quicinc.com> (Wen Gong's
        message of "Tue, 18 Jan 2022 10:43:15 +0800")
References: <20220113023145.14292-1-quic_wgong@quicinc.com>
        <164242492251.16331.2627237965817574376.kvalo@kernel.org>
        <6ac56fa1-b369-831f-2b1d-9a188b7cbacc@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 18 Jan 2022 08:33:14 +0200
Message-ID: <877daximdx.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 1/17/2022 9:08 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> wrote:
>>
>>> When station connect to AP of 6 GHz with 40 MHz bandwidth, the TX is
>>> always stay 20 MHz, it is because the flag WMI_PEER_40MHZ is not set
>>> while peer assoc. Add the flag if remote peer is 40 MHz bandwidth.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> Fixes tag
>>
>>    Fixes: 2cdf2b3cdf54 ("ath11k: add 6ghz params in peer assoc command")
>>
>> has these problem(s):
>>
>>    - Target SHA1 does not exist
>>
>> Did you mean:
>>
>> Fixes: c3a7d7eb4c98 ("ath11k: add 6 GHz params in peer assoc command")
>
> Thanks.
>
> yes, it is.
>
> I see you have already changed it in master-pending.

Yeah, so no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
