Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA551D0C0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbiEFFg3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 01:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiEFFg2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 01:36:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214E43A5CB
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 22:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFBB61ECE
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 05:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B0EC385AA;
        Fri,  6 May 2022 05:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651815166;
        bh=nR9V7jemUNjIp2es8J4WtsRQp+BbXrKQQN6R5IkFuUU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Fm0bc+wCZo6cf3GSxPNHL0bSM/rTEGqq/cCNLwQx3lA9WQK+Ov3cVHxNG1HF5z0tw
         yvfW37DusyWJCmuDZbDlb9GSVF1IRjXdCBxe2RkiFayBAWjvTwQ04SD4HwU9DT8kvv
         ATcFHz6dlwjtTYNXbpxk6rpcHT/h/0jHougtvGc5Z/vQpnfRrxgnirIzBjm9wxFrf8
         7b2gdeRQ/AJqLEk+9sOxqgCqTjKa0EHOmjw0Y5WVgZauJ0979ckt83c7gcaEMOC+KD
         40MTKQdJ6IrQ4MO48wxRM8bN8/+v6zF+Rt5WWmbFmCS+bqt7DBblLxnGzscWgo3xnM
         IwVKWL5Re2tvw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH wireless-next 2/3] wifi: mt76: switch to netif_napi_add_tx()
References: <20220504163316.549648-1-kuba@kernel.org>
        <20220504163316.549648-3-kuba@kernel.org>
Date:   Fri, 06 May 2022 08:32:41 +0300
In-Reply-To: <20220504163316.549648-3-kuba@kernel.org> (Jakub Kicinski's
        message of "Wed, 4 May 2022 09:33:15 -0700")
Message-ID: <87wnezxm2u.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> Switch to the new API not requiring passing in NAPI_POLL_WEIGHT.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Felix, I'll assign this to me on patchwork and apply directly to
wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
