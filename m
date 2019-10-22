Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7BEE02FD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 13:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbfJVLfW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 07:35:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30023 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388671AbfJVLfW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 07:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571744121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lXUdIMpqZFihIoO9yzChXD19YUfn5jCLlrdTWpXVmA=;
        b=e48az/H181QGPEk5nrq5EjCQG4d4ruwJzaJRoPj56062kAO94I6R48qmODqzkJNwKATJNX
        XihGMdD4cmiLCR5D4ikCjwFazd8RdsGTQEiIPl4WY7ud97HNBD6H6rTeH+cgyjYxG2qdEG
        d411Gpy0MbvTlRh0xTSqH6S7JxFgWNM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-ngypYPZ7OHSHwod_HwKkFg-1; Tue, 22 Oct 2019 07:35:19 -0400
Received: by mail-lf1-f72.google.com with SMTP id m24so3367677lfh.22
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 04:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5Z4MpTbIw+JCQPCzaEXbau+RX+9w+zSZ8KSShaRJy8k=;
        b=oyTNJyxDgpdqmS/mlQ3TmFxqxqi4kVi64l8recvIvA+tHbMmqKxko/AwJWEV6SIybL
         +1qwn9LOK67S9cfTmVU5oKVTwCDOCXXxG2P0evxaQLaAfb6hZ+1SwUrt0fw6V2LbKx5D
         5Lur97z0JS2bIHDC7HOnz02+jQsDI0jt9QP3GNFOfn8m1t+y+2NR9prMjiT/OOK1MOda
         n2kFc8Cs4bD6yiP2Xz5l0Qf+jwr46H3B2TQrwInbxX9gUbGPiKY5FfJR0X/v0vHxw2Ni
         xmjYT75qdFhhfPxnRH8FsfRbUXJCaA/nm1dM14/OQyzktETUxBfCJVY++5RleahbSUzr
         wz8Q==
X-Gm-Message-State: APjAAAUXa1RTBBiCeWeYHWdvfnmkZPmTcWc4G2SghvKyG/w5f2DvS9qW
        Og6X7UyQ+fXvm4JiOV8SvQiS3Uaf+dl0ba12UBb+L2PkP4GDGnGceq6hSNEX6MWwJuuTBjXLMaM
        FbalNVXE+MGUgzQ7YwRGbXJU42Jw=
X-Received: by 2002:a19:6a08:: with SMTP id u8mr19884669lfu.74.1571744117868;
        Tue, 22 Oct 2019 04:35:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmGTFXAJkFuoNzgelmQogIQSog/uQu9muSz0RpmB3Wbx+A4SlxIO3hShCl4fhxL63M2txo1g==
X-Received: by 2002:a19:6a08:: with SMTP id u8mr19884659lfu.74.1571744117720;
        Tue, 22 Oct 2019 04:35:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b67sm16614489ljf.5.2019.10.22.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 04:35:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2DABF1804B1; Tue, 22 Oct 2019 13:35:16 +0200 (CEST)
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
Subject: Re: [PATCH v4 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
References: <157148503415.2989444.7391437309981941226.stgit@toke.dk> <157148503865.2989444.7118792679603045723.stgit@toke.dk> <CA+iem5sy16=xMZjJi1nKHrxP_xWHk-86G=ZLwtMMb04EOt5tQA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 13:35:16 +0200
Message-ID: <871rv5ovwr.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ngypYPZ7OHSHwod_HwKkFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> +               if (ieee80211_is_data_qos(hdr->frame_control)) {
>> +                       qc =3D ieee80211_get_qos_ctl(hdr);
>> +                       tid =3D qc[0] & 0xf;
>> +                       ac =3D ieee80211_ac_from_tid(tid);
>> +               } else {
>> +                       ac =3D IEEE80211_AC_BE;
>> +               }
>
> The tid/ac is incorrect either here or in __ieee80211_tx_status() when
> tested with ath10k. The ac is set to AC_BE with test done using BK
> class traffic,  hence the pending airtime get updated for the wrong
> txq.

Hmm, I guess we could just get the ac using skb_get_queue_mapping().
I'll send an update with this fixed for you to try :)

-Toke

