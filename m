Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A15782DF5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjHUQLk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHUQLj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC72FD
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAC286135A
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 16:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B9BC433C7;
        Mon, 21 Aug 2023 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634246;
        bh=YcTFITg1w2MSkOZ90kX0KAHyvfxxA/6uy/ihnKv1GGM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ia0Gv9heKLSF/QG6XryPKu/1LOwZNPybav4BrVgXWQOREP5lCZXGh5oDiKJxfZPcD
         b9UCC+3b3YR0bduoNP9hqG0jYppVEue1ahpnNg5RuObhJoSDSuRabHpb4PXOqoKkRV
         xE/Nlz9quPrIeF1NgQOvq+y5O6U27U0+Cq/LawXIOUyelEe+ON6C4qp+15acJAi/ms
         zGayOBpdZTrnBM/dLwVIHGkaF1o2YQ2+RNnlt8m1itAjf/43pweBuzoeit7OufxPeC
         L6wWjhwM5IUKCXZTToC1+4QRq8DG+vsl/aBmAKlfpQQMpVVXTZkESulRnXWKQEmDsy
         l8BR40juxB6SQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: 8852b: rfk: fine tune IQK parameters to
 improve
 performance on 2GHz band
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230803110150.8457-1-pkshih@realtek.com>
References: <20230803110150.8457-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263424377.572263.6378907015497822191.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 16:10:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> A few samples get bad performance on 2GHz band, so use proper IQK command
> code and select another group to have wider range of calibration value.
> 
> Fixes: f2abe804e823 ("wifi: rtw89: 8852b: rfk: add IQK")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b3bfc4fb1edc wifi: rtw89: 8852b: rfk: fine tune IQK parameters to improve performance on 2GHz band

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230803110150.8457-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

