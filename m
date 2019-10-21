Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90978DF09E
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2019 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJUO54 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 10:57:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbfJUO54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 10:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571669875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LCLBxaSD8g38T8u/ybfkijweWWcwiPR1YNTgQYJONY=;
        b=gGf5qFuVWsa0QSikEMSn73CvvUeATeb1VVd45A+akFPKg+CvR97JUaj50XyVRuR/LLKSth
        gMvI084knV7XmszZoCC2jxZHnX692OIQb0x6LR3SYCMU+1NJ7aiDR7CxOFTftqOT3mkUPy
        hEiC/3l5uhBOCZA/knoJz7HcmT3Mc5M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-JrUssL2yPLii7IChtDN-2g-1; Mon, 21 Oct 2019 10:57:53 -0400
Received: by mail-wr1-f71.google.com with SMTP id e25so6857996wra.9
        for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2019 07:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uq0uDmRtgXO3GMqtdwEBfqJdfQu+hMv3WbuD0weh130=;
        b=HMChfKHh98IlMBakeFh29EkAGSXEyQVRnCUetJ7qGeanWBVHlgSDigfiqdF2HAb5Qz
         bdANAvGRlkRLkRux2QqelbHH4G34gfDhqdWISIvw+2CtWD1SGBqI9D2S3zqt+drvu00T
         8OcHmggYCsrHmdJIuL3NChdbaZx+WJE6UEbZR1Chpwg0CRVGxpE75MF5Ebo9Vis31elD
         rXxtGznwCvPtGBFYI0yoZ9UiFLXAVcAjwK3u8lng/VkfhxQ8SrbW29VdeQDMqeKuasrK
         PcV/3eNKN8XjGYYJ/fRJFBTZWJSNvOAfW3/EnV3hqSlmHJ8IFVsHznLXGGK+3O7AzRUy
         BDkQ==
X-Gm-Message-State: APjAAAWuinqiLK9qzq0HQg2yfCCYnpNxlPP17nGOzRLt5gbjwvjXpCyi
        tqywaawKNe6QOb/E5T9/Ova51NFNB4Ua8XSL1/efOA3ahBJp1SHzsGqeTiz+t4JePa93F2vFreY
        fxQx86F+cizMrY7GzR9bxSj+cp/Q=
X-Received: by 2002:adf:dbcf:: with SMTP id e15mr20788529wrj.134.1571669872539;
        Mon, 21 Oct 2019 07:57:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwjEPCqaFlqG75Sr20Nuzi+1rlCvDUYLDh1LXlWULjlqxXbBBkdJRH2br3nUhJY4SbuXETleQ==
X-Received: by 2002:adf:dbcf:: with SMTP id e15mr20788514wrj.134.1571669872348;
        Mon, 21 Oct 2019 07:57:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id a189sm2135474wma.2.2019.10.21.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:57:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BB7831800E9; Mon, 21 Oct 2019 16:57:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Kan Yan <kyan@google.com>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Yibo Zhao <yiboz@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <87r236tbgz.fsf@kamboji.qca.qualcomm.com>
References: <20191011022413.176208-1-kyan@google.com> <87wod7y9ui.fsf@kamboji.qca.qualcomm.com> <87sgnvy9c2.fsf@kamboji.qca.qualcomm.com> <CA+iem5uLYFVQjPaE1QDKc6c+eKz8Xd4LbwczYXOBKP3q+HHdBg@mail.gmail.com> <87r236tbgz.fsf@kamboji.qca.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 21 Oct 2019 16:57:50 +0200
Message-ID: <878speqh75.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: JrUssL2yPLii7IChtDN-2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> (please don't top post)
>
> Kan Yan <kyan@google.com> writes:
>
>> I believe Toke will integrate this with his version and move the
>> estimating pending airtime part to mac80211, so maybe in the next
>> version, ath10k change is no longer required.
>
> What do you mean? Are you saying that I can drop this patch:
>
> [v4,2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
>
> https://patchwork.kernel.org/patch/11184783/

Yes, we're trying to do it all in mac80211. See
https://patchwork.kernel.org/project/linux-wireless/list/?series=3D190333

-Toke

