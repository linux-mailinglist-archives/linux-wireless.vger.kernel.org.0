Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A94DC270
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438519AbfJRKPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 06:15:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47997 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442482AbfJRKPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 06:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571393717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPfdn1wJgZGqQXuVAEaKG2OM7BuZcbx3t0qWbYXPYIY=;
        b=CqO/ZpzOTBDlRsy0P/nPM2HzbfCVXmu6Q87v96ubVGedtcDrrBGsZZKrTu6DV+wlup5BJl
        5gv4Y1O/vC6+EP7L+ew/rmOrlqLoe+1W14B+XfvxHIETLBgHJYkPUcaFkjG4mGtLtHevzW
        5I0HU+UU3/1ar2Sbvy6fZKtu0d3oan0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-B31KicRPMLelMl44H7gV5w-1; Fri, 18 Oct 2019 06:15:15 -0400
Received: by mail-lj1-f200.google.com with SMTP id m8so963428ljb.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fPfdn1wJgZGqQXuVAEaKG2OM7BuZcbx3t0qWbYXPYIY=;
        b=M+Ip6H7U4JdiFm/LeLt1oN4FOhBf5X7ckhtO6fZ6tG8fMNLyqvobpJjXQMPjOO30sL
         On0QK61XYv+1d1tkEjYh7OUY5VcFB87AdJX1l6BA4aDX+mg0516x/SVkICV3z7cZTvp4
         kNRoyvM5OpNlozmimvqVlOgOCpzydge0fHuvhltFEVb8KhnIG0f2rqqaKzMzahthsXy1
         HHvLO1O0C7LdjrqhNc7FBJQFsJdwXhqY12g9IDAbBrT6t7YsBlR0MsaQbt8wR0pfHnSq
         9HqewSVTvLRdsy52phOlHuqQVlQy9FvnZKyoZ+B0sDLUExh3wVgk4j2E8nPGTAQ2Fyuq
         ztwQ==
X-Gm-Message-State: APjAAAXaI7qX8hSFGAOZ5jGYqlxGp6e+UD6zYyIDTMESCx+71OM+pY8D
        macEXC1pjHaRhQ5SYI/GpV2dLfBJo6wmuu62yenVzFu6+A90Sc1wm/YzSiHxGkSLADyCDD4mVbL
        rDSV05KsOeQltWPVXWphKCbB8UmY=
X-Received: by 2002:a2e:501c:: with SMTP id e28mr5633714ljb.201.1571393714343;
        Fri, 18 Oct 2019 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzS9cqDMn8709PKQFYCsL6fEv1jTLkzhF66c6MpwtxFxNTvaB57PQEp+T6O/S1uC35uTMRvqw==
X-Received: by 2002:a2e:501c:: with SMTP id e28mr5633684ljb.201.1571393713934;
        Fri, 18 Oct 2019 03:15:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v1sm2085763lfe.34.2019.10.18.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 03:15:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 000821804C9; Fri, 18 Oct 2019 12:15:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
In-Reply-To: <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115993866.2500430.13989567853855880476.stgit@toke.dk> <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 12:15:11 +0200
Message-ID: <87sgnqe4wg.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: B31KicRPMLelMl44H7gV5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> The "tx_time_est" field, shared by control and status, is not able to
> survive until the skb returns to the mac80211 layer in some
> architectures. The same space is defined as driver_data and some
> wireless drivers use it for other purposes, as the cb in the sk_buff
> is free to be used by any layer.
>
> In the case of ath10k, the tx_time_est get clobbered by
> struct ath10k_skb_cb {
>         dma_addr_t paddr;
>         u8 flags;
>         u8 eid;
>         u16 msdu_id;
>         u16 airtime_est;
>         struct ieee80211_vif *vif;
>         struct ieee80211_txq *txq;
> } __packed;

Ah, bugger, of course the driver that actually needs this is using the
full driver_data space :P

> Do you think shrink driver_data by 2 bytes and use that space for
> tx_time_est to make it persistent across mac80211 and wireless driver
> layer an acceptable solution?

Hmm, the driver_data field is defined as an array of pointers, so we can
only shrink it in increments of sizeof(void *). I think it may be
feasible to shrink it (as in, I don't think any drivers are actually
using the full 40 bytes), but doing this in a way that will gain us a
2-byte space that is also usable in the case driver_data is *not* used
(i.e., it needs be able to align with a field in .control and .status as
well) would require some serious surgery of the whole ieee80211_tx_info...

However, there's a nice juicy 'u16 ack_frame_id' at the start of
ieee80211_tx_info. Could we potentially use that? We could use the top
bit as a disambiguation flag; I think we're fine with 15 bits for the TX
time itself (a single packet won't exceed 8ms or TX time), so if we can
live with 15 bits of ACK frame ID space, that could be a way forward?

Johannes, what do you think?

-Toke

