Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43C91244C8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 11:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRKhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 05:37:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48344 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfLRKhl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 05:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576665459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SktKQZsXLkZz8tbp2+l3lCaDvOYc6OBmZ+sYSZcMbc=;
        b=bhNfdWquakN8fM1To/Hv/sxEOFUGyAcL+eDcCGhyxMCr6qyMNx3is5DOfloqFdLxMUGGfJ
        4kFnUTNWtaWNR+YQDP4rwUFlVJc17AqaTMEXd+n9UEnlobVpQ2Twv6y7nsHPX3fhrB9Afh
        0w6xqq6Z3BRrEOTSIj6F6lPXSnRwBj8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-iWF7CZxcPqCOuo3_8OUAvw-1; Wed, 18 Dec 2019 05:37:37 -0500
X-MC-Unique: iWF7CZxcPqCOuo3_8OUAvw-1
Received: by mail-lj1-f198.google.com with SMTP id k21so555215ljg.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 02:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8SktKQZsXLkZz8tbp2+l3lCaDvOYc6OBmZ+sYSZcMbc=;
        b=Ey4AMQkEq8m3YjTHv/cR2oF+Dn7u3bCEYvJV+L/18EOFWGagFdf/nHlzJxP1gl15Br
         g1ECaGVYhRetZvm5xqG+76hWApCdGNjXgRWFPO5MYrhIzuObfSgVdwC5fI4WJKsD9QY2
         XOuarM2HNwByTWDOJJbTofkL+YvT06iIEZWw4LfKuMcFFld5XCUnfbgpmFnkJ0dyRDkt
         oPm+2fKJiNtlVrOK9Z3KyX1gNGO/jQ+n/C0RpW9D8tdoxMDH98OLJFhKh5LBEkY/mT3m
         iuU+EFzntrHiPdR2bvA/thfDY6CcpxbJ/bCViswZdac6dqCRT/hzLhH/Ftf6bdBybJyN
         wp9A==
X-Gm-Message-State: APjAAAUEfn+qEgKbuZ5gk2XN7h4JLJk0Wkrqh90qt00rIiWIdE3edbR+
        lSLslE8CcyX9eGFRIAb0Ku/qbMnwbnkmzMLUa3ToZtwaRhU8VteiuqlOf1nfRHecdCMFuX5qMTX
        G6P5x2uUBI/bTVIHeVUNEJFMo87A=
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr1320741lff.144.1576665456020;
        Wed, 18 Dec 2019 02:37:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzsm4BEwtdXYCE4SXm+dNHdcNZ7fckwOwHfd7+0KfcV46AHBqkzkspUmpyIyo2eN2s5LOIVnQ==
X-Received: by 2002:a19:c3cc:: with SMTP id t195mr1320733lff.144.1576665455819;
        Wed, 18 Dec 2019 02:37:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r26sm881937lfm.82.2019.12.18.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 02:37:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 148F3180969; Wed, 18 Dec 2019 11:37:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>, yiboz@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH 2/4] mac80211: fix issue in loop scenario
In-Reply-To: <c126d2ff0866faf9ac50b12920f0497b03b031f7.camel@sipsolutions.net>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org> <1576221593-1086-3-git-send-email-yiboz@codeaurora.org> <94471b2381bee394f9708eae8ba47129f3facd03.camel@sipsolutions.net> <6f092bd44cfc581a219bd0f0506cc636@codeaurora.org> <c126d2ff0866faf9ac50b12920f0497b03b031f7.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 11:37:34 +0100
Message-ID: <87h81x7wcx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-12-18 at 18:12 +0800, yiboz@codeaurora.org wrote:
>> 
>> Yes, this is a fix to the first patch. Actually, the rest of two patches 
>> are also serve the same. So, are you suggesting to merge them to the 
>> first patch?
>
> Yes.
>
>> Previouly, I had added Toke's signature in this patch but Toke advised 
>> to delete it. I feel a little bit confused about how to handle it. 
>> Appreciate any detail guide.
>
> I guess that you have to discuss that with Toke, how he wants to handle
> it ... If he gave you a patch with his signed-off-by, then you should
> probably keep it? There's also "Co-developed-by" tag to give some sort
> of non-author developer credits.

I'll do some squashing and send a new version; in which case I think it
makes sense to have both our s-o-b tags, and maybe a co-developed-by.

I'm hoping to get this done before the holidays (i.e., this week).
Already got everything rebased to current mac80211-next, just need to do
the squashing and fix up the other outstanding issues from last time.

-Toke

