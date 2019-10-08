Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08842D02BB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfJHVSp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 17:18:45 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:2395 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730720AbfJHVSp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 17:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570569525; x=1602105525;
  h=mime-version:from:date:message-id:subject:to;
  bh=7ivXoMVu8s+JtT7SVGYU6lcEvBBmpcUMZbNR5PyOLRg=;
  b=jiVFkVxXXBxd7w1nT73nX00z2hipuPXtmwSWQZR2Sn/8RZCTGSPzRCpR
   QKjPEcmQHW17yuD0qF5ZSlTTksB0V/v4sQ4w06OHNAfbUUUsFvjiMhGb0
   JiCqGmjtiilAKkzxk3gYIa+e3w1xLvq5oUL9mODL6xDnotdqnFkULVyOe
   st+gWooVeA0wBq5CHfFajtTmkrnuLcw33tPOnvy4s36DQ/gfETQv1qO01
   HSWSuTxDCEBx1ptf30A1wMBApx/Rgto2SLNl9xkJwIreuD6qRjoLAwxvd
   rXS4o7w4MHsgbHnPh5vlG1hO1XfoGhbdhKhCEkcxX3Cr7qaOI1KIxwxsb
   A==;
IronPort-SDR: hJsPqtPI01xeRiZcky+kyZLKy5fyw1o4O8OqpuFT2TRfPb1fBMZbWvvWeH9ipkopSBUrecrKHZ
 ANdGYNaThmnqsfW6x8mKP2d/uw51JJ8KR16GMPAWKs8vDcm4+wWvd6TfSKlq7ln6q0gsLRJH9o
 xs7Ho9cbGMXVHWQ1Yc3WGRjQC92IjdbWIGVoVe6E5bT0SHEB3OF39svN3y6RYaVKmYoC5ORLpb
 Ri9UZHtrBUN8kv6oJj4LyDWk3FtvZLKTmWxzO7foL/GI1x/sWfZdF/Zuy9D9FKV26z1VqagrRB
 j00=
IronPort-PHdr: =?us-ascii?q?9a23=3A4rgGkB+kUsQGRf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20uocTK2v8tzYMVDF4r011RmVBN6dtqMP0rSP+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanYb5/KBq6oRjQu8ULnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?FcXMheSjZBD5uzYIUPAeQPPvtWoZfhqFYVsRuyGROhCP/zxjNUhHL727Ax3e?=
 =?us-ascii?q?Q7EQHB2QwtB9ABsHXVrdX1KacSVv2+w6rIzTrZbvNdxDDw6YjJcxAhu/6MXK?=
 =?us-ascii?q?58fdbfxEQ0CgPKkk+QpZb7MDyIy+QAqm6W5PdjW+K3k2MrtR19rzy1ysovio?=
 =?us-ascii?q?TFnJ8Zx1HG+Cljwos5ONu1Q1Nhb9G+CptfrSSaOpNzQsMlXm5npj43yqYDuZ?=
 =?us-ascii?q?6nZCgKz4knxwLHZ/yHbYeI5hXjWf6UIThihXJlfKuzhxK88US90+H8WMu53E?=
 =?us-ascii?q?tQoipKldnMsX8N1xjN5cSdVvR9+UKh1S6O1wDV9O5EPVg5mbTHJ5Ml2LI9lZ?=
 =?us-ascii?q?oevV7eEiL3mkj6lq2belg89uit8evnY7HmppGGN49zjwHzKqQvm82/AesiMw?=
 =?us-ascii?q?gCQ3SX9Oqn2b3+4UL5Wq9GgeMrnanEqJzaP9gUpralAw9J1YYu8xK/Dzag0N?=
 =?us-ascii?q?QFkngLNVxEeBOdj4f3P1HBPuv4DeykjlSynzdk2erGMqfiAprTNHjDlqnufb?=
 =?us-ascii?q?Jn505b0gozwoMX25UBKLYBKfT1V1S5ntHCAVdtMQu0yuDhBc5VzYIGQmWLH7?=
 =?us-ascii?q?OYN6XJ91mF+rRra6OgbZEUtH7GbbAA5vrqgGVz0QsRdLek2LMbYW61G/BhLV?=
 =?us-ascii?q?nfZ3fw1JNJFWYMoxp7U+3whVmPSiV7eXm/ReQ/6ys9BYbgCp3MAsirjaCN0T?=
 =?us-ascii?q?mTAJJbfCZFB0qKHHOucJ+LH78IaSSPMopinyYCWLyJVYAsz1etuRX8xr4hKf?=
 =?us-ascii?q?DbqQMCspe25dln5/DU3SMy/D08W9WP02iMFzkvtn4DXXk70L0p8h818UuKza?=
 =?us-ascii?q?Ut268QLtdU/f4cF15ibZM=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E+AgCt/Jxdh0enVdFmHgFDDIFThBC?=
 =?us-ascii?q?ETY5ihRcBliKBewEIAQEBDi8BAYcIIzYHDgIDCQEBBQEBAQEBBQQBAQIQAQE?=
 =?us-ascii?q?BCA0JCCmFQII6KQGDVRF8DwImAiQSAQUBIgEaGoMAggsFohqBAzyLJoEyiGY?=
 =?us-ascii?q?BCQ2BSBJ6KIwOgheMM4JYBIE5AQEBlS+WVwEGAoIQFAOMUYhFG4IqlxaOLZl?=
 =?us-ascii?q?PDyOBNgOCCDMaJX8GZ4FPTxAUgWmOTCSRRAEB?=
