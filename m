Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E86217A6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiKHPG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 10:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiKHPG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 10:06:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D994B1834F
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96032B81B1B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 15:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7256BC433D6;
        Tue,  8 Nov 2022 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667920013;
        bh=u1C3QwRl3T4Sh0lHCyPvLvwdjoMtrYW+/j3HiFizy9s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OcXhl2Ng0t1yvwqkf76jvkYSjXvqAyu0/LiVmN3CSGmUiWVG+SyeIKebeuXvBUL2J
         3u6Jc8xP1ysPhjdQJLY6TqzC3fr2cqZtbwirtKhpexEu2CG/TEn5W7b/Bn8wR8C0ik
         HPVWYQ9Zti4JoOkrqcKVFxs0xvhqAhRGmAjOSjrp01QPNTFAeRXyFu5ObxuN/9G1y8
         eSkKZL8LqDx2Rv7uLai5NYXed3idmKV8aqw8AqyENYNEQTG2dT8q1crWumaEARk7ae
         3HRpznqZ4qgHT5Kd4QbUXsjVeU4xEIrc2tc228+Re5HIC1XUsONmG36rDI75dbiplS
         g56P4MM84jWhg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 40/50] wifi: ath12k: add qmi.h
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-41-kvalo@kernel.org>
        <f6e2c694-4803-be69-ec05-08541b718b8f@quicinc.com>
Date:   Tue, 08 Nov 2022 17:06:48 +0200
In-Reply-To: <f6e2c694-4803-be69-ec05-08541b718b8f@quicinc.com> (Jeff
        Johnson's message of "Thu, 18 Aug 2022 17:25:42 -0700")
Message-ID: <87r0ydcwon.fsf@kernel.org>
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

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/qmi.h | 610 ++++++++++++++++++++++++++++++++++
> [...]
>> +struct qmi_wlanfw_ce_tgt_pipe_cfg_s_v01 {
>> +	__le32 pipe_num;
>> +	__le32 pipe_dir;
>> +	__le32 nentries;
>> +	__le32 nbytes_max;
>> +	__le32 flags;
>> +};
>> +
>> +struct qmi_wlanfw_ce_svc_pipe_cfg_s_v01 {
>> +	__le32 service_id;
>> +	__le32 pipe_dir;
>> +	__le32 pipe_num;
>> +};
>
> curious why the above two structs use __le32 definitions but none of
> the others do. I thought the QMI interface would use the qmi_elem_info
> to properly encode/decode in host order on both sides of the pipe and
> hence we should expect host order on both sides

That is a good question, I was also expecting QMI to be in host order.
In ce.h I see this:

/* Establish a mapping between a service/direction and a pipe.
 * Configuration information for a Copy Engine pipe and services.
 * Passed from Host to Target through QMI message and must be in
 * little endian format.
 */
struct service_to_pipe {
	__le32 service_id;
	__le32 pipedir;
	__le32 pipenum;
};

But I'm not convinced about that comments. Thoughts?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
