Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3E36A1FD8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBXQm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 11:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBXQm0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 11:42:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C66B144
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 08:42:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F672B81CAD
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 16:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD5C433EF;
        Fri, 24 Feb 2023 16:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677256942;
        bh=bx60CYoaNoZxomfYUfBlsFJeCUbn1kDuOdNIeJdjd4I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QGbxZS9HIp7ra+HpDfW7YqYoW/lEL1Xa1w4ItG7Gx1mpVy3R5+XUAzypyNYyBqegC
         keYqrsi0gD6B8l5rUbSUyk/posk5RBxTD7uVqtBonP9/e6z9l5OAiG8s3aFXNVLqgt
         kaaOXzXPxIcIthZZ8BM9kURR9UbJTTdIcKuQaXFWEKJ4Almh5cIKYOQ8SLXyad1fZL
         lOjDWax63WKsSy5JEOb5nK2d2JKKeS6Xe/taJK7UUGQMaaF1tCZBDx5NZaZrJxirk0
         SCjXc+5FounVjizBug1PaYXcHuW8n0CQwRzclDpVJEwX+wzFIQxsRc+T+eAH4pIjcK
         ibncyovmSvOVg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, helmut@subdivi.de,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH wireless] wifi: mt76: do not run mt76_unregister_device() on unregistered hw
References: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
Date:   Fri, 24 Feb 2023 18:42:16 +0200
In-Reply-To: <be3457d82f4e44bb71a22b2b5db27b644a37b1e1.1677107277.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Thu, 23 Feb 2023 00:10:25 +0100")
Message-ID: <87cz5z2exj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Trying to probe a mt7921e pci card without firmware results in a
> successful probe where ieee80211_register_hw hasn't been called. When
> removing the driver, ieee802111_unregister_hw is called unconditionally
> leading to a kernel NULL pointer dereference.
> Fix the issue running mt76_unregister_device routine just for registered
> hw.
>
> Link: https://bugs.debian.org/1029116
> Link: https://bugs.kali.org/view.php?id=8140
> Reported-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
> Fixes: 1c71e03afe4b ("mt76: mt7921: move mt7921_init_hw in a dedicated work")
> Tested-by: Helmut Grohne <helmut@freexian.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

I assigned this to myself on patchwork and will queue for v6.3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
