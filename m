Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA205171BF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 16:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbiEBOma (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 10:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiEBOm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 10:42:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728C60F3
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 07:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A809B81058
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 14:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DA6C385AC;
        Mon,  2 May 2022 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651502338;
        bh=L/dvX2BgI8HxvXU5xU2F5JMzkoAkwfnr/326EOEanVM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rPzMmQYUf28JH07PmLcrlZoF4cVPT5xwsQsNSrYCSR5pxV0MI5TFw2gGvK6ubSGdt
         A/nsf4HsduklsNRIheCUhmI3eyefbxoWqEkMKCFIvypk6VrdHpQRNZ+OpTK5Dgp+I3
         JH1MK1CdyY/kgoEX7Pm8dbDPD68yDGPIQ1ZX/pe2WgrPyyhYzHTW/+jTrReLIRGh47
         8em/62o6YNbjiMfQfIm0tsoh41Zr1KpyKzfGi7i2QKcHdtUNlmFM/m6iah+Rp4Mi9I
         X8NeHcFXFAjeheesugVoh31g3AXfxNyW1QeBHhl3SknmFg0TmO/JBIV5rItooFMi+A
         CDsAdgkk8nHgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-next,1/3] rtw88: remove a copy of the NAPI_POLL_WEIGHT
 define
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220429174643.196994-2-kuba@kernel.org>
References: <20220429174643.196994-2-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        tony0620emma@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165150233492.32510.1215509289795240440.kvalo@kernel.org>
Date:   Mon,  2 May 2022 14:38:56 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Defining local versions of NAPI_POLL_WEIGHT with the same
> values in the drivers just makes refactoring harder.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-next.git, thanks.

0d3b26c4b97a rtw88: remove a copy of the NAPI_POLL_WEIGHT define

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220429174643.196994-2-kuba@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

