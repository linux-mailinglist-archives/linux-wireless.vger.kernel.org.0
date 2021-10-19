Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F727432E22
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhJSG02 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Oct 2021 02:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhJSG01 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Oct 2021 02:26:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D4C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 23:24:15 -0700 (PDT)
Date:   Tue, 19 Oct 2021 08:24:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634624652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmonJHMmw4GJweFmaKQYoWKH7A+91AtuAa0M2axQW1Q=;
        b=r90lG1FLnXPzmAgpW9dQeuAtPFIMsb2nIKdboT28Cpvfjg684ekb7Y/reqBg8ec+3kMeQs
        Cl9z+X71DE20XkCunlZp0LXsaUl9yfYYw5Q+FFix8LQw9067SKuKf/M+UGhl5+Q2CjTlqF
        l3sjdUO6ZazFNaHX6tbkbOUQFjCQlgszfHlI8vxOWPrFmxfZNr6sTypuRCLeyEfL4FuFCn
        kA/XS+ZoRG8utNET4/d6esHiGBR+p/mUxwpUZH6IlZO3pXiEEv0YMFRRjwFitdZTluF7mg
        hN95VGb1ypYj7U2Y6xII8YyMMAQhqWZv2iWbcab+JnKY0lxhjqx63VN2jZjqJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634624652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmonJHMmw4GJweFmaKQYoWKH7A+91AtuAa0M2axQW1Q=;
        b=kdTmGPp63//GoO47P6UIRWYwbu0WH2zG2U6PhbqVYM+zbgP5TVkSlRsBFv+ZAbp3cira/5
        LqzcyIIzp4UrVADQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH 08/15] wireless: cisco: use eth_hw_addr_set()
Message-ID: <20211019062410.ivoiqon45j6tbe5z@linutronix.de>
References: <20211018235021.1279697-1-kuba@kernel.org>
 <20211018235021.1279697-9-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211018235021.1279697-9-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-10-18 16:50:14 [-0700], Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
> Use dev_addr_set() to match the existing logic.
> setup_card() is always passed netdev->dev_addr, so pass the netdev
> pointer instead and assign the address using a helper there.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
