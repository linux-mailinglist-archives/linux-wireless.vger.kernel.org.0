Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54964EEC65
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiDALaQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiDALaP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C64055207
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DB661851
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A345C2BBE4;
        Fri,  1 Apr 2022 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648812505;
        bh=OGPs7QPfIe4uK6qCD5NhS8JC+pB6ZWfO4gHmnuvtubI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DrkzPJtawXy3ZOUJIaVZnBj9qE1Ct7rfFBtRFR9hy5705d46Lm5KZ2wZ8X0HOFFHb
         xQaKyOOKHRZlDFlCcuPRybWNLD6uL/kEL0MJEc7z9aOF3dc2LCA1YwTpdvBRiM8BK8
         HmwpwR7IX7KWbdsuVNi5w+kbRwTgNL2vU5tARgpkhhlyg9zO980rTakw547pOSLxfs
         YH0NDkfCew1ihSrZBXMi5ipYWCCl0VM9246Abgw53kjH8gqS/0VRZZXoQG0T9EQJ/I
         lch6iX682ViLO2Wc9Q6ovDwLqNpMBFAwOlF/hUssF+yYj5oQUsZ3UdjQOC5yXFMbDa
         eGf0GaCC+awIQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Nagarajan Maran <quic_nmaran@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5.18] ath11k: fix driver initialization failure with WoW unsupported hw
References: <20220331073110.3846-1-quic_nmaran@quicinc.com>
        <87sfqyv1td.fsf@kernel.org>
        <2f25bb87e665488b30f6fdaa5877ad8b5b19da0a.camel@sipsolutions.net>
Date:   Fri, 01 Apr 2022 14:28:18 +0300
In-Reply-To: <2f25bb87e665488b30f6fdaa5877ad8b5b19da0a.camel@sipsolutions.net>
        (Johannes Berg's message of "Thu, 31 Mar 2022 13:59:04 +0200")
Message-ID: <87ee2hujot.fsf@kernel.org>
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

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2022-03-31 at 13:44 +0300, Kalle Valo wrote:
>> > 
>> > Fixes: ba9177fcef21 ("Add basic WoW functionalities")
>> 
>> Fixes tag is wrong, it should be:
>> 
>> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
>> 
>
> $ git config --global --add alias.fixes 'show -q --format=fixes'
> $ git config --global --add pretty.fixes 'Fixes: %h ("%s")'
> $ git config --global --add core.abbrev 12
> $ git fixes ba9177fcef21
> Fixes: ba9177fcef21 ("ath11k: Add basic WoW functionalities")
>
> :)

Hehe, really nice! I added this to the wiki:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#fixes_line_is_incorrect

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
