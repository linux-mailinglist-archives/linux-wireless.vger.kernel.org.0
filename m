Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11B0784273
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjHVNwv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjHVNwu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 09:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543BFE4E
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 06:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA33564BAA
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 13:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9142BC433C8;
        Tue, 22 Aug 2023 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712357;
        bh=ogLfVaAECGa5mmo0mVqPMk4h28Fw9C6EgHrYjf2b9Rk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uov8BMgkYnR/7UwF/nmEnmrkwV+S21QPWiHA8HTIuU6tV1pePjcFpYmrG9QGrkQus
         0fyV8lIQvUBm9hYSvK7onx4zRc08LhYsAqKxndpxRKWCs7z7hXHhrdTas4HTiUCJfq
         UJYXq7kJ3HCphUDBlsh+N5Tr8oclqJksfnu5Ik7IuVLp9D7tYpUJ9Gpt4H2m8vwcUP
         4Cq5d0CJsW/8RhHQAWiCW92g7wHARh2b7myxwKLAMz4Pjn0LvHnEOoFGMi33YdiOHz
         bsoZopXAIOVivD+4UebSDYKhU+jMyx5xvbNJOoYCgBFNlFnGbRFwXZ+MPDz92eiqRW
         yk/PLumTi6tjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Missing Patchwork entries
References: <0659b81b-0d1f-7797-7968-f81a0e5df365@yandex.ru>
Date:   Tue, 22 Aug 2023 16:52:34 +0300
In-Reply-To: <0659b81b-0d1f-7797-7968-f81a0e5df365@yandex.ru> (Dmitry
        Antipov's message of "Tue, 22 Aug 2023 16:39:52 +0300")
Message-ID: <87350bi3q5.fsf@kernel.org>
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

(adding linux-wireless so others can learn as well)

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Hello,
>
> has Patchwork experienced some technical problems in the second half
> of June? Below is what I'm seeing at
> https://patchwork.kernel.org/project/linux-wireless/list/?page=2, and
> there is a visible gap between 2023-06-16 and 2023-06-29.

Your filter is set to show only New and Under Review states. If you
change the filter to show all states when you can see lots of patches
from that period:

https://patchwork.kernel.org/project/linux-wireless/list/?state=*&page=8

Unfortunately patchwork is not very intuitive to use and has pitfalls
like this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
