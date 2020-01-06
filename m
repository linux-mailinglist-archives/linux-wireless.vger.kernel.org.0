Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEE76131577
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgAFPyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:54:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58542 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgAFPyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578326054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6pr2vDp7GuUB/s0xuB/d+Xhxr3Bho+yffIoUy9cSlWQ=;
        b=CqCrVLMQwIXuBd2pcYqgbsdnfZkZFOtlZ45SU41Fy5fezW0Olh9+Rea94lUJADcE+D22Gd
        wAmmruq/4jwOvZY2UNV4/3II7PKh3R/PNjPjXzX4dPPUa5kBF6N80VywRLiSlZwPQhqKsN
        mKL5b7qYEDLAiLWPyVosA3lqevJwqco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-c_BKz-n8M6S2LLoJ_jGMgA-1; Mon, 06 Jan 2020 10:54:13 -0500
X-MC-Unique: c_BKz-n8M6S2LLoJ_jGMgA-1
Received: by mail-wm1-f70.google.com with SMTP id t16so2995924wmt.4
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 07:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6pr2vDp7GuUB/s0xuB/d+Xhxr3Bho+yffIoUy9cSlWQ=;
        b=Aj3O8clVXwwoGygIuy8dQ4PG0HVhQokwyCTKzFEu819Iof2zXHntsbFl+j7msj5R80
         10zZ+vO4NTudXE990Zm9uE462h3a8//eyQD/HiU0TYDhyQUfdlLNAv7jB2h0qw5EL5Lh
         39+TfR7NQYq9Ac2KuBim0flRUn1QAWGTXbJaXtsl+R1NiEOPT01P73BdBOfyu7CcTTCb
         VunJFTMsbuVOMaqKk/LKw3grN/h3NjZL/MLDttKHzVeTrjtx8Cx2xQOw4r9FKksUUMuA
         8Pk1aQ1eSOvCECFsmokgdGz5RMvs3Bx7PkFm+9mViD6Vf1We7A0cZQlBooGGF+EO3Y23
         jGCA==
X-Gm-Message-State: APjAAAVKMPDCj31MqSmeo4vpLUv+dIEe9wCFJJMc/BehEkcIebl8VZi+
        72vOtRq1hkCTxmupmnisW1kBb5AQJXJaOK+hcScrN+ITMLfrz5XcUv35yQdCv6IZy98agMT723D
        F5Yv4hPJcVVTkCPl1hQLBA5gEcds=
X-Received: by 2002:adf:db84:: with SMTP id u4mr106058101wri.317.1578326052153;
        Mon, 06 Jan 2020 07:54:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYHtUInFoiYX9T3XvsmrAcd5xwxCOKNazEwOVw9Q1lBVna6NJ3ZvtZ8RfME1lAJFCx2BX/iA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr106058082wri.317.1578326051996;
        Mon, 06 Jan 2020 07:54:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x6sm23375389wmi.44.2020.01.06.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:54:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D742B180ADA; Mon,  6 Jan 2020 16:54:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Yates <john@yates-sheets.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kan Yan <kyan@google.com>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Yibo Zhao <yiboz@codeaurora.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v5] mac80211: Switch to a virtual time-based airtime scheduler
In-Reply-To: <CAJnXXoiyWKSLHqMzMcSzHBM-HhfYtcURW1hYd-3Yf7K00NTqgQ@mail.gmail.com>
References: <20191222172423.131033-1-toke@redhat.com> <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net> <87r20ck3x9.fsf@toke.dk> <CAJnXXoiyWKSLHqMzMcSzHBM-HhfYtcURW1hYd-3Yf7K00NTqgQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jan 2020 16:54:10 +0100
Message-ID: <87mub0k2cd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Yates <john@yates-sheets.org> writes:

> On Mon, Jan 6, 2020 at 10:20 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>> Or do a middle ground thing where we use 32-bit arithmetic
>> for the per-station weights, but go to 64-bit for the weight sum? I
>> don't really have a good grip on how much of a performance impact we're
>> talking about here, so I'm not sure which I prefer...
>
> Double width accumulation is very common in many applications.
> Double width addition and comparison are _much_ cheaper than
> double width multiplication and division.

Yeah, we'd be doing the accumulation in 64bit values in any case; we're
talking about mainly multiplication here (the whole point of the
reciprocal stuff is to get the division out of the fast path). So how
big of an impact is one (or two) extra 64-bit multiplications going to
have on a 32bit platform?

-Toke

