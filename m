Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC505100438
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 12:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfKRLct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 06:32:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbfKRLct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 06:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574076767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrXtzxd8mglGLRdGfil/BT3CpqfjW0pQ6XkstoEJu1A=;
        b=gYiDj7ik2Z+gxHqX5hSBaFwmj/kU5AycGeCkXziPBMp+cMUMjmpypgdRoXpqD4J/DB2Vj2
        9WWzCuX6apjx6gcazUBfDJPhH4lmg9GW2eqnyGBTvJoO84mA/m54og4rVfGUFKT1rLD54l
        8MLm+4WoW/NkCjYVjKyBWh6VhSCIpZ0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-UfHNObznNzGtkeB9VU5nQg-1; Mon, 18 Nov 2019 06:32:44 -0500
Received: by mail-lj1-f199.google.com with SMTP id 70so3203501ljf.13
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 03:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IAgBjcqZliVGAeskhCUE1TpV4MaPXe7hf936RNbjg4A=;
        b=td87qG1Irpn4n9iikJ1ELCzSiFyDlxSLURwY6Gi2/TOatTgjQKEJYxh9iTQS8wCOkp
         C+dBDJBq8x+sIBEGUfz9eyVaBcnIya3su6towXVyjKIq2G2RYA7c/nP3dlOKfpP2ygdS
         4S5nRXV5gUlbz2JSRlzPOTvyN4pI0g+2UQJhkRXwx8wwF6Vd3ZjVg94TKjlzDlU5VnMU
         uTMzNVJcrQhtNRyjvhlCR+qPorCDJg9njsQ3wGH1GnR+QhFD6QGYkiuTiMfs/sCPfPgM
         gxBORBbZd1EmuqtcEZRzKjTwUbhfHY+kP1KA3ex/tLPNOBx/oR5tpKWRdN0yHr+pYKvI
         1b3w==
X-Gm-Message-State: APjAAAWoKzDhBViGcCaZIQaO3L1i5hJPTZXWgnfjHVDttynRMzOWMxXR
        OWJPaRkzc0doMt1yyfSfVsJWiDVIgcKNY974fs8JFsaXnawa45fCv0+qTwzRJylzox3MZGKoBeV
        Y9SUNXkyK0Fel0qS3sKa+Cccw80g=
X-Received: by 2002:ac2:4102:: with SMTP id b2mr2552981lfi.16.1574076762590;
        Mon, 18 Nov 2019 03:32:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl7xVVcmWbCfSn3JtIVYgSFqaE/CLSsQcb5uL2caD5OFZjeWgfoqKJUfLiKx2k3AsWooXbkA==
X-Received: by 2002:ac2:4102:: with SMTP id b2mr2552960lfi.16.1574076762359;
        Mon, 18 Nov 2019 03:32:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id h16sm8361399ljb.10.2019.11.18.03.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:32:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9A15D18190D; Mon, 18 Nov 2019 12:32:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Ming Chen <ming032217@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Ming Chen <ming.chen@watchguard.com>
Subject: Re: [PATCH v4] mac80211: Drop the packets whose source or destination mac address is empty
In-Reply-To: <20191116060833.45752-1-ming.chen@watchguard.com>
References: <20191116060833.45752-1-ming.chen@watchguard.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 18 Nov 2019 12:32:39 +0100
Message-ID: <87blt9ctd4.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: UfHNObznNzGtkeB9VU5nQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ming Chen <ming032217@gmail.com> writes:

> We found ath9k could occasionally receive some frames from Linux IP stack=
 with empty source
> and destination mac address, especially when the radio mode works as a wi=
reless client and
> configure a static IP. If the ADDBA has been negotiated, this kind of err=
or packets will cause
> the driver failed to find the opposite node (VAP) while in the function o=
f processing these frame's TX
> complete interrupt.
>
> The above failure happens inside the TX complete processing
> function ath_tx_process_buffer while calling ieee80211_find_sta_by_ifaddr=
.
> Inside the function ieee80211_find_sta_by_ifaddr,
> the condition of ether_addr_equal(sta->sdata->vif.addr, localaddr) will r=
eturn false
> since localaddr(hdr->addr2, 802.3 source mac) is an empty mac address.
>
> Finally, this function will return NULL to ath_tx_process_buffer.
> And then ath_tx_process_buffer will call ath_tx_complete_aggr to complete=
 the frame(s),
> However, the sta is NULL at this moment, so it could complete this kind
> of the frame(s) but doesn't (and cannot) update the BA window.
> Please see the below snippet of ath_tx_complete_aggr
> if (!sta) {
>         INIT_LIST_HEAD(&bf_head);
>         while (bf) {
>                 bf_next =3D bf->bf_next;
>
>                 if (!bf->bf_state.stale || bf_next !=3D NULL)
>                         list_move_tail(&bf->list, &bf_head);
>
>                 ath_tx_complete_buf(sc, bf, txq, &bf_head, NULL, ts, 0);
>
>                 bf =3D bf_next;
>         }
>         return;
> }
>
> To fix this issue, we could remove the comparison of localaddr of ieee802=
11_find_sta_by_ifaddr
> when works as a wireless client - it won't have more than one sta (VAP) f=
ound, but I don't think
> it is the best solution.

Ah, so the TX path doesn't do any lookups when the device is a sta, but
the TX completion path does? This was the information I was looking for;
please explain this in the commit message, you don't need to paste in
the code :)

> Dropping this kind of error packet before it goes into the driver,
> should be the right direction.

So I still wonder why this happens from higher up in the stack. If
there's a legitimate reason, maybe dropping the packet is not the right
thing? And if there is *no* legitimate reason, maybe the packet should
be dropped higher up in the stack instead?

What kind of packets does this happen with?

-Toke

