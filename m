Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43C76E6ED
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjHCLc3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 07:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjHCLc1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 07:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9F1FCB
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 04:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628F561D29
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 11:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F0AC433C8;
        Thu,  3 Aug 2023 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062339;
        bh=2mgGVC2Dfs7rGuoAE5V9tx/SPrTMRLD/AfsO+GTjpTI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HiX0gQleE28pWg1ATJ5Anxo5m1b3U4oe4myCn0Ux9C/9gkdmBTynMVkV//dn3cZjV
         iQOxHR7vjpGq2wET7Hue9xS/Ot8YklCZCAf3jCBrrP42t179BIM8dKgEv0nyRyNSrQ
         XcBObVQV33w2opNKEMVWn1VNhTmmUH+GiGQJpNatl5lktysnB+j9Tzl4CSWeNg65SW
         W6Imemh1QF680itn99b8o9NR7xKObZLGe1NhE3zZUuixKlFdC4FhX12nBnizWqAvA0
         ff1c5JO4/kUKinxO7fvorrYO6nvQLp01oewOXjdZOyAaWcxfvCbLULh0mrYpcxsOvq
         88L/C8ycNNQ2A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] wifi: ath12k: configure RDDM size to MHI for
 device recovery
References: <20230721055305.20420-2-quic_wgong@quicinc.com>
        <169105464227.894438.15435946207134709277.kvalo@kernel.org>
        <1bbe5e90-1f37-3926-98f7-a685578fef8f@quicinc.com>
Date:   Thu, 03 Aug 2023 14:32:17 +0300
In-Reply-To: <1bbe5e90-1f37-3926-98f7-a685578fef8f@quicinc.com> (Wen Gong's
        message of "Thu, 3 Aug 2023 17:40:39 +0800")
Message-ID: <87msz8tl8e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 8/3/2023 5:24 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> wrote:
>>
>>> RDDM is RAM DUMP DEBUG module, it is used to debug issues when firmware
>>> encounters an error.
>>>
>>> The rddm_size is needed by firmware while MHI enter RDDM state. Add it
>>> to support device recovery when ath12k receive MHI_CB_EE_RDDM message.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI
>>> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>>>
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> I'm not sure what "support device recovery" means exactly. How does this patch
>> change functionality from user's point of view?
>>
>> No need to resend because of this, I can add that to the commit log.
> Device recovery means SSR(subsystem restart), when firmware happen
> crash, ath12k
> will receive the RDDM event, and then ath12k/mac80211 begin to
> re-start wifi/firmware,
> after that, the wifi become normal again.
>
> This patch is to let firmware report RDDM event correctly to ath12k.
> Without this patch,
> firmware will not report RDDM event to ath12k correctly, then ath12k
> will not begin SSR
> process.
>
> I think it should be changed like this:
>
> The rddm_size is needed by firmware while MHI enter RDDM state. Add it
> and then firmware will report MHI_CB_EE_RDDM correctly while firmware
> encounters an error, then ath12k could start the device recovery process.

How about this:

"RDDM is Ram Dump Debug Module which is used to debug issues when the
firmware encounters an error. The rddm_size is needed by the firmware
while MHI goes to the RDDM state. Provide the size to MHI subsystem so
that the firmware restart works when the firmware crashes."

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
