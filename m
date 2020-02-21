Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF334167B57
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 11:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBUKr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 05:47:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32046 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727145AbgBUKr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 05:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582282075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8D8p2+biOtJc/YHupPZKhc8o4Z2rp+4Qz69KFk87HM=;
        b=HKO28mP6kdVuSrE+ZT3lClSpX9wunU4BF3I44u42R+fqmfADz1HuBKGmP1YoxPxfGuW0Ng
        O9uH9WCFaKdMnFT4xaTgRpiml8jvmyDz0D/2mzpbz53Yk9z6QCqakbhHNgyZBB6oVavlCP
        P92MICZNVJvAkHJNa6MdjgnXTZpbPno=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-E2zsJrViPl2uOL3YE5j_dg-1; Fri, 21 Feb 2020 05:47:54 -0500
X-MC-Unique: E2zsJrViPl2uOL3YE5j_dg-1
Received: by mail-lf1-f70.google.com with SMTP id i24so510740lfj.17
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2020 02:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=D8D8p2+biOtJc/YHupPZKhc8o4Z2rp+4Qz69KFk87HM=;
        b=RkNlvS0HsvuG4d+wwJtv5CGuA+CVdR89L5l8qOXTtAGfxD/QevUXHuOPKXQuaKprDQ
         UaaAMjyQ/h7IjFsB8BigzRRd0TesJc3quzC96wIbw1D0jbDAlu3yDwnl5iOaEKqiMImV
         6psK/brCckLog7+HlPDAb+/KZFVi3NLTt38P9fwSiEefZdRqH1I3Y6l+fNx5X/YC40VA
         9J2QsolY2WHUZr7affbbjhhVbwflmO1qo1lCTYGq5Bnj9OzMYxwIX2AxcJuqGr1QStYR
         nMuX+fJyBxhM6SYTm5qWBPdS0yJm/sx038ZeoO02c0DaY08tsY48biuVgYKyFGc5x1ud
         TM8A==
X-Gm-Message-State: APjAAAVclbvEOu5lnb/46/6lFMljeeY639CtvxAYHwFkZoG9wBaOduPH
        JVYPm2LvUc/WZXJNemCpCibCZGEOH3Ye0HP/16e/L1unDQp6E4m4lnYDssdyvHL8x9hn760YZpD
        F2ZeKKT3RyZT1ZS8gV6I9I90AZ/Q=
X-Received: by 2002:a19:22ce:: with SMTP id i197mr1260431lfi.119.1582282072538;
        Fri, 21 Feb 2020 02:47:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMNfVP0CTJtg9G45d+c0eoGrdFgJHjeqdcuoQmjcrAhkHc+/TNFUlVtN06bzCHNGqRVYYo4w==
X-Received: by 2002:a19:22ce:: with SMTP id i197mr1260418lfi.119.1582282072266;
        Fri, 21 Feb 2020 02:47:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 11sm1401313lju.103.2020.02.21.02.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D2309180365; Fri, 21 Feb 2020 11:47:49 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: check vif pointer before airtime calculation
In-Reply-To: <20200221104544.dddb7a3568fd.I0ede2733a3c76e95daeab07538449ea847e7b78d@changeid>
References: <20200221104544.dddb7a3568fd.I0ede2733a3c76e95daeab07538449ea847e7b78d@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Feb 2020 11:47:49 +0100
Message-ID: <878skwush6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> In case of monitor mode injection, vif may be NULL, don't crash
> on that in ieee80211_calc_expected_tx_airtime().
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

