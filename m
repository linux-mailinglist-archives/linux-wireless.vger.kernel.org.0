Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B885FAF15
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJKJIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 05:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKJIo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 05:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D61182C
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 02:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E58061162
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 09:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17554C433C1;
        Tue, 11 Oct 2022 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665479322;
        bh=V07c6zERjtkGzCyja5fYGKCrw2kdM5CZDpl2KPEbxi8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NJ/Y9oX5WGsnB0nZbiY/HTUxU3UDYROI6xe/whhhJ+t9Kaq7rXFCXaI5xlc9w8uKR
         Ks1VX6c5G5XPoDFtlosoBivJ2nq79YQiYko+zsHG95C5nvAENGYRUOHcg+lZa0Lzyt
         F8Arbh4FHgiLIF6fdbhaOklklWdPjqFCbKsbvRGZ9Q5GdvvmTulcyH0v4aUUASdGrc
         82I5D1BxvldNEvRsSkTx+gX8cvfVafMgMAdbDt0cir/2Q4wLHoqzgSEAtm8Gos5h4f
         qFph11900KX/MCeTck5Xz2Phxo+6cd8T5WPDWAWKvqfl+P9yN2B2+ny/oTmAqDsRYn
         /CFTSRzC9DXZg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] wifi: ath10k: Delay the unmapping of the buffer
References: <20220816044310.19101-1-quic_youghand@quicinc.com>
Date:   Tue, 11 Oct 2022 12:08:36 +0300
In-Reply-To: <20220816044310.19101-1-quic_youghand@quicinc.com> (Youghandhar
        Chintala's message of "Tue, 16 Aug 2022 10:13:10 +0530")
Message-ID: <87lepmohgr.fsf@kernel.org>
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

Youghandhar Chintala <quic_youghand@quicinc.com> writes:

> We are seeing a corner case where host receiving copy completion for WMI
> command though copy engine is processing it. Once host receives the
> copy completion, host is unmapping corresponding memory which results
> in SMMU fault. To avoid such conditions though host receives copy
> completion, as a work around we are adding a delay to unmap the memory
> for WMI end point.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>

Please describe the actual bug in more detail (symptoms etc). Basically
I would like to see information so that if there's a bug report I can
easily pinpoint that this patch fixes it. Currently I have no idea how
this bug affects the users.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
