Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3221652DF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2020 00:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBSXE1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 18:04:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSXE1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 18:04:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so2464075wrx.11
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2020 15:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=C73F6kvL6smsrwyAA+k5Qcd19TZwXhDtmPcn5LrJkwA=;
        b=zdvfG+Co5Eo9fVbehzWUjE+W1KoiY0Tr9QYG21Z7Jkesy28cYlg8nv2OgqGNOL9mQm
         eplQIMIlzJZwFTBe7WQcYdYncz0pFK8HoPVsFpGhlSjsIInTyzOl+E0deh8O1LXj7udN
         w3bp9hSdSBuBuAWRB5II+H1Ft+hinDn0uPqInYChWc8VI+TDbkN8H+RNN2FGodTaTX+k
         8iCdg99ffvTXQaF9bG82GZqe+ewqEFnFQabpkxhySGtV5+qsIrpa+Pq9KZf0NqylkhVe
         YnSYCz+bmIPjIqflw3niqQSyeUctO5buoqMXnWvzfbDCTNYsvUtiDwmT5NGDtThVvO0k
         RBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=C73F6kvL6smsrwyAA+k5Qcd19TZwXhDtmPcn5LrJkwA=;
        b=lbRAx7IRc/uL2bggGxmXgMaKJGK0Rz6hL2yXLEGMQrOSmNHsDT6iDmfCZ8k4I4WT+o
         1UrMtVrzyIzGNtNJibDx89BT1zxK6J3CGZITzC/tq/2980oaAiRbgT8CzDffMd1sK5TT
         RQN//nUzkPasfryBZ+tjqep6K5C8XT9VDg1a36AIoiQDlqV3yIc73uJ/8C8sLqQ3CrNP
         82JggckoHjNqIq+BZ9thfzfA0i1g9eeWiMQ5Mv1JSEuXtxgne33YOsmc/G1nYpSmPpsG
         ZiPVg7K8ce7maXoe0tMUM+lCP/Am1hVSKRyYBrJEViin+o9DNDa7LEaurLYCglfdtavQ
         BGTw==
X-Gm-Message-State: APjAAAU3Dkbk2YVVVlYc1ZxEmXhW8f7ybhqM3Zshj+b7a5M2mzuXyfKY
        cbCZWe02lri/6o/B9vp1CZ4T3bbGpQye0f+nQRRJnXG/tQ==
X-Google-Smtp-Source: APXvYqzvPUjun8egxz76DTZ8k6LrMjH2PeRse0Bn+LLsc6szzgbTyZA8bbWXUvAaO5xj8RjvXAR4njW2tV+cQaUtzqo=
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr36567117wrx.141.1582153465259;
 Wed, 19 Feb 2020 15:04:25 -0800 (PST)
MIME-Version: 1.0
References: <CAG2Q2vUH95JyMqOELtU4=uU3nO5jr2+806KiO+T1-tNdBZ=DYw@mail.gmail.com>
In-Reply-To: <CAG2Q2vUH95JyMqOELtU4=uU3nO5jr2+806KiO+T1-tNdBZ=DYw@mail.gmail.com>
From:   Cale Collins <ccollins@gateworks.com>
Date:   Wed, 19 Feb 2020 15:03:49 -0800
Message-ID: <CAG2Q2vU3spU6VOdGAF5beWmgG1eaWuVm3pc+gzcnhaTUHvX+yw@mail.gmail.com>
Subject: Re: ath10k_pci rawmode = 1 requires support from firmware
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

When attempting to bring up my mesh0 interface, I recieve an error and
in "dmesg":

[  901.629999] ath10k_pci 0001:90:00.0: must load driver with
rawmode=1 to add mesh interfaces

I enable this mode by changing my bootargs, appending "ath10k_core.rawmode=1".

On boot "dmesg" reports:

[   12.040581] ath10k_pci 0001:90:00.0: rawmode = 1 requires support
from firmware

Where does this "supported" firmware come from?

I'm using SparkLAN WPEQ-261ACNI(BT) 802.11ac/abgn + BT PCI Express
Mini Card (Half) - Qualcomm QCA6174A-5 chipset, with a mainline 4.20.7
kernel and Ubuntu Bionic root filesystem.

Thank you for looking into this, I'm glad to provide more information if needed.

Best regards,

Cale Collins
