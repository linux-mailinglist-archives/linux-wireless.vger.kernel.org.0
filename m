Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C606E231F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjDNMYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjDNMYK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEDAAF32
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC38D6186B
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA798C433EF;
        Fri, 14 Apr 2023 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475043;
        bh=qMxSjhVTx/lqPCt3atD7jpiKoYtDl0IhhaI3LB5AaQw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PYTT90gl0ZstE0M6GQDd2XacOQkI6Q0EaffB3YRSaVYBzJTjP3AUJZpIVrfdClyKS
         2DeFS12sP7L9wVphZvs6sXrEn2rcsvAtOV7WJxdK0n0A2g0cCAygk40/8w3wxfg00x
         7qr2JmVWK2tw2jjRNISHUq7smXoJlCZJFegLwahfHWFebtvEDsIpYNUWhU54YxngVX
         lvX0paXab4AsGF8QJ2jvvdTdeEyU7l47GXZX5eeYwSBZZjNo6oPj+DXieHV7DrNYZn
         GE0Vote8r9h4GLuTzz7A7niPM2HMZ5Tiotw/Wa/+cl+zj8lsXCqZZ2mir0zeT41vw+
         aRGnDx9azjxEQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: read version of analog hardware
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230330133324.19538-2-pkshih@realtek.com>
References: <20230330133324.19538-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147504062.16522.2962599599283522309.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:24:02 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The chip contains digital and analog parts, and each of them has its own
> version number. This is used by BT coexistence mechanism to make strategy
> decision for different analog version.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

a6fb2bb84654 wifi: rtw89: read version of analog hardware
d5289b2d69a7 wifi: rtw89: 8851b: fix TX path to path A for one RF path chip
5c3afcba545c wifi: rtw89: mac: update MAC settings to support 8851b
2a6d518dedcb wifi: rtw89: pci: update PCI related settings to support 8851B

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230330133324.19538-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

