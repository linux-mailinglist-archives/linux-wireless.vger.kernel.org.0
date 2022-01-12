Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD0248C7BF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354876AbiALP6q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 10:58:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50864 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbiALP6p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 10:58:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B508B81EF6;
        Wed, 12 Jan 2022 15:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE24BC36AE5;
        Wed, 12 Jan 2022 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642003122;
        bh=pjC4KMQyAyu3E+EiXmDq+rSi+8UKS3IDXR/BoUE5+/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fd8l2Kv/EG9QjT4ik6SNmvLXOw7FDLpUBnTIwP3r8yxJt/hrdfq+Dd8eNa6f5QHwJ
         iBMYfiS53IRLj25Q/g39M0pcgQId0JY6XdkhGFFAYkwT6Q7EHeUcvpwoKkqJ2bZyIh
         NRkiOHyvWrvR3iSCOPBqxYtloO2errkeS1BL8f8S0+gnsM/dHAJbiBLisVtlvsQgKb
         KsGgOYhZWBLXQm/lQLgiCJa+2JArz3yiatYccmCKsBP3jvSCFm1QMWkd+t3RPr0CiT
         XvpZIY+HrVWOCmu7j4ZJr1hc7uOXN+EA0CGN9Clg38Fp4q8b+J8T9ZuGR8tjck5dY8
         8JG0NruD4lWSw==
Received: by mail-ed1-f45.google.com with SMTP id b13so12014445edn.0;
        Wed, 12 Jan 2022 07:58:42 -0800 (PST)
X-Gm-Message-State: AOAM530HA6/w2syd7YAkXBphDyD0XGbhUFMv4U8EGbLaiJ+DjqlGM7XY
        O/DE9+hjK8PwqumtIIkJwpduVLj60YMlKg8EYg==
X-Google-Smtp-Source: ABdhPJze/NM5/jH0wN5zRCih5gPvHLxxsPQTb9KIu1sza7REMPsdGafwJ/Kc684l5iliyoFbfrnTAuahbBT7F2UtIPI=
X-Received: by 2002:a17:906:dc4e:: with SMTP id yz14mr282016ejb.325.1642003120989;
 Wed, 12 Jan 2022 07:58:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641996493.git.lorenzo@kernel.org> <Yd7jdaKTrTFDU36g@lore-desk>
In-Reply-To: <Yd7jdaKTrTFDU36g@lore-desk>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Jan 2022 09:58:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzJCi+7ziZ6H=oBoQhi_onMXk7Hb9ry-Gv17S0_gYvwQ@mail.gmail.com>
Message-ID: <CAL_JsqLzJCi+7ziZ6H=oBoQhi_onMXk7Hb9ry-Gv17S0_gYvwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] introduce background radar support for mt7915 driver
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>, owen.peng@mediatek.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 12, 2022 at 8:19 AM Lorenzo Bianconi
<lorenzo.bianconi@redhat.com> wrote:
>
> > Introduce radar/CAC background detection support for mt7915 driver
> > Background radar/CAC detection allows to avoid the CAC downtime
> > switching on a different channel during CAC detection on the selected
> > radar channel.
>
> @Rob: I forgot to add devicetree ML in cc. Do I need to repost?

Yes, that's the only way patchwork picks up patches and checks run.

Rob
