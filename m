Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35584242754
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHLJR4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 05:17:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22645 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgHLJR4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 05:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597223875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4RXszcOGztEXae4AGflL1rKAVHKYykrZyCXInPVzmA=;
        b=LdLw9t+nBG2fcY3IDrN/peHZ0kAGYV04OX4SV9/E5OUlOZxOWrKgP+pL+d9M/NkUcghhTR
        lhoQCL67Mv7UOwmYJXbqWc3966WhnQHBPLtTwq6jgWl53M0zpg7nDVkY1O5crpcPDLIymU
        C+YhMzAAanIhjcqgE0d2UplfKkkFk9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-8hAG7hcnPfWdp3yRb6De_w-1; Wed, 12 Aug 2020 05:17:50 -0400
X-MC-Unique: 8hAG7hcnPfWdp3yRb6De_w-1
Received: by mail-wm1-f70.google.com with SMTP id p23so505650wmc.2
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 02:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I4RXszcOGztEXae4AGflL1rKAVHKYykrZyCXInPVzmA=;
        b=mo8hTv4TX1sizGSn6E7HEaSnPTqlIesuaj65/piXJwOmP6tEj/NrGPAo9GNG/sOtjK
         ZPC0LZkP+sVBJbUiXrRJ4vA5zP5KngUkIlT2uNohW18J48tQSvdbsqeyxvasUZd8UoMj
         6Ws59zVWHyjODD+59zP22Nb0LEyYBefanr8SniPBmFaHYO5kLZNt7SAUPjT7funmEGeP
         JoqmGt+WrY8CpdNTGf8I1aOB41wa5aO/C35jetTkCBS9UkHQG3SU9mroOuvjmzVKIWn2
         jc7Fl34CLgvdYU2EaBYLHwMyhaiZJg9Olzvd9gESKWvSF9KkoNeucJ8j0RAjxCdK0alf
         uT/g==
X-Gm-Message-State: AOAM530X43IZj8oFFlZhMr5J8Lwm8BwFbgW0WAeCgOySzah/eNxKsI16
        UzFh8uOnDAuf3ehvCPtIV6dctldYYbnAcePN3BtqCY40UfAhYJJZixZ9Ld0kMFVFraCzYjjUU3q
        rKeur8tRHqHbYUrU45Ddp7/qXdfc=
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr10678517wrn.340.1597223868958;
        Wed, 12 Aug 2020 02:17:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw57FMs3Ztiy3xWtAD5B1OgsGtWCZxHoO4awt3OtmMIUVmXadn5Zg2iGoSdyPK9msAvehsv4A==
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr10678478wrn.340.1597223868584;
        Wed, 12 Aug 2020 02:17:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r3sm3064256wro.1.2020.08.12.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 02:17:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5167118282F; Wed, 12 Aug 2020 11:17:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        ath10k@lists.infradead.org, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: CVE-2020-3702: Firmware updates for ath9k and ath10k chips
In-Reply-To: <20200812083600.6zxdf5pfktdzggd6@pali>
References: <20200810090126.mtu3uocpcjg5se5e@pali> <20200812083600.6zxdf5pfktdzggd6@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Aug 2020 11:17:47 +0200
Message-ID: <87lfik1av8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Monday 10 August 2020 11:01:26 Pali Roh=C3=A1r wrote:
>> Hello!
>>=20
>> ESET engineers on their blog published some information about new
>> security vulnerability CVE-2020-3702 in ath9k wifi cards:
>> https://www.welivesecurity.com/2020/08/06/beyond-kr00k-even-more-wifi-ch=
ips-vulnerable-eavesdropping/
>>=20
>> According to Qualcomm security bulletin this CVE-2020-3702 affects also
>> some Qualcomm IPQ chips which are handled by ath10k driver:
>> https://www.qualcomm.com/company/product-security/bulletins/august-2020-=
security-bulletin#_cve-2020-3702
>>=20
>> Kalle, could you or other people from Qualcomm provide updated and fixed
>> version of ath9k and ath10k firmwares in linux-firmware git repository?
>>=20
>> According to Qualcomm security bulletin this issue has Critical security
>> rating, so I think fixed firmware files should be updated also in stable
>> releases of linux distributions.
>
> Hello!
>
> Qualcomm has already sent following statement to media:
>
>     Qualcomm has already made mitigations available to OEMs in May 2020,
>     and we encourage end users to update their devices as patches have
>     become available from OEMs.
>
> And based on information from ESET blog post, Qualcomm's proprietary
> driver for these wifi cards is fixed since Qualcomm July release.
>
> Could somebody react and provide some details when fixes would be
> available for ath9k and ath10k Linux drivers? And what is current state
> of this issue for Linux?
>
> I'm looking at ath9k and ath10k git trees [1] [2] [3] and I do not see
> there any change which could be related to CVE-2020-3702.

How about these, from March:

a0761a301746 ("mac80211: drop data frames without key on encrypted links")
ce2e1ca70307 ("mac80211: Check port authorization in the ieee80211_tx_deque=
ue() case")
b16798f5b907 ("mac80211: mark station unauthorized before key removal")

-Toke

