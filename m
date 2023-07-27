Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42EE76467E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 08:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjG0GK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 02:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjG0GK0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 02:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7830F1731
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 23:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4EF61D30
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 06:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFF2C433C7;
        Thu, 27 Jul 2023 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690438224;
        bh=b1xzARFcfbsh47td8lDof2znYm6SZgwcnpC+n8lHdr8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ML29VomnBsCtFJ0bDngtcOR1CdC/PqR8FgQWVhDSdlJn+bx+MMQNeNFcYT5nmSfSQ
         rlFRr0WnZncYjN+cWWhD7dUxTUoQyPknD/QB3w8QubKKm4bczP/+Ery4G2/+pAy3yY
         vvh2ZKZf8wR9es8TaSMCHd45LN//knEHsjk4ofov7eBWeT56GQwYsAj3P3IsM+F6hX
         Zy/QljUo+43NcYMPW4LUS5Pv2wLz3n/VI/6D4q9qu6mmRzN573FkJLz0NkEPSXLb8B
         ofADyhWzyiiFOfrlejxj6sWfxpfvJBuXQRgrOmJNAvZZbgKxrLaaptWrck2RJ9pngb
         8QpzE0h5bVR5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Polaris Pi <pinkperfect2021@gmail.com>, matthewmwang@chromium.org,
        kuba@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
References: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
        <ZMGO3r44oOtMck7S@google.com>
Date:   Thu, 27 Jul 2023 09:10:20 +0300
In-Reply-To: <ZMGO3r44oOtMck7S@google.com> (Brian Norris's message of "Wed, 26
        Jul 2023 14:23:42 -0700")
Message-ID: <87ila528c3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Sun, Jul 23, 2023 at 07:07:41AM +0000, Polaris Pi wrote:
>> Make sure mwifiex_process_mgmt_packet,
>> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
>> mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
>> not out-of-bounds access the skb->data buffer.
>> 
>> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")
>> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
>> ---
>> V5: Follow chromeos comments: preserve the original flow of mwifiex_process_uap_rx_packet
>> V6: Simplify check in mwifiex_process_uap_rx_packet
>> V7: Fix drop packets issue when auotest V6, now pass manual and auto tests
>
> "auto tests" isn't clear to anyone not familiar with Chromium stuff.
> It'd be courteous to at least make an attempt to describe what this
> means (even just, "ChromeOS WiFi test suite" or something). For the
> record, I believe that's approximately this?
>
> https://chromium.googlesource.com/chromiumos/third_party/autotest/+/HEAD/docs/wificell.md
>
> Anyway, I think the patch contents look good:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

I'm nitpicking but now that you (Brian) are a maintainer I would prefer
that you use Acked-by instead of Reviewed-by. Patchwork shows the
statistics (A/R/T in the web ui) and then it's easy for me to see that
the patch is ready to be applied. This is for the future, no need to
change anything here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
