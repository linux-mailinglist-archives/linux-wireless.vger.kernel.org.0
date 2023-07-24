Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986F475FE8A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjGXRyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGXRyI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 13:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDA173E
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F9DA612F4
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 17:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F0C433C8;
        Mon, 24 Jul 2023 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690221083;
        bh=BZOrA5Om0Yb/tOxiSlYhYhBS0gk7LhsJ/6Vdqi+GtP4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=o2GEVnRimB3RjPhxOrerCgoEbsW9lsF2MBJ1gtfAIw+l/0OAr7S72krqErJIwJmKm
         kFYmMj53CPbLTmZtdijf1LoWBCZttNdXc3+Gaprz+1oAITXD2dSIQidsUw85wUs9UZ
         zSBAzMiCbjkkWpmfhKVvW2W3dXNgVUnVTObQadMBQNMDhrLBWCIsnx5h02XEMOQKdM
         IPPDTevY6Egw1rXvcqi9ZifisogME4fYYcmH175U2KEQZpUZCG+d9wTTQdNwc5BxYX
         14IRZpGSVnNOQS1vLtQiz9Ujr1ccgc57DblhdM+BFRsD6NwYe6JdFtLICGgjtIv7uo
         2FIySXSvAeKuQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 8/9] MAINTAINERS: wifi: mark b43 as orphan
References: <20230724104547.3061709-1-kvalo@kernel.org>
        <20230724104547.3061709-9-kvalo@kernel.org>
        <14cfb9d7-089d-607a-9062-eb9e268ffd67@lwfinger.net>
Date:   Mon, 24 Jul 2023 20:51:20 +0300
In-Reply-To: <14cfb9d7-089d-607a-9062-eb9e268ffd67@lwfinger.net> (Larry
        Finger's message of "Mon, 24 Jul 2023 11:44:09 -0500")
Message-ID: <87zg3l19lz.fsf@kernel.org>
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

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 7/24/23 05:45, Kalle Valo wrote:
>> There's no maintainer for b43 so mark it as orphan.
>> Signed-off-by: Kalle Valo <kvalo@kernel.org>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4e275c077608..a6538fd53887 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3391,7 +3391,7 @@ F:	drivers/media/radio/radio-aztech*
>>   B43 WIRELESS DRIVER
>>   L:	linux-wireless@vger.kernel.org
>>   L:	b43-dev@lists.infradead.org
>> -S:	Odd Fixes
>> +S:	Orphan
>>   W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
>>   F:	drivers/net/wireless/broadcom/b43/
>>   
> Kalle,
>
> Michael Buesch and I have been unofficial maintainers of this driver
> for years, but your change makes sense.

I would be more than happy to add you and/or Michael as b43 maintainers!
But I don't want to force anyone, it's not exactly a fun role :) Just
let me know what you prefer.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
