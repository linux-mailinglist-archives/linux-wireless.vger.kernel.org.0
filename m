Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A31242C13
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLPT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbgHLPTz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597245593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/6YCC8rF/n0jjkmOFgRfI6WFgYQisH5kto2Ia8JPo8=;
        b=UfpMGj2DYBJziavyqVYRH+36Z48POCYUbnbz5Bf4WdjUx133HjK+/VMPVg5rjkj+tXSLSn
        BKCYIzYt6Dyq6To6UVDdmXcy/tbhb06QtdR15D/l2MOrkVLdu/fUaZCXSWgubZi2TXykaL
        /RVvdNiKWLCp7gZuiYXTvGFnZmVk6Y0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-suTHRt0nPxmQl5ILj8mQww-1; Wed, 12 Aug 2020 11:19:51 -0400
X-MC-Unique: suTHRt0nPxmQl5ILj8mQww-1
Received: by mail-wm1-f72.google.com with SMTP id f74so1000568wmf.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=j/6YCC8rF/n0jjkmOFgRfI6WFgYQisH5kto2Ia8JPo8=;
        b=PETxO2seY/gmmpkPaqaGesZEkPjFSnEvwXyC+RxfPNFd3bv9Jqc4bjI1ZKyWvZ2n0r
         e7fE5ArFwqjL7S9UGSic6GWWmzc6II5nVhisCLl29qg4ANt6gmUQCSR2iJlp1c3L6cdt
         bJN7ishJovaY7ROGXiJnIgVUGsI35pwIVwdxgb9UEDzfpLU91ZzdLaeLj1kV+SDAlDlh
         O1a4JNZVhIljRzL8eWF/G4WCmGu9oCtuIa7I9EYBrDkhxl/kRi5axPnmXuG1WbKDOt1M
         TvblkJF+tQkGIFyDoEPbRbc+WSniW069XjOPgxM6fcni5OcbzRbTk6yzFajsurttOGYW
         ij3A==
X-Gm-Message-State: AOAM533zD9QtrIP2eOK0Nu41jFdfUROEmjXzbZiX825dvrLO1pEn3em4
        JTXqG+ZbT0O5cXQt86VRbUg7QsO2eyCHVRXEACwm3u2nCt15iAqCKtEJwVPjeKqt9EmpFOLrjVw
        k7GdCoOwIvqXmXTOFYLtAOi5FB+4=
X-Received: by 2002:a1c:a787:: with SMTP id q129mr214040wme.77.1597245589862;
        Wed, 12 Aug 2020 08:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyifW7MBtz5Ifw99ppqpsbHhMb4rjKY8IqCyT1LZSHRkjkvjtGx5F8c3S+0my7NYtkMWGw7WQ==
X-Received: by 2002:a1c:a787:: with SMTP id q129mr214026wme.77.1597245589670;
        Wed, 12 Aug 2020 08:19:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r16sm5285140wrr.13.2020.08.12.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 08:19:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 16271182840; Wed, 12 Aug 2020 17:19:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: Re: [PATCH 5.9] mt76: mt7915: use ieee80211_free_txskb to free tx skbs
In-Reply-To: <20200812144943.91974-1-nbd@nbd.name>
References: <20200812144943.91974-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Aug 2020 17:19:47 +0200
Message-ID: <878sejvqlo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Using dev_kfree_skb for tx skbs breaks AQL. This worked until now only
> by accident, because a mac80211 issue breaks AQL on drivers with firmware
> rate control that report the rate via ieee80211_tx_status_ext as struct
> rate_info.

Ah, nice catch! Is it safe to assume that you also have a fix pending
for the mac80211 issue you're talking about in the commit message? :)

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

-Toke

