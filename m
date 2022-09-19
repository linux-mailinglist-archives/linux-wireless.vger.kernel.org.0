Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB445BCC74
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiISNED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiISNEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 09:04:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B62F3B8;
        Mon, 19 Sep 2022 06:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68D1FCE1071;
        Mon, 19 Sep 2022 13:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C01C433C1;
        Mon, 19 Sep 2022 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663592627;
        bh=qWWYH4oPxyt4F2eriRjE9L3xJK1Sgu6Hh4lXFLgL9Qk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mBpLPFFduAlWGGSlQRK3Fc61BwoOQCcM3HCIC7Rcuvp/hhFoCP8JmALrdOJOSxc1e
         VR4yx619kKwBGfeeLYv7NnjJ8rYYMlUsK0uBUivdPRSmz7zxIr+ClBJUOiCwPSxGcq
         7JueOKyXSzPgziiyfCM7sQsBfx6xyul109Uk6A+UXx2UtY7z0ha5rLV0a83KLa5MSk
         QmFi2DroHZYwMm6JUQdkQuXJGzrudZfXAvk0O29rKD0jH6Y2+yRtbjaY02U+UBG9C/
         3WXi6o+mEn2xZI4HS8Sl2G0NYblnXP1p3o46n4om3u7cMldnNQlMqzWG2iS4AgNnX4
         z5sMUXiJJPzuw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] dt: bindings: net: add bindings to add WoW support
 on
 WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220902112520.24804-2-quic_mpubbise@quicinc.com>
References: <20220902112520.24804-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Manikanta Pubbisetty" <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166359262191.25311.8343606005325253163.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 13:03:45 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Add required bindings to support WoW (Wake on Wireless) on
> WCN6750 which is based on ath11k driver.
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

957f60273af8 dt: bindings: net: add bindings to add WoW support on WCN6750
69ccee619a38 wifi: ath11k: Add WoW support for WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220902112520.24804-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

