Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9595F506F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJEHrw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJEHru (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 03:47:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34065815E
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 00:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F7F1B81C76
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D6CC433D6;
        Wed,  5 Oct 2022 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664956067;
        bh=VFIBzjCrZ4MMZ+z2e2Nb6TpNn0LRd/litlDhl7Ar6m0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ls3NQMNNu32CRLMI5sajBEuX8hLar3fCpDp3sONhGsIxVOMNZFwpbnnADRHS7XuPG
         k7h596Y/Ne6Cj6UFRJ5cOXF95b2QLo8vid6S2XS3prT+ZVhV6ujPJAf53irhgQgphX
         5sYBLdo7vcldOdsp65o7yAyVJofoFPiLe9DA2U/ILHkp4IMcPUe604mnpritDwtCtW
         qXLHp8MdDNrnikzBn6kO3MHko8sOOx2R/P8Jm4Twmnq3aFEN3MJ1+O+6uSzE8GmGSF
         4nKqiwQv/AIXk6QH1ngZm00gCSwwsEUHjsZQj1sfj73UHXdqKOtUnM3C74HLPpiB7l
         oNfwGyPzkFa5A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH 1/4] brcmfmac: add creating station interface support
References: <20220929050614.31518-2-ian.lin@infineon.com>
        <166495571909.5945.9074519493480723249.kvalo@kernel.org>
        <87czb667e4.fsf@kernel.org>
Date:   Wed, 05 Oct 2022 10:47:43 +0300
In-Reply-To: <87czb667e4.fsf@kernel.org> (Kalle Valo's message of "Wed, 05 Oct
        2022 10:45:23 +0300")
Message-ID: <875ygy67a8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Ian Lin <ian.lin@infineon.com> wrote:
>>
>>> From: Wright Feng <wright.feng@cypress.com>
>>> 
>>> With RSDB device, it is able to control two station interfaces
>>> concurrently. So we add creating station interface support and
>>> allow user to create it via cfg80211.
>>> 
>>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>>
>> 3 patches applied to wireless-next.git, thanks.
>>
>> 2b5fb30f8ff5 brcmfmac: add creating station interface support
>> 4388827b87d8 brcmfmac: support station interface creation version 1, 2 and 3
>> 1562bdef9251 brcmfmac: Fix AP interface delete issue
>
> I didn't notice that "wifi:" prefix was missing, please always add that
> in future patches. More info in the wiki below.

And please stop CCing brcm80211-dev-list@cypress.com, the bounce
messages are really annoying.

<brcm80211-dev-list@cypress.com>: host smtp2.infineon.com[217.10.52.18] said:
    550 #5.1.0 Address rejected. (in reply to RCPT TO command)
    
-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
