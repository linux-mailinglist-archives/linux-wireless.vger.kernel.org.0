Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF551FB28
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiEILWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiEILWg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 07:22:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8021FD1D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 04:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F38ADCE169F
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 11:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7304C385AB;
        Mon,  9 May 2022 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652095119;
        bh=Egxy8I3WhP1b3Wpnd1iYHDhTfn7Dr+0MIkN+jj2FnVU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dh+PFbbKMmpztf42ul/x2YS+LBqU+Ys+P3HYG3dTJ0KbeIhzRsuDJ2FacZiRMKDTH
         Kb9rYy8y0btEnLM9LMBk1IEffBHsC6cZeJ+aY0gdRWTwNKSL+/chqKfk/v3Fum3/xD
         2ae0Wp+9sjt4KfHMlWD1FR80R5BKVeOpPxqcjURO8klJHJyWBAY6H8zZJcysb78jQq
         LVBCNvTn8LIRhuMsxCF4BG0xDIpEK46aQlON9jFw6A22DTAx/jjFNvBbs+SRVqIe+S
         +TcIymnPNtCmEtDAxwfifb4EEv9p8U3VMwvNjzyHMhyi6G3l6W35IhnYCvLhAIaMYE
         TbUWcOkLolxGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mailmap: update Kalle Valo's email
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506084212.8952-1-kvalo@kernel.org>
References: <20220506084212.8952-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165209511198.31643.4404700417530411650.kvalo@kernel.org>
Date:   Mon,  9 May 2022 11:18:38 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> I switched to use my kernel.org address, the old kvalo@codeaurora.org address
> doesn't work anymore.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>

Patch applied to wireless.git, thanks.

c7e34c1e263f mailmap: update Kalle Valo's email

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506084212.8952-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

