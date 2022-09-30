Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6E5F04D7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 08:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiI3GdT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 02:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiI3GdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 02:33:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3341F65DC
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 23:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 610C0B82455
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 06:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532F4C433C1;
        Fri, 30 Sep 2022 06:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664519594;
        bh=AjE9ttVTxQyrvvGBjQ3K8rHuqcgBsgTiY5i7Op2lqCk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bDJJnYEqYzM4l65RDTROm+w8PISHo921Ac6jWMvAarrMre1y3XGMVkt3JS629UAxx
         VwU/rZ8Z7ZNC7S2ikUdOXGTkxe0fOZ4m6LuwiY2jDdXuh7DoLFwL0lCVoSP2MSWwT6
         oJSftY0DVGukgk/S9lbFfTkPgnIp6nGZtZE6qtQfu8pXj3QNjeycpL9vPMLy3SePyi
         w8BI5IOB7TXo+a5z3aVdDtcS+JKkJ3LKcfwIF2qOVKd4xkdtN838QQBHWVt5QCBjTn
         J9nQ0Nqvi5u2ADHM5JRWLlCid7HMwBTexGVjwyKtW0CCjJXqt+abEioOZYCLjTB+gR
         byspQAAaE/hBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Don't exit on wakeup failure
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220928015140.5431-1-quic_bqiang@quicinc.com>
References: <20220928015140.5431-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166451959112.6083.18119896187567020828.kvalo@kernel.org>
Date:   Fri, 30 Sep 2022 06:33:13 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently, ath11k_pcic_read() returns an error if wakeup()
> fails, this makes firmware crash debug quite hard because we can
> get nothing.
> 
> Change to go ahead on wakeup failure, in that case we still may
> get something valid to check. There should be no mislead due
> to incorrect content because we are aware of the failure with the
> log printed.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

45d2e268369b wifi: ath11k: Don't exit on wakeup failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220928015140.5431-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

