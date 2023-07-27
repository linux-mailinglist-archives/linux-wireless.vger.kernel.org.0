Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A337658C6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjG0Qdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjG0QdX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 12:33:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64F73A9A
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DD861DFA
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 16:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC98C433C9;
        Thu, 27 Jul 2023 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690475583;
        bh=++37BNE68MVdChM0LoCg87zzFbUTUqDbPyrk6Ns+omM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aOoqepxGAxgNou/FgG/YKjQ7UahRNLeWqXeT+HaXRG+UM3TckogBFg3sa/jD7uNwY
         GiUdGgPbNhQP8B/wJ2Tnmt1EVBudqzM+pKZXpT73EQabEn7mneosW55nqPSkYLRofX
         2UPdFKRlzIKdeSvixgmZ8wqivK941MewwbgiC8lORnQ4Wxpgm0yYqHvC9xwGi3z2Ci
         bmAOJtMfB6E7+Zj60zIuaIqKqV6sWWd2/pRXs/f0j8Geq9AqylggnMwOWgzVc0vyE+
         pvEIW692GmXtOLVW0RSHyMtLw76Zi+nr3w8V1Kh50crZNiTMtb1AE7xEzTj1uAN0H0
         ict9xf5yfWJbw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Ziyang Huang <hzyitc@outlook.com>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: Re: [PATCH] wifi: ath11k: simplify
 ath11k_mac_validate_vht_he_fixed_rate_settings()
References: <20230726092113.78794-1-dmantipov@yandex.ru>
        <b23c9ebe-b49b-0c8c-5e20-d02fd4134844@quicinc.com>
Date:   Thu, 27 Jul 2023 19:33:00 +0300
In-Reply-To: <b23c9ebe-b49b-0c8c-5e20-d02fd4134844@quicinc.com> (Jeff
        Johnson's message of "Wed, 26 Jul 2023 11:31:12 -0700")
Message-ID: <87h6ppz54z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/26/2023 2:21 AM, Dmitry Antipov wrote:
>
>> In 'ath11k_mac_validate_vht_he_fixed_rate_settings()', 'ar->ab->peers'
>> list is not altered so 'list_for_each_entry()' should be safe.
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> In the future please make sure driver-specific mailing lists are
> included in your patches when they exist in the MAINTAINERS file.
> Adding ath11k@lists.infradead.org

And this is actually v2, there was already v1 sent earlier this month:

https://patchwork.kernel.org/project/linux-wireless/patch/20230704174753.76968-1-dmantipov@yandex.ru/

Dmitry, PLEASE read our documentation from the wiki below. You need to
always mark the patch as v2 and provide a changelog what changed since
v1.

And especially slow down with the rate of patches you are submitting and
instead use that time to learn the process first.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
