Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A93DC61E
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390344AbfJRNcC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 09:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729783AbfJRNcC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 09:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571405521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cODPLBBVonkUiIpH4f4PqhtfdSO3phWXnys6GllvTEg=;
        b=MUeIYi0GsztQHYM6oAfLN1h7ok59IcC/Kioa0jhI9r7WQTBVVWmB2lMPsl1vKfd9q0dwoo
        wLJ9Os1arbML5hj9zysas4ukd68AlDgEvauwLCAH/aek6ZoDfEonNIS+1jOw1/O51/1sJh
        UBgvX/ImdYib4RsTvKl6+8NkrRNqSSE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-z_aKQ6mGNtGX_20ycYET0g-1; Fri, 18 Oct 2019 09:31:59 -0400
Received: by mail-lj1-f198.google.com with SMTP id h19so1077776ljc.5
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 06:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XN/8OjVppdRnLblVaPpSKD9DtkrDEMBwYKQu+M/VWcw=;
        b=MxaBHZEVQlagnCnQz3kArtkNi8sxgNzx0Nf2jkfGXd2KQ+WQKNg7bJOAQn8nbApEJ4
         /nB93cl7jfMGMCi2+QkpNUzvo600MaC/5Hg5uTr1DLhjFLoERPUyiEiBaIDHEkaWzZvg
         b94Ple4bUnTuNMf7SHzNbS2FOMjf8f4o8Lqc4pufA3s9zAyMqQAkHAo0wXwP/pZKgjog
         oz9FyKi5KHsTB6XcCULxUoHS2su9NgVrZQgt7tkZXcA76rO6bS3FYRFZymxxZ2wYxmbX
         K2MFzpEuRavSJL5GMs/Twra3o4gLbc3HTamDt421CK3JMSdT5VWxP7zs+mKDKpWALwbY
         AsxA==
X-Gm-Message-State: APjAAAUNPq/0khODlHQxRUABdwWnLg8yBYtChcfIJanXE9htzcEGAjcC
        5fpZUfxBT1dLiZOug6iNzMYD+136eopdIF08XQl7FP98eHfzKqD5YJ0UzWw8BikmZ6PFDJmgsQa
        RPAY1NY2gOqwsJCQiMYtOigWESrw=
X-Received: by 2002:a2e:9d06:: with SMTP id t6mr6315640lji.253.1571405518207;
        Fri, 18 Oct 2019 06:31:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzobtq2iwjsmdwouFLGuBz34E9/3KDGP7qHrvOlf6dl4IKYvTs4reNBPkKTi0p7qMtrwryUwg==
X-Received: by 2002:a2e:9d06:: with SMTP id t6mr6315616lji.253.1571405517859;
        Fri, 18 Oct 2019 06:31:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id n17sm2124674ljc.44.2019.10.18.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 06:31:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 566B21804B6; Fri, 18 Oct 2019 15:31:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
In-Reply-To: <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115993866.2500430.13989567853855880476.stgit@toke.dk> <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com> <87sgnqe4wg.fsf@toke.dk> <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 15:31:56 +0200
Message-ID: <87imomdvsj.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: z_aKQ6mGNtGX_20ycYET0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-10-18 at 12:15 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
>> However, there's a nice juicy 'u16 ack_frame_id' at the start of
>> ieee80211_tx_info. Could we potentially use that? We could use the top
>> bit as a disambiguation flag; I think we're fine with 15 bits for the TX
>> time itself (a single packet won't exceed 8ms or TX time), so if we can
>> live with 15 bits of ACK frame ID space, that could be a way forward?
>
> I was going to say that should work as we only ever have a handful of
> ACK frame IDs, but ... you still need the airtime even for a frame that
> userspace wants to know the ACK status of, no?

Oh, right.

Well, let's try to do the actual math... A full-size (1538 bytes) packet
takes ~2050 microseconds to transmit at 6 Mbps. Adding in overhead, it's
certainly still less that 4096 us, so 12 bits is plenty. That leaves
four bits for the ACK status ID if we just split the u16; if we only
ever have "a handful", that should be enough, no?

We could also split 5/11. That would support up to 32 ACK IDs, and we
can just truncate the airtime at 2048 us, which is not a big deal I'd
say. We could even split 6/10 and only need to truncate the TX time at
rates below 13 Mbps... Or we could sacrifice a bit to the flag and only
truncate if the ACK status flag is set.

Think it mostly depends on what is the smallest ID space for ACK IDs we
can live with? :)

-Toke

