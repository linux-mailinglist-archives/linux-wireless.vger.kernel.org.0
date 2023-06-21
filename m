Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812267380E4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjFUJvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjFUJv1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129D1992
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90BA5614B8
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7336FC433C0;
        Wed, 21 Jun 2023 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687341037;
        bh=D/wWlRysbpsOUUpmYrAYqvLCoBKlTDmYnscO8T+7EKY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BwA0dFNd+ecevfFEVUiwCtimx6rOmbPE4qBlT2EIeiGiNm9xj/Wi0pUqugj28ym6J
         Wci+2kYz5jEx0934XPLaD0qhiYVPsWEH3QMScP5uCVdNEGMToo2Iq63xbzuwjMfGKF
         PmpdJr8Wt0OMvAvf7Hn/bjDWhlDJU/rdMQrF7mcr14rjn1tJairGn/vzJu0N/1t2y7
         GZrEsOMRPIZg3LTbier2RZylnn92WEE2Kc4nzv2iUU1ecujQe+2SjvzYVy/4ykEHEd
         SFp0H19W/5I57E9Kh9rTq+i4+0o4kaizl4/6SpDqANbQ/QzMftVwfSa8DrReOT1bqx
         GmI304z38+BhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: use struct to parse firmware header
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230616060601.28460-1-pkshih@realtek.com>
References: <20230616060601.28460-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734103459.549389.6256162760944232125.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:50:36 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> A firmware contains basic header, sections and optional dynamic header.
> Define them by a struct, so it will be easier to understand the layout,
> and also simply access these elements.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

f072eb39e4f2 wifi: rtw89: use struct to parse firmware header

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230616060601.28460-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

