Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F92621791
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 15:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiKHO7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 09:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiKHO7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 09:59:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6555B1263F
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 06:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0099A615FA
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 14:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECB0C433C1;
        Tue,  8 Nov 2022 14:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667919544;
        bh=vFhIltWmITKlHXvJoUUzOLAmI85IxHcQqbjPo2Zb26U=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=enLKWTwToJk/L3Sx/KGmVCkGwv/JruAl9xbGc68tTZHIPSGA66ZD5mjMFH/Aczmut
         vFTn0V/8s0rYrqnz93jqBOkTsbl+auq0U7pV3Rft2fBaS9IwO3jRw5dphpQpVY+Qo0
         LeMVmavPArt7KH4m1RSV5+Vjdd2lVipbPfbjbu/502ET6afEnzkomNgk9wZUd3iA9d
         nqnLQtiVDd03EX9THs3MRDhHPXrszhggEmqgeVacU0GV7156BS0PYqLjCw6td6n1m1
         I4L2pjaZyzXWGg+/M0IC9qQH8+RDp+DCea1YeO1LIShlh+B/4VcQBiIZ8wxvi8g/Ed
         QZHirEsNSwbaw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 39/50] wifi: ath12k: add qmi.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-40-kvalo@kernel.org>
        <30a097d8-d084-2a1e-f067-bb7a303968da@quicinc.com>
Date:   Tue, 08 Nov 2022 16:59:01 +0200
In-Reply-To: <30a097d8-d084-2a1e-f067-bb7a303968da@quicinc.com> (Jeff
        Johnson's message of "Mon, 22 Aug 2022 10:14:17 -0700")
Message-ID: <87v8npcx1m.fsf@kernel.org>
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
>>   drivers/net/wireless/ath/ath12k/qmi.c | 3305 +++++++++++++++++++++++++++++++++
>>   1 file changed, 3305 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c
>> b/drivers/net/wireless/ath/ath12k/qmi.c
> [...]
>> +static struct qmi_elem_info
>> qmi_wlfw_qdss_trace_config_download_req_msg_v01_ei[] = {
>
> FYI I've submitted a patch which will allow these to be const:
> <https://lore.kernel.org/linux-arm-msm/20220822153435.7856-1-quic_jjohnson@quicinc.com/T/#u>

Thanks, I'll fix this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
