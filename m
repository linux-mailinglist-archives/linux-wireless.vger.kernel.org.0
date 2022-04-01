Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461724EEDF4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 15:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbiDANUe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiDANUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 09:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624645045B
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 06:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10E49B824C0
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 13:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8A6C340EC;
        Fri,  1 Apr 2022 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648819120;
        bh=wrMgiEFWz5tExTwNpneICoem7zquqiVIvT/B0wAxmg8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HwAsSPcYP/q5Ra/mRjWUSbapEZDx1Gcgw83Bappx4TSRaRgjrq4cqle8+AHn/vDq7
         BUwVq+s+oEpKA6np3T7xAPdBzykdGwHn2ebDZZORT8TrbjvVsRoxwfwivrxTGcyktr
         exnZKxi/BmCEIdpupsHOni2KUzURrldArP8M4ysJ08gXVesGH23gKFfzN2DgIiLxTG
         /Y7nr8uTeEnNnVpbSOtWK2k9IdjgUxV/jJKqb8u9XOMniWTcjIYtyDxWj8enIqrTHR
         YhWKUKdyp2iNjeBYAfsNxuBai2VqBXHrhgez8O81HgmFoMOZh/nuBeNsCt2a94YNgw
         NLfJUvL6WpzGw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] ath11k: Add support for SAR
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220401120948.1312956-3-quic_bqiang@quicinc.com>
References: <20220401120948.1312956-3-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164881911553.13354.3859976459020276949.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 13:18:39 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops,
> and this function is called when user space application
> calls NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR
> type and frequency ranges to wiphy so user space can query
> SAR capabilities.
> 
> This feature is currently enabled for WCN6855.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This introduced new warnings:

drivers/net/wireless/ath/ath11k/mac.c:8326: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:8913: No space is necessary after a cast
drivers/net/wireless/ath/ath11k/wmi.c:8920: No space is necessary after a cast
drivers/net/wireless/ath/ath11k/wmi.c:8950: No space is necessary after a cast

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220401120948.1312956-3-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

