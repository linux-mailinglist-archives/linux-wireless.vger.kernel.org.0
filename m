Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437F524BC4F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgHTMoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 08:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729508AbgHTMoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 08:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597927443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90C0tk9lG7EAHa53ku1Pvna6aL8rHbPZbMBZTTSPNRQ=;
        b=VzLyc2QYL96UHioJ4mhYixaJtFibUqOLaNEb5a2vaHZzsWPGnmm8uKu/kxtnpEShOp82Gr
        Dd1IsnRHGXJDekRpdRi+Jj5nVs4HgLZO1ltKxbbevpGcXy5sCrb9HeSLDhElg1tC5tHB/G
        HBzOUP0V0CzrNv2BwGuut7Xacksy084=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-2lczvF3LOuK2JWv07JPsHw-1; Thu, 20 Aug 2020 08:44:01 -0400
X-MC-Unique: 2lczvF3LOuK2JWv07JPsHw-1
Received: by mail-wm1-f69.google.com with SMTP id a5so746068wmj.5
        for <linux-wireless@vger.kernel.org>; Thu, 20 Aug 2020 05:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=90C0tk9lG7EAHa53ku1Pvna6aL8rHbPZbMBZTTSPNRQ=;
        b=mSfQDFIzFE9zHj4Jn/c/r41XxMJYoJBJZdKU7co3PEsUkeAcdL12OFQUD6mPIlVcei
         rnZDH6gwfsD4pk6vJVu8ZLfE0IUOsAvEa8g93e4On3T9nJ3+qLE9FGcmWY7nMzQh+sh1
         JvV31VFRiOowLIQqLQxoun9hxIIaY0FjhtG6+/GokZ7iob23X3EAjroc2T80RCGqiYWh
         mfihm2le1hzJEKMBIpLrF1UwyMysomdb2JF2qJea8+N9BiBac+36noTYTYCJk8F2V3rg
         vFiWsZDagPDvhj4bXnRwVKqkXdjSZvi9+akM1XGQRWUchuYR5pDe8HJ2nqh2OiGybvRq
         PScg==
X-Gm-Message-State: AOAM533bX9IskgGP+HrnmQdOT+/Wp5Q88ABJ3fAKXyLg1YJ4aEMSgNqM
        ftVOJOA9vqZMW0UXXIM8lGV2xKLQlGoJvjuo8w4o/HxEsPwOYwjsm/xRE+GZaIOTeOOffncq0S4
        cCN3aJeh/HuKoGdpk0GMfMgVdR2U=
X-Received: by 2002:adf:9463:: with SMTP id 90mr3000330wrq.223.1597927440379;
        Thu, 20 Aug 2020 05:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHvpseUhROjflL451g0/jKQ/9BOnGeJWb6JgvO0Kgo64Jj1ApLXxi2UtMOLIy+/K/ffRfwPw==
X-Received: by 2002:adf:9463:: with SMTP id 90mr3000320wrq.223.1597927440144;
        Thu, 20 Aug 2020 05:44:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n124sm4103680wmn.29.2020.08.20.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 05:43:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B3D06182B55; Thu, 20 Aug 2020 14:43:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 1/3] mac80211: use rate provided via status->rate on
 ieee80211_tx_status_ext for AQL
In-Reply-To: <20200813155212.97884-1-nbd@nbd.name>
References: <20200813155212.97884-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Aug 2020 14:43:58 +0200
Message-ID: <87lfi9zdv5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Since ieee80211_tx_info does not have enough room to encode HE rates, HE
> drivers use status->rate to provide rate info.
> Store it in struct sta_info and use it for AQL.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

