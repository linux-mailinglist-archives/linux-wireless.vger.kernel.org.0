Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1978420D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjHVN2C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 09:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjHVN2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 09:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20752CEE
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 06:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A53A656B6
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 13:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EE1C433C7;
        Tue, 22 Aug 2023 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692710862;
        bh=H3lL4hRz7BWjICYi+JiYCyi4XJOYiVGuW3F+KajnREo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HRqqrVKDb+lhDrsTAvfLnbHvNGpIk8nIymTQhmXvBix6Gbi0FCZ4/f1kekLJ4JV7R
         gwuE+iRfw1WfJXr9X8xjWr9McipV15yxhN8dsbI1bE0mYh+qAf/KHH1yG/EN/08eRf
         X8tGXEvwtDTvNVHEDf33oBU6EPVDQ0O+CuqMb5kwiQ23ptjSJGG4wgFq3B2sKFqAzG
         aL2Xf17yrCA6HXXpWXsdWzej79xSbSXi3rC7+KEQ70AJYzZUOoOREuCp58SPxODkJv
         o0HOgDt/nOE2cfz6TinxF6WVgin+laFENI+m0EIYaXuWfX0Ghc4ZjKcuJy9LUCMWIi
         FPxxEMlhxCRHQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath12k: fix undefined behavior with __fls
 in dp
References: <20230821130343.29495-1-quic_hprem@quicinc.com>
        <20230821130343.29495-3-quic_hprem@quicinc.com>
        <ab94c255-8ac3-4b2a-a7a5-af40058ad6e6@quicinc.com>
Date:   Tue, 22 Aug 2023 16:27:39 +0300
In-Reply-To: <ab94c255-8ac3-4b2a-a7a5-af40058ad6e6@quicinc.com> (Jeff
        Johnson's message of "Mon, 21 Aug 2023 08:27:53 -0700")
Message-ID: <877cpni4vo.fsf@kernel.org>
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

> On 8/21/2023 6:03 AM, Harshitha Prem wrote:
>> When max virtual ap interfaces are configured in all the bands
>> with ACS and hostapd restart is done every 60s,
>> a crash is observed at random times because of handling the
>> uninitialized peer fragments with fragment id of packet as 0.
>> "__fls" would have an undefined behavior if the argument is passed
>> as "0". Hence, added changes to handle the same.
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7
>> devices")
>
> this should be in the last section with the Signed-off-by
>
> see
> <https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes>

I can fix that in the pending branch, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
