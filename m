Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83727611332
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJ1NmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiJ1Nlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 09:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5624D167F65
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 06:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089B3B829B9
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 13:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F58C43143;
        Fri, 28 Oct 2022 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964453;
        bh=80M5z3G6EudmtnIBuKj1K24+NxFXRZMki+pjSgoRv1A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=I3h20+uyo/1OiHMzZQrWkxkcpzZAk4IzL9JudkSP8GNXSKGql74hytO3Y4EzB1eQg
         T5jEnt5UISJYBZOsmi/8ZvOeUXi77bmyDqePe9CL1azCKoK4sUBnfaPv92xmTpky9g
         A3xCnCZUA9q1QWBjSPFN+wlisycY0cimSNIyLnQuqXvAJQBX0/5INDdaQe9a0N3eX3
         zEsbOIwqv6SbEKRpoXhCfz4Pg1QTID0lDxb+bq9FBv12QOivk3WE0V/0G30TE8N5MZ
         soJ5T1mfp3FHR8SN21NkU0Lvs4qZjhsuOtjaq54RFB7w+SD/bfQDEfsej0p4W2BzM4
         V/mbnDTqNwOtA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: fix monitor vdev creation with firmware
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221014155054.11471-1-quic_nmaran@quicinc.com>
References: <20221014155054.11471-1-quic_nmaran@quicinc.com>
To:     Nagarajan Maran <quic_nmaran@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Nagarajan Maran <quic_nmaran@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166696444811.2585.6793212023358512651.kvalo@kernel.org>
Date:   Fri, 28 Oct 2022 13:40:52 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nagarajan Maran <quic_nmaran@quicinc.com> wrote:

> During firmware recovery, the monitor interface is not
> getting created in the driver and firmware since
> the respective flags are not updated properly.
> 
> So after firmware recovery is successful, when monitor
> interface is brought down manually, firmware assertion
> is observed, since we are trying to bring down the
> interface which is not yet created in the firmware.
> 
> Fix this by updating the monitor flags properly per
> phy#, during firmware recovery.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nagarajan Maran <quic_nmaran@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f3ca72b03271 wifi: ath11k: fix monitor vdev creation with firmware recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221014155054.11471-1-quic_nmaran@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

