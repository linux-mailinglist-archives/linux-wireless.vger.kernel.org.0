Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5662DC1D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKQM6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 07:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbiKQM5r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 07:57:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663762042
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 04:57:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF795B82047
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 12:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0A7C433C1;
        Thu, 17 Nov 2022 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668689863;
        bh=0/DXGG0FpalOrK5YKRn6w8anso4j2ak9dr9rUgU/UAE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bcNRfVMHLhuFw0q6nXAdhsNM4UYjHCSPnoZFskVPO+Iy3Oz6lUBqQqWfi2tEQ2Pez
         /sAo04b7/2vPxiKv1OZDgSTDTC87oqfTqCD5I0lavxti5S0or4Z6AHWot8NzIAODGz
         iowoQzvnHIxkO3nLHEdu0DWsZ9pWNqLRNrnBb3IkeTx31CJRRNt7Pxhr1t5noFoKrS
         uM7+CYQjJ1hdkbLpy/YLBRhaLgI42FnfCBP7DJ5lFF+E6RBRNr2mBwf9pu+8gwKeN1
         8YNP0ZPIEXHGg9XhRO9PiK7LvWV0oYwxDxuf2Y07Jv5AooZ0MoNOBiPz6bdI+4jGVg
         GrI9r2vKo9NEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Remove redundant argument offset
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221110164025.14418-1-hujy652@gmail.com>
References: <20221110164025.14418-1-hujy652@gmail.com>
To:     Zhi-Jun You <hujy652@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Zhi-Jun You <hujy652@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166868986062.22046.4412615782635710951.kvalo@kernel.org>
Date:   Thu, 17 Nov 2022 12:57:42 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi-Jun You <hujy652@gmail.com> wrote:

> This argument of ath10k_htt_rx_h_frag_pn_check() is always set to 0 so
> drop this.
> 
> Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d9e38350a7b1 wifi: ath10k: Remove redundant argument offset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221110164025.14418-1-hujy652@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

