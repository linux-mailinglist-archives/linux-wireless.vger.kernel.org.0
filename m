Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08678814C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHYHyR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbjHYHxt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B1CF1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F86E62E69
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0ECC433C7;
        Fri, 25 Aug 2023 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692950026;
        bh=KOzRnaC44+Xlhg47OtXM9sPc7szh93iPq2k6FzlXDMI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mXhm/f1FO8Tc7xtH021mtnaY7iM//JOkkg/jY194PRLKCjVar6RkJwMRGXfWXVO/a
         Ky4ot7sM/jn2dzIxdvApbK+dzO4D4Rwz5WM14Q9yZO4pb+qaOI4rniLhqYnyLPEO+1
         vyOndbP2p/6jWVgcqDujuW+gbR2S7TDelFnK7R0nBx7apYNlD4sLySfKRkVk3Mg9T5
         YYnm8GMX8nuvutG2FuyiWRmS6DdNxVDDDeByp2ckML1dK6glcA4VhyMCYpajtXzE1y
         QppNiHpWJkXNa8xOJdUjzmZgGLZrCH5hCgQ3hmOdC4DY0pzVMBtFwA/LW6HfoQzTvX
         aiUK60dmJ49Eg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band
 in
 EHT PHY capbility for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230824025432.19406-1-quic_wgong@quicinc.com>
References: <20230824025432.19406-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295002356.1753110.7150166655358699685.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 07:53:45 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> 320 MHz bandwidth is reported only for single PHY mode for WCN7850, get it
> from WMI_HOST_HW_MODE_SINGLE ath12k_wmi_caps_ext_params and report it for
> 6 GHz band.
> 
> After this patch, "iw list" show 320MHz support for WCN7850:
> EHT Iftypes: managed
>         EHT PHY Capabilities: (0xe26f090010768800):
>                 320MHz in 6GHz Supported
>         EHT bw=320 MHz, max NSS for MCS 8-9: Rx=0, Tx=0
>         EHT bw=320 MHz, max NSS for MCS 10-11: Rx=0, Tx=0
>         EHT bw=320 MHz, max NSS for MCS 12-13: Rx=0, Tx=0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

New warning:

drivers/net/wireless/ath/ath12k/wmi.c:4199:69: warning: restricted __le32 degrades to integer

Remember to ALWAYS run ath12k-check.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230824025432.19406-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

