Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAF614840
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKALMA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKALL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 07:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E140E19026
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 04:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9899CB81B0F
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 11:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3872EC433C1;
        Tue,  1 Nov 2022 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667301115;
        bh=P7kT1MMpxsfB7gIxz8V6XoU+mTr/dmQT4RbpOHKFf1w=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=F5Fg9mSvHQMM0uUdzej+IOrQN+FGAsZsIZbxC2JYg5R5IZy4Tgh7Ty2e9HU21B/WQ
         X2jClMXvotsOluacq/VkOfG/vSaAoNFpYlqwYvGZnQU63x6aqos0YsM/cR6iGqWmgz
         PeD3+P5VpAYYoD80y6T6YPvbyYD/ubKlh73wB9ZZk6nJs1rvun3J4v/+9SsoH36L7O
         qwmBW3K3LdSStNBbHLUxVdACzE5ZQU/zlDRGKxDndOc/0u0pSivc7jPF5t4WyGOqZE
         FflRlRBzzI1cfpZwJK5xpoweEPTmIkKEr+TkJGnyhqIulmuMnZZZFofr7DIFzpLrtr
         QYhkJT1BPSg+A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v3 5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
        <f5ceeb63-bfd2-0fe5-c88b-2bc4c9c7c46a@gmail.com>
Date:   Tue, 01 Nov 2022 13:11:50 +0200
In-Reply-To: <f5ceeb63-bfd2-0fe5-c88b-2bc4c9c7c46a@gmail.com> (Bitterblue
        Smith's message of "Fri, 28 Oct 2022 19:40:29 +0300")
Message-ID: <87iljzudxl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> Replace two instances of bare pr_info with dev_info.
>
> Also make their messages a little more informative.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[...]

> @@ -5420,7 +5421,8 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
>  			rtl8xxxu_queue_rx_urb(priv, rx_urb);
>  			break;
>  		default:
> -			pr_info("failed to requeue urb %i\n", ret);
> +			dev_info(&priv->udev->dev,
> +				 "failed to requeue urb with error %i\n", ret);

Should this be dev_warn()? It looks like a warning.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
