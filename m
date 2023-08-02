Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407376CC03
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjHBLtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjHBLtU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 07:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82E26B0
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 04:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43ABD61940
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75EAC433C8;
        Wed,  2 Aug 2023 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690976958;
        bh=vr23ekRDfTSaR0GKV/GudGjbseDbs01M1DzH452Wjcw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZcBh7BC3o39yFMKbUzh3w1ICm+qDb39E2i51g/3VV3ivx9iva1IbfmT3pjNcxmZAt
         CXLrkaAX7unRC1+oGydabW3M66HwY7++yNx3tsOjpa6Y9pLjyTEDTYNlgZzt4FO3b6
         58UpM34afPXWzAzUqITuQQ2rV3mRy1+HXGbQL+R8JDcEvtC8Uz9ptRdM5F/tZm/LPa
         coZmFx3/+cAs2V06iuoyxJGBEJV/Hei7OZIyihcctsZwO63b1W8+w6aFUbs8vHfX5u
         2AvQQUbDTMmvrt7CcxtMG+lero9BNk7LUb4OxUtVW35+1eeKGX+s4FUQ+NkBhnDWjU
         wbl3XQcAuf33w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix band selection for ppdu received in
 channel
 177 of 5 GHz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230726044624.20507-1-quic_adisi@quicinc.com>
References: <20230726044624.20507-1-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169097695583.406507.10371419021787807224.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 11:49:17 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> 5 GHz band channel 177 support was added with the commit e5e94d10c856 ("wifi:
> ath11k: add channel 177 into 5 GHz channel list"). However, during processing
> for the received ppdu in ath11k_dp_rx_h_ppdu(), channel number is checked only
> till 173. This leads to driver code checking for channel and then fetching the
> band from it which is extra effort since firmware has already given the channel
> number in the metadata.
> 
> Fix this issue by checking the channel number till 177 since we support
> it now.
> 
> Found via code review. Compile tested only.
> 
> Fixes: e5e94d10c856 ("wifi: ath11k: add channel 177 into 5 GHz channel list")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

72c8caf904ae wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230726044624.20507-1-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

