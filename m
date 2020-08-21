Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A34924DB5B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHUQic (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 12:38:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728370AbgHUQh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 12:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598027875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BpCqlz36u1/crvTEnbIvAbFbtkMSwTldtETWDdR1vY=;
        b=biAl5L+iHENglyPpVq5p/fqYpJcZ/lxPiG+RqnREgxghCILaKh/GjACicNd0JYCXgUwzKf
        jcMYyFz+YWLh+MCYDlZBhM9rIn7DO5qI1NdwyU+mNvdPSqjqZZYrjfVr4M1KDNYo/ZI3Sy
        fSWGqJZzpvhgSG7CUb12Uhkapc0EY0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-RWpnp0S7NDqHaKtjXAb18Q-1; Fri, 21 Aug 2020 12:37:53 -0400
X-MC-Unique: RWpnp0S7NDqHaKtjXAb18Q-1
Received: by mail-wr1-f69.google.com with SMTP id z12so714644wrl.16
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 09:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/BpCqlz36u1/crvTEnbIvAbFbtkMSwTldtETWDdR1vY=;
        b=FUcUCLzG+iB/m7Xp7n4t0rEroaj+4aUZNRT87oL0XwTxGk2zVkUrOk0/UWFpOwfc0O
         W1aBjXNJ0yIIt2S3E8SaBeauAbVkjroRtAzAXuvL7decw1DEPq5FCoqD/8g197ywDsNa
         5ux3XmM0kNgE24JPLHw+z6BaDYlrWXEGw4Fgtb3dKv2+ADVkqRj0fN7lpnwDqCD8NK6E
         CopZF7k+pKyq2ckTakuZBmfkEwPSUKMXek/hmXOdD41PlUJjUzwO1R7+yXD86dtIGQI3
         bXg1oDFtBSpfeOq01BX0CD3+ARjT89G875L3EQNR45aSdJYQVNWXtBwN9Xul8fnzOcuy
         ksKQ==
X-Gm-Message-State: AOAM5318y1/reievDH4iKhObYdnUgqunrlMF6fdmKnQ1nl+3Q/YcXLH3
        MyznjWMEVRcdBe8KRDeliH+f6C0tNIVNTGdoYW2vfw/85K1dwEKLuQMU7HW3wwqDmbh3XhpVQ+G
        NosJjjqnPlro6yTzdm/2HlQY/ijY=
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr4759517wmm.71.1598027872561;
        Fri, 21 Aug 2020 09:37:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysas+GDGIC0tphXjWA9kTZiHG4HkDhE7Mhz+5maoqZOCFPizENXk1cVcNAOvMUJx6CcZg4rA==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr4759505wmm.71.1598027872349;
        Fri, 21 Aug 2020 09:37:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z203sm4164417wmc.31.2020.08.21.09.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 09:37:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6B301816A2; Fri, 21 Aug 2020 18:37:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation
 for low data rates
In-Reply-To: <623a2b24-31c8-83be-ae24-1461ecbfc224@nbd.name>
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-3-nbd@nbd.name>
 <c3c5197f-17f7-4f6b-712f-d7c68f39ae38@dd-wrt.com> <87tuww2ggm.fsf@toke.dk>
 <61d66ec8-117e-7c75-2b4a-1de7715f0bce@dd-wrt.com> <87r1s02eve.fsf@toke.dk>
 <623a2b24-31c8-83be-ae24-1461ecbfc224@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Aug 2020 18:37:50 +0200
Message-ID: <87lfi82bvl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-08-21 17:33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:
>>=20
>>> i mean airtime fairness policy was not configured
>>=20
>> Ah, right, that makes a lot more sense :)
>>=20
>> Still not sure why this would affect throughput, though; maybe the
>> change in calculation makes AQL overestimate the airtime and throttle
>> too much? Or does the saving of last_rate_info on tx_status_ext() work
>> badly for ath10k?
> The issue turned out to be missing return code checks on converting the
> tx rate to struct ieee80211_rx_status.
> I'll send v2 of this series with fixes.

Ah, great! :)

-Toke

