Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669515B1559
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIHHHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 03:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiIHHHU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 03:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2AA0625
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 00:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C316061B7D
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 07:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D89C433D6;
        Thu,  8 Sep 2022 07:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662620838;
        bh=IJ5Y5859RzK2tBMeAuXEmz2aXfcKQmjm9q1cRifDZUc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rAyIU/ZzEBuKpJL64Xkn16HRr4FxCto9zkmwnJxFUcfi0yODGoQd+fFmvddKuCN62
         CUkmQwRcyxjCpz2ikXzMnz7/6jGStLOi3F7ygXiLBOzSg6kdBIC9T1SzD1zm56UCp0
         iFsUVyetBbBghuEugDGRvK2HU6LWqmUMCuElCtkKfwpIG9MuE4/1AXTNVwSFv1Xgi8
         VdgAFB3/l7LFJRukM5l2axUOOtZKfvBmplaSZQ32UwbdOz1DBPSdMdZUJVD7ie0Mbq
         jdCRbs3fudq1HDPUBtSYglafbtsGkzWn4dz0Y2FhAjdOJO1TgCt2WyFWvL0tJ+yUx4
         1E8019Qju5jfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] wifi: rtw89: configure TX path via H2C command
References: <20220907084402.66480-1-pkshih@realtek.com>
        <20220907084402.66480-4-pkshih@realtek.com>
Date:   Thu, 08 Sep 2022 10:07:13 +0300
In-Reply-To: <20220907084402.66480-4-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 7 Sep 2022 16:44:00 +0800")
Message-ID: <87r10mbazi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> In order to support TX diversity, add a function to control TX path.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +	ret = rtw89_h2c_tx(rtwdev, skb, false);
> +	if (ret) {
> +		rtw89_err(rtwdev, "failed to send h2c\n");
> +		goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	dev_kfree_skb_any(skb);
> +
> +	return -EBUSY;

Overwriting error codes is confusing, so it would be better that this is
'return ret'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
