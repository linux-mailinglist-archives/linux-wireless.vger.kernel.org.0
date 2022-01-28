Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F381C49FD46
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349765AbiA1P6Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349747AbiA1P6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E38C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:58:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02DEF60EBA
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AED0C340E0;
        Fri, 28 Jan 2022 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385495;
        bh=TcBsgucCSK1JBjBFdKT15EaTKr3nuf9BoAl8qL79Rus=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AmHyzCT6ky3AedccS6trctvst2Sj92u9WU5v8LU9PAxs75xR4DUpj6mUNJOQmkW5y
         Pzvgv2p9dfH9ucUF9qLSc/J1Q9u6jGc2o8NP4YHJOIE3mOL6gRGNk4enWGMA8O4ZiF
         Ki/0U63lSAAJzhfNXwNJKS7KuU67IlCogvAUIQW8AcZNEmRkF2zf4AqhKpOTZUaB/N
         S2sVX2YmqpRooHZ+vAQ1euaPWLzGrP6tZC+/tjnKfnAP3J/oC9Ea8nbqUeeqx7p4PV
         vDM2/bwgjtRcTCZKrhD/37Kvb6pFHJwPxiZqbLCy1Hk25qCyyG4xm9Yz65vfeLecBa
         WOKzayKDbGc/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: refine DIG feature to support 160M and CCK PD
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220121075555.12457-1-pkshih@realtek.com>
References: <20220121075555.12457-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <johnson.lin@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338549203.19531.793317118329671073.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Johnson Lin <johnson.lin@realtek.com>
> 
> DIG, which is short for dynamic initial gain, is used to adjust gain to get
> good RX performance. CCK PD feature, a mechanism that adjusts 802.11b CCK
> packet detection(PD) power threshold based on environment noisy level in
> order to avoid false alarm. Also, refine related variable naming.
> 
> Signed-off-by: Johnson Lin <johnson.lin@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

1c2423deda1c rtw89: refine DIG feature to support 160M and CCK PD

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220121075555.12457-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

