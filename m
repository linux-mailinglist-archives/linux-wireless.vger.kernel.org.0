Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4C7B6B3C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbjJCOTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 10:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbjJCOTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 10:19:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61443BB
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 07:19:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC50C433C7;
        Tue,  3 Oct 2023 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696342773;
        bh=K3RoKVJclUVf3QIQB6MS24Zqp3gCNfi/X2ais8mZN4s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lDO1elFe7pUNBAb/AOog4tNvplshj1FAMSLnmj+ZfsZ+0jlJ7X7eeGE02r4UbDvC7
         xhSf5pnWYjwBUCBOuuYvzFtzBRGoKN61P4X3SQ8lgBptCBD/R9kgZELt76xl7uktma
         d2zMvN4+H0HF18hOdkX84UWIh3v32fk+8es1Htbz2nOCQ6UdaLXL4eZB0lI+gkWoyB
         8XeNWo2dW/UZQD4rU2WxnTVp1a7cMU9JE9lUTLASCU1AxjMTmNfdiK65XnBoiqZIwA
         mCHd39OKe8X3EFSByDYYTZqe2fZdUdinfx3JcDTafGWKOMTEJM5E2arkpNON0PWrqq
         HdXuUpWhhrnWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: fix memory leak in WMI management
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230707105243.22824-1-dmantipov@yandex.ru>
References: <20230707105243.22824-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Rakesh Pillai <quic_pillair@quicinc.com>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169634277042.61956.2280885704658772960.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 14:19:31 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'mgmt_pending_tx' of 'struct ath10k_wmi' contains pointers
> to dynamically allocated 'struct ath10k_mgmt_tx_pkt_addr' objects,
> these objects should be explicitly freed when removing from idr
> or when the whole idr is destroyed.
> 
> Fixes: dc405152bb64 ("ath10k: handle mgmt tx completion event")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This needs testing on real hardware.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230707105243.22824-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

