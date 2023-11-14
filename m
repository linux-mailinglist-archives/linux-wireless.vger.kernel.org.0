Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE77EAD8B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Nov 2023 11:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjKNKEy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Nov 2023 05:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKNKEv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Nov 2023 05:04:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0206D5E
        for <linux-wireless@vger.kernel.org>; Tue, 14 Nov 2023 02:04:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581AFC433C9;
        Tue, 14 Nov 2023 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699956283;
        bh=YFAhdH6RMeRY/BH3hLp02ssXMzT9DAy87cwdL0UpOZw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UgyKzLgLKa/dC3o2WONUOXb9EBMesWs+Td+oSNqWQyxqOcHA1xgOnBFcGp8MSE/jY
         NOaSvrcCl9STfIzdQvSQ1/v74rsDqOBcXWmeuZeNSPVQAu04xLHhhq6vuPlXaT7e6h
         1FXp/1RwcAK0039sXPKvwQgSMnMgpJZ1ry3W5Ju3novB8rDOvPI8CBWrfo+kaagTR1
         FNzXNHUpGKy6bP2tYdmtvBd2pt0DwBp2bJ4nGZdp9Dhj5ePJs4tYFcPMIdlHrFZgwB
         fMwl2t56BWjyBg9X2tcWlb9YLrM9jP/xAfg32ilZ2X2OAcJQZ0/gUDF5laFlG8oYMT
         EW0RaySWJD+KA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        nbd@nbd.name, sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: Re: [PATCH wireless] wifi: mt76: mt7925: fix typo in
 mt7925_init_he_caps
References: <7de6e939dc75ee08f05bf1ee73253aa7eeccf28e.1699869649.git.lorenzo@kernel.org>
        <87cywdvox0.fsf@kernel.org> <ZVIXQx4nb25pO0EP@lore-desk>
        <87v8a5u8t7.fsf@kernel.org> <ZVIZaEsH4gedQNCN@lore-desk>
Date:   Tue, 14 Nov 2023 12:04:40 +0200
In-Reply-To: <ZVIZaEsH4gedQNCN@lore-desk> (Lorenzo Bianconi's message of "Mon,
        13 Nov 2023 13:41:12 +0100")
Message-ID: <875y24tzuv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> >> 
>> >> > Use iftype for interface type switch in mt7925_init_he_caps routine
>> >> >
>> >> > Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver
>> >> > for mt7925 chips")
>> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> >> 
>> >> What issue does this fix? In other words, what are the user visible
>> >> symptoms?
>> >
>> > Since we are using i (equal to 8 after the for loop above) instead of iftype
>> > we are missing some HE capabilities exposed to userspace (we are hitting the
>> > switch default branch). I agree this is something not so harmful and we can
>> > apply this fix to Felix's tree instead, up to you.
>> 
>> No no, this is fine for the wireless tree :) I just want to document if
>> this is fixing a real issue which users can see or just a theoretical
>> fix you found during code review. It makes handling fixes a lot easier
>> when we have this documented in the commit message.
>> 
>> No need to resend because of this, I can update the commit log if you
>> tell me what to add.
>
> ack, thx. I will more 'verbose' next time :)

But what I should add to the commit message? Is this just a theoretical
fix you found during code review? Or was there a bug report which
prompted you to fix this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