X-IPAS-Result: =?us-ascii?q?A2E+AgCt/Jxdh0enVdFmHgFDDIFThBCETY5ihRcBliKBe?=
 =?us-ascii?q?wEIAQEBDi8BAYcIIzYHDgIDCQEBBQEBAQEBBQQBAQIQAQEBCA0JCCmFQII6K?=
 =?us-ascii?q?QGDVRF8DwImAiQSAQUBIgEaGoMAggsFohqBAzyLJoEyiGYBCQ2BSBJ6KIwOg?=
 =?us-ascii?q?heMM4JYBIE5AQEBlS+WVwEGAoIQFAOMUYhFG4IqlxaOLZlPDyOBNgOCCDMaJ?=
 =?us-ascii?q?X8GZ4FPTxAUgWmOTCSRRAEB?=
X-IronPort-AV: E=Sophos;i="5.67,272,1566889200"; 
   d="scan'208";a="81493384"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2019 14:18:44 -0700
Received: by mail-lf1-f71.google.com with SMTP id z7so21799lfj.19
        for <linux-wireless@vger.kernel.org>; Tue, 08 Oct 2019 14:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BzqX1zVw4wq3Gt+nW+YozxJEWLVjzz1XyMCyK/6yVFo=;
        b=bAHYrYp2keqWyqQrfIlJxfqczpjdJsi8lZdB1PcrdaTmzygYPO6efsaGYq45mDYnmM
         i0ZYFXzKVyuuoP0kIBcNUHXtkYUvaAPc/w6ydzQ0rvUww6VyDiZxH5CIKuALQDVeuaYZ
         bqLVOJwn9sudDDEZboIZ2B6owWQHKPkdjxHCMmmRszeeineo4M3Bg203dibMcZb0pqFc
         tVygUiTfTUJENBrbeCJqx7m+wVY4gccrhFtuvX+al0ZVN0Za/iiyhC02/KWwkNOxPrlP
         OeSoMkfUcj4U2XtqxZWg1XwbkXVtCX372Mh6IB79DiGm2hsA7LRZozFoVWLhQpye6PDu
         xMDw==
X-Gm-Message-State: APjAAAU3FUArkWj+DAvhfSyo6FfMDdFtobxD6OSlj8b7zIarXyu6MD+z
        qojnGEByDxlQaS1UMoX0nz9tbqxeGYuL8x5dtQ87oZl5bfizWYBpBpsb3pUMNDVopfORUrNV4x2
        tmg9itj/L5X5FTBFjUEn/RO1AiSDUomzcKSEhiuOROY5z
X-Received: by 2002:a2e:634e:: with SMTP id x75mr152653ljb.25.1570569521567;
        Tue, 08 Oct 2019 14:18:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxdSHEcSfRKYlPljj5Tuv1lx9cKQ4bNLJxj+P06OlnAhwoDIezvXyKWld7+DEaALP61IUuVX5UPYX+YpMFYDk=
X-Received: by 2002:a2e:634e:: with SMTP id x75mr152642ljb.25.1570569521308;
 Tue, 08 Oct 2019 14:18:41 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 8 Oct 2019 14:19:23 -0700
Message-ID: <CABvMjLQ0Qgzk74yg4quZG4CMKy8pb6pV3XGm_cg4NRkTiCHaKA@mail.gmail.com>
Subject: Potential uninitialized variables in cfg80211
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All:
net/wireless/chan.c:
Inside function cfg80211_chandef_compatible(), variable "c1_pri40",
" c2_pri40", "c1_pri80" and "c2_pri80" could be uninitialized if
chandef_primary_freqs() fails. However, they are used later in the if
statement to decide the control flow, which is potentially unsafe.

The patch is hard since we do not know the correct value to initialize them.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
