Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3F11E19E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 11:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfLMKHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 05:07:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725937AbfLMKG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 05:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576231618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=feFHbn2YNWUjGLJE6LofvmX2NV1W+0p0Di+5/xog3Xw=;
        b=YXMiU8/urwepbzJSZlamYqdKx10x1pcQCU7OoO3obtOc1vgKE6zws+wip+itmaw2+UZszp
        jFTBW8QQVTyg2l1LxNKG/tvFeuOFwycr8XZimseKfHJviFZgIyzhZkpSJWMpFVriBH22FV
        e5Pm8qk82qsRLpTCkW/PBH/JPbcQ4sE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-wEslkmPMNveSORs_9YJ2kA-1; Fri, 13 Dec 2019 05:06:57 -0500
X-MC-Unique: wEslkmPMNveSORs_9YJ2kA-1
Received: by mail-lf1-f70.google.com with SMTP id 6so294319lfj.17
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2019 02:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=feFHbn2YNWUjGLJE6LofvmX2NV1W+0p0Di+5/xog3Xw=;
        b=RMkLRXDIge1ZMXR5nt8/64dWMkBDKuvxSg2R3eRN27lEJcEKnWxEFwEA9ia6bWcVW4
         lRU9Qgc3vfyqxkW7mVG/a3oxHTbe/QJU2hbLIJvsmZKy4ix0Oxx8Km8kUEhdMMVYsCKp
         a5Z6PpkaLCw/gRxsWL2rkd5M+yDw7S+HPzlqufVmk05KUd8Slv5H2LIMc27kRkg7rRuK
         b6j3ZeGLx/Fa2O/3kY7hIqqvw2b7iWsSTQT9WsEZiq/hm4lkvI55YcEq5pzjXA9+z+Ft
         i38e8rMDaQi3GTtt784uHi+pSEmBbZibI9ePvM1PP07BWWnqtBa7BVua2hLOnIxTo0EH
         GmHw==
X-Gm-Message-State: APjAAAW+V1JzMpaJAT8j4epMcsyJTBCexNXjkTuXNPOKysuyTVhuPkYH
        sR8rWx0AViFGQi1mZ9fSsPyExYRcIIhTASrZYRzPsFE+Cm8D2Ulwmz37e3YDRvgj1iMZr088byb
        uuqBihDTzmgAULf3dtfFfza4DbQM=
X-Received: by 2002:ac2:51de:: with SMTP id u30mr8300282lfm.69.1576231615615;
        Fri, 13 Dec 2019 02:06:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvB4rf8JDsbKkcgH0MszrRXvZuRC+aCy1TdOzPEvMHLP4GzQm1dm9QAySVe4ZLTBKQ2h75oQ==
X-Received: by 2002:ac2:51de:: with SMTP id u30mr8300271lfm.69.1576231615477;
        Fri, 13 Dec 2019 02:06:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x84sm4367188lfa.97.2019.12.13.02.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:06:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ABC971819EA; Fri, 13 Dec 2019 11:06:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Justin Capella <justincapella@gmail.com>,
        Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH V4 0/4] Enable virtual time-based airtime scheduler support on ath10k
In-Reply-To: <CAMrEMU_w7dj5RVNmkVoCjU1o_FEEXn9oA7XCBwFQ+j2EQkck4Q@mail.gmail.com>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org> <CAMrEMU_w7dj5RVNmkVoCjU1o_FEEXn9oA7XCBwFQ+j2EQkck4Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 13 Dec 2019 11:06:53 +0100
Message-ID: <8736doedz6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Justin Capella <justincapella@gmail.com> writes:

> Would it make sense to consider skb->priority / QoS in the Access
> Classifier selection?

Erm, what? Not sure I understand what you're asking here...

-Toke

