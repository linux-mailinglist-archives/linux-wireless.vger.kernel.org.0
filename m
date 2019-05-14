Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A261C421
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfENHtO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 03:49:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37750 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfENHtO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 03:49:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1698668wmo.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wkkzAeBSr5IRd0ouYGcN8bTsUi6rqw1eAt0fzyLJGqo=;
        b=O2ajfBiF1g7f+4WhobB597W1hFAP9PeQ3g0JbVYTY9UIGeEzrAWtGo2zcaMh1z2NTi
         m+iYSYE2ODjEftC91g4adKCsiuL20/0seMd03et1oxjEESgtgCfLhNfKh6GX702eaz5H
         615G4qiS3ZObEm85EOSWWU4h8E+K0Rz7HZYEJH6J1Dquo6GDFAR2dtQSifsO0yxHuPWk
         4xL4m1jcVTYrm3whtKfA/PwcuXsoBks7xYAK1LVdMlAnYbMds33pU8ln5hNGerDCzxNu
         jN39595hXGCsrMOsLtPC04AkYx2EKP5l2Ph3QLuBDyU1SsilQUo8WP9GbOqMet+01egY
         PBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wkkzAeBSr5IRd0ouYGcN8bTsUi6rqw1eAt0fzyLJGqo=;
        b=EXAb32Ayj/1Nbx92evzygqf26v1XdVeX0Ke0TTt9YAobqdh6Mzq/n7OokjvuHl2fcH
         IrcQa6vJ9W9gw311E2YE7rYdg3fLaViXlpNPp2N0vKlqoDcp/xz6pMVbMH7bEM0lAEH0
         ZmUW3OoMBom2qhMVqkRDEu1N8yRToumcnJ2JUF6d3QgW/lnONoO3r2+ClCfQxMGL3QXz
         4blz9fMM7us9IyHHtmgrccrOFnym0UTmHtqJsSYrm9nfAuAQgkb3yNFSw6HA7wNqHtZR
         UMKgdlI2iwECtjK+dCUVwjy8bNg9yBz74DjUEWC+68ukJlvSV+4msGtYfJxUP91dfEVS
         5fFQ==
X-Gm-Message-State: APjAAAVzpTDI5HEsM0ISUdHyGmOcrXfiejhIUw1dLBgiRNKezhaCzy+W
        MgZZI7YBKjLm9cyrQW+iXfgEMN9dvMsUW0L2tEc=
X-Google-Smtp-Source: APXvYqynBEUp3Zq7Rai7hX7keATr438iv01j+6V/KgW7GTohdi+mVPWR1KhZBOluJh4jaP8WpKnST4SBjGUNDIeZCVs=
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr18740855wmh.40.1557820152337;
 Tue, 14 May 2019 00:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com> <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
In-Reply-To: <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 09:49:01 +0200
Message-ID: <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        robert.dolca@intel.com, oleg.zhurakivskyy@intel.com,
        clement.perrochaud@effinnov.com, charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 8:43 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
[...]

> The nxp-nci kernel module is loaded and neard is installed.

You have to...

# modprobe -v nxp-nci_i2c

# lsmod | egrep 'nfc|nci|nxp|i2c' | sort
i2c_algo_bit           16384  1 i915
i2c_dev                24576  0
i2c_i801               32768  0
nci                    77824  2 nxp_nci,nxp_nci_i2c
nfc                   131072  16 nci,nxp_nci
nxp_nci                16384  1 nxp_nci_i2c
nxp_nci_i2c            16384  0
rfkill                 28672  10 nfc,bluetooth,thinkpad_acpi,cfg80211

# modinfo nxp_nci_i2c
filename:
/lib/modules/5.1.1-1-amd64-iniza/kernel/drivers/nfc/nxp-nci/nxp-nci_i2c.ko
author:         Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
author:         Cl=C3=A9ment Perrochaud <clement.perrochaud@nxp.com>
description:    I2C driver for NXP NCI NFC controllers
license:        GPL
alias:          i2c:nxp-nci_i2c
alias:          acpi*:NXP7471:*
alias:          acpi*:NXP1001:*
alias:          of:N*T*Cnxp,nxp-nci-i2cC*
alias:          of:N*T*Cnxp,nxp-nci-i2c
depends:        nci,nxp-nci
retpoline:      Y
intree:         Y
name:           nxp_nci_i2c
vermagic:       5.1.1-1-amd64-iniza SMP mod_unload modversions

- Sedat -
