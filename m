Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABD5B1541
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 09:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIHHBq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 03:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiIHHBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 03:01:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3950B9A682
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 00:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C68CB61B7C
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 07:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D05C433C1;
        Thu,  8 Sep 2022 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662620500;
        bh=lqYvB4+IpnbYi8IFTJlpZPXf0fjAarRD8vOeRlhaZGo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TzB2d6BJ7+9aIkrruyuZDUQyffsZZR0PUYJfl6jCQl9IthCchnVJkJhOn3+K9O1ql
         p/lQraacm6rcSk6tgLQz8a1bSpIexh0sdnofQsSsDxX3taclZmYRQ0paTCdrQp5/QM
         VeY0TVXnGxa3s5R884Gt0lOLueQ46W1akZDLVseEcJBKQ0CRMAVas+zGOhB77Xe6Ao
         j/De6CltnEmf+zWuX61qyQsByjX+S+RlZeQU1YtD9XIq9744V7JaA9X1T828r9mIuQ
         toFKCCeOgW4089UUYFhwayv/Fpb5oiOoX1JH8konWULDXfsHYPSnGrCu/dihRJihZ2
         R0NSAZdmM0Stg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6.0] wifi: mt76: fix reading current per-tid starting sequence number for aggregation
References: <20220826182329.18155-1-nbd@nbd.name>
Date:   Thu, 08 Sep 2022 10:01:36 +0300
In-Reply-To: <20220826182329.18155-1-nbd@nbd.name> (Felix Fietkau's message of
        "Fri, 26 Aug 2022 20:23:29 +0200")
Message-ID: <87v8pybb8v.fsf@kernel.org>
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

Felix Fietkau <nbd@nbd.name> writes:

> The code was accidentally shifting register values down by tid % 32 instead of
> (tid * field_size) % 32.
>
> Cc: stable@vger.kernel.org
> Fixes: a28bef561a5c ("mt76: mt7615: re-enable offloading of sequence number assignment")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I assigned this to myself on patchwork and I'll queue this for v6.0.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
