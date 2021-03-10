Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C4C333CA4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 13:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhCJMb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 07:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCJMbS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 07:31:18 -0500
Received: from mx2.freebsd.org (mx2.freebsd.org [IPv6:2610:1c1:1:606c::19:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59142C061760
        for <linux-wireless@vger.kernel.org>; Wed, 10 Mar 2021 04:31:18 -0800 (PST)
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id BC3769D83C;
        Wed, 10 Mar 2021 12:31:11 +0000 (UTC)
        (envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 4DwWdq4Z6Wz3F5K;
        Wed, 10 Mar 2021 12:31:11 +0000 (UTC)
        (envelope-from bz@FreeBSD.org)
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.sbone.de", Issuer "SBone.DE" (not verified))
        (Authenticated sender: bz/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 73E401042;
        Wed, 10 Mar 2021 12:31:11 +0000 (UTC)
        (envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:31::2013:587])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.sbone.de (Postfix) with ESMTPS id 47C698D4A157;
        Wed, 10 Mar 2021 12:31:09 +0000 (UTC)
Received: from content-filter.sbone.de (content-filter.sbone.de [IPv6:fde9:577b:c1a9:31::2013:2742])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPS id 65D16E707DF;
        Wed, 10 Mar 2021 12:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:31::2013:587])
        by content-filter.sbone.de (content-filter.sbone.de [fde9:577b:c1a9:31::2013:2742]) (amavisd-new, port 10024)
        with ESMTP id vBufYr1yu8lY; Wed, 10 Mar 2021 12:31:06 +0000 (UTC)
Received: from [127.0.0.1] (unknown [IPv6:fde9:577b:c1a9:4902:408a:bbb4:e93e:18d9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.sbone.de (Postfix) with ESMTPSA id 919B4E707B5;
        Wed, 10 Mar 2021 12:31:06 +0000 (UTC)
From:   "Bjoern A. Zeeb" <bz@FreeBSD.org>
To:     "Kalle Valo" <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, luciano.coelho@intel.com
Subject: Re: [PATCH iwlwifi-next] iwlwifi: de-const properly where needed
Date:   Wed, 10 Mar 2021 12:31:05 +0000
X-Mailer: MailMate (2.0BETAr6151)
Message-ID: <F2DC47F0-A92D-40C7-A268-3F6C9ADFFA78@FreeBSD.org>
In-Reply-To: <87tupvcp6t.fsf@tynnyri.adurom.net>
References: <alpine.BSF.2.00.2102261652510.72241@ai.fobar.qr>
 <87tupvcp6t.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1 Mar 2021, at 7:23, Kalle Valo wrote:

> "Bjoern A. Zeeb" <bz@FreeBSD.ORG> writes:
>
>> In order to de-const variables simply casting through (void *) is
>> not enough: "cast from 'const .. *' to 'void *' drops const 
>> qualifier".
>> Cast through (uintptr_t) as well [1] to make this compile on systems
>> with more strict requirements.
>> In addition passing const void *data to dma_map_single() also
>> drops the (const) qualifier.  De-constify on variable on assignment
>> which may be overwritten later.  In either case the (void *) cast
>> to dma_map_single() is not needed (anymore) either.
>>
>> [1] See __DECONST() in sys/sys/cdefs.h in FreeBSD
>>
>> Sponsored-by:  The FreeBSD Foundation
>> Signed-off-by: Bjoern A. Zeeb <bz@FreeBSD.ORG>
>
> Why are we using the const in the first place? That sounds like a bug 
> to
> me.

For the he_cap cases I’ll leave this to Intel to answer as they added 
the
comment that it is writeable.


For the dma_map_single(.., DMA_TO_DEVICE) having const data is probably 
okay.
This seems more (and I can only say from the distance not knowing Linux 
internals)
that the Linux KPI doesn’t/cannot cater for it.  I am not sure why it 
would need
to change a virtual address along the lines and the argument is not 
“const”.


> BTW, your patches are hard to read due to excessive context, I guess 
> you
> are using a very large context value with diff? Our recommendation is 
> to
> use git with default values, see the wiki below for more info.

Sorry.  I’ll fix the three casts you mentioned on the other review and 
send out
v2 with less context for all of them.


Best Regards,
Bjoern
