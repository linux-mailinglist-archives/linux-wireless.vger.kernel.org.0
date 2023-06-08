Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A13728471
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjFHQAo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjFHQAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 12:00:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727992D4B
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 09:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9A1C64E9D
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 16:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD76C433EF;
        Thu,  8 Jun 2023 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240009;
        bh=8CHMakvzh7d7SG5fF00PAkQqLlMVw6ll1ojFXaqZANg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=R5QOb8eKfDNhfTol7OzFf0RnTn2eysKrFhZyn4btF2of42Bih6EWxH8SiB+/eOUE1
         3DIJcmTXUOofoeDhSxk3Qp4SeD1FUD9MYPIGs6hZBNXBkrHw8/yI55O3or5vsVVAi8
         1WfMAhLpQKkBKhD71lMZTKDLKY1edJg0DuiqXhm1+umemnKmalHlh8MxTR2G2j3Nqu
         YQS2dC3k4RPVKWpu8nUapBaczCbToxSSrEHDf/jhk2X96SnCtr36L7j0QBlun3zSms
         rqW1ECvjYGLx0TkwkoT2WLFf5pS4NwAAjGUPlEnVVOKkh8mpWOlttCzU5scrBFRbTt
         nmZaibRcO3NOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: brcmfmac: Detect corner error case earlier with log
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230603060021.57225-1-nealsid@gmail.com>
References: <20230603060021.57225-1-nealsid@gmail.com>
To:     Neal Sidhwaney <nealsid@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Neal Sidhwaney <nealsid@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168624000624.5828.4050513344928794764.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 16:00:08 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neal Sidhwaney <nealsid@gmail.com> wrote:

> In brcmf_chip_recognition(), the return value from an MMIO read is
> interpreted as various fields without checking if it failed, which is
> harmless today, as the interpreted fields are checked for validity a
> few lines below.  However, in corner cases (on my MacbookPro 14,1,
> sometimes after waking from sleep or soft reboot), when this happens,
> it causes the logging to be misleading, because the message indicates
> an unsupported chip type ("brcmfmac: brcmf_chip_recognition: chip
> backplane type 15 is not supported").  This patch detects this case
> slightly earlier and logs an appropriate message, with the same return
> result as is the case today.
> 
> Signed-off-by: Neal Sidhwaney <nealsid@gmail.com>

Patch applied to wireless-next.git, thanks.

f8f912bf69a0 wifi: brcmfmac: Detect corner error case earlier with log

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230603060021.57225-1-nealsid@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

