Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B66F5D25
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjECRmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjECRmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 13:42:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695CAC
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 10:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E990960F3C
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 17:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D6EC433EF;
        Wed,  3 May 2023 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683135720;
        bh=oS1UqJvT9YwKZbIIzQccc+25t51qQGkqKy8e6NYb1B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuhf2MJYprCSLPF+JCuTXwtLUFAZ3nMh5eKl7xEvqf5Ua3GsMhfq4vuPLfGaQ4NJk
         b/abPwpnBHuwwV8hKGPLVbW/cuJ6FSEPG29rZhz0P5mPsLJ3BHijeSYKG+DVW4ht1Q
         hKuQ+nuv0uCVcBgCpWRKIrktM0R7CYGnOD2sHH+8/XcBuqrLcGYWfBYhdJRGdo/a4t
         PAce9TzK2gN/Y7E5bK4Yc0IPOaZz8/hUXV4z8YJ2zAbctxVjBGvR07EYhf9Pn96B9N
         jYeQ/uVW2zRTXkEUT1RTNbAAb/zhKXd06zrxrf756BYBepl07lq7T1ux+r6nytFPNG
         vsY1vhPZLr3vg==
Date:   Wed, 3 May 2023 12:41:58 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Tavio Wong <tavio.wong@proton.me>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Hong Kong
 (HK)
Message-ID: <ZFKc5uAVGToHg68o@ubuntu-x1>
References: <lPLmWUrjD7qCP9xceeomrJkM3UROE54cq2gp0jV2M-FeSKypWU2OB1smaPcro_p8kRHjXUcZd31egElc_z46nBTC5IMr9l31VNApPck5V6E=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lPLmWUrjD7qCP9xceeomrJkM3UROE54cq2gp0jV2M-FeSKypWU2OB1smaPcro_p8kRHjXUcZd31egElc_z46nBTC5IMr9l31VNApPck5V6E=@proton.me>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 03, 2023 at 03:37:14PM +0000, Tavio Wong wrote:
> Update frequency ranges and max EIRP for 2.4 GHz and 5 GHz, and add support for
> 6 GHz based on latest HK regulations.
> 
> Source:
> https://www.ofca.gov.hk/filemanager/ofca/en/content_401/hkca1039.pdf (2.4 GHz and 5 GHz)
> https://www.ofca.gov.hk/filemanager/ofca/en/content_401/hkca1081.pdf (6 GHz)
> 
> Signed-off-by: Tavio Wong <tavio.wong@proton.me>

Applied, thanks!
