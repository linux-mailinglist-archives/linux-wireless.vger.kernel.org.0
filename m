Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949C6DA9DF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfJQKYf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 06:24:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28082 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726248AbfJQKYe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 06:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571307873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcgTAsykrrNBZTJbyqExhJnM6yJEQufUqHJ8rZTQa9o=;
        b=gNTkiB6wKIovZ/4gxGtDcwLNPQ01CM7HnefPmM9ooGLZuPR+z84lfjWYC7ekcNoYCQncnr
        CQCn+FtvnmeM2hBL/bK5xy7l23DpZGh+cSwWorFVyaImF61hq5lyhbG215zVQKKDlwrl2E
        o46X+r1Q2hhuB9+R6th+I2zc/YslHLo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-dQMtahO1NPKRB5gwb4vitw-1; Thu, 17 Oct 2019 06:24:29 -0400
Received: by mail-lf1-f72.google.com with SMTP id f3so414481lfa.16
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 03:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lcgTAsykrrNBZTJbyqExhJnM6yJEQufUqHJ8rZTQa9o=;
        b=eVMgxumWdMFMvqR6hBYu4wYSQw3/FpA+ASQL7fQ5nf25UsxEEMBTUpgzBm4+cVS9Vb
         JyII1rBDNBtiyMv5Bi58800IoYrclGh+G3IHH6rvd0hCROIQu9m+Bh7d7Q6pe9mILB7S
         Ugj7drSOe5TvaX52kGIbUlGW6aA2Vsh7Lx6uDtBj8bJm+xu0dJk4Ksz79/16zmZev4rx
         2SumXmG0HyO8lSwQ26yM5uof1OwLXi8BE/Sb7qQXEdjgY2ljwAMBPhf3fLE2acTb+Gac
         0WV0OiMERTaOsxHvMmBlhzWSx9SqxUZsQVj9Uqx383iDfPFa0Ep4ps9622WAgkQUkc8k
         cBnQ==
X-Gm-Message-State: APjAAAWsW4BWVEsw4VcpddcaYmTsO/oDTlgKVB7l7bmch8xBVXMQdv7N
        z4m0Qp30PW/2OIZXelyaVPF0CCuhrgad735E8oSg0wRcPb99G0MhGdR1s3O3GBXfGJC2DYPWSWr
        0Kex/3ul2RlQCgRjffQitJd2h5ss=
X-Received: by 2002:ac2:495c:: with SMTP id o28mr1930777lfi.114.1571307868182;
        Thu, 17 Oct 2019 03:24:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4Um9PtHf45hF1sDU6N7En5Zg6AyOeucAQgAhGOFjb+fQT27D52C4f7YvAByVqn4imrAvxGw==
X-Received: by 2002:ac2:495c:: with SMTP id o28mr1930764lfi.114.1571307867946;
        Thu, 17 Oct 2019 03:24:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v203sm1119453lfa.25.2019.10.17.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 03:24:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A575A1804C9; Thu, 17 Oct 2019 12:24:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Moeller <moeller0@gmx.de>
Cc:     Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>,
        make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [Make-wifi-fast] [PATCH v2 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <751EA059-654B-4E06-A3D6-C727FE1FCE98@gmx.de>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115994190.2500430.14955682016008497593.stgit@toke.dk> <CA+iem5s=xbzZ5goaBO4tZWUKVQRaXb+SnB34NPCppej9mi8sAA@mail.gmail.com> <87o8yfg0zo.fsf@toke.dk> <751EA059-654B-4E06-A3D6-C727FE1FCE98@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Oct 2019 12:24:26 +0200
Message-ID: <87lftjfz51.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: dQMtahO1NPKRB5gwb4vitw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sebastian Moeller <moeller0@gmx.de> writes:

>> On Oct 17, 2019, at 11:44, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com> wrote:
>>=20
>> Kan Yan <kyan@google.com> writes:
>>=20
>>> Hi Toke,
>>>=20
>>> Thanks for getting this done! I will give it a try in the next few
>>> days.  A few comments:
>>>=20
>>>> The estimated airtime for each skb is stored in the tx_info, so we can
>>>> subtract the same amount from the running total when the skb is freed =
or
>>>> recycled.
>>>=20
>>> Looks like ath10k driver zero out the info->status before calling
>>> ieee80211_tx_status(...):
>>> int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>>>                         const struct htt_tx_done *tx_done)
>>> {
>>> ...
>>>        info =3D IEEE80211_SKB_CB(msdu);
>>>        memset(&info->status, 0, sizeof(info->status));
>>> ...
>>>        ieee80211_tx_status(htt->ar->hw, msdu);
>>> }
>>=20
>> Ah, bugger; I was afraid we'd run into this. A quick grep indicates that
>> it's only ath10k and iwl that do this, though, so it's probably
>> manageable to just fix this. I think the simplest solution is just to
>> restore the field after clearing, no?
>>=20
>>> We need either restore the info->status.tx_time_est or calling
>>> ieee80211_sta_update_pending_airtime() in ath10k before tx_time_est
>>> get erased.
>>>=20
>>>> +       if (local->airtime_flags & AIRTIME_USE_AQL) {
>>>> +               airtime =3D ieee80211_calc_expected_tx_airtime(hw, vif=
, txq->sta,
>>>> +                                                            skb->len =
+ 38);
>>>=20
>>> I think it is better to put the "+  38" that takes care of the header
>>> overhead inside ieee80211_calc_expected_tx_airtime().
>>=20
>> Hmm, no strong opinion about this; but yeah, since we have a dedicated
>> function for this use I guess there's no harm in adding it there :)
>>=20
>
> Silly question, is this Overhead guaranteed to be 38 Bytes for all
> eternity? Otherwise a variable or a preprocessor constant might be
> more future proof?

Well, yeah, as long as we're sending Ethernet packets. Which is kinda
baked into the WiFi standard :)

-Toke

