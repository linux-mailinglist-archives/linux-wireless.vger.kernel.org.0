Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2976A4147
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 12:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjB0L7I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 06:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjB0L7H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 06:59:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF523C14B
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 03:59:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 743D960DD4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 11:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCC1C433D2;
        Mon, 27 Feb 2023 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677499145;
        bh=J1blplwPa0aZoNLKPB/GZBMFK3yDQyV1wzJAbyyKUGE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cApfinZDsVDBAJakIKHuMjjVGGZ8fEeMzdQ8A7dzPCgn3YcyJpIN4OZOhqnwZrHFm
         t1OnoB9W4h/+O81ScOWocmGkOHIUCp02mv4KiYx9XgUN/5h+le11ptAaYdSEjQ8ICY
         F1MAugrtUmbXRd8F1jbszNDgN72UAuGpG0OecXQPMFTgMyjvZuaGERaNEE71QF1vP3
         aU68PzfNswzj6WTsVLnwBWbHx2tNB4cFzLi1FyU5P2g6g113PphIQCLASMYa61urcE
         +EapjoGuSY3KN2pDh7MCgRY1YCKgH2q9w3GAjqo00Rcf096x6KGAz/5O0Q9zCUN9dl
         DJqQkxVgOQcow==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] ath11k: Enable low power mode when WLAN is not active
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
        <20230203060128.19625-4-quic_mpubbise@quicinc.com>
        <87cz5zruc6.fsf@kernel.org>
        <9efc2082-d46d-5d57-d275-1cb47277f639@quicinc.com>
Date:   Mon, 27 Feb 2023 13:59:02 +0200
In-Reply-To: <9efc2082-d46d-5d57-d275-1cb47277f639@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 27 Feb 2023 16:19:08 +0530")
Message-ID: <87v8jnqpyx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

>> Also I want to mention that I suspect eventually we have to always power
>> off the firmware during suspend to get hibernation working:
>
> This patch will power off the firmware for WCN6750. I'm not sure how
> to get that working for other ath11k devices.

Oh, I didn't release that. If you can, try to clarify the commit log on
this part. For example, "for suspend we run command FOO_OFF which means
that the power from the firmware is complete turned off". Or maybe just
read them too hastily, but still having clear (and simple) commit logs
help understanding the issue.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
