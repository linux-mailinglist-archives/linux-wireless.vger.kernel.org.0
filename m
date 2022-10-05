Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD74C5F506E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJEHpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJEHpi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 03:45:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DF421804
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 00:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 707BBB81C76
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D1EC433C1;
        Wed,  5 Oct 2022 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664955930;
        bh=XUZcFeY5yksZjZ2kF0J5CSErHyqES2H/jY/sTtWo+hg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bEO4Dai3CjtCx5yD84C6gteVSmo88CbEyhZIwgIOV3H4tqD3nz63E657wo3A6g66m
         4orUV3fwV1inc56TjREj616Qb/3n3F5arXwahOtg26i7tQRvZD+W3rY1mdsoBjBxz9
         o5Zgl8nuC3iecpz9ibJ4l5w9/TBQJp1sf5reqPukO6k6ABaQGJRqQTuREyy0NH23Ub
         5QuJxZtT/3COByJnpa9M0Q9vGvXOcOB2xYbE8HGe87qXOhdA0FPb7i7V7mgQCZznxl
         HtiytVKgZyFHmNxkIAVah4KMvZM5wMDUCht7dqt5/7hcXZezC3ME6T1DmrPooQiQJK
         60Ic7BmO2QY2A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH 1/4] brcmfmac: add creating station interface support
References: <20220929050614.31518-2-ian.lin@infineon.com>
        <166495571909.5945.9074519493480723249.kvalo@kernel.org>
Date:   Wed, 05 Oct 2022 10:45:23 +0300
In-Reply-To: <166495571909.5945.9074519493480723249.kvalo@kernel.org> (Kalle
        Valo's message of "Wed, 5 Oct 2022 07:42:03 +0000 (UTC)")
Message-ID: <87czb667e4.fsf@kernel.org>
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

> Ian Lin <ian.lin@infineon.com> wrote:
>
>> From: Wright Feng <wright.feng@cypress.com>
>> 
>> With RSDB device, it is able to control two station interfaces
>> concurrently. So we add creating station interface support and
>> allow user to create it via cfg80211.
>> 
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>
> 3 patches applied to wireless-next.git, thanks.
>
> 2b5fb30f8ff5 brcmfmac: add creating station interface support
> 4388827b87d8 brcmfmac: support station interface creation version 1, 2 and 3
> 1562bdef9251 brcmfmac: Fix AP interface delete issue

I didn't notice that "wifi:" prefix was missing, please always add that
in future patches. More info in the wiki below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
