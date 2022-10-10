Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585265FA32C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 20:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJJSJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJJSJk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 14:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC82F7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 11:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39AC660BCC
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 18:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E186C433B5;
        Mon, 10 Oct 2022 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665425374;
        bh=RKRZiw0NyczwHRdkeUVJ3EXEp69C4Pd8hlq2i0tQgjs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kNOxzz4WOuJ+CdKRPbUq4cdn2GCElTBzISphZnEXTh+QOiuvh/E9Aeen5tDB2PRPv
         kRd2wJbVfjQCSXX0q0mrkIQS+ehvsJJIy7pXuLv6cr1EWeGKUvb368PkMOaTMZHmUI
         rlOWiszLc+dA5eD91gJUm8D2KMJEx1mqGyPGEY/GpU5ViP63ukrB91ZdHNTqY1ERve
         k78ZH5tq5RAp9b4A4djiWfCJKtASMaSyWfhmREO0OaYwiLKhLECWly2JuaD2ekSa4o
         2YaF1zJQHnIpH+ZcRy5/S8Uw9oTgDAK2+DpK4OikmcfgYAAtcXZYpmFjPq6tgKKvDS
         Mw8Pj9K8EV1zw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath11k: change to set 11d state instead of
 start
 11d scan while disconnect
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220928081413.27339-2-quic_wgong@quicinc.com>
References: <20220928081413.27339-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166542536986.511.1244496445875563981.kvalo@kernel.org>
Date:   Mon, 10 Oct 2022 18:09:33 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When switch to connect to a new AP for station which is already connected
> to an AP, the time cost is too long, it arrives 10 seconds.
> 
> The reason is when switch connection, disconnect operation happened on
> the 1st AP, then 11d scan start command sent to firmware, and then a
> new hw scan arrived for the 2nd AP. The 11d scan is running at this
> moment, so the hw scan can not start immediately, it needs to wait
> the 11d scan finished, it increased the time cost of switch AP and
> even happened scan fail as log below after apply the incoming patch.
> 
> [ 1194.815104] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 1196.864157] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> [ 1198.911926] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
> 
> Change to set 11d state while disconnect, and the 11d scan will be
> started after the new hw scan in ath11k_mac_op_hw_scan(). Then the
> time cost of switching AP is small and not happened scan fail.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Fixes: 9dcf6808b253 ("ath11k: add 11d scan offload support")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I still see warnings:

[ 3627.691737] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 3715.435608] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 3860.333214] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 4542.000955] ath11k_pci 0000:06:00.0: failed to start hw scan: -110
[ 4604.018451] ath11k_pci 0000:06:00.0: failed to start hw scan: -110

2 patches set to Changes Requested.

12991768 [v2,1/2] wifi: ath11k: change to set 11d state instead of start 11d scan while disconnect
12991769 [v2,2/2] wifi: ath11k: reduce the timeout value back for hw scan from 10 seconds to 1 second

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220928081413.27339-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

