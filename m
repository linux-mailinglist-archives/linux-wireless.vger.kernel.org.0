Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27137A8394
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjITNim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjITNik (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:38:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6CDE
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:38:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D35C433C8;
        Wed, 20 Sep 2023 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217114;
        bh=XauREkdUDckz8leh4QeQjsODnulH8uUzRvYFx3cwuv4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VzCeMHxVM5XJimhQFHEEhmZ0PPfCAr4P8XqbawZLIpLZFHIG4SdGjFC8oeYEcvlqm
         wsZJr/TW/RsS6iN/Us86qfBizt3riShY5walDgFYAGXG2qfxkDWbCsZpbZ765UNoFx
         TPGxmkcCvkjmXVKjCfMN5fvHYi3i8M0UPGn+KVLg7F4jYT8P8TtLTrASey/2BIf3Ou
         aIyJ7JfHmQzJtYwkZgDhAFupEGQDMoCZoH/oejBcG48+Ni3E5zNRV8UiTtTyYO16Dm
         4bMxnS8dEqS4g3f2KU2AK0ddSIIdmAvwz5QPImx+gZGFNKOZrfEG2A6vkplZjDi+Rl
         xUwWYQCG6Cw8Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix possible out-of-bound read in
 ath12k_htt_pull_ppdu_stats()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230901015602.45112-1-quic_bqiang@quicinc.com>
References: <20230901015602.45112-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521711198.1118199.13181861616088470480.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:38:33 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> len is extracted from HTT message and could be an unexpected value in
> case errors happen, so add validation before using to avoid possible
> out-of-bound read in the following message iteration and parsing.
> 
> The same issue also applies to ppdu_info->ppdu_stats.common.num_users,
> so validate it before using too.
> 
> These are found during code review.
> 
> Compile test only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1bc44a505a22 wifi: ath12k: fix possible out-of-bound read in ath12k_htt_pull_ppdu_stats()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230901015602.45112-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

