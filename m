Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B341A109E21
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 13:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKZMjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 07:39:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48484 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbfKZMjf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 07:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574771974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VadMJ/aSgwHbJpMFCv+DTeYpcUUQbzgSGAFUkGztGI=;
        b=L/s0D1Bj79CpS/8zoehJlhXffJwhKZTNCh4H+O3F6h0NoyIGC1JESm8XcDY720GYmtLQK7
        +HtDosJnyDyRWSDZ3yt7+giBKq7woRM6FTCeUV+/SqX1gqCSm12voTKp+QMItDe6rXC05u
        kCqvVqsVf3GSmW4kYk8AH/z9w15vpgk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-CJlfpUNcPS-bUabcFJpOXQ-1; Tue, 26 Nov 2019 07:39:31 -0500
Received: by mail-lj1-f200.google.com with SMTP id d14so2184846ljg.17
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2019 04:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2VadMJ/aSgwHbJpMFCv+DTeYpcUUQbzgSGAFUkGztGI=;
        b=RHQNFv8wkEUb6kaH7i50zYxavdunc/vlU/+GVd5lPpZ980VwzwWTMDR0CJjvrAnhLA
         NUHKGzcQjcBEaIx9RTDFe2ss5LqgIm6zjEnWzuv0m6NHVInpJgjD2ZiSeqMToEkK2O71
         F9GfLWkQnYo6O0fivzC6Yz3XfaDwpeQbGtv/WeswDrfG3KfgckBmnb1SEv5UuWrrVKVp
         Pxf+e0NwFxwXl756/I7heEXSx3jRsUZgqrx+naExM864p9xsKinvB7CfDtBuk/YGZcWm
         6pOejnwwKmJs3+g36VLy4aEg060mnNwmSW/78B70g5iGz3Hl84c5+D0KlJV3OMXCG8Mk
         0TwQ==
X-Gm-Message-State: APjAAAVCcEcZ7wWE8NJRVSv8W4lGepGFXXBZh1ns6JvOxH3GgVgaxNKg
        4I6YGV/D1qR2f1+CskNR3AztdjJpSjKnbYvGR0QtySOYbNs2reRLAqujenCUaDoIOvrbYnCuIOw
        ZqfAYXzpSm/IxwTJ2Sx9jXBLQcB4=
X-Received: by 2002:ac2:4102:: with SMTP id b2mr25034851lfi.16.1574771969930;
        Tue, 26 Nov 2019 04:39:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMUX4nVqQ+FMTokq7ORlBMBeiqIzP7BUvwDeFyDsu8c8xnsq1l+pQCS86d53A3EOuT0b0huQ==
X-Received: by 2002:ac2:4102:: with SMTP id b2mr25034833lfi.16.1574771969730;
        Tue, 26 Nov 2019 04:39:29 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d4sm5140763lfi.32.2019.11.26.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 04:39:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 65E451818BF; Tue, 26 Nov 2019 13:39:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mac80211: airtime: Fix an off by one in ieee80211_calc_rx_airtime()
In-Reply-To: <20191126120910.ftr4t7me3by32aiz@kili.mountain>
References: <20191126120910.ftr4t7me3by32aiz@kili.mountain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Nov 2019 13:39:28 +0100
Message-ID: <87wobmyfpb.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: CJlfpUNcPS-bUabcFJpOXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> This code was copied from mt76 and inherited an off by one bug from
> there.  The > should be >=3D so that we don't read one element beyond
> the end of the array.
>
> Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from mt76=
")
> Reported-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

