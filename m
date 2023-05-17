Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76D370622F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEQIG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQIG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 04:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0F10D4
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 01:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70FF564354
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 08:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583EAC433EF;
        Wed, 17 May 2023 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684310814;
        bh=NhkbkWR4boBNXOeyUH9PAT8Ra6Ui3vo2m+golL/gTls=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VA7n1WXZkI8iw4HzHuBwuzY0wbVnnUV1J4TjzJEyWe+aC3bVP7s3baXvOECUbwPmS
         iH6CUJlXGPcF77n7TpzccTBzgTMLn1yGIj1k9+9gMknEvUSUiGsOs/wJi5TKaeOoLE
         0GCmE3u/PlkWkNTaDgz6bMSoJv4c78wnhVCAFIH4hfpSG27s9pIlgSLdP9qa4r+xay
         zZxRw//4OPuI0GNcOQ6kCKdK4TdNw7p/N4LtBJ+X6hwrZ7zD6FJmCF3o3E6Y5Bbun8
         p6kgTMZ58tPcLYzX3mmyviG31tjeezbKfomjlU8TZ+wobXhA6Gy8AOUq+Yuz5lTACb
         fnjffQ3XryD8A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: 8851b: rfk: add RX DCK
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230513054425.9689-2-pkshih@realtek.com>
References: <20230513054425.9689-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168431081216.4384.5854942324737825075.kvalo@kernel.org>
Date:   Wed, 17 May 2023 08:06:54 +0000 (UTC)
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

> RX DCK is receiver DC calibration. With this calibration, we have proper
> DC offset to reflect correct received signal strength indicator. Do this
> calibration when bringing up interface and going to run on AP channel.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

fe8a168266eb wifi: rtw89: 8851b: rfk: add RX DCK
0194a95cbe72 wifi: rtw89: 8851b: rfk: add DPK
3f2da9fc17f6 wifi: rtw89: 8851b: rfk: add TSSI

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230513054425.9689-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

