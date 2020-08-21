Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D424DC98
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHURFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 13:05:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727961AbgHURFQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 13:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598029514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90C0tk9lG7EAHa53ku1Pvna6aL8rHbPZbMBZTTSPNRQ=;
        b=ZO16IFhmy95UGd+90E7z5ll2NtkoiK1ncGPpDO54IsCIcghxlGWtn5iCq/PHfvGRtx+ujH
        UVOSng+I+Lo7tIaDFUOOu8PR7txGmAKuTRQkEMhVijcb80FhEquXeaR7OhpCmmJyo3YPIt
        as6hJzYR0ArDOhtPk6kW3TgJ7qIZjds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-4qq9IXWbNUiacgIlwZEoTg-1; Fri, 21 Aug 2020 13:05:09 -0400
X-MC-Unique: 4qq9IXWbNUiacgIlwZEoTg-1
Received: by mail-wm1-f71.google.com with SMTP id c186so1207568wmd.9
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 10:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=90C0tk9lG7EAHa53ku1Pvna6aL8rHbPZbMBZTTSPNRQ=;
        b=JOCdYiLyJDykmkBeoQ1UqzUV9yZ5O3NK9SLiJrRXvSYY0YI5FyJzB67rMOZL2GzOY7
         LPkq5U2eYh1cT2vQ9+CveSc8xf69xC06k4no+rSRCDXUfIklrrzJZDnvToM0zSrmiBTB
         cvOgMqTyiAmxqF/ZjhmvwB+FMbG2MGvUQcY7DAFHL3eC8dtZn7PWAiGAwuYsSwgBJlhM
         HjuKBwL7djwvNevdbVSydriFQmPvCZRdBsHUL05wfBPjAzUMII6gHv/eniDD1+BNkRsZ
         PksATazWeAGPsy1qBLqWG6RywIWQSHNw2fzC1jtTcCAOVxfxJxdgk+Zg0yUQSpLrZ2Bi
         Jz6A==
X-Gm-Message-State: AOAM533LZxKiiMkhgUinzRRhqVO25CEQ2kvwnEFI8yzkpbn+REs2dfhn
        RknCxf47/hx5tmu8vO1BXMhW4wS705LO0CVLMU0m76ZFgMITP41vBKGjQ+JX1X/7890BwXuEue8
        NoVjUBcjVqhbwzT6ZSFb8aD9/ywg=
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr3907893wmb.129.1598029508619;
        Fri, 21 Aug 2020 10:05:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT/Z9820P86kzl8kOpMIWEzR1C3OSGb9mBmjZT+v9ZrfUfqYBIJLw5mcFBAUryiY7VKU+s0w==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr3907872wmb.129.1598029508402;
        Fri, 21 Aug 2020 10:05:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t11sm5117886wrs.66.2020.08.21.10.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:05:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6FA161816A2; Fri, 21 Aug 2020 19:04:37 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 v2 1/3] mac80211: use rate provided via status->rate
 on ieee80211_tx_status_ext for AQL
In-Reply-To: <20200821163045.62140-1-nbd@nbd.name>
References: <20200821163045.62140-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Aug 2020 19:04:37 +0200
Message-ID: <87ft8g2amy.fsf@toke.dk>
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

