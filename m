Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAE69DAA3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 07:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjBUGaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 01:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBUGaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 01:30:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2076241F4
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 22:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8BB60F06
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 06:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9138EC433D2;
        Tue, 21 Feb 2023 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676961013;
        bh=3/5RD5Q4QPKkxlWdnuEfpgaax2HZxVoeKycfaYgHhbE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bLa9LLY7T+Q8Fz8r2NMtHd8hAJd2QOmNDtresOYqQftZ/jAKMJgV9RQB1c+uWqCQf
         E1P/9ITuKJ87i9e/pY1/LYyxtTIoA6AujwkO/8kVomsj/wU20/pNAzMWSMWe6ZVu7W
         ZYbrOSOMfn75M8GlhZv/vcQfhHtzfScXlnjuRsvvj99gQ4RbMV9VzcOx6w4/6gJkzg
         Ib3cUj6/tT2lD+AcdieRtDUseKR8cUV1wXAZZ9bHAxSYTNdPvq5xysvsT62JcQbMsv
         gF/Op/u92praN8hm74FRMN+XKE1QDQW1Tab3+EkggX96ZbdDpqD5nd/ADxpEFrlZGx
         wstt9tPISkIoA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Howard Hsu <howard-yh.hsu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: mt7915: rework init flow in mt7915_thermal_init()
References: <20230221024317.3218-1-howard-yh.hsu@mediatek.com>
Date:   Tue, 21 Feb 2023 08:30:08 +0200
In-Reply-To: <20230221024317.3218-1-howard-yh.hsu@mediatek.com> (Howard Hsu's
        message of "Tue, 21 Feb 2023 10:43:17 +0800")
Message-ID: <87wn4b34zz.fsf@kernel.org>
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

Howard Hsu <howard-yh.hsu@mediatek.com> writes:

> If kernel do not enable CONFIG_HWMON, it may cause thermal
> initialization to be done with temperature value 0 and then can not
> transmit. This commit fixes it by setting trigger/restore temperature
> before checking CONFIG_HWMON.
>
> Fixes: 7d12b38 ("wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work")
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>

Should this go to v6.3?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
