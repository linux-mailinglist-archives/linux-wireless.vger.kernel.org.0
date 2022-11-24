Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8B63734C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 09:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKXIGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 03:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXIGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 03:06:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24CBE868
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 00:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E55276201D
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 08:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DEDC433C1;
        Thu, 24 Nov 2022 08:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669277202;
        bh=+hdVqNbGzl+XUzfQ1p3+T+Rghb2DWU3+wt8Ww6Qy7jU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=j55+x6av7TgZLYbiVh3pJoDs0aKnvGLNyVdNT5zborUjYzts+yQnJ0kz02D5BNhqO
         dHyTGXnZLxY+LIC+hBFi5h9sdlTQS0hZFtyU2jHPOzeS9Ivwz6ktKmnxD3WaA3FAYg
         JWpRTu+li9J9nnaVLXgJlDOjP1llGvrsLWO2u9HRcwvaNM4CSExop2K3T9smYrOhzQ
         mp6IgDVSmFf0I8FWrIl8V8k2Reg+mdPu11UAJIRbLyifZ4cCMDd04xnTSw3Wziv5ZZ
         JmOPE+wjZkH+jW6TG6FVASt5ldQYC6M2ztI15KqqdNtX122LXGosHgQhxfaL893ons
         WuOBlHwEkotCA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: Re: [PATCH 0/9] wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
Date:   Thu, 24 Nov 2022 10:06:33 +0200
In-Reply-To: <20221122084554.9494-1-shayne.chen@mediatek.com> (Shayne Chen's
        message of "Tue, 22 Nov 2022 16:45:45 +0800")
Message-ID: <87k03kojxy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shayne Chen <shayne.chen@mediatek.com> writes:

> Add MediaTek new mac80211 driver mt7996 for Wi-Fi 7 (802.11be) devices.
> The driver first supports Filogic 680 PCI device, which is a Wi-Fi 7
> chipset supporting concurrent tri-band operation at 6 GHz, 5 GHz, and
> 2.4 GHz with 4x4 antennas on each band.
>
> Currently, mt7996 only supports tri-band HE or older mode.
> EHT mode and more variants of Filogic 680 support will be introduced
> in further patches.
>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> Co-developed-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
> Co-developed-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
> Co-developed-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Co-developed-by: Money Wang <Money.Wang@mediatek.com>
> Signed-off-by: Money Wang <Money.Wang@mediatek.com>
> Co-developed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
>
> ----------------[commit message cut here]----------------
>
> This series is based on the following series with fixes folded:
> - https://patchwork.kernel.org/project/linux-wireless/cover/20221110093525.29649-1-shayne.chen@mediatek.com/
>
> For easier review, the big patch has been splitted into multiple patches
> per functionality. These patches will be folded into a single patch in
> the final version.

I wish you had split the patches per file like I asked, it makes
reviewing a new driver so much easier. Reviewing is hard, please always
take us reviewers into consideration when submitting patches.

No need to resend because of this, but I am grumpy.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
