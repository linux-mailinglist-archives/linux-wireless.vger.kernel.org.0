Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F046749FD39
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349718AbiA1P4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:56:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42488 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349725AbiA1P4T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:56:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4CA61EA0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8F5C340E0;
        Fri, 28 Jan 2022 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385378;
        bh=vfps1f1T3YVhFSWp/hMLOS3k8+j1k8Db3FhK5TnjO6Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gqq6RxkHtXTzzcgSfIE4FAgVd+LzJofG6wbLlaY9a2e1GZMAPS7JZ+ZICpfktMH3r
         ZdPtp23LGxU2xIEaFDw3lu2i8Td8rX859aJJKvKaBGinhmLQIDBq+hiAcvrdjC5KzT
         h5mfn7YIaqIM7L9fzNdY04+kxPTbgufJq22mh8H+sg1hhk3slWvlNbngK96/WW8smo
         Ae07ThIBAK7RT092HAeddOnd8CE47T99vB2E2YcjGFlzR01R9QGXTVqwMJMxWJbVgR
         hdR5xspJKIp7QjapppYo9MEzVET32idBOX8BWFP8WgiSvsdYK2UxB8i6e6E5U+aICV
         T+isKugtlr2nQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw89: correct use of BA CAM
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220104012052.6911-1-pkshih@realtek.com>
References: <20220104012052.6911-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338537673.19531.9625284139100997022.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:56:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> BA CAM is used to ACK peer's packets, so it must be established when
> IEEE80211_AMPDU_RX_START, and free it by IEEE80211_AMPDU_RX_STOP.
> 
> The hardware can support two static BA CAM entries, so I implement a bitmap
> and a struct to record which entry is used and its corresponding tid. Also,
> the hardware can learn and create dynamic BA CAM entries automatically if
> received packets don't match static BA CAM. That means it can still work if
> we don't use H2C to set static BA CAM. An exception is tid=0 should be
> always allocated in static BA CAM, so an existing static BA CAM will be
> replaced if it is full and peer is going to establish a BA with tid=0.
> 
> The new firmware use new format of this H2C, so I upgrade it as well.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

3ffbb5a8b8cf rtw89: correct use of BA CAM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220104012052.6911-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

