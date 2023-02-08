Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6D68EB88
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 10:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBHJfj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 04:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBHJfg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 04:35:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF230C4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 01:35:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8423561593
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 09:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A994EC433D2;
        Wed,  8 Feb 2023 09:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675848923;
        bh=cDj+e/iAbuL4RBaTZZQuNHpaXf2z0D7rnqFPZS2npV0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nirilJ4KH7sKLaby5eYSIiuoopXDReFcAF56JApJAb02jfNE7LhhpiLZcPJqJ9m/+
         hmreppXlTdP6csSKWhhF7gSrsR2VckEd+4GfoUfSAkBOiHW4zT9Tk9gZhmJmKO/SQf
         yU+aRpTw5fqSlLNPG/0rjmJbEQMuJ5IIKO87WmlIOFrWIrPRQvxfkwhikSPPuENilo
         489mOb17ileItJOslkLx3UrGo/59woVhcDMEvyOonbIkfyPzhx8gWepPyGaEP2q2q7
         TouDkM2EQD586WKj+clvaT04slTb5R/5pSt7VmxjFuEAVnwcF1e720pQCjK4TdMx12
         8xrqg/IXcEB+w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: support ww power config in dts node
References: <70b8acb74fef12b10a74501cccd20e0c12f3f134.1675348583.git.deren.wu@mediatek.com>
Date:   Wed, 08 Feb 2023 11:35:14 +0200
In-Reply-To: <70b8acb74fef12b10a74501cccd20e0c12f3f134.1675348583.git.deren.wu@mediatek.com>
        (Deren Wu's message of "Thu, 2 Feb 2023 22:47:24 +0800")
Message-ID: <87cz6k7b59.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Deren Wu <deren.wu@mediatek.com> writes:

> support new node for WW regulatory domain

The commit log doesn't really explain much. What does this patch do
exactly?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
