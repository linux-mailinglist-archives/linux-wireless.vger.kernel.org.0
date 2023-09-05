Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8ED79258A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Sep 2023 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjIEQCO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Sep 2023 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbjIENZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Sep 2023 09:25:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C912A
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 06:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C51E1CE10E3
        for <linux-wireless@vger.kernel.org>; Tue,  5 Sep 2023 13:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA48C433C8;
        Tue,  5 Sep 2023 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693920332;
        bh=7zk19dbUfCQeOlC5iH3EPz2MBd/m3C2qfHvr3PUWqmM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HJa3JgFDFSeHyvUhTRSCoUOU74sso3R3LSiDO8vo1RnWOOUHnUqXNKoylw1b7uWJD
         pkOKbBR6g4RwoHlzN77OaJwJbVV/qi6qm+ErJ9nAYPU2YiNKJcmqtOwNAO5zoRut1n
         kMY4VnK3S9uuH8Rz7ORE3H2pWMpIOEdPWwjlXzU/9+MNGE8mggxXsChrthBML+tnfo
         oxDGnpMZQ0OlMBwgDEBvDk5u+sVz+ZT9WaN59FP9TceA//mqz+gCRorJcXy60dsRiK
         r8CjC5GAj7T5UifTVx0+Aj1I3nAyQmphp14SWa7REyzzJG+vRTUgtlxWfICREfWAbE
         ADy8MeUMQMkvQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v4] wifi: ath11k: Add crash logging
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714001126.463127-1-arowa@chromium.org>
References: <20230714001126.463127-1-arowa@chromium.org>
To:     Arowa Suliman <arowa@chromium.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Arowa Suliman <arowa@chromium.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169392032901.3610046.4213233908840247809.kvalo@kernel.org>
Date:   Tue,  5 Sep 2023 13:25:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arowa Suliman <arowa@chromium.org> wrote:

> Currently, the ath11k driver does not print a crash signature when a
> MHI_CB_EE_RDDM crash happens. Checked by triggering a simulated crash using the
> command and checking dmesg for logs:
> 
> echo assert > /sys/kernel/debug/ath11k/../simulate_fw_crash
> 
> Add a warning when firmware crash MHI_CB_EE_RDDM happens.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Arowa Suliman <arowa@chromium.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4a93b554cf9f wifi: ath11k: mhi: add a warning message for MHI_CB_EE_RDDM crash

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714001126.463127-1-arowa@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

