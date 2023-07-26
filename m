Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2D8762C19
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 08:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGZG6H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGZG5q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 02:57:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1892700
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 23:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4B96142E
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 06:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54865C433C8;
        Wed, 26 Jul 2023 06:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690354636;
        bh=xHlm5bWMUQRL1QFrdtVePyYirEwMmuuFHBU4VTFFaAs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TLXto8tPa+qYK1hudIzzA9cAn3Vl8T7PkUdFfUh8boNtASqEQI2lH2sJl7ky6b6zv
         9PDqus61KcI8DmMPZV+c40J4CfqS2yb6ni5tV3Jgl0YSYdiuf0b3ogj8IXUwjKztjT
         omFySydNduyhCi3lPra42a7LHefRmtI9wDf+ZNq9kHZHdtSM9IRBQCGaxnhk3dbW4a
         n73zHTvmtfFAQg1zd77HkIYHKxF6Y6pLF3UdkRzm/aKSnBNCrkLlo/QeHRcyopwrDt
         2JIqfDzw44BvxFtMtU9b9eFTZXA5imbNfGmb1tWuEo7gxn1ajnZ0DL9cUsiH3GmiTZ
         aDa4kPFnYCDQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6.5] Revert "wifi: ath11k: Enable threaded NAPI"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230720151444.2016637-1-kvalo@kernel.org>
References: <20230720151444.2016637-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169035463311.3467307.11151341644167452252.kvalo@kernel.org>
Date:   Wed, 26 Jul 2023 06:57:15 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> This reverts commit 13aa2fb692d3717767303817f35b3e650109add3.
> 
> This commit broke QCN9074 initialisation:
> 
> [  358.960477] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 36866
> [  358.960481] ath11k_pci 0000:04:00.0: failed to send WMI_STA_POWERSAVE_PARAM_CMDID
> [  358.960484] ath11k_pci 0000:04:00.0: could not set uapsd params -105
> 
> As there's no fix available let's just revert it to get QCN9074 working again.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217536
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to wireless.git, thanks.

d265ebe41c91 Revert "wifi: ath11k: Enable threaded NAPI"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230720151444.2016637-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

