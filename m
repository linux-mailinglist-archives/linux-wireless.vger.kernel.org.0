Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743BA155A4F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 16:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGPEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 10:04:22 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:38548 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGPEW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 10:04:22 -0500
Received: by mail-il1-f182.google.com with SMTP id f5so1956623ilq.5
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MBGi1cfCz6Gqa27LRzy8F8lKupJYjEcvdM7f3wUr/IY=;
        b=Gg8GCvcspgQjs4N9z8VQPPce1C6UuR12lEUYtgeF2/7CT8ETu089mYtSmJTvMlC1iE
         HWUIX3kTgVA3gxViCqQ/ZDMh+EB1XCUIzy9fL1LhEASQmBcBbl2tcWd3n2Rq32XQmmly
         ckFP1fBuouYj584qD4UMbskuthvfk82CQwUnv5bynMmAeFXMBJdLEs0uzTOJapF4AUbA
         10Ades1791z0xFlsizftTi66X7A3UNqxqeWOj3rm6FCXrloLaiu5iCKUqGy8Llpg4g2G
         kfaz+inrFyT2r7QjxzkKLtkhmCgsKUUBEffb5NVZwC0FDocXpGlmVEww10GXeYRmj7xo
         yjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MBGi1cfCz6Gqa27LRzy8F8lKupJYjEcvdM7f3wUr/IY=;
        b=As1pQwZDfBneafE/chEpsM7U5Frt2S9DMtq+Ys84Gg3GzbFvG0GwLHF6sbn/jCeIeQ
         6sF9anM5n9IEYjcvUeLIMaG2fDpGF4iEx9zBT1LqXQ3x3AZ2Sk3kyMj30rjBPDFByNn4
         7TwbOTM89DS077imEWge9n9E4wcOGSRFw5wPGmpVjE3drMt47Ii9XlIIqD49S/sl4tnj
         4nuwBqjgaTvRp5A+xsxBDjZF9vAxmJC4Bn8zFixzLnRh+Q8eQ/KfVjMJVmA7V9Cb3Lfv
         3wX9RB64s3hgH1BiSF2otf9vq7IeIOSoKdyDkpYHyftdkuz3+FI49QSBsozasByMJ0sX
         gNPw==
X-Gm-Message-State: APjAAAUdaNX1/qYPeRh5BpKf0qG3+iOgj3B8X9NGqT38aIcF5A3MuotX
        sUukFGPj6ihXgnb5bRruhMZKgaYP3shAW5+yvts=
X-Google-Smtp-Source: APXvYqxEE70B/9m5pBKgHK+LpddFreOrytLntBkKv1H5QTG5I3V40IwNSejIX79woWjhf9r9OkRiVzlb6dCeNtbw17w=
X-Received: by 2002:a92:1fda:: with SMTP id f87mr9971910ilf.225.1581087861351;
 Fri, 07 Feb 2020 07:04:21 -0800 (PST)
MIME-Version: 1.0
From:   Zulkifli Izoel <izoel21@gmail.com>
Date:   Fri, 7 Feb 2020 22:04:10 +0700
Message-ID: <CAKAWfyJ=H9rGaPvYvY_cBmzD+nW8ZGra5tFTBhCbZyT0BPNtjQ@mail.gmail.com>
Subject: wireless-regdb: Update regulatory rules for Indonesia (ID) on 2.4GHz
 and 5Ghz
To:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Latest update regulatory rules for Indonesia of 2019 :
Taken from Ministry of Communication and Information Republic of
Indonesia Website, cancelling 2005 old regulatory.

Ref:
Peraturan Menteri Komunikasi dan Informatika Nomor 1 Tahun 2019
tanggal 24 April 2019
See Appendix II (Lampiran II), Section WLAN Telecommunication
Equipment (Alat dan/atau Perangkat Telekomunikasi WLAN)

country ID:

(2400 - 2483.5 @ 40), (500 mW)
(5150 - 5250 @ 80), (200 mW)
(5250 - 5350 @ 80), (200 mW)
(5725 - 5825 @ 80), (200 mW)
(5725 - 5825 Outdoor @ 20), (4 W)

Please make correction,
Thank You

Zulkifli Yusuf Singedekane
