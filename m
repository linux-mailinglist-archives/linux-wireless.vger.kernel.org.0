Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64400461428
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbhK2LwV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 06:52:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236069AbhK2LuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 06:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638186418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOhMvjNUpAatTJjpg94z43eovPBVGYPtIJjaf1OGP34=;
        b=AQj7NeIEWxX1XgsnTAr4vGDB4gfaLaEfRtVmInngZ4Ffu28p5/Mm8oAD2Iu5avExjRst68
        KDNkOXwFWphrBOb1uNghMMKU6kFWPibqQfqxo7yrZlcInIhx93fTpx/RFPMrt/D0Wjq1uJ
        eqPSEihRwe+cKJipe5A//YXDTjOou70=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-276-s4_EuQAAMy6VzpGnujYQ3g-1; Mon, 29 Nov 2021 06:46:57 -0500
X-MC-Unique: s4_EuQAAMy6VzpGnujYQ3g-1
Received: by mail-ed1-f69.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso13450877edc.18
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 03:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mOhMvjNUpAatTJjpg94z43eovPBVGYPtIJjaf1OGP34=;
        b=mXDPgXf7xaa1mEL7yKpMifmYYDxyZ9LLc0OldjMygCModmro29NJVA2RXgszVwOi39
         3Y/w9xjY0TFWf38/iu6ZvIjmBH7OGMOyhTO1ut0gg4SPGGFzy3VRPAzXYfrhAnjmpv0H
         HHDWhb4v0mDBj0cE//8IEsKBSVj8odnO7qfX1XwwNktyNC2GaRydq5iIt2a8CGJ/scJp
         guQuQc9ovXj2Rhu4m5NJFWcgEgrP9Y0QXYqvWOnT0dEEnbEtiQAVhRM4CR7uGBtXabWR
         KOBtKG2MqnIe3MkrebMaQUEffRQtsrLTF/9RJOXtAWAJl8V8yFlF340a5yFFdutMTp5X
         jbpA==
X-Gm-Message-State: AOAM530g0z/uqw5TuiUfgJ7QgDVHQT+w6Jl7Y+L9x8wXQdTuiZIgveJd
        wO1RvxyhhePmZkPIlWXAgntpJW96Ju89IJxfb1uz2Ku9x5XQqozOModiAGkSkpCARiqe23884d3
        8xvzg8wNoJsJvZSAVQ7uA3I9v2fU=
X-Received: by 2002:a05:6402:2814:: with SMTP id h20mr74150978ede.288.1638186415913;
        Mon, 29 Nov 2021 03:46:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJywMGjp72wdcWEKWJZtg0ZjVFVZf8EUNtBtzQtLSVMJUUbknoYpGWghdXGdNuLIU+P9WMRQ==
X-Received: by 2002:a05:6402:2814:: with SMTP id h20mr74150934ede.288.1638186415563;
        Mon, 29 Nov 2021 03:46:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gn16sm7333737ejc.67.2021.11.29.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 03:46:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 53A971802A0; Mon, 29 Nov 2021 12:46:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: Re: [PATCH v2] ath9k: switch to rate table based lookup
In-Reply-To: <20211128090753.958-1-jelonek.jonas@gmail.com>
References: <20211128090753.958-1-jelonek.jonas@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 29 Nov 2021 12:46:53 +0100
Message-ID: <87bl239ob6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> writes:

> This patch changes mac80211 rate control for the ath9k driver.
> The rate lookup per packet is changed from legacy usage of
> ieee80211_get_tx_rates() to the new rate table based lookup in struct
> ieee80211_sta->rates.
>
> The most recent rate control API (introduced with
> 0d528d85c519b755b6f4e1bafa3a39984370e1c1) allows drivers to directly get
> rates from ieee80211_sta->rates. This is not used by every driver yet,
> the translation/merge is currently performed in ieee80211_get_tx_rates.
> This patch changes the behaviour and avoids the call to
> ieee80211_get_tx_rates and subsequent calls. ath9k now directly reads
> rates from sta->rates into its rate table. Cause ath9k does not
> expect rate selection in SKB->CB, the table merge does not consider rate
> array in SKB->CB except for the first entry (used for probing).
>
> Tested with a 8devices Rambutan with QCA9558 SoC by performing two
> runs, one without the patch and one with. Generated traffic between
> AP and multiple STAs in each run, measured throughput and captured rc_sta=
ts.
> Comparison of both runs resulted in same rate selection and no
> performance loss or other negative effects.
>
> Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>

Better, thanks!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

