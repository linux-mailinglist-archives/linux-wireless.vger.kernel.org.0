Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0999D12300C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 16:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLQPUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 10:20:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47850 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727546AbfLQPUU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576596019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjTz7LOmmrU7defJswKhdMHwuqxWQ3iCJF5TdK3gajs=;
        b=gtVexMRP4J0t0NzMvnCgQ7OhM+k9WBLAIz8RIh12MpuwI7LcyC0g2j8DMES052HaHSdF6b
        lvbhNn4DptmGpeK9PnmIGS4VfpZQRzHlskKphfvtPRWn0MxxnYJKaGz1wb1vmobYF1sE4N
        Ysq6Ep/BN6OhqiYyOUtvgIkAWexARgo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-nwHeLK2oOSqdxVuXjf1NTA-1; Tue, 17 Dec 2019 10:20:18 -0500
X-MC-Unique: nwHeLK2oOSqdxVuXjf1NTA-1
Received: by mail-lf1-f69.google.com with SMTP id y4so1040419lfg.1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 07:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NjTz7LOmmrU7defJswKhdMHwuqxWQ3iCJF5TdK3gajs=;
        b=WjK5+KowWm8LGNylSC10EaM5WMe+Mpny7P6E4JYgfZlw58A2NjRn6PnEptLgasIHZw
         Uqmhh+CHd8ZwGVluSu/cnjmu5XXJdHFIkeys1UeOYAgp9Z6nz2XaE419JusodXFndB9g
         EnNTnU0mE1PdQutvvahHx3NmuaZDjLBzRAQ7QXtjWNXVkV5UHQqykHfUkUxhIKJObWcq
         Gtj+SUWbMT4YF0pxWsljEOFD4ECGlMJ2rcNHEBFa8assAsIKhBAA4yBw0PDx/E4ej6Px
         nEB5u4Wb1SDov7zsWmSEXZ8lQe2eUPokgJ0On/M/OITxVBMwWF8hwIO7rCKhVyLoauN7
         0q8A==
X-Gm-Message-State: APjAAAVUxXARe3zJejziy9uKWcxzrlomqoxon5RzOVScLynIYgmRCnJ0
        6aT9Brw2Lyd3nrH+fYA7ae1hA3EHtPdw/zT/Za/DuDCm/NooJATnC0FP9zGTcKdu26kJfFi/jL7
        FMfDdpmcMNoATiEDJoDuFUhGmxWc=
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr3590613ljm.46.1576596016293;
        Tue, 17 Dec 2019 07:20:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqztxgpKt/OSWn6SzHt4oocpDc3uFmJvtqVjNlgXLq4a034Zy2YphmRg5xQxdRLqtAjIGV0oow==
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr3590604ljm.46.1576596016143;
        Tue, 17 Dec 2019 07:20:16 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i9sm7236641lfd.6.2019.12.17.07.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:20:15 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5CE361800B3; Tue, 17 Dec 2019 16:20:14 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org
Subject: Re: [PATCH 4/4] mac80211: Sync airtime weight sum with per AC synced sta airtime weight together
In-Reply-To: <fd7b4cb48f3510d81d227ae8020c3b6c46f4a4b0.camel@sipsolutions.net>
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org> <1576221593-1086-5-git-send-email-yiboz@codeaurora.org> <fd7b4cb48f3510d81d227ae8020c3b6c46f4a4b0.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Dec 2019 16:20:14 +0100
Message-ID: <87v9qf6ksx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> I'm going to assume that Toke will review all of this and there will be
> changes, so you'd resend anyway ...

Yeah, this series doesn't even apply in its current form. I'll try to
fix that, and do a few other updates that are needed while I'm at it.
And to answer your question in the other email, yeah, this should
probably be squashed to a single patch...

-Toke

