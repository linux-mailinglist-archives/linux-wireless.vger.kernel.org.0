Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCBD5FD694
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJMJET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJMJES (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 05:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C442B10CFAE
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 02:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CD661738
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 09:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92020C433D6;
        Thu, 13 Oct 2022 09:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665651856;
        bh=/mPI/uw75aDViFfpPoodmj+vuy+4nn0QsyLu+/OLL2g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Dh6CX5VmT+/b6+CLVueMSqizJAEr7+8k9xZJn+8RRvCOEN2hb0bARtLR6XIs73Dxn
         REzyRE/1K0PSoYZqV3HrP7avAmh4WTDNCGZNbZ1rynUfuiyEFy1dRDErAD9P25x2QE
         LFHVIY6+d39DCmQDz/mlRpVFfZSiFnC/JIGVuH+ib8/Po5f6p7j+cBAybe5M4VL/yp
         jSg2+++3V4JoBB84lRguVNM4Ez4vNnexKMXn/X8E4uLOXDqQqGYjoBTg1tpAXlqzh5
         rdms+3dGKLUl22sM+0zhTljlQeL0bwzQZHKYrUias/NCRTSKKp4HiE/X4kcrr1kS/5
         fV62E5URYIm2g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com,
        daniel@makrotopia.org, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] wifi: mt76: introduce WED TX support for mt7986 SoC
References: <cover.1664356281.git.lorenzo@kernel.org>
        <87r0zd4mxw.fsf@kernel.org> <Y0aH8T8pTARNWcPE@lore-desk>
        <87zge0memc.fsf@kernel.org> <Y0fQ0f3uy5p9f2mP@lore-desk>
        <3b029dc7-054b-3510-f159-de6622d8ce01@nbd.name>
Date:   Thu, 13 Oct 2022 12:04:10 +0300
In-Reply-To: <3b029dc7-054b-3510-f159-de6622d8ce01@nbd.name> (Felix Fietkau's
        message of "Thu, 13 Oct 2022 10:50:49 +0200")
Message-ID: <87v8oom6wl.fsf@kernel.org>
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

Felix Fietkau <nbd@nbd.name> writes:

> On 13.10.22 10:48, Lorenzo Bianconi wrote:
>>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>>
>>> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>> >> >> > Enable WED TX support for mt7915 and mt7986-wmac drivers
>>> running on MT7986 SoC.
>>> >> >> What's WED TX?
>>> >
>>> > It is the same as we did for MT7622. It is the capability to offload traffic
>>> > from lan/wan to wlan. I specified "TX" since MT7986 supports even RX
>>> > offloading (I am working on it at the moment).
>>>
>>> It would be nice to mention in the commit log that the feature is about
>>> offloading traffic from lan/wan to wlan. That way it's stored to to git
>>> history and people like me have some clue what the patch is about,
>>> otherwise we are totally in dark.
>>
>> I think Felix has already applied them.
>> @Felix: are you taking care of it or do I need to repost?
>
> No need to repost - just send me the description that you want to put
> in there, and I'll update the commit.

Thanks. And if it's too much work to change it feel free to keep it as
is. Just try to keep this mind in the future when using exotic acronyms :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
