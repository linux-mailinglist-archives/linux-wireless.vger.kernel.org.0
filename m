Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568552CA34F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbgLAM7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 07:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728641AbgLAM7G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 07:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606827459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfBZF9Gwlj8atg5YTnMHxzLvKinpO1z+2vEpFdQPe6g=;
        b=aMwtFln9q11v4vzHn+9OuPEY7kW1eTPndpVpzPb9DmEqS6MxLLnYY44fnZYttSgnsSxOSq
        PsnVUdKmwFlsDb6VGJ2hSK7sJrRakJ4SyNokhRCK+p7r1aRrbyjYSgIF/Z1HdWx8Csl4yh
        O8hrNjOl/FN4pjwtj9pty7kDX4Lt4zw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-zyTWk9pONYym5jvKFMeRpg-1; Tue, 01 Dec 2020 07:57:38 -0500
X-MC-Unique: zyTWk9pONYym5jvKFMeRpg-1
Received: by mail-qt1-f200.google.com with SMTP id v18so1151755qta.22
        for <linux-wireless@vger.kernel.org>; Tue, 01 Dec 2020 04:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lfBZF9Gwlj8atg5YTnMHxzLvKinpO1z+2vEpFdQPe6g=;
        b=AKTyD+XX0BODdIZmV37RupqTQwON0GZ3e43fkAKQIFq/5UzEWvDlJKEKC1KLdlW9K6
         HPeq0qicG3QRHkJKA1oAQcWUUwpGPUVXoXE/O4pMaFc9AjpXJobmolDsY4scwSUvRbJx
         qNABe/92QIn2YACPHKpD3qZAj1ngALexyMiIqKNVFk8obSfWUKmynMekzVvPIGWrWx2K
         RijUWskyWtJNBVvAJp+orOeAd0OifhslJ5eraPdZBHDPXEwtyuoT57C3MlE9s+o5jU/c
         bhRLVw9acHYiLgctX3+EViizn3CDoJTjRhBeasZG4cpkE6N/Q4WzGnULgO3PEX7KQxAE
         BsHw==
X-Gm-Message-State: AOAM533H7+M3CC0epx2e1GY8MSveFhbv4hgS4n6wUZcnPMm2NH3H7F59
        2PE1KKx4oj1vFjtjsvz3xWigSeEWC+pwcMyJYcjH6WywE93EibtRAg8YYAoxLi0xhmJcE+6wxz8
        YaGw6FnkBTtoYrMrze3q8Yfg13iw=
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr2543670qkg.421.1606827457571;
        Tue, 01 Dec 2020 04:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBQWFieS4W49w2CEIlj/A7J4CoG0nWUbAZ9xO0ZEOcV3GjNFNiFuT+CpEHasW5yQ2q7ucY0Q==
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr2543648qkg.421.1606827457343;
        Tue, 01 Dec 2020 04:57:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v31sm1952021qtd.29.2020.12.01.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:57:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F249E182EF0; Tue,  1 Dec 2020 13:57:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: ath10k: Missing airtime scheduler parts
In-Reply-To: <3078279.oiGErgHkdL@ripper>
References: <2631481.BEx9A2HvPv@ripper> <87a6uxx092.fsf@toke.dk>
 <3078279.oiGErgHkdL@ripper>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 13:57:34 +0100
Message-ID: <875z5l3cqp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> Hi,
>
> thanks for the reply. I will forward the information.
>
> On Tuesday, 1 December 2020 11:56:57 CET Toke H=C3=B8iland-J=C3=B8rgensen=
 wrote:
>> I did recently rebase that patch to the current mac80211-next, actually.
>> Sent it off to Felix for some testing, but if you wan to give it a go I
>> can post it to the list as well=20
>
> Thank you for the offer. But I doubt that I will find time for it
> before next year.

Alright, fair enough; I'll give Felix a chance to test it first, then... :)

-Toke

