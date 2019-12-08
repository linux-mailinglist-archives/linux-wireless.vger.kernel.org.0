Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3779311611A
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Dec 2019 08:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfLHHSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Dec 2019 02:18:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725554AbfLHHSm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Dec 2019 02:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575789520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6LBgTmyNXFM+QcAw3B1ecJBRmlrnsPEqJyMF/aU9zg=;
        b=AmTv0Se+Cx01YZiCV8KjhYpfJC29Yuu+hXSd3g/ukW6DyDdiF7l2XEifMiO86ZIgvJvM5g
        QPEr7ZaMKj/rmHeAJlnSC/BbwXn3QYY3bm3Ev+ZPERychbYvDkkVQX4DbjZ3dEXm/9IKrl
        GUCQmXTJnmgJW9kf9onmiRHthDG09yE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-4PCnnzWgPp2n221WTBnZ7w-1; Sun, 08 Dec 2019 02:18:39 -0500
Received: by mail-il1-f199.google.com with SMTP id d14so8972390ild.22
        for <linux-wireless@vger.kernel.org>; Sat, 07 Dec 2019 23:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO35+8XAZIdoFeG+oR62XkbqkVhZSC1+oO0AGjU8JvI=;
        b=ixeT3OjrNKZAC3rswCqOwE4q0+A5PB5dFGKoweFeDEWmEa3cHrG8zVHtacpQ9sEs3P
         qKuU9dWBwZxlJFnFKpueDqaDpHalM3xJXGH5AABqGJobtlghxQljIFbvHS4ZRes9SHI7
         q+Qx63fKHmghWkQ5Dt5BTOl0y4dKOpm3oinm+v0RbboqFaxFJ8W7UlXA8M5dlhNWPVOq
         aQfLSiA850JcdB4oACufUZz2Qb5DEjUEjURHMlRlNSavGiAGvRRzAvfvQO6iyitXUuJ3
         dT2kaFngbYLZcGgRKtcbiteXXwaDC+eigwWK/yA4cyBXkZQVBqWcCO+qvVaBqER56DrK
         WRkA==
X-Gm-Message-State: APjAAAVuFx5eA/7dScWRc7e80mJMd65oow2T5F0Z52QFzK9XM/6aF+dS
        g7dhWCQabCgDxVMEHsQ/MwdmgDrorqgDbMe5wqx1+l60+l1u2BpMFpKhw0gzIMRk1J1bBcvvjGd
        08OrbGVeyTdx6NViNasQgb/M2QUbh3rB5wDStr8vf+fA=
X-Received: by 2002:a92:d80b:: with SMTP id y11mr20656979ilm.12.1575789518661;
        Sat, 07 Dec 2019 23:18:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3ojEVu8VW2/A4bM1ju1lpAH5z1jUXRLqwDpl/GMNjCHC65rZd1tejGyXgie11Jssmq9jo66Vif3aD8xXisKQ=
X-Received: by 2002:a92:d80b:: with SMTP id y11mr20656969ilm.12.1575789518394;
 Sat, 07 Dec 2019 23:18:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575609821.git.lorenzo@kernel.org>
In-Reply-To: <cover.1575609821.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 8 Dec 2019 08:18:29 +0100
Message-ID: <CAJ0CqmVTq7n0UOoBgtFKjv_CaOroREh3Ez_2gK49coDMjLXZeg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] add set_coverage support to mt7615 driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
X-MC-Unique: 4PCnnzWgPp2n221WTBnZ7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Add the capability to configure ack timeout and slottime to mt7615 driver=
.
> Fix coverage_class definition in mt76x02 driver.
> Set 0 as minimum configurable value for coverage_class since mt76 does
> not support dynack.

Hi Felix,

please hold on with this series, I will post a v4 since slottime needs
to be initialized for ext phy

Regards,
Lorenzo

>
> Changes since v2:
> - rebase on top of mt7615D support (DBDC)
> - add DBDC support to mt7615_mac_set_timing
>
> Changes since v1:
> - drop patch 2/3 'mt76: move coverage_class and slottime in mt76_dev'
> - set 0 as minimum configurable value for coverage_class
>
> Lorenzo Bianconi (3):
>   mt76: mt76x02: fix coverage_class type
>   mt76: mt7603: set 0 as min coverage_class value
>   mt76: mt7615: add set_coverage class support
>
>  .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
>  .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   | 61 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7615/main.c  | 21 +++++++
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 +++
>  .../net/wireless/mediatek/mt76/mt7615/regs.h  | 21 +++++++
>  drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
>  .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
>  8 files changed, 114 insertions(+), 3 deletions(-)
>
> --
> 2.21.0
>

