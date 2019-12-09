Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4D116C00
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLILLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 06:11:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48196 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727561AbfLILLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575889866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKNJqGYoFHuNlkkCEvoI/4LL4dAPCIC/HY9H8FJVQzM=;
        b=hVNAV6rsqhJAMiPYIK0ZN808289z3d33x7cIjOUBnS6VNZ+AVaHifw9oy4U1ajN+WxtUJj
        aros+dE67MvaG1rXHQfRWT41Fm7B9TOek//CtjFRJ8//2qi0851gZjsKq1sH/lGyONVtv7
        vJuKs19807p+VysDzwGT5bZOm+cQlg4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-yYSHLWsyPU6n20vUzU1GHw-1; Mon, 09 Dec 2019 06:11:04 -0500
Received: by mail-lj1-f200.google.com with SMTP id c24so3223638ljk.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 03:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/XI1i3yD2ZF8jeazCNhTgJLTTX7l/kk7N2T0Iz8NsVo=;
        b=IGaLNZp0CV8HHXXHxQDvQzrtDSBTFFPB+nBz3y63CFomVBkgF9aOMkATFX4MBO/4BY
         LN1ug8nEi7UGQO9b6om+tdl6+ri5taBMP1mX8KeNtLFihJzNQCBRvcRtBQbyD05V90//
         G778e2kY6F+a0ybTQZ2JaaSvBA36BGLyu7Tw6C4T/VuMY0eXhp7mdYllOsaNyq0d45EU
         B8KPfe5/d3d2+W3LqH5kE93AuSXDZcj7S1Un/9cSMGnML/n2fb/NWNvGKq1d/MbkezMZ
         Ew48Y8J08Kd98/S2MaMCQCcmCNxPWFEMMV53KTjKKfMFeTvVB+4mCXsXqYSAzHO2YJvO
         G+fg==
X-Gm-Message-State: APjAAAUyQup91tot11JRXidAG2VjSlIqFM15YaPgGARKDke7gbZcaYYZ
        SdnORIXj6Qch3Bwhd7KNp0yMdU++bN/LvTKIJdk9fq3eGRzsQAKa4tdNt4Xsy/AZlaQKNH8pnYb
        f4Ibrjr9Nb5Hp2zdQ1CvPCWOEv5Y=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr17195083ljc.87.1575889862656;
        Mon, 09 Dec 2019 03:11:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz7+idSyfFRccLmSN8y783VRquoHKeJhGew9SSKWdah45sGBl7BuznHHfRp0fUYiD+0/fR8A==
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr17195059ljc.87.1575889862292;
        Mon, 09 Dec 2019 03:11:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v9sm4240067lfe.18.2019.12.09.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 03:11:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B41A18257B; Mon,  9 Dec 2019 12:11:00 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: 5.5-rc1 oops on boot in 802.11 kernel driver
In-Reply-To: <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com>
References: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com> <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 12:11:00 +0100
Message-ID: <87h829lpob.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: yYSHLWsyPU6n20vUzU1GHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Hi Steve,
>
> Steve French <smfrench@gmail.com> writes:
>
>> Noticed this crash in the Linux kernel Wifi driver on boot a few
>> minutes ago immediately after updating to latest mainline kernel about
>> an hour ago. I didn't see it last week and certainly not in 5.4.
>
> please CC linux-wireless on all wireless related problems, we don't
> follow lkml very closely and I found your email just by chance.
>
> Full warning below. Steve is using iwlwifi.

Right, we already got a similar report off-list, but with a different
stack trace. I was going to try to reproduce this on my own machine
today. However, the fact that this includes the iwl_mvm_tx_reclaim()
function may be a hint; that code seems to be reusing skbs without
freeing them?

If I'm reading the code correctly, it seems the reuse leads to the same
skb being passed to ieee80211_tx_status() multiple times; the driver is
clearing info->status, but since we added the info->tx_time_est field,
that would lead to double-accounting of that SKB, which would explain
the warning?

Can someone familiar with iwlwifi confirm that this is indeed what that
code is supposed to be doing? If it is, I think it needs the patch
below; however, if I'm wrong, then clearing the field could lead to the
opposite problem (that skbs fail to be accounted at all), which would
lead to the queue being throttled because the limit gets too high and is
never brought back down...

-Toke


diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/tx.c
index dc5c02fbc65a..7d822445730c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1848,6 +1848,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, i=
nt sta_id, int tid,
                iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
=20
                memset(&info->status, 0, sizeof(info->status));
+               info->tx_time_est =3D 0;
                /* Packet was transmitted successfully, failures come as si=
ngle
                 * frames because before failing a frame the firmware trans=
mits
                 * it without aggregation at least once.

