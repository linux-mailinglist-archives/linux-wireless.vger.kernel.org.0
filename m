Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68B6BB27D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfIWK4R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 06:56:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732124AbfIWK4R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 06:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569236176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd0DRRuSK1KZajbDnec+HOdMYMvRrU+KMiQr1eyYspI=;
        b=JA/LQl1hn7XlYSf7eor1pF16BMieak/2llC//xSlpA1M6S4RT4ho4lWdp+U7MXYQgxcljC
        wM70KSZ5B5/aXPSBS7C/5BC0GoXU8ciVSg/iPThRhyzhDw7vPm9ot1yN++nqbUDQUJg/VZ
        N5YJRyuhcXWG9lMA2xV8wiX/psDnsgU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-DIwPiwW6OluZRhDWlmk7wg-1; Mon, 23 Sep 2019 06:56:14 -0400
Received: by mail-lj1-f198.google.com with SMTP id 5so609272lje.12
        for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2019 03:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dd0DRRuSK1KZajbDnec+HOdMYMvRrU+KMiQr1eyYspI=;
        b=jW7eXXJ/OxGc8DLClIbgfGGD4lssHqYeDbcYdwJZWcwHdWVvwz8i9vGhxERjzFnDm+
         EYj1Yr5qw4MlSTlZ6UfmVZytaZ7A0qfgjTgrZfFTVGxIl97m2JxSGbaUlQaY+8Wcv/29
         LvZ0XtvakYTK5U23TKTUo7Fu4SD9Ob9o5HECube/n2AIesASi7p/Ce5XSSrOkh7DXJoS
         R3DTyEHh50dCZIESY3feOCAgQfgZzL0Soi5gPKPHZAVefOGVNA+Y/0QRnexJ2rdd4zAT
         h5L57bGTrFLM6IC+hMEnGJKMiiAIILhibA6fnnYH/r982Ux+QzFUEsj/2dugw6Ru2UlP
         dFkw==
X-Gm-Message-State: APjAAAWmw0WfIYhKryF1EltBOkH+oRwwNqnWOGrsHNw/UEEhdFd06Oma
        4fctJpGf3OhVPA956QcXVEzFX5Z0b9XXKo5pnP2hS1ZVtaHae1BgGIK+MSB9U9n3jeaaz4vKGiC
        VnjEPTndPYz4N6YjsJX+t5+HSsmQ=
X-Received: by 2002:a2e:8558:: with SMTP id u24mr17189189ljj.191.1569236172604;
        Mon, 23 Sep 2019 03:56:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWtGd+z4ZvrIlXFR1MjZzxJf6lCR4c3SqpHXhBocMr4ZVUh1j+TDaXTghcEpGSOG6uPk/9eQ==
X-Received: by 2002:a2e:8558:: with SMTP id u24mr17189180ljj.191.1569236172489;
        Mon, 23 Sep 2019 03:56:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h9sm2139336lfp.40.2019.09.23.03.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:56:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EC7EF1804C8; Mon, 23 Sep 2019 12:56:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH V3 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <1569223201-1490-3-git-send-email-yiboz@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> <1569223201-1490-3-git-send-email-yiboz@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Sep 2019 12:56:10 +0200
Message-ID: <87ef075lit.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: DIwPiwW6OluZRhDWlmk7wg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> In a loop txqs dequeue scenario, if the first txq in the rbtree gets
> removed from rbtree immediately in the ieee80211_return_txq(), the
> loop will break soon in the ieee80211_next_txq() due to schedule_pos
> not leading to the second txq in the rbtree. Thus, defering the
> removal right before the end of this schedule round.

Didn't we agree that we could fix this by making __unschedule_txq()
aware of schedule_pos instead of this deferred removal mechanism?

-Toke

