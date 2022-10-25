Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894C260D53F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Oct 2022 22:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYUJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Oct 2022 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJYUJg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Oct 2022 16:09:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32ADD8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 13:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B32B81EAC
        for <linux-wireless@vger.kernel.org>; Tue, 25 Oct 2022 20:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183E2C433C1;
        Tue, 25 Oct 2022 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666728567;
        bh=cwe9wFJMPffYEDWB/0g1DlQTTxY9z46bTTGMhYOtXtQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ha6TWGROqDD6VRM4JXTg+RQqZMlFPp6pQbasrjJmknnEjmWNJYSUduASb2nINp2Zv
         Ezyg6cr9Chw/BEX8Rs82Ry4LzCEhsyNuQ33L/axxYPn9o78N0jbRzilMXR9OXP7/SJ
         dIfwJ6L0cQSqR0DsU+0BrU1mh4usFJjfoyejsACx8pXgClNp8sVycMP2ZYBaSg9gmX
         p/KK43+GNt/PW1HqLJJNC6TuuozznL1n2Qs1GaCwfQkbWcEH08H4rrX7yhmiu0rcpi
         P+i9fEmAW66Zob8PRf94adA9aKym1z7HbmqTtTd/VPbxi5VMXFUmd4fhPKrOZser5j
         zd7oEL6cnYFqg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Chi-Hsien Lin" <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <brcm80211-dev-list@cypress.com>
Subject: Re: [PATCH] brcm80211: brcmsmac: Drop BMCMA consistency check
References: <20221024124002.10120-1-linus.walleij@linaro.org>
        <1840a6374e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date:   Tue, 25 Oct 2022 23:09:23 +0300
In-Reply-To: <1840a6374e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        (Arend Van Spriel's message of "Mon, 24 Oct 2022 16:26:42 +0200")
Message-ID: <87wn8ny8b0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On October 24, 2022 2:40:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> The driver looks up the BCMA parent GPIO driver and checks that
>> this succeeds, but then it goes on to use the deprecated GPIO
>> call gpio_is_valid() to check the consistency of the .base
>> member of the BCMA GPIO struct. Surely this belongs in the
>> BCMA driver: we cannot have all drivers performing cosistency
>
> Should be: consistency
>
>>
>> checks on the internals of things they are passed.
>
> Apart from the typo in the subject and missing wifi: prefix (replace
> 'brcm80211' by 'wifi')...

I can fix those.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
