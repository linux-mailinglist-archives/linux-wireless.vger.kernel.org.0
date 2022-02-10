Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1134B0681
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 07:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiBJGnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 01:43:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiBJGnu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 01:43:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE447D6D
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 22:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C81761CD8
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 06:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD109C004E1;
        Thu, 10 Feb 2022 06:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644475431;
        bh=pXQiyMaauFh8Bj8MjlVGhSxfr8jsid80WwPF8tabY/Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qM7Rz7GcSXowP0Z0iHfglJSlwIZfWr7W5yJdLHYKdhJKAtqKoZKUFve6jiKBT2nLK
         UpOtKzk+irJB6EJpGs6Ih3odeYb88VFf/PFGtosGM84xtxHx/hj+mKwqNLazu1yrcL
         c/bVSdKctHmhhpWCfuSoHCHMiJcPWawNsN2pS6YpKFaIDQ88QdlNOF//eWIdGhiIPf
         iPS5RdIurLcpRrxIqcOSqi7g8hJZP7x/eYDxYS7C8Didj/zQsP+uRYwlJ64r0PJp/U
         /daOKNzoB4O9FhRiTc1o1htCS0sqcMLlBzgniQUUBixnmhl5Wy3AM5tJ/gEYptZ2HV
         GLkc8qoRjS+0Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Carl Huang <quic_cjhuang@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] ath11k: Add basic WoW functionalities
References: <1644308006-22784-1-git-send-email-quic_cjhuang@quicinc.com>
        <1644308006-22784-2-git-send-email-quic_cjhuang@quicinc.com>
        <23784b65-745a-b269-74c9-172d414ed752@quicinc.com>
Date:   Thu, 10 Feb 2022 08:43:49 +0200
In-Reply-To: <23784b65-745a-b269-74c9-172d414ed752@quicinc.com> (Jeff
        Johnson's message of "Tue, 8 Feb 2022 12:55:10 -0800")
Message-ID: <87r18brzkq.fsf@kernel.org>
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

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 2/8/2022 12:13 AM, Carl Huang wrote:
>> Implement basic WoW functionalities such as magic-packet, disconnect
>> and pattern. The logic is very similar to ath10k.
>>
>> When WoW is configured, ath11k_core_suspend and ath11k_core_resume
>> are skipped as WoW configuration and hif suspend/resume are done in
>> ath11k_wow_op_suspend() and ath11k_wow_op_resume().
>>
>> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>>
>> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>
> Carl your S-O-B should be last since you are submitting the change

I can fix that. Should I also add Co-developed-by tags for Baochen and
Wen?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
