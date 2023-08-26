Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6777893F7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 07:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHZFox (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Aug 2023 01:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHZFoX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Aug 2023 01:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC026A5;
        Fri, 25 Aug 2023 22:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91ADA601B6;
        Sat, 26 Aug 2023 05:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AFCC433C8;
        Sat, 26 Aug 2023 05:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693028660;
        bh=iiyTHPtsH0r2NOwXQ3GIfftBWZLfSVf49/SdaJ48fkc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RNDwK038a5Ls9IG2WkwXtN3l3/S5in1DeLWusyq54rshtrYON4ieLWm9xvdM1tBkD
         nZypuJ/TWeho9EEd3bH/mw5OgerKEWtm7cvU68+5LjlZS69BGDRcjw4A4l8jV/Crak
         VLOTrhLUPeFm1YDWH5AybsRyX5U6WCF779w04iotyhevEcEKKqp9aRNC3yI2XGbrV4
         bnkZ/XJC+COIEfx/mQNf/ryk+5Un+jleybPB1FkdyQYIf0TbEFMPGXuMUTn6v4lnf5
         Myxd+ZqHTe41TR2FtGtxJjivWv4G2B9pKaxz5aU0onVdtMByAp5nr9PNXkxdA80HrE
         9adhCOz81zabg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] wifi: ath10k: Default to board.bin for legacy board
 data file
References: <20230825202610.1580132-1-dmitry.baryshkov@linaro.org>
Date:   Sat, 26 Aug 2023 08:44:17 +0300
In-Reply-To: <20230825202610.1580132-1-dmitry.baryshkov@linaro.org> (Dmitry
        Baryshkov's message of "Fri, 25 Aug 2023 23:26:10 +0300")
Message-ID: <87pm3afjda.fsf@kernel.org>
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

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> Default to 'board.bin' for the legacy board data file, in case the
> hw_params array doesn't list hw-specific board data file name (e.g. for
> WCN3990).
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Could you provide more background _why_ this is needed. What are you
trying to fix?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
