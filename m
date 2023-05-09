Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75D46FCC3E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjEIRD2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 13:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjEIRDM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 13:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB061D2CF
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 10:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FF5D60F4D
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 16:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7769DC433EF;
        Tue,  9 May 2023 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683651563;
        bh=nJ7qm7dCXPLZjsUv2Zv2I3JSUpvWHMqX5gDg8LKZjmc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MID/fIbNlOxp3BXiZ39BIObWwCumMLRBa0r0jPe+3lNBBRbZtNLf+owPIbOZAjYrx
         pZvJ8n0bN7W2AdjxZxwlCmPX5qFtcu1Sc3CMrbSZcCDdmBYdtRli4YzVJDokpoFEU1
         lCg1WGEKBeTbSnwlZ3o1qWf4bX6oB0rB+pxHg9Hu9Ap3pj9/9EX0CYNKN0CCAnu9QB
         4wXsK6jpuMcUdf/hVliUT9gqcBhW/a9veqsWHDT1eezMJvbbpwuD7nQIOS5e3qmoG2
         XGHmjIrayhjD4q2fvhQzQIewZnUU8X8Kf7rW0MvSjWQLbkoQPA9CK9xFAy4BB3v/Lm
         TXsu+GTwoqfzA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/7] wifi: ath11k: driver settings for MBSSID and EMA
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230405221648.17950-2-quic_alokad@quicinc.com>
References: <20230405221648.17950-2-quic_alokad@quicinc.com>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168365155854.21274.2582854709073882511.kvalo@kernel.org>
Date:   Tue,  9 May 2023 16:59:22 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> wrote:

> Advertise the driver support for multiple BSSID (MBSSID) and
> enhanced multi-BSSID advertisements (EMA) by setting extended
> capabilities.
> 
> Configure mbssid_max_interfaces and ema_max_profile_periodicity
> fields in structure wiphy which are used to advertise maximum number
> of interfaces and profile periodicity supported by the driver.
> 
> Add new WMI fields to configure maximum vdev count supported for
> MBSSID and profile periodicity in case of EMA.
> Setting WMI_RSRC_CFG_FLAG2_CALC_NEXT_DTIM_COUNT_SET flag
> indicates that the firmware should track and update the DTIM counts
> for each non-transmitted profile.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Co-developed-by: John Crispin <john@phrozen.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

7 patches applied to ath-next branch of ath.git, thanks.

a08dbb04d736 wifi: ath11k: driver settings for MBSSID and EMA
5a81610acf66 wifi: ath11k: MBSSID configuration during vdev create/start
cf604e72bc6e wifi: ath11k: rename MBSSID fields in wmi_vdev_up_cmd
c82dc33f252f wifi: ath11k: MBSSID parameter configuration in AP mode
cb9bea773c85 wifi: ath11k: refactor vif parameter configurations
335a92765d30 wifi: ath11k: MBSSID beacon support
87bd40113816 wifi: ath11k: EMA beacon support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230405221648.17950-2-quic_alokad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

