Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD478D9E1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjH3SeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbjH3H3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 03:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2149CC9
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 00:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B81860B3F
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 07:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A78C433C7;
        Wed, 30 Aug 2023 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693380576;
        bh=ZeJ1BwB7KYij36PHxFK2U1Xz4mZAx/yEcPnFn0t3l/o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IP/Xf+Jti9LTA6m8LlnmX2OjaWLNUBdSXugPabPX7MFuLnR/Xeoex0fKZ6WHIUm0V
         bHD6rS7V495MnUIn5lHmvHLvp/vDkzfn6ybJBp1eyzKXQQ4kCdKty8mh1l1eJ9zR/m
         FY3CtOs8p8wlPNY5WRlq1DkwjkZBqV4F5muT8XB3YgQu4UdvmKIzz1E90B6rF/OsD2
         71VbZEWIY1/UqCWjiVea+I+L2uMNKKFFWdpt99xtSJP/w9kY81NHpsbH7i5q/ip3qv
         +EwHlHAyr7UvBBCb7EHxWLlDfsh1CN16kQhFAU2zEsTcCTqCmoqsr/Y1zFykkk9DH5
         rurdfDXOKIlJg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: add chip id board name while searching
 board-2.bin for WCN6855
References: <20230830060226.18664-1-quic_wgong@quicinc.com>
Date:   Wed, 30 Aug 2023 10:29:33 +0300
In-Reply-To: <20230830060226.18664-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 30 Aug 2023 02:02:26 -0400")
Message-ID: <87cyz5f0o2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> Sometimes board-2.bin does not have the board data which matched the
> parameters such as bus type, vendor, device, subsystem-vendor,
> subsystem-device, qmi-chip-id and qmi-board-id, then wlan will load fail.
>
> Hence add another type which only matches the bus type and qmi-chip-id,
> then the ratio of missing board data reduced.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

Wrong list, adding also ath11k list.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
