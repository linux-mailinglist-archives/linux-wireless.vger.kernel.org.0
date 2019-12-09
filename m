Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4611763A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 20:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLITtB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 14:49:01 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:45009 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 14:49:01 -0500
Received: by mail-qv1-f51.google.com with SMTP id n8so3133679qvg.11
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AQll4KRhgPJZReykA/0eCvQSWgdhy+FBux08PlQKUvo=;
        b=OrlO+8ZDubdamDsG/B0TX7TJTiYB1EwlO14UoXaRBPYaa8F+oIEReSDz1y+Ga7K+c0
         uYkdOdWvcui8BvK2nStBMMss6lVEsWBeRFSrFhBd5+tgIsGSDJqvWx1nWYmvHFozIBIH
         jb30+1ouf/vjT8LMmhDpKTtyKfcBnK1I9RH8xPQpqPeukPIgxr8OcGD+AsYQtQJabttn
         T95J05Z62Eviho3e31Ymk8LbRPHOMo1yn3bmtbjMAiZfiDVZovC3IR/tsolnz4ScHRGR
         TvM5pOlF4KeB/Vi0/9tydtC7LRLYpHDlaMTX6H32Zj4btNyKKm1ephDWSnhapMH5m5RS
         /cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AQll4KRhgPJZReykA/0eCvQSWgdhy+FBux08PlQKUvo=;
        b=guvoOLTx1cMT3uoc8r1z2MQshyXh/9XvQxHAX0hBthN5KBxur6fEGhA5ET5Bi5beMp
         tRMoDM5I337wgsFstMp0gRmiZH+iwHSaTau1dJn4JxnqbriCAj6KF+c3jk32z/lqGJUC
         A3xfZqfpn5tyjioFMd2Y35zfWqLSPWcZYocBvH89L82z1163mjM4EyEkrADhUF7mqiKw
         fbhHMyxQgVssdF8PSTUH/RS5ypBZWKJtho2xgHclxCI/1FAQvxdSOi1YLz+aSz5BCvQB
         Q7NGCfZolSxjZ2nJ7k9Q4L+/YpWuXvAL1pvlMIJ7CFYjy+F6+j6ysr25T1GIiFYdWZ2X
         rTFA==
X-Gm-Message-State: APjAAAVjwiGiQaOaV49EdmMcoK6iMgUPFQU6iLSdvtVT7k0nqtKagGn2
        sFxuKfO7RbJ+k82lOLHi/rncLWKXDYeGxEwZbC30pfay
X-Google-Smtp-Source: APXvYqz5qDZpDUElNYxzMrnSyRDvbM6ZtlYlX/lfojPILeYexpKVffi1dJh28JPZiuLxEnHK/6Sr1K8L+T2lzsERMlI=
X-Received: by 2002:a0c:e34e:: with SMTP id a14mr25049112qvm.73.1575920940049;
 Mon, 09 Dec 2019 11:49:00 -0800 (PST)
MIME-Version: 1.0
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Mon, 9 Dec 2019 20:48:49 +0100
Message-ID: <CAFED-jkz2U244BvqaHkMdj018fbTLOpz+ZK2j_1SrxaG4CvyNQ@mail.gmail.com>
Subject: iw set freq regression
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

For v4.9 this command works correctly:
./iw wlp1s0 set freq 5220 20 5220 0
./iw wlp1s0 set freq 5180 40 5190 0

With latest master this fail with err msg:
Usage:    ./iw [options] dev <devname> set freq <freq>
[NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]
    dev <devname> set freq <control freq> [5|10|20|40|80|80+80|160]
[<center1_freq> [<center2_freq>]]
Options:
    --debug        enable netlink debugging

After bisection and revert this one, works as before:
4871fcf iw: parse_freqs: check how many center frequencies to expect

I know we don't need to set this all arguments and finally I can
change my script (don't set cf1/cf2).
Anyway report this.

BR
Janusz
