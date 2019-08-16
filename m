Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AA8FF7F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfHPJ41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 05:56:27 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:41687 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfHPJ41 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 05:56:27 -0400
Received: by mail-ed1-f43.google.com with SMTP id w5so4623149edl.8
        for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2019 02:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DVmDCVA+evLtq2XLreSXuYjIzjRadJcmpmk+J0XOpeo=;
        b=lat511NjSmWysS+jh6qx10YI6zfAvAl3UvGISeewdyVwH5IyL40Bci1cTrql59VsjR
         jHHElwltIA5TXQ88WQ/pmDKdX/0AkrBR4Eud/jbBQIUnfk/tqw15/jldgnVeOHI2vC+2
         At1M2VWygBEet76wy9xiLZ4o/sDuMsVB3tIHRj+/i8nScm8aE5UclGvAZR1SUfY0lBfa
         mfar/f3RuHTdfhJCc15hIpd9X6hKGYEtDrEpDmyv8UcpYmCIxZ3tjTIuhbq2VY+jrD6a
         4BCkMzr5JxFkE1KLgqvyROoxh3gQoJbgGpytuXD/iFWtk1Qvlf4hHCtrUjGmkp8f8Egt
         c9Dg==
X-Gm-Message-State: APjAAAWAQqHrHj5ZCzeE/gxUVMqX+7m9AZN9UQViPAhRTDdopeRpSMS9
        nbA0c3Lf107odr/eJqq9xgJDmUa7iD0=
X-Google-Smtp-Source: APXvYqziDrq4Ka0+eHosNg9s/pzYkUyfxpMM+s7hqHA3RVSMbI7aVVEwcCQ8Cf2oPEV6w9kkAbt/Dw==
X-Received: by 2002:a50:cdd9:: with SMTP id h25mr9784639edj.231.1565949385699;
        Fri, 16 Aug 2019 02:56:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id s4sm755452ejq.72.2019.08.16.02.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 02:56:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 06EFD1800B1; Fri, 16 Aug 2019 11:56:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jeff Johnson <jjohnson@codeaurora.org>,
        James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [RFC 0/1] Allow MAC change on up interface
In-Reply-To: <46810d9dbb674fb8d8fb442f2418868a@codeaurora.org>
References: <20190815185702.30937-1-prestwoj@gmail.com> <46810d9dbb674fb8d8fb442f2418868a@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 16 Aug 2019 11:56:23 +0200
Message-ID: <877e7dwi0o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <jjohnson@codeaurora.org> writes:

> On 2019-08-15 11:57, James Prestwood wrote:
>>  - Adds a new NL80211_ATTR for including a "random mac" to
>>    CMD_CONNECT. This MAC is passed down the stack and gets set to
>>    the net_device's address.
>
> My initial reaction is that I'd avoid using the term "random".

+1 - from the description I was expecting calls to get_random_bytes() in
the setter function :)

> For some use cases the address may truly be random, but for other use
> cases it may be derived, perhaps in an AP-specific manner. Other terms
> which may be more appropriate are "spoofed mac", "administered mac",
> etc.

"custom mac"?
