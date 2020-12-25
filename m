Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431B12E2995
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Dec 2020 05:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgLYERy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Dec 2020 23:17:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39574 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLYERy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Dec 2020 23:17:54 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kseXQ-0002ap-CJ
        for linux-wireless@vger.kernel.org; Fri, 25 Dec 2020 04:17:12 +0000
Received: by mail-lf1-f72.google.com with SMTP id 140so2397726lfm.23
        for <linux-wireless@vger.kernel.org>; Thu, 24 Dec 2020 20:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0yfjrvzC0/FeQwqt4EgClgwqVYwsZCYRgh1b5lM3NA=;
        b=XdXUAHvJUJWk5VMxszCCgdSlojd8YsdszZ6BATom4nC+XBrxZykqgoyLqjd9Nos6DB
         4q1BATuS7R2pjjd0PqmGuEBBC5SqQzvOqFNMbGehHccHMg6ZD7Qych4yLzJNxBL7zu9a
         9CpcOQtmzRqdmPQYR5dhv5jxIM1bbOZ7VOf17sMNlGtKsWozWseyjJdHeiPgzrt5RjGf
         zYf0N1z2mTqZvWDn6GkEume6rAxX3SEgFP/omi7dNqaYZCxocugn+hnEnpDTGj8z0UAO
         DB+8rvhNmMdSyrxMbQnrIGyqSjDaa/6XvcrrEx8nIVe361QZ3PQaDgTXZVoUmnON8uHk
         uFEg==
X-Gm-Message-State: AOAM531ibyEXAJXOQ0YBk+ca7z9wGdQyVl14n7gFxPP+h/OMIbmnOnXV
        cWzlZJaHUzDnHvqPzbIq8kuyR4nMntkqoLor5ydFLOJ3zu9x0DPiPIqjB3ZaWijWDX7kzva8k30
        lo1WBrhetUFwhBl9rTW8mDPOzwBccYNFiZ5KIwiNwYE/i7DaDhUEx1Z2zxrCc
X-Received: by 2002:a19:dc5:: with SMTP id 188mr14453936lfn.513.1608869831699;
        Thu, 24 Dec 2020 20:17:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVfPvWgOn1HXNlvtEnV/4n50FDBSdFERPHhC1d+FntiUMSp/ZQm+ayN+b/6zxpRltAslTPBBcgnhDiF6ycUHw=
X-Received: by 2002:a19:dc5:: with SMTP id 188mr14453933lfn.513.1608869831451;
 Thu, 24 Dec 2020 20:17:11 -0800 (PST)
MIME-Version: 1.0
References: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
 <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net>
In-Reply-To: <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 25 Dec 2020 12:16:59 +0800
Message-ID: <CAAd53p4=tAmyCE3QhFP8N9We3T_CGvnLWYgZAH8naWc_njtrOQ@mail.gmail.com>
Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ethan Hsieh <ethan.hsieh@canonical.com>,
        Hugh Chao <hugh.chao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 25, 2020 at 2:18 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 12/24/20 7:26 AM, Kai-Heng Feng wrote:
> > Hi Ping-Ke,
> >
> > We've found that when creating 5G AP on 8821AE, it's not on other
> > devices' wifi list.
> >
> > Here's the steps I used to create an AP:
> > $ nmcli c add type wifi ifname wlp3s0 con-name hello autoconnect no ssid hello
> > $ nmcli c modify hello 802-11-wireless.mode ap ipv4.method shared
> > 802-11-wireless.band a
> > $ nmcli connection up hello
> >
> > If we change "802-11-wireless.band" to "bg", then the AP can be
> > scanned by other devices.
> > Does 8821AE have hardware capability to support 5G AP?
>
> What does 'iw list' show for 5G frequencies?

* 5180 MHz [36] (23.0 dBm)
* 5200 MHz [40] (23.0 dBm)
* 5220 MHz [44] (23.0 dBm)
* 5240 MHz [48] (23.0 dBm)
* 5260 MHz [52] (23.0 dBm) (no IR, radar detection)
* 5280 MHz [56] (23.0 dBm) (no IR, radar detection)
* 5300 MHz [60] (23.0 dBm) (no IR, radar detection)
* 5320 MHz [64] (23.0 dBm) (no IR, radar detection)
* 5500 MHz [100] (23.0 dBm) (no IR, radar detection)
* 5520 MHz [104] (23.0 dBm) (no IR, radar detection)
* 5540 MHz [108] (23.0 dBm) (no IR, radar detection)
* 5560 MHz [112] (23.0 dBm) (no IR, radar detection)
* 5580 MHz [116] (23.0 dBm) (no IR, radar detection)
* 5600 MHz [120] (23.0 dBm) (no IR, radar detection)
* 5620 MHz [124] (23.0 dBm) (no IR, radar detection)
* 5640 MHz [128] (23.0 dBm) (no IR, radar detection)
* 5660 MHz [132] (23.0 dBm) (no IR, radar detection)
* 5680 MHz [136] (23.0 dBm) (no IR, radar detection)
* 5700 MHz [140] (23.0 dBm) (no IR, radar detection)
* 5745 MHz [149] (30.0 dBm)
* 5765 MHz [153] (30.0 dBm)
* 5785 MHz [157] (30.0 dBm)
* 5805 MHz [161] (30.0 dBm)
* 5825 MHz [165] (30.0 dBm)

Kai-Heng

>
> Larry
