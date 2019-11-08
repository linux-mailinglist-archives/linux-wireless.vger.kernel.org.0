Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6987DF456F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfKHLKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 06:10:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHLKk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 06:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573211439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+7OvF9pTiFagC4uXjlG85gg/uA64p5Hu8Gw3YYGZVc=;
        b=fUDtWw7gldO3vTzZiCCqbmMRYkdMeGfjIlJHjOQUZshh0RV45s+Rhuo8A1AxQkaXPebqtE
        kZvnceUEtetTQJFgSYU+TelbRbyyIPA3OIObgkBZoIwV2PW00ALvC8kUiV/cnKNDshUUAY
        9aJVSdnvZZ7PzVjGHgHlllReYiZtC6c=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ciScoZfCPc2wcGGl6wm4Xw-1; Fri, 08 Nov 2019 06:10:35 -0500
Received: by mail-lf1-f70.google.com with SMTP id d2so1226841lfl.12
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2019 03:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=f/TIDfvlS9K2Q9yW8jvdJa+i8whstu4ovcYsTR8Jd+c=;
        b=Iu1FoYceQgWLH/koinQTWstaV2b4XwbSPo+ALONjCud8er5MYoMA2iNf4GaaNaF4B5
         qb6icMmqUjiG8Ti/xeuHkSGDx2C05TdoxATWMdSaw5s27+we8fpCT6uHPXWtwj38au8X
         Zx+JtiT4BHL30hv0KeYqNFp8UMJluZCGg6OR+xLMWwsoEwtnfCYfHXzvntIYSas7xMRV
         lVf31OlN4g/9/KOoTzvYjgMoGXercGNxMpeYfANuiROWGK8PdHUP4m/SiJCVcqNyyT2M
         PE61CGyShKZEejKI34lQM4IPeyHgVIhcNswzOBPZSiL+zt9FJKPprZbr8CUGfyl4283C
         3I2w==
X-Gm-Message-State: APjAAAX/p0lGOh5fAeo7OOVqLKOK3yXWcffs8XpSd7Es2/g0OL3JNvqd
        ywFegrxgHVMG6cwRfBfAdMnwSTykPOuSimmszzkI9QMRnwkbirIdGDnDvGvNFvUHsjEkgj+/+An
        bie+1tTS0LYzMY/r8/oGjKq4fWeQ=
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr6459974lja.239.1573211434286;
        Fri, 08 Nov 2019 03:10:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvL1cSCElAKKooFC9WpiIg1tuPMvZ1oS5U0qu+66rIj8IZ6hiz62Nov/WldvhI3NoplSN+bw==
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr6459954lja.239.1573211434056;
        Fri, 08 Nov 2019 03:10:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id y17sm2225326lfy.58.2019.11.08.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 03:10:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8F9CD1818B5; Fri,  8 Nov 2019 12:10:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v6 3/4] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <f395a9a971ca1a0d0438fca10dfb160c421caa7a.camel@sipsolutions.net>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk> <157182474287.150713.12867638269538730397.stgit@toke.dk> <1a2eb096119c9029e67caf797564d6511c8803a7.camel@sipsolutions.net> <87a796fxgd.fsf@toke.dk> <f395a9a971ca1a0d0438fca10dfb160c421caa7a.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Nov 2019 12:10:32 +0100
Message-ID: <874kzefwt3.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: ciScoZfCPc2wcGGl6wm4Xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-11-08 at 11:56 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>=20
>> > On Wed, 2019-10-23 at 11:59 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> > > =20
>> > > +void ieee80211_sta_update_pending_airtime(struct ieee80211_local *l=
ocal,
>> > > +=09=09=09=09=09  struct sta_info *sta, u8 ac,
>> > > +=09=09=09=09=09  u16 tx_airtime, bool tx_completed)
>> > > +{
>> > > +=09spin_lock_bh(&local->active_txq_lock[ac]);
>> > > +=09if (tx_completed) {
>> > > +=09=09if (sta) {
>> > > +=09=09=09if (WARN_ONCE(sta->airtime[ac].aql_tx_pending < tx_airtime=
,
>> > > +=09=09=09=09      "TXQ pending airtime underflow: %u, %u",
>> > > +=09=09=09=09      sta->airtime[ac].aql_tx_pending, tx_airtime))
>> >=20
>> > Maybe add the STA/AC to the message?
>>=20
>> Can do. Any idea why we might be seeing underflows (as Kan reported)?
>
> No, I really have no idea. The shifting looked OK to me, though I didn't
> review it carefully enough to say I've really looked at all places ...

Right, bugger. I was thinking maybe there's a case where skbs can be
cloned (and retain the tx_time_est field) and then released twice? Or
maybe somewhere that steps on the skb->cb field in some other way?
Couldn't find anything obvious on a first perusal of the TX path code,
but maybe you could think of something?

Otherwise I guess we'll be forced to go and do some actual,
old-fashioned debugging ;)

-Toke

