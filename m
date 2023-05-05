Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96E6F836B
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEENBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjEENBi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 09:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4101E988;
        Fri,  5 May 2023 06:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57DDD63DE1;
        Fri,  5 May 2023 13:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31970C4339B;
        Fri,  5 May 2023 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683291695;
        bh=/jJRR7zmYd2NwUUaRgBBZHi/LSaazlrrBn7yHDLa/LU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t/mbZcq+P0886LZVkw2H1mTTOmyup06UBoiSTdWhIW6Pn6ti/K1wrQluxmIYHiFX/
         Z6FgPgYD8y39GyFjDQSwKPs5E9q8akELmhuy6/C30zOz6E6QbpX09JfjrNgpkBVJo3
         v7n5MDbBuyMfZdrYXOk+WApl27ejJx/RxVFnvu3xea9Pr+Nw9Fsvdel9d9vurJuakS
         CDMCra2j+xn6DXRQqMJJlRuDmxAFX5Y3Z2toQDTG4zyQH50hs+mXV04eFVZlzrOkiv
         zq0mlLy21GDgKPClAGK8mSRk+kr1Q/I90ANi4oH4NLMHNqN76yucZXW6dY3nitoEh5
         m6RzZgD6N6qsQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Serialize wake_tx_queue ops
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230323165527.156414-1-alexander@wetzel-home.de>
References: <20230323165527.156414-1-alexander@wetzel-home.de>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgens?= =?utf-8?q?en?= 
        <toke@toke.dk>, Alexander Wetzel <alexander@wetzel-home.de>,
        Felix Fietkau <nbd@nbd.name>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168329168628.4336.2281740515872835038.kvalo@kernel.org>
Date:   Fri,  5 May 2023 13:01:34 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> wrote:

> Serialize the ath10k implementation of the wake_tx_queue ops.
> ath10k_mac_op_wake_tx_queue() must not run concurrent since it's using
> ieee80211_txq_schedule_start().
> 
> The intend of this patch is to sort out an issue discovered in the discussion
> referred to by the Link tag.
> 
> I can't test it with real hardware and thus just implemented the per-ac queue
> lock Felix suggested. One obvious alternative to the per-ac lock would be to
> bring back the txqs_lock commit bb2edb733586 ("ath10k: migrate to mac80211 txq
> scheduling") dropped.
> 
> Fixes: bb2edb733586 ("ath10k: migrate to mac80211 txq scheduling")
> Reported-by: Felix Fietkau <nbd@nbd.name>
> Link: https://lore.kernel.org/r/519b5bb9-8899-ae7c-4eff-f3116cdfdb56@nbd.name
> CC: <stable@vger.kernel.org>
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b719ebc37a1e wifi: ath10k: Serialize wake_tx_queue ops

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230323165527.156414-1-alexander@wetzel-home.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

