Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3F4E4F3B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 10:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiCWJZd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCWJZd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 05:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021081B7B4
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 02:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9938E617DF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 09:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F87C340E8;
        Wed, 23 Mar 2022 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648027443;
        bh=LkQSu4GtbjtlPRibNiKuRI3ET6kmKXw/PY8GIRgQhPo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=chS3gRFQHMctCTHBquOoTQB/tVIt9yErI5uWb3Co3Jckt3im4cjxvWkJwRiiNIAWj
         KmdEj5vKv6rx0ckGNVh/36xlQGXpXjTqIboKmiwTZaCBxVNINMYPHd3cGxPK3qmdZf
         OSoSveupnDpVGRixXlNMB8z+k7UTW6IxSMp/1L8FtonDmqNRGnp1Ut6zMSESZkfcZr
         R7Ea94OA9muS33deWk0tud4TRT3YgI7dHBQQttP12545wz0sAdwmPdnE2S4qyafwpv
         MnOsmJZCed9WpmT9gKzX/ZWVbahxLZRcb4ExC4YgCxE7yZLPVDzRg06MRzB4YGu4KX
         W8L+S2O8xLKAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: store and send country code to firmware after
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220322032224.11382-1-quic_wgong@quicinc.com>
References: <20220322032224.11382-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164802743902.26958.7086724509485424560.kvalo@kernel.org>
Date:   Wed, 23 Mar 2022 09:24:01 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently ath11k does not send the country code to firmware after device
> recovery, as a result the regdomain info is reported from firmware by
> default. Regdomain info is important, so ath11k also need to restore
> it to the value which was used before recovery.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Failed to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:619
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220322032224.11382-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

