Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D456FF293
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbjEKNU0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjEKNUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 09:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1B110E66;
        Thu, 11 May 2023 06:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E482C61652;
        Thu, 11 May 2023 13:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E721C433D2;
        Thu, 11 May 2023 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683811082;
        bh=4YERbDXXstqPQ1/3lmZBAHqtWDMcORq7IokrQhfuPJ8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=t6vFzM6xY6fG+dhEsI7HSJ1LTrlos7nN46mFAyCnJ88bveaRcIONCTKsErgUwLLtc
         pYF4cL3DZ29AaxB+ffbABHRGvC450LHo3OuVW0d8JGtzdnjhfBTJ751qbjdrWovGHG
         nfS52rSgsU9UtS4mDQYbtxAbE7Jv6IJ+9LxD+DQhZi/LOuHRgKaRZF/7DZgIF9FyBK
         3uvYZzsc1LrTUGCxeNrUvtpTHs6ul+sTb4nEbgbA9O94QdmdEWehS6flvGnUXbszwp
         1awL1rZnpUmWQq3MUV5reDK9eESwfmjk8ySZZIvFtTAifEn9KBO05wMXV1pVhTX+Y+
         JVhQ9VdWBhlcA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: unlock on error path in
 rtw_ops_add_interface()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ddd10a74-5982-4f65-8c59-c1cca558d239@kili.mountain>
References: <ddd10a74-5982-4f65-8c59-c1cca558d239@kili.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Po-Hao Huang <phhuang@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168381107884.27145.12968599583133133991.kvalo@kernel.org>
Date:   Thu, 11 May 2023 13:18:00 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Call mutex_unlock(&rtwdev->mutex); before returning on this error path.
> 
> Fixes: f0e741e4ddbc ("wifi: rtw88: add bitmap for dynamic port settings")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

e2ff1181b3d4 wifi: rtw88: unlock on error path in rtw_ops_add_interface()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ddd10a74-5982-4f65-8c59-c1cca558d239@kili.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

