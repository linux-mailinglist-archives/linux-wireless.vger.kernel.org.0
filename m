Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4844AF2CE0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2019 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfKGKzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Nov 2019 05:55:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727528AbfKGKzL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Nov 2019 05:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573124109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4pL4jpvKYALp1ZmBjwLiX5kLjNlt9sKgPX3+ptzxho=;
        b=hBeWLmJg0N+Sf+bzGXoQaVHGqCWgT97zgYCwFcRSBCoE3SlMEdwEGsU6h6Cw29cNgQ+NM2
        Pit1L9Vbtc92+V9g0eIJ+z+80vrNCUvBPMKepBnEzXDGJgd1RZriEo2TPIAwYQiYj1j4Rq
        7JfU6WImq3/26VM+2L6DgbQct/jvecQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-VXTljJ1MOCOJEzhQeR7DQg-1; Thu, 07 Nov 2019 05:55:08 -0500
Received: by mail-ed1-f72.google.com with SMTP id c27so1131861edc.3
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2019 02:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Q4pL4jpvKYALp1ZmBjwLiX5kLjNlt9sKgPX3+ptzxho=;
        b=YQ4Y897GYVMR8Im0cTMg6e0qKPmOAkvmvM0EqacqyH1HQ7CnuOFDdy4lNb9takNkAp
         e9WMMYyJPor/mpoNQ9z1MFkS69/uxbjiH8h1Nzuslw98c6UKdZvDbngG3BK3znh4Rbqe
         3UxGYCK9+uMiaqtJiv1+p2trHppTjlYU8i1vXwf+qjnjmhvAXqYnTKtNGMef1niM6TGd
         /vZg7T2VPBA/qlAp4BMAF7SsQJWNtWBxYePpC/NH0bBk1+ZpEybExE/qQYAhzyxVvgMt
         i/RAhuy2XFQuz3xTkRjEA/Of4lp+tyb6WjEjCetpXWFMZMCCquH5DIbSA9jP6hFwEQUs
         un3A==
X-Gm-Message-State: APjAAAV9wyupb1hfFqPQ0i+x6Kn10uEJzTXn5vGGQYZMANNLdqioM89k
        Ybi37viCM73e3rVSPOdZZhJrutaI9Sl6HPfRoSOujuikZlBHv5rgdYR2KQ7mfIOMKUc5tt/GHwy
        OwNU4XwYXgblanJ/JocSdFm26KuM=
X-Received: by 2002:a17:907:36e:: with SMTP id rs14mr2343746ejb.330.1573124106643;
        Thu, 07 Nov 2019 02:55:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEpX0MtxlKhDZdMCOWAf1U4DukYDNvzzciu6G2l7tjeepUbmDJuI635gQspWdEjys3zMh9Jg==
X-Received: by 2002:a17:907:36e:: with SMTP id rs14mr2343731ejb.330.1573124106481;
        Thu, 07 Nov 2019 02:55:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id x6sm54134edc.50.2019.11.07.02.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:55:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2B6091818B5; Thu,  7 Nov 2019 11:55:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v6 0/4] Add Airtime Queue Limits (AQL) to mac80211
In-Reply-To: <CA+iem5s6jDNR+yA21UB_zJiZeVxix_QaO6RYw6sN69j2859zFw@mail.gmail.com>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk> <CA+iem5s6jDNR+yA21UB_zJiZeVxix_QaO6RYw6sN69j2859zFw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 Nov 2019 11:55:05 +0100
Message-ID: <874kzggdme.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: VXTljJ1MOCOJEzhQeR7DQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Patchset v6 works for me with ath10k driver.  AQL does its job as
> expected and tests show very significant reduction in latency in
> congested environment. The txq stuck issue in patchset v4 got fixed.

Awesome! Thank you for testing!

> However, the device's total pending airtime count still underflows
> sometimes. Even though it doesn't cause apparent side effect, there is
> some issue with the pending airtime update and needs further
> debugging.

Huh, it *under*flows? That's... interesting. Cloned SKBs? Or maybe the
tx_time_est field is being set in some other place?

Could I get you to add a dump_stack() to the underflow test so we can
get an idea of where that happens?

-Toke

