Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18377DA8E5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 11:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405728AbfJQJod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 05:44:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25295 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727873AbfJQJoc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 05:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571305472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvdX82gDjYsI6+terlAiEqdwIFtB7f56kH7xxsKFHgE=;
        b=h4JFgOYZ8BXpArxA53D/nP428nOrPmZkP8NFAN16rEC+z/DKb6SWNvUCKv4oXW8myZ8vFW
        kMW6yNcUgscuc1qCyp/QF3aUXwAR+TG6hGIoIIuvyPXI7pJkbDKHcpjz84VB4wCOjR8DjY
        XFvBFeGKCQ+vqXKVGfpFU667IEGcUJs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-JqSH6VFdOmC58Ta36sWcVw-1; Thu, 17 Oct 2019 05:44:30 -0400
Received: by mail-lj1-f200.google.com with SMTP id m81so308044lje.4
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 02:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=s+jcaxhu6oDWhtVBooMl1ngDQtHW2eHMGXoYZ8Sz7Y0=;
        b=H4cLoR9SmhScP0aeycDpRKKnsATqWn7oNSd3mzdoHzQ9DMV0tW2qe0XLMYS940qWqv
         1hHhAFKyGAuL437UaZ2rtAjQBPQgD2p178y+Y1IbJgd9VgW1wyfOcE24eTDguuSfPwiG
         BKvEOXGxTEsZ4BhoimPiGpQHPN12dwQWrtnPCEhrvmzAJYv0wi8s8TcHOtyQes+RBZu7
         6xKhO6FL1pyP88B+VsBpSqcv6XaxEORGX9UNMpsPlCPBZISH2pnMTDs7QWisD+qZUF0A
         ecSBfZrDOnpOWiOoBAOPFpyEbG6B7N8clAxUjaRvQYqXh9oAwqK0KVQ4ZAMf/5NTUst+
         DmwA==
X-Gm-Message-State: APjAAAW772snomnK62ZGsQhJ6otTXMRAVAbwQQHJtRcPwdrxuuMTe7LL
        zkK+cCdGEYTcBj5/0aAsMlAeB+gNpGiAmVPkM09dNcrvR0AyI5JrV09x+KE3uBWPa7yOffYYpio
        ItG568MEUy3GlPqeTCf7LSUufTsM=
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr1947443lja.24.1571305469130;
        Thu, 17 Oct 2019 02:44:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxO1j6qiZOfAL5tJA6olP8+LPlYQd+Y7no3y4yFz1FQHRzpNQVDOQEvMTwwldWseOilFhe41A==
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr1947434lja.24.1571305468911;
        Thu, 17 Oct 2019 02:44:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id u26sm825833lfd.19.2019.10.17.02.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 02:44:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 810AE1804C9; Thu, 17 Oct 2019 11:44:27 +0200 (CEST)
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
Subject: Re: [PATCH v2 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115994190.2500430.14955682016008497593.stgit@toke.dk> <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Oct 2019 11:44:27 +0200
Message-ID: <87o8yfg0zo.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: JqSH6VFdOmC58Ta36sWcVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Hi Toke,
>
> Thanks for getting this done! I will give it a try in the next few
> days.  A few comments:
>
>> The estimated airtime for each skb is stored in the tx_info, so we can
>> subtract the same amount from the running total when the skb is freed or
>> recycled.
>
> Looks like ath10k driver zero out the info->status before calling
> ieee80211_tx_status(...):
> int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>                          const struct htt_tx_done *tx_done)
> {
>  ...
>         info =3D IEEE80211_SKB_CB(msdu);
>         memset(&info->status, 0, sizeof(info->status));
> ...
>         ieee80211_tx_status(htt->ar->hw, msdu);
> }

Ah, bugger; I was afraid we'd run into this. A quick grep indicates that
it's only ath10k and iwl that do this, though, so it's probably
manageable to just fix this. I think the simplest solution is just to
restore the field after clearing, no?

> We need either restore the info->status.tx_time_est or calling
> ieee80211_sta_update_pending_airtime() in ath10k before tx_time_est
> get erased.
>
>> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
>> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif, =
txq->sta,
>> +                                                            skb->len + =
38);
>
> I think it is better to put the "+  38" that takes care of the header
> overhead inside ieee80211_calc_expected_tx_airtime().

Hmm, no strong opinion about this; but yeah, since we have a dedicated
function for this use I guess there's no harm in adding it there :)

-Toke

