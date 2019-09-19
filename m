Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C42B80A2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfISSSY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 14:18:24 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:40495 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbfISSSY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 14:18:24 -0400
Received: by mail-io1-f42.google.com with SMTP id h144so10004789iof.7
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahligibXiJhNWBTuy+o9QiP7Cz5qoO2HoJkp8A3bcZk=;
        b=UeazCZMG6znxqqDbIjAEXzYjQoUqaFMi5Yle6YG0oV4XjWz0wBzo0PL9AK9W7dD3+Y
         x37jDBwZPmYficI5qnO25HYtorgThbSwWlz+ZJArqobZhH9IXE+DRhYF1mgm3UkBREPT
         G0P2GVrw5Vi583MqUt/JiYGwbwg46SXrkzC4xNpxC+94QgS9ux0e2k3/bXnBtT1eET2F
         9MYbNnUd2JkFLd8eOpBYnBw/hsJWD7zVo0gCMloOPJ8jErIz+eOk0rHTOn4Y5YzFGvUq
         yxMbZMFv8zt7FV3hrZvjVCswnfkYBic0A3nNtEOpEI08kZGo64Opumt8cQJPUgUgQOqC
         K7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahligibXiJhNWBTuy+o9QiP7Cz5qoO2HoJkp8A3bcZk=;
        b=olsIJ2Md4w2ae+x7qd35v5IZQ86B6XvMSfDrjYnosy3NL8nX4hZieP4gzlo2JCB0fh
         3Z31KuOrEpaz/3usmuuKQx/iIQb3YY+osDKdWm1hpPYdF3xBiTnU/T2fGmYTi93/HW8t
         +P0yJx3ExTFDioE5S7Kgghb5mq0SXBvsfGsYTWkikyP95ZCWy7HIDz15PgM/RL3MipEU
         4GgYKMjAcOcl6BtTPjhtMy8ax2QQQmlIA/MhhohIhbdD4GHa8zAySlQxeV77mQenK9aC
         FR2UBdrSm8uDhypoZ9NhPOwcoxQrhPuqWIKPJ3nS6k8QDYaeYtRM95yCxFbXAmmFLn/J
         V/1g==
X-Gm-Message-State: APjAAAUtEy8APnUGASx8T8na0BIWpw5rM8XWEcfjJlDDmXVDdqeGOlz3
        ahoLUSXBxSTmTNhTkf11FRbHywCB+XUh6Nk+eeM=
X-Google-Smtp-Source: APXvYqyR7oiJFqJ7SwTF5dfuPR0vrfX4sD+D2XDjjXPbGC1xu89OBLxAm08rEDsrO+Nc7rZrC2iFUQyK3Rf0+wlm+Sk=
X-Received: by 2002:a6b:3705:: with SMTP id e5mr8990417ioa.213.1568917103551;
 Thu, 19 Sep 2019 11:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1>
 <156889576869.191202.510507546538322707.stgit@alrua-x1> <f21b10fd-02ae-af59-8e2f-88f654627ab3@eero.com>
 <879913e9-4254-1381-07f6-d860fb0b8de0@candelatech.com> <f9b224a0-305f-9715-f627-7a5fae0988d3@eero.com>
 <df105ac6-833b-4a22-9ecc-484513a2eb9c@eero.com>
In-Reply-To: <df105ac6-833b-4a22-9ecc-484513a2eb9c@eero.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Thu, 19 Sep 2019 11:18:11 -0700
Message-ID: <CAA93jw4F4vuXdWOne_A=h6x-ERMshw5B5UqxU1-ZrnD74nAavw@mail.gmail.com>
Subject: Re: [Make-wifi-fast] [PATCH RFC/RFT 4/4] mac80211: Apply
 Airtime-based Queue Limit (AQL) on packet dequeue
To:     Peter Oh <peter.oh@eero.com>
Cc:     Ben Greear <greearb@candelatech.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the record, this was the google report on their implementation in 3.18.

http://flent-newark.bufferbloat.net/~d/Airtime%20based%20queue%20limit%20for%20FQ_CoDel%20in%20wireless%20interface.pdf

The latency vs RvR graphs at the end were to die for.
