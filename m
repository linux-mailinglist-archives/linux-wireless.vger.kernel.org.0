Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E405ED4ED
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiI1Gdb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 02:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Gda (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 02:33:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90841C00C5
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 23:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB8D6153A
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 06:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08369C433D6;
        Wed, 28 Sep 2022 06:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664346808;
        bh=XMBTqonJyXAbh28dOQcD6U/6GTMbM9xLJwjQdgB1wTg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hSY1o3EIQ6G48pHnMLJPXbHmdHDUoDb3QpUgk3Gk+6WgPKOkLnkWS0HO7fzw/EPwm
         uTSFwakikZAPFPexNznvCFBfBiceHXy0ewvopmEWBTYvsRDKoG62X8W25m7ARWmj69
         8SRAqK28GXnCsDi/WBwXQCPb2Iap1YjQZH0hirScoOOwB+rIibwpTfUvr1cLFZF4fF
         qxHEwaMJOPBeF8j7lBPwZtQFHTzRFeCAkbBhEb1uy2j26zMsqaN9P8vYZFvrB+nD4O
         KsO6THTQSGbKEE9/b/SF6jIwgb0bhDrWzHcQtX8gaC59r/1jru72+omNCcSoJJYZmd
         1CXU0VOhkCFAg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH v3 0/5] Fix connect/p2p issue series
References: <20220927034138.20463-1-ian.lin@infineon.com>
Date:   Wed, 28 Sep 2022 09:33:22 +0300
In-Reply-To: <20220927034138.20463-1-ian.lin@infineon.com> (Ian Lin's message
        of "Mon, 26 Sep 2022 22:41:33 -0500")
Message-ID: <878rm4rost.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> writes:

> Fix several connect and p2p issues.
>
> Note: there will be known build warning with commit
> "fix P2P device discovery failure"
>  - warning: parameter =E2=80=98vif=E2=80=99 set but not used [-Wunused-bu=
t-set-parameter]
> However the purpose is to overwrite the pointer(vif) in function paramete=
r,
> and the pointer will be used ouside the function.

We have a rule that there can be no build warnings so this needs to
solved somehow.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
