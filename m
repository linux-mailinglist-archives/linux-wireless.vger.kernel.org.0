Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A289E788131
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjHYHrR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 03:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbjHYHrH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 03:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F70C1FCA
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 00:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0552961567
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 07:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D856EC433C7;
        Fri, 25 Aug 2023 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692949624;
        bh=vpWMNFFp37Wpc/BeG4cbX3GZ7yuXUNsmebR40KDAuQE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZGvUD6VGqiJ/BD7tjRLo1958ecnJZ7TskDnxXNTE6kaDO+3U64RtsJkJs1jACIAkN
         x8CwsfPGtR3ZhtqORzfatpuFtzrtrJje6pkkmLP0jL3+D7jmfKsISDxmI6OLFRwoL4
         /tDP1bzxIqJ40xRYTyzDYcsEfTZgY9eaoMsMbBrU3wJHmWBOzUfskHtRxsLUFdHKK9
         UdurmTi2H4xenoyQOWYn/qoEgn9RXDIDhlq8Ck/KuKNX+UDyRFK+1cun30DzKEn9Eu
         B5qevSkF1wLsYHKhQ2nm4/xzoCiQ6UzcjMpOOkazvFlxzN9mrKJ1D1p6JZL2h2kIKx
         2ibaX6NcIvS7Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Antipov, Dmitriy" <Dmitriy.Antipov@softline.com>
Cc:     "khoroshilov@ispras.ru" <khoroshilov@ispras.ru>,
        "dmantipov@yandex.ru" <dmantipov@yandex.ru>,
        "quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [lvc-project] [PATCH] [v2] wifi: ath10k: cleanup CE initialization
References: <20230823095008.50515-1-dmantipov@yandex.ru>
        <fb14be76-c3af-8ede-38aa-8b88f3cea7b7@ispras.ru>
        <0eed7a68c03555cc815959b9fa32b37657f8aeda.camel@softline.com>
Date:   Fri, 25 Aug 2023 10:47:00 +0300
In-Reply-To: <0eed7a68c03555cc815959b9fa32b37657f8aeda.camel@softline.com>
        (Dmitriy Antipov's message of "Wed, 23 Aug 2023 10:13:01 +0000")
Message-ID: <877cpjh8cr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Antipov, Dmitriy" <Dmitriy.Antipov@softline.com> writes:

> On Wed, 2023-08-23 at 13:03 +0300, Alexey Khoroshilov wrote:
>
>> > v2: adjust to match series
>> 
>> Do mean that nothing has been changed in the patch regarding the
>> previous version?
>
> Usually it is, including the cases where some patch of the series
> is changed so the following ones are applied with offsets and thus
> better to be regenerated.

Saying something like "no changes" or "rebased only" would be more
understandable. It is assumed that when sending a new version of the
patchset that offsets can change so saying "no changes" is good enough.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
