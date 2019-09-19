Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B25B7BDA
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfISOMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 10:12:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732436AbfISOMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568902328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjwZXRA4/wGuSYivmBDiMELQqrlAeAJ/4svl5cn5p44=;
        b=KZn059WAsec6ud1ue4BZ7saZX5jXrej3vNOcVYnM/pM3W5yToOgShEWJWRzndUb7WTN5wb
        PbCCAXp1fgQ1bSC6/slnI6DJ7lbXKFRLxzwjFPfgNeeUif9ajnLE2WCIuAtLFuzkNEbz6H
        SLMVdwISAM4kf5Woe3e9yexR4lKjgeQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-OChtXlj8OImC5qcFBISDwQ-1; Thu, 19 Sep 2019 10:12:07 -0400
Received: by mail-ed1-f71.google.com with SMTP id m2so2048145eds.12
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 07:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nqkXS5MsSQWaPs8wmhHCW242OlfdpvhtSB/D3SBl3XI=;
        b=crwUOCHkcTOE6eVcrrKTTET5ylJ9ms+FwlgtPIGznJgtli/hD3FJoRoT4enbLNPpdW
         ogq9uniPyoUI0QRS/4zbscvV5EZZufE9wcVl6pVvBDlmewDkXODEhtdcvycoeNcMb6dp
         DgP1VSw417ELIml9XEnXYoBkE5AUI3PgAE6t5LW3qjuiGL57FS373caXZ65E5R1MjtMx
         HrNGntvT8jt3ZVJERyO5xOLynyr4kuczUukybTdBxk4T2Vu7PylGqdVzTXXCseJ+rWiR
         wwn97ZuM815j7KYUC/DkzLMScnPQVaf/1GXAtSxlP4osS2f8kJP+K0WhinB1N7Yw0Dx9
         Ssfg==
X-Gm-Message-State: APjAAAXsOQP6cZjrB+5zHfNYwQfcjIulQ4neYPqB3QM8zdaUgBvi6mDS
        8uu7jyl9m4Kpj3wX0MLWw1OXULgxnfWoEwfGnQ2beywn0k6BF/1abAYB8S6iwMXpXksMz2JHMnU
        ZV838p+c9Tltfe2jUZQZxImRTsN0=
X-Received: by 2002:a17:906:e109:: with SMTP id gj9mr2436644ejb.160.1568902324455;
        Thu, 19 Sep 2019 07:12:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPqNM3pijjNln3JMahHQlD3HfPcRrSmQCsaiTpk+6jNVZuCsUg0uao2PjHxxZfWGY4dX0ekA==
X-Received: by 2002:a17:906:e109:: with SMTP id gj9mr2436625ejb.160.1568902324246;
        Thu, 19 Sep 2019 07:12:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id n6sm944692edr.27.2019.09.19.07.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 07:12:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 078E518063E; Thu, 19 Sep 2019 16:12:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 0/4] Add Airtime Queue Limits (AQL) to mac80211
In-Reply-To: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 19 Sep 2019 16:12:02 +0200
Message-ID: <87d0fwfk99.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: OChtXlj8OImC5qcFBISDwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> This series is a first attempt at porting the Airtime Queue Limits concep=
t from
> the out-of-tree ath10k implementation[0] to mac80211. I limited the scope=
 of
> this RFC to ath10k, but it should be straight forward to enable other dri=
vers
> (they just need to provide a last TX bitrate).
>
> Unfortunately I don't currently have access to hardware to test this, so =
I'm
> posting it here in the hope that someone else will take it for a spin. Do=
 note
> that this means that the series is completely untested (although it shoul=
d
> compile :)).

Heh, it seems the kernel build bot did not agree with the "at least it
compiles" statement. There's a bug in the debugfs code; guess I don't
have debugfs enabled on my own build system...

Anyway, I've fixed this in the git version, but won't bother submitting
a new version here until someone's actually looked at it. If you're
going to try and compile it, I'd suggest just cloning the git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/log/?h=3Dmac=
80211-aql-01

-Toke

