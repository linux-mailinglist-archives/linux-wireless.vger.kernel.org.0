Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D46FBEBA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 07:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEIFad (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 01:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIFac (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 01:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336799027
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 22:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B42C064423
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 05:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59091C433EF;
        Tue,  9 May 2023 05:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683610230;
        bh=tfK56c7AYEPmr0e77RaY2s4xdbpEAsF0d7sMOIndBZo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bJmmN1zvlYTH3Rp9Ked3zBrBDB/9mp0ht2SH4fipxUgUDmOh0Z5CDAg7NdMzQ5ro8
         9E9ToLIX+T4+6Khk+GlSGaE5DeBDtdOkwaLWwPL8XXDgFq71fA7PvE3wKEHmyvOB7w
         aeiD/729P3vYw9bgZIKUP+5cIoqeN9n019pR2Fa1O/0gVYIU/RaVmZnZiUQDrxgZ9M
         vNyKy/f2L7+jnSbY/jyscOPsVJJQ9IlCIrgIsR1nZdfJpkmjOt3EAlpz06AZ3cNzms
         vcuqbL5eOo8F91F09vlvmsHUIS4oA5GGDoumNryw+VYTZ9eOqtLRls1tQzxVbS60YX
         LdSJeGUq8ypMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Use msdu_end to check MCBC
References: <20230427013021.29792-1-quic_bqiang@quicinc.com>
        <87zg6rqnhv.fsf@kernel.org>
        <b0321483-ae4e-c44f-ed41-4a83e8693f09@quicinc.com>
Date:   Tue, 09 May 2023 08:30:23 +0300
In-Reply-To: <b0321483-ae4e-c44f-ed41-4a83e8693f09@quicinc.com> (Baochen
        Qiang's message of "Tue, 9 May 2023 11:42:43 +0800")
Message-ID: <87ednqnkb4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 4/29/2023 1:13 PM, Kalle Valo wrote:
>
>> New warnings:
>>
>> drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast to restricted __le32
>> drivers/net/wireless/ath/ath12k/hal.c:892:16: warning: cast from restricted __le16
>>
>> Please remember always run ath12k-check (with sparse installed).
>
> Hi Kalle,
>
> I have sent v2 where I change __le32_to_cpu to __le16_to_cpu which
> should fix this warning.
>
> But I can not find ath12k-check, where is this tool? Could you help
> point out?

It's here:

https://github.com/qca/qca-swiss-army-knife/tree/master/tools/scripts/ath12k

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
