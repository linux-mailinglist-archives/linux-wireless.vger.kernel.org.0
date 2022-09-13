Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291855B6869
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiIMHOW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIMHOV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 03:14:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF220F76
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 00:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F989B80AFA
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 07:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531AAC433D7;
        Tue, 13 Sep 2022 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663053258;
        bh=3IAaG5i9BMfJkmrzHP9UDz6S0XKdAG3s8OWpc/wy6eY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=g/YkRIyA4ttkdZ3mOAFMSN5lOo5mfIgrGn0BA4eLFGYGzy5bgqNbdmImkku4mntg3
         rZmOJlZgk75Yi8PUYz7WMAdW6UWLkp0zo3KtwBvQsqJiQbynnJAMGfr9hrTHt0SDNT
         pYzuy75Le3/s9JNukeOxtXt2AqlSLJKbldoWkej6jWsnUNC3XTsdws2P1Ul4/Y6aVi
         ChOosgNwdCkM3CKEfmil8J8OFsfR0DLVmXrPL3oH9IwYCW3YP2HNRQfcSBE0yxm/Pw
         o1+W2qZVsJdOUYKeHKs8C1eTrVFNhk0Pm9PZRFKKJztVFDrxAzMCpO8oORvUDhtVsd
         awdhvzafw+o1A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] wifi: ath11k: Implement sram dump interface
References: <20220802075533.1744-1-quic_bqiang@quicinc.com>
        <20220802075533.1744-3-quic_bqiang@quicinc.com>
        <87fsh0962e.fsf@kernel.org>
        <0e64e270-77c3-5c1a-08bc-577a82c8abac@quicinc.com>
Date:   Tue, 13 Sep 2022 10:14:14 +0300
In-Reply-To: <0e64e270-77c3-5c1a-08bc-577a82c8abac@quicinc.com> (Baochen
        Qiang's message of "Tue, 13 Sep 2022 11:06:33 +0800")
Message-ID: <87pmfz7nll.fsf@kernel.org>
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

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>>> +	u32 i;
>>> +
>>> +	/* for offset beyond BAR + 4K - 32, may
>>> +	 * need to wakeup the device to access.
>>> +	 */
>>> +	wakeup_required = test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
>>> +			  end >= ATH11K_PCI_ACCESS_ALWAYS_OFF;
>>> +	if (wakeup_required && ab->pci.ops->wakeup) {
>>> +		ret = ab->pci.ops->wakeup(ab);
>>> +		if (ret)
>>> +			ath11k_warn(ab, "%s: failed to do wakeup: %d\n", __func__, ret);
>>> +	}
>>
>> I changed the error handling so that if wakeup() fails we do not
>> continue and just return an error.
>
> I prefer to keep the original design, because in that case we still
> have something to check after firmware crashes.
>
> I admit that the dump content may be invalid if wakeup fails, but we
> can know that by checking kernel log, so we can avoid misleading.

Too late now, I already applied the patch. You need to submit a new
patch to change the logic. And if we really want to ignore the wakeup
failure there should be a proper comment in the code explaining the idea,
and maybe improve the warning message to make it more understandable for
the user.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
