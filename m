Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3233508798
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359795AbiDTMDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343673AbiDTMDW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 08:03:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974334664
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 05:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B142B81D0B
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 12:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66390C385A1;
        Wed, 20 Apr 2022 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650456034;
        bh=s4h4iNGNSRMhU8eoKlzQfxtlVjp6pqF5NBiJ2H+kiLc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Teh/2Tvr3OIp3cB16oakEVyv64/IzLvum6oqV0yZAyvRsWx0HXmmgtJNbrwopwWpL
         qSjdesyGba+FD30dqUN/fhiT45iIiEY5vTVYrdTfxQ8qRjc5zwrx5dtMWjjoHnsBcC
         PPvJ5UDPs4VYKZC8yVz3pCD61AYvybwTy4dtEJAbChiWVA1nEq3qDX+Pltyzb+Vcou
         j5HKjoCGKcx+9iFLnx5ldWE+RP2WZ4KHf/3WwnGgAspUFKBK28uiwpv+pgPxSVxZx6
         NcDnlpdYDQjXUjHM7c/07aNVuiXqjnI8iY7GQ1SqGi6JN+jlSl0c5zySngsvbOoc2N
         W6XyGKDc2yC9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 1/9] ath9k: add QCN550x device IDs
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
        <20220418071313.882179-2-wlooi@ucalgary.ca>
Date:   Wed, 20 Apr 2022 15:00:31 +0300
In-Reply-To: <20220418071313.882179-2-wlooi@ucalgary.ca> (Wenli Looi's message
        of "Mon, 18 Apr 2022 00:13:05 -0700")
Message-ID: <87tuaonew0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

No empty commit logs, please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
