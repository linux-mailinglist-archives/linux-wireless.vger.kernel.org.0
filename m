Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3172DC29
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbjFMIRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbjFMIR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66F170C
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:17:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0D461446
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896F5C433EF;
        Tue, 13 Jun 2023 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686644245;
        bh=v97Pgmi2O3ZAlo7DqMrbTlr6gqnIz2L9jXl7WR2Mjfk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZZaGGjSE2XvY6utuR0FG36SfM6DeKX4MivxEEmxfHSpnaf2sSgMyBWMZgQEcoCvJl
         EgT1MQonaVzrtl8Bnb0wv0fHs8P0kUJwNcl9KKyHBZXLQ1BvPSzGAD8LE4Voa/nrVU
         +4LajWnvtbZlIyfiw230euIaxOpeHtV9NnPmocG/2RWKfC4ng9NsanyxU/U1zGKcV4
         1CpL1xqtAdiat7dg/5SJZ4sdHxBlc/2glaKES53KEdTpxcmtXAPaNnqTjK/kcfgSoa
         Yq1hgDAB7irJT5iFBy+4gL5IVdZegGLeNkz6m2NmVFA1X7RK3RkfAi5xhhdypF+nzp
         o30WA75CoVeZA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A reads as unused
References: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
        <20230601105215.27013-1-dmantipov@yandex.ru>
        <3b92f9205003f44187f7ebf7add6c3e0626e9646.camel@realtek.com>
        <0d1f24b9-a058-52fd-b669-54aa4e9162f9@yandex.ru>
Date:   Tue, 13 Jun 2023 11:17:20 +0300
In-Reply-To: <0d1f24b9-a058-52fd-b669-54aa4e9162f9@yandex.ru> (Dmitry
        Antipov's message of "Thu, 1 Jun 2023 16:50:02 +0300")
Message-ID: <87ilbrepyn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

>> Why not just
>>
>> rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
>> rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);
>
> Compiler with -Wextra etc. or static analysis tool may complain about an unused
> return value. As far as I know GCC has __attribute__((warn_unused_result)) but
> lacks an opposite thing, so (somewhat ugly explicit) cast to 'void' may be helpful.

I assume you are referring to this attribute:

#define __must_check                    __attribute__((__warn_unused_result__))

But if __must_check is NOT set doesn't it mean that checking of the
function's return value is optional? At least that's how I interpret the
meaning.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
