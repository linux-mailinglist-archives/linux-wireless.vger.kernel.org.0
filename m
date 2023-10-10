Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD92D7BF406
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442441AbjJJHWS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 03:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442399AbjJJHWR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 03:22:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EBB0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 00:22:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D01C433C7;
        Tue, 10 Oct 2023 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696922536;
        bh=AfdHByMUUZajCAW8uhlGqfq1AsBB6O7960Qb6NBj9Rs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=D2nXk+/xkOBYbCt6LkRgVEFsWz/ALKhKEhbKgcDFzi979TBzCYYYb4T/q7DRiDsfz
         B3VCfYJgq022XiQv6nrOnW0rQdVnhxDdR4ut2IrbRtSQDH+f/DQFx5gG4FrIEmzYfQ
         60y+SHWUnVmNGYpPR3M6+s14x38FOX0skKsDOpDpDVQg3xvmEjVuOwQVAQy4lKYsc3
         699sLhs7cgTQ3h/fnYZtGQE9zLHbMqYImbae8ieL0IThZcXgPET+zTLg+suXJaYr7v
         fhQ7CXnTQj+0VfN8a0oSLiKl7UKtqtieOFk87MBBEEHgj9NBm/RUfJSEJw8FA2EE50
         QWu4l+ceWih1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: remove redundant memset() in
 ath12k_hal_reo_qdesc_setup()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231002182856.131254-1-dmantipov@yandex.ru>
References: <20231002182856.131254-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169692253271.2589238.16759325479642080708.kvalo@kernel.org>
Date:   Tue, 10 Oct 2023 07:22:14 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'ath12k_dp_rx_peer_tid_setup()' is the only place where
> 'struct hal_rx_reo_queue' object is allocated with 'kzalloc()',
> call to 'memset()' in 'ath12k_hal_reo_qdesc_setup()' may be
> dropped. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

258242dac924 wifi: ath12k: remove redundant memset() in ath12k_hal_reo_qdesc_setup()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231002182856.131254-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

