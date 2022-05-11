Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D584B522BA0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbiEKF1e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 01:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiEKF1b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 01:27:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E56EC6E
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 22:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13077B81F91
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 05:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC670C385DB;
        Wed, 11 May 2022 05:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652246847;
        bh=lcgHPw77T/7vHIw0JU+9nQTOwFtabxj2y5nvnWXc3qs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BMegyVap2SXGPrhSG/Xwoynluo2vfFBUP5KPlDhrVnpZ6iroFBlx3+wAFtnrcbenr
         9DGf456sCybuokLtRxxLKwCC7ypjgE2FWAFCjeVMzbjWJL57gOX8tduZANM1TCGmqP
         C7sDi4lbDpWZzuTyuN5DVrSHsPTPJPET8lR4VsVL2OlBceRG7+r48Kp+0nTZOGfCJM
         ZEQkb+pC/O02FWJUktiWsiBA12JjAp+kMzzmYRl0vrW0abiuLvdkhygnBC9nPqWFVB
         2UPyHHqdkIpChc0Hf+5emrqsvm3rxBC22+eH+/VHu8kdmIPXtTPlRMI7/tRNoB9cCN
         cOrZO4138lRhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] brcmfmac: allow setting wlan MAC address using device
 tree
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220506044246.67146-1-pavel@loebl.cz>
References: <20220506044246.67146-1-pavel@loebl.cz>
To:     =?utf-8?q?Pavel_L=C3=B6bl?= <pavel@loebl.cz>
Cc:     linux-wireless@vger.kernel.org, davem@davemloft.net,
        =?utf-8?q?Pavel_L=C3=B6bl?= <pavel@loebl.cz>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165224684450.19198.1338953215884982196.kvalo@kernel.org>
Date:   Wed, 11 May 2022 05:27:26 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pavel Löbl <pavel@loebl.cz> wrote:

> This allows firmware to provide MAC address using device tree. Like in
> case there is no MAC burned in wlan NVRAM.
> 
> Signed-off-by: Pavel Löbl <pavel@loebl.cz>

Patch applied to wireless-next.git, thanks.

716c220b4d99 brcmfmac: allow setting wlan MAC address using device tree

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220506044246.67146-1-pavel@loebl.cz/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

