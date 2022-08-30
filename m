Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E85A6883
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiH3Qgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Aug 2022 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiH3Qgs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Aug 2022 12:36:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC1B7754
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 09:36:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3692B81CD8
        for <linux-wireless@vger.kernel.org>; Tue, 30 Aug 2022 16:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1450CC433C1;
        Tue, 30 Aug 2022 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661877403;
        bh=TFRHNAB562YkyJdjR5mxnm2w0A/qdLViHJHohLlVuEQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Qh5O2tx3+kORPzU33VnIDoqD/IcodC3MhVNkWx+fqQMfGX9FXmrbZzuJ8MeANKQ6h
         xVZ7f6KM7M7hKypc8yPM6LUVEf3Sw3mzFUJEKZgeKKOBkjxnRurO3IVXqE5dAPsk50
         pjvFUROvQ0OJuTDXujGMdiXTtm1uglW3eARgaEpmV0l2P6cgEeG74wVYGSws3qrEN3
         h1EjovkrPl9Nc2fvmcM7WNo5/EuUE9m+gNiwYv8qLO5xRwbqlZZ7Mene49E8wjKUZy
         YCWoks0F46TlIBcHbl+5ntie5VwfW9vCQho1b+0AX/Lh8SOyvUgtPM2LJGrBEAg+Fd
         9wywEvb67vnUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: wilc1000: fix DMA on stack objects
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220809075749.62752-1-ajay.kathat@microchip.com>
References: <20220809075749.62752-1-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <mwalle@kernel.org>,
        <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166187739680.28049.7809271821015045293.kvalo@kernel.org>
Date:   Tue, 30 Aug 2022 16:36:41 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> Sometimes 'wilc_sdio_cmd53' is called with addresses pointing to an
> object on the stack. Use dynamically allocated memory for cmd53 instead
> of stack address which is not DMA'able.
> 
> Fixes: 5625f965d764 ("wilc1000: move wilc driver out of staging")
> Reported-by: Michael Walle <mwalle@kernel.org>
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Tested-by: Michael Walle <mwalle@kernel.org>

Patch applied to wireless.git, thanks.

40b717bfcefa wifi: wilc1000: fix DMA on stack objects

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220809075749.62752-1-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

