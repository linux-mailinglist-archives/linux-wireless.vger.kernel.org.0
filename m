Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338B761CF4
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjGYPIu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 11:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjGYPIp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 11:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3261FCF
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 08:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2BF61782
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 15:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AAAC433C8;
        Tue, 25 Jul 2023 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690297718;
        bh=wTY69qIWieqj5OJS6H4W+MfTyMM37cqETgvYsu3imf8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aVaipoCJmzp+d/2lZyBcy7aylV8gQOhNTDmbpLgQUJSr5DoQcNzNS82yHA+Bc8PHL
         sbUjTRjcxogLCRYw3Cwll8ipbQfE464Ttnt42Zx0Zv9+13yPQTPxqD+vesaGEZ2Fcg
         xTPVpZpa9xL0wPSXFfuHObFvWahVBqMGaDKEuPPG8giiQlWGZgRu78n5PzfnV3/UWL
         yhqWjOV8suAuAVStZtqCGT4AG/ptjhkInDOYoKkfW3DBkdWmU31JkK4Uf0H+AN8RvS
         iF6lAPcTI6yRfNkFMAevDzayjgOfuBMVuVghdVge+WPfyLQ92Qk1pN4RTcpnaSlLsv
         z4gGp3lxv6ouA==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <dmantipov@yandex.ru>, <Amisha.Patel@microchip.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: wilc1000: simplify TX callback functions
References: <20230713082616.112160-1-dmantipov@yandex.ru>
        <df4db7fe-b51d-5eba-dd9d-527753903eac@microchip.com>
Date:   Tue, 25 Jul 2023 18:08:35 +0300
In-Reply-To: <df4db7fe-b51d-5eba-dd9d-527753903eac@microchip.com> (Ajay
        Kathat's message of "Thu, 13 Jul 2023 21:33:46 +0000")
Message-ID: <87r0ow111o.fsf@kernel.org>
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

<Ajay.Kathat@microchip.com> writes:

> Hi Dmitry,
>
> On 7/13/23 01:26, Dmitry Antipov wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>> 
>> Drop unused second argument of TX callback functions and use
>> 'struct txq_entry_t *' as the only argument, thus removing
>> 'struct wilc_p2p_mgmt_data', 'struct tx_complete_mon_data'
>> and 'struct tx_complete_data' (actually intended just to
>> pass callbacks parameters) as well. This also shrinks
>> 'struct txq_entry_t' by 'priv' field and eliminates a few
>> 'kmalloc()/kfree()' calls (at the cost of having dummy
>> stack-allocated 'struct txq_entry_t' instances).
>
> I'm just curious to know if you have tested this patch with the real
> hardware.

There was no response from Dmitry but I suspect this was not tested on a
real device. Submitting patches like this without any real testing is a
bad idea as the risk of regressions is high. Please _always_ test
patches on a real device. Only exception are trivial patches which can
be easily reviewed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
