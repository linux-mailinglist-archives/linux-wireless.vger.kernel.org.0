Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63D96A1FED
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBXQpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 11:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBXQpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 11:45:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B3E2BF17
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 08:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66FB4B810B2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 16:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E9AC433EF;
        Fri, 24 Feb 2023 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677257111;
        bh=2yTUKRx3XdLapW50dJNmgYDP6iZpEONSnnN1j1EwVsA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=VUDxlDhEXSR/CIV9onvNhNdYi2NFqBTalBqDt+S0ZeUcx9+X5ogLsW2B/NvR8esTc
         1lXwHVXlM0mbYhonGYIYjLUGSIv4iqYVvJRhthBp7Awgb/iwFgl8THhmODcetdSQuh
         sdRulyLyZSFT7eQAs8XRJNFAEWRXLSLPbbDa+wZKTQFggxTFy1slZfz/hwU4Ln8q4e
         XAO9JOUoG1pNE3O8ZGvXsaV9j6Q0mFFEG01e83zvrppdZrWSTDeWhI/4I0CD6r8SEW
         EDivBwS1g8m2N48bkyoMwKM+9CVHceeTjsk35KTP1MASaj/5S8WXYRXUE8paFS5rVt
         /7dW3+8o4ZHaw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Howard Hsu <howard-yh.hsu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.Lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7915: rework init flow in mt7915_thermal_init()
References: <20230223062457.342-1-howard-yh.hsu@mediatek.com>
Date:   Fri, 24 Feb 2023 18:45:07 +0200
In-Reply-To: <20230223062457.342-1-howard-yh.hsu@mediatek.com> (Howard Hsu's
        message of "Thu, 23 Feb 2023 14:24:57 +0800")
Message-ID: <878rgn2ess.fsf@kernel.org>
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

Howard Hsu <howard-yh.hsu@mediatek.com> writes:

> If kernel do not enable CONFIG_HWMON, it may cause thermal
> initialization to be done with temperature value 0 and then can not
> transmit. This commit fixes it by setting trigger/restore temperature
> before checking CONFIG_HWMON.
>
> Fixes: 7d12b38ab6f6 ("wifi: mt76: mt7915: call mt7915_mcu_set_thermal_throttling() only after init_work")
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>

Was this supposed to go to v6.3?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
