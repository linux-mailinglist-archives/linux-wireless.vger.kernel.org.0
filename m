Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8E24BC63
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgHTMpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 08:45:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729210AbgHTMoO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 08:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597927452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+s5qDnvDNxAoLj8pQE3tHYHYfaTGarALQyX/pzVwzo=;
        b=MILyeZ9J2Puq1yPmoXQ77uN2tLrct7kOplewPYXlZD1M9S9r8raPNc8dn+MngJLQSKFh9R
        4+gKTKvOoUQIiaaGVjV38eCfbLd7LRCQKW7BGqouVsDix8Ub6Ojqif4OnY+kVbJcmI/iBW
        r0ChbwHW8MdlzXmqwlMe7blNOQCvfOU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-Bp_FizFLNyqs3sKlrYPaOQ-1; Thu, 20 Aug 2020 08:44:10 -0400
X-MC-Unique: Bp_FizFLNyqs3sKlrYPaOQ-1
Received: by mail-wm1-f72.google.com with SMTP id v8so931017wma.6
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 05:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j+s5qDnvDNxAoLj8pQE3tHYHYfaTGarALQyX/pzVwzo=;
        b=DhDsqRmhUxAzZDSo+AyYZGcsXyl9/0FGKGmTAwLCqPtPPglrYc38zGHRyWIwI8WgNc
         hBah2iol+qcZvmt6Rg4A1w2T5AjFYdT0J/Sz9vECnhlimy4/emz9fgWgrECnwZDeTsIW
         xxNNkdEEG1PkLvh37/TxY7pYwY/8VViFANICp8eOsoyBEtW8PGTu1vVNpe1dGuUQvPX+
         7nqN4Uc4QKYM4p0rlzhk6B1jjEEc4Y3k8FSC2WDcF4he5JU3FTIc5acVmNcv9AXWFWK2
         qTz5HYtsAxl5dRcuFNRk6LLlsdd3STabZ4CRfq0eaNf1JMeJB78PiUfldEZX1e8fjwZ6
         AJGQ==
X-Gm-Message-State: AOAM533d+iFvylQZa0XdxhmRcOYvYo1OdR3fcDU9ePQtmnBfoLxbBdWb
        Gw6yvq3RhuGOAhQRtfzFwOibphdng2wK+Nft+49mPvONY8Lw/WGlHPsJmn6VzS3UQ1SzsB2J+e/
        hV+CVJbplKy7KNjFIKF99x3mIW+c=
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr3233561wmh.37.1597927449424;
        Thu, 20 Aug 2020 05:44:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUCCty161sUZM8oPW1X6SbR/XNQku5hXzYJX4Hb1G9VwAvnXQn3PzHPHErQmgmQi+xIrxAlA==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr3233545wmh.37.1597927449216;
        Thu, 20 Aug 2020 05:44:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id c145sm3874877wmd.7.2020.08.20.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:44:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 510D3182B55; Thu, 20 Aug 2020 14:44:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation
 for low data rates
In-Reply-To: <20200813155212.97884-3-nbd@nbd.name>
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-3-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Aug 2020 14:44:08 +0200
Message-ID: <87ft8hzduv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Links with low data rates use much smaller aggregates and are much more
> sensitive to latency added by bufferbloat.
> Tune the assumed aggregation length based on the tx rate duration.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

