Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9545224DC94
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgHURF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 13:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728009AbgHURFU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 13:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598029518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igXIVvajZYMKBSh30l418z2ksog26ZFY0O7EeHjDQnI=;
        b=e7T82zNP5ViqARRULZWNkxGsCR8uBBR71FqP/URStJtDnnve3bgx+C5HEdav/kGZC8+zow
        zMYOoc4cg+1eC89X6t/zHZCDUC6op3cWMFZhleMgEkLDlPZnHo0wJsB17RJrZ31YJXCdpz
        5Q++Klk6vbJdOC/Cfavpy8p2qW3DHWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-mvrvAoEqO3iLikL3H_FvZg-1; Fri, 21 Aug 2020 13:05:17 -0400
X-MC-Unique: mvrvAoEqO3iLikL3H_FvZg-1
Received: by mail-wr1-f71.google.com with SMTP id w2so500081wrr.19
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 10:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=igXIVvajZYMKBSh30l418z2ksog26ZFY0O7EeHjDQnI=;
        b=NEEv6A86RfAe5XLJvO2u9akMqJwOD1YQCoav9tOsb6HE/gzepyklx6kO2l5h4IaFy7
         B/kT+TOXmogG1DaVUWmw5T36k+zMIEXgHLWVLcLrbGMilgT1+IWiwrGlTnzzTM9nVM5U
         mao6efN8GZqyxvXAGWiY1yItpsV6qkrE0a+AnO6CsekCqXJCZPYkKAvJrOTsa7AVYyD0
         nsOuoa58aCVXLcozAw7+pnbmUXDj4FaC8IkGBQfWY8JEoWPxDKnmgLdKwS6eXub1KQeO
         Kp056o0rr1LLpn5eTZU1IE4/WUI0cA4//twCEP4eD1NgldhoeDB5PO57dHbbk/oSIqM5
         iqBQ==
X-Gm-Message-State: AOAM533/DXF9WJRr0G7UXDi5woJFK50Sj96PALuEcNGWSC3+MKiNMXcO
        0ZVmOxNkfrSy7iYcjCewgMN/5VkV7uNJXU7qGz4BpzAi2xjbYd1FXQPAkZ3//iO0wKWaMSA09CU
        qqWo+EfDAkXkLAlW7ymU7N4CaDBQ=
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr4027711wml.48.1598029515926;
        Fri, 21 Aug 2020 10:05:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBjSJ8EoTyZ1if1EvLuihxlWaBuilRYgsjh2XZVZCmKdlmNPAdVjoPUGttgxwQVRICfUCDHA==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr4027691wml.48.1598029515722;
        Fri, 21 Aug 2020 10:05:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e5sm5662015wrc.37.2020.08.21.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:05:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 70A7B1825D0; Fri, 21 Aug 2020 19:04:44 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 5.9 v2 2/3] mac80211: factor out code to look up the
 average packet length duration for a rate
In-Reply-To: <20200821163045.62140-2-nbd@nbd.name>
References: <20200821163045.62140-1-nbd@nbd.name>
 <20200821163045.62140-2-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 21 Aug 2020 19:04:44 +0200
Message-ID: <87d03k2amr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> This will be used to enhance AQL estimated aggregation length
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

