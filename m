Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1BD47B2FF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbhLTSjy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbhLTSje (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:39:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B42C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 10:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AC69B81082
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 18:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6BCC36AE8;
        Mon, 20 Dec 2021 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640025571;
        bh=IrE7StyS9P5oiN8AM78b7G0DKxcXBjR5pIRoDMQGIlU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jzb8J+0xImGVkKzHc6O6+rx3p7CVXHqOPrmH8vZXaW1Bp6ujqoIzlemjyD5AxOnMS
         2ssRBTHue6p4DmbamTIovNQANPCxOEFtjf7uMJRRtzIaw4up8yTZQ/CKH9DyMjQg0G
         J+cIkT0BWg+7Xms9VDbCyWQV67CsedKTuLhwXZVgJ7S8gNnBX357Iw5itCUFqbex/S
         w0TqgAEguvMMTspbP4nu4f65H4ERI7JaSKKUKGVLFBJfPhif79KDEe/Sb7a49r23Z/
         IQPx9gU5Tibti0Ox0ldpHXPW+cHIYNkxcu7vvKCoIXzXZk4nHFWWRp2yL4OLPhUroF
         cHDcfX1p66NDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-12-18 v2
References: <de06ccae-1983-33bf-7cb2-908aee6b2412@nbd.name>
Date:   Mon, 20 Dec 2021 20:39:27 +0200
In-Reply-To: <de06ccae-1983-33bf-7cb2-908aee6b2412@nbd.name> (Felix Fietkau's
        message of "Sun, 19 Dec 2021 15:27:32 +0100")
Message-ID: <87mtkv9l40.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my updated pull request for 5.17 with a compile fix for rebase issue
>
> - Felix
>
> The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9:
>
>   Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-12-18
>
> for you to fetch changes up to b1460bb4eadf4b0bf5afe79fb4d25b9d985f2879:
>
>   mt76: mt7921s: fix cmd timeout in throughput test (2021-12-19 15:24:05 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.17
>
> * decap offload fixes
> * mt7915 fixes
> * mt7921 fixes
> * eeprom fixes
> * powersave handling fixes
> * SAR support
> * code cleanups
>
> ----------------------------------------------------------------

Pulled, thanks.

I switched my email to kvalo@kernel.org and my codeaurora.org address
will stop working soon, please update your address book and scripts.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
