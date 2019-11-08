Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B9F451A
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfKHK4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:56:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52825 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbfKHK4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573210600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z632feK0xo57emf6fFS5gwdIUzpWePHRoWFGwMcdBdg=;
        b=MAn+gmY6hP8+ZOLNyneH2SnM4CvRJCnKTzhfEu1THymRQ8I+PpZlAaeN2dfhNb9D5sNdUv
        hVNZG3wT8PJY6eVVt92td6/2YfpvniWHgmFwIjtflSZhnkllEAyjc9L1hfzrPKGzf+epBX
        zlh2fsawvlwtvZ97LzUNr8y2bPsdzYs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-KXHTCg0MNHiIbK8_Z4h99A-1; Fri, 08 Nov 2019 05:56:37 -0500
Received: by mail-lj1-f198.google.com with SMTP id o20so1169535ljg.0
        for <linux-wireless@vger.kernel.org>; Fri, 08 Nov 2019 02:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B9ScARlo/HyQ+QLgyEDozc6otjhcAwH0CJnAxZVp+qs=;
        b=JFFgZ1JRC02u4zfiZLZ5PFT0C/rUaI5anFEM7TYJtyP9oKjPb7AM/xeec2Pi8W3hqT
         7CNwdn1JuPfPGrNz1CFKWoxHsNTHB3VqK0uKK3aD/LbzUSMsnZaWn4VN1Urh9K7q+5VD
         I0SsZBcKiEugHP0FA0EGt6nbFbrsp81DimSMt8xdbTWNaAIo9sXbA/N3uLPZ8wLzP4l6
         qyT3ndPUF9etrNAehfWS2dqNZKkvbk+dXpOI+J2MAnxp1BHyzD4AqjZYFr96pE+faXKV
         MFW2c2Zb9mfIpL6E+oKJn99iDR58yRDjKgVuFxE5VUF3XChtC+HJcPF+fcvrsQTppA8J
         urpQ==
X-Gm-Message-State: APjAAAWApZqoRp0JMzBOn3x6Zd5mcCTH2xKyNvY5Y6NuUtLQNMb6C/ES
        LgCdomaExXpjtjBkpaBEYd14RluyITlpAN3HWikie0iLJd5FVhjaXgQVEz6gL5vg3bskUpgTThb
        l+SEJaQmoXldqbtZ4bVav7Vv1594=
X-Received: by 2002:a2e:481:: with SMTP id a1mr6439832ljf.209.1573210595635;
        Fri, 08 Nov 2019 02:56:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFcYZbOdtEDfT7QaSh8Ph/WLAe9hmZ00Pfr21Wfx5hUy6ZBT/I3FE48cO9bVUQkyeCpv48Hw==
X-Received: by 2002:a2e:481:: with SMTP id a1mr6439821ljf.209.1573210595508;
        Fri, 08 Nov 2019 02:56:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id x23sm810347lfe.8.2019.11.08.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 02:56:34 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39B381818B5; Fri,  8 Nov 2019 11:56:34 +0100 (CET)
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
In-Reply-To: <1a2eb096119c9029e67caf797564d6511c8803a7.camel@sipsolutions.net>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk> <157182474287.150713.12867638269538730397.stgit@toke.dk> <1a2eb096119c9029e67caf797564d6511c8803a7.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Nov 2019 11:56:34 +0100
Message-ID: <87a796fxgd.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KXHTCg0MNHiIbK8_Z4h99A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2019-10-23 at 11:59 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>>=20
>> =20
>> +void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local=
,
>> +=09=09=09=09=09  struct sta_info *sta, u8 ac,
>> +=09=09=09=09=09  u16 tx_airtime, bool tx_completed)
>> +{
>> +=09spin_lock_bh(&local->active_txq_lock[ac]);
>> +=09if (tx_completed) {
>> +=09=09if (sta) {
>> +=09=09=09if (WARN_ONCE(sta->airtime[ac].aql_tx_pending < tx_airtime,
>> +=09=09=09=09      "TXQ pending airtime underflow: %u, %u",
>> +=09=09=09=09      sta->airtime[ac].aql_tx_pending, tx_airtime))
>
> Maybe add the STA/AC to the message?

Can do. Any idea why we might be seeing underflows (as Kan reported)?

-Toke

