Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A966F54D6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 May 2023 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjECJe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECJe6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 05:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F03C14
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 02:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F7562B61
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 09:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B06AC433D2;
        Wed,  3 May 2023 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683106496;
        bh=Y/ElWgpSd8y9Qqlt1D2zfRznNNoTNJCzcng+fYIZNSo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BuwsCKAFXz0ck49jhINUs/YrsshSNkLYjnWlwwh6RvM7J3WIBUvjqGmqFr9GbIW7h
         u4U19Ud2l0plWs/5R9nJQoGljQ8ap1klMO1HjYlroeLdEvHSpXS/iejPJ+/ATOLMDm
         9/uabj4doR2eV/ePtPDfkiG1Arpkv2T37ZKeLicrJTjVUD9zVgwjwK+1ELvJrAWdgb
         jr9byUrM+vQp2kpXmJu+F5JQGoBhq0MoHMcepGybEgXY2i3uqvKY2zmb9vCOncpXSc
         Jim0n+WMHY7CU0//0wXSBflm++ft9LBhhiO+31FbwfnOFo94n/c7jQVAIx1Mytv5Yw
         JXv+TyjdTWKOQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: mt76: mt76x02: remove WEP support
References: <d560f1a16c9024b6e4029bd0baf53384f4552f5a.1683020788.git.lorenzo@kernel.org>
        <871qjyosnd.fsf@kernel.org> <ZFISvk7QzpqVkV/L@lore-desk>
Date:   Wed, 03 May 2023 12:34:53 +0300
In-Reply-To: <ZFISvk7QzpqVkV/L@lore-desk> (Lorenzo Bianconi's message of "Wed,
        3 May 2023 09:52:30 +0200")
Message-ID: <875y99rc5e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Get rid of WEP support in mt76x02_set_key routine since it is not longer
>> > supported upstream.
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> You marked this for wireless-next so should I take this directly?
>
> it is not a fix, "wireless-next" is just the default subjectprefix for my
> git tree, sorry for the confusion. I think it can go through Felix's tree.

Good, thanks for for the confirmation.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
