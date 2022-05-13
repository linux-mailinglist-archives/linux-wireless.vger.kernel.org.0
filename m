Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75B525B7C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377285AbiEMGYX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 02:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiEMGYT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 02:24:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9305828E4E3
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 23:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40EECB82C52
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 06:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65800C3411C;
        Fri, 13 May 2022 06:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652423056;
        bh=eymVdpYJtDpzpCVbtneJ6XoAhBjlEqEkQU0jvJxDDIU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Hqcdi0zfVxIsRHVhP1lezCg7Oe9OYyhhqPlLciWyz1yCi9Wkj4qjDb/z7gTX6c9Io
         b8bEqBSS5ZvOOVzRGwuVXQPBOafGz7+yujGmqHXUTKsEFHx0c+JkYa9Ugcqn/7uR7d
         ICifTxIMAI/j8qkdneCeeornLSCsazlUeoOQ8zZzrneIRLYimro6kX+crwS4smuTaq
         tcJjoaNE/ZCLFD2U9ZwNA8VeCE0vmH6MCXwo76OU38NAKDvGOMrLBMgbKTqUnVOVvi
         pO6pa8NBuIzhVTo7fMkjCj1jldRP2aaq5ON5N60y0RccNQMWMHEB7MMgwQZ5h3yqqM
         y/b7v60Pa3VuQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2022-05-12
References: <32474297-71bc-9f16-a2ce-d90d9e37082b@nbd.name>
Date:   Fri, 13 May 2022 09:24:12 +0300
In-Reply-To: <32474297-71bc-9f16-a2ce-d90d9e37082b@nbd.name> (Felix Fietkau's
        message of "Thu, 12 May 2022 11:39:16 +0200")
Message-ID: <87r14y54s3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.19
>
> - Felix
>
> The following changes since commit 2c33360bce6af0948fa162cdbd373d49be5a7491:
>
>   wfx: use container_of() to get vif (2022-05-11 08:32:57 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-05-12
>
> for you to fetch changes up to 50662fae4fad14dace11954a2e8e5212330de14a:
>
>   mt76: mt7921: add ipv6 NS offload support (2022-05-12 11:33:54 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.19
>
> - tx locking improvements
> - wireless ethernet dispatch support for flow offload
> - non-standard VHT MCS10-11 support
> - fixes
> - runtime PM improvements
> - mt7921 AP mode support
> - mt7921 ipv6 NS offload support
>
> ----------------------------------------------------------------

There's one warning:

In commit

  3b4852e3cfad ("mt76: mt7915: do not pass data pointer to mt7915_mcu_muru_debug_set")

Fixes tag

  Fixes: 1966a5078f2d2 (mt76: mt7915: add mu-mimo and ofdma debugfs knobs")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
