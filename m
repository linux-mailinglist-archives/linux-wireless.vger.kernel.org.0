Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BCC1264F9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 15:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfLSOjd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 09:39:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41161 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfLSOjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 09:39:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so7467377otc.8
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oFOf+MWDFUmc1sY/Zs1YC5RTRUuqHQJ3teYVmEjeOEk=;
        b=TcAXceDg+FJbb4u0xRlVaA0he7AjjE1+5vDSYAOP6ejWO7reVxKZrniNpKP/5/YeRs
         RQNdePo51hLzFoIKVChThZSGXKCV7Kas4RoO+ASQg5PRSu50grABrFel3G/OCr+cgmKJ
         wn1UkksgcM3Nur419xZbqTXqysZLOGnck/fhCXDfyUfh7BTpmwjmcJjZLh4tYYJzBfxB
         EbDSsF2ErHFAfE2W6OV0PfLxujWtknAVyAEPDmY9iwIy5cXLU0UVQR/9iJOJySDM09v8
         /1B9q7Pd+Se6B9U2hKj99HBV6rfQfuLMDW/wfyOdYVH+G0xXIxIRcpNIrwDLIN346iBt
         qEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oFOf+MWDFUmc1sY/Zs1YC5RTRUuqHQJ3teYVmEjeOEk=;
        b=jEqe+JxkJUx6hj4bu3r2UbeFhzdiY68WgMy1x7X8KG9DYd5OD8+BSvO7p4pB7wY0MH
         4QaqYe1E20vHSBpIBRgtZ0Je5G4Cfw139BpEmAbqjhzAl4O3ULpIHmx/bKP0WkiL8kc2
         Ko8DN/xZh3vMOSJSTnmJIlL3l7QJ4ApqpQxXMbPK4G9f57l7frzTj80P2z6dV3KSsCT1
         JzWyhVjGjIh8Ki5VqDf369LlFa11VlSJsQHdazHayEggDJnEiTK3gQMsbwFfVnLsXOAp
         OljccAQxOixQu2Frc6JeyTTC/5qEaN/6rCKyr8TBe1m2q0iqoyCcmkUWFOORhQGf/Km2
         RDNw==
X-Gm-Message-State: APjAAAVG4zQ2zdAAlSd/aA+btt0asgr7uCfycRe/+rS3DxTPL2lpVbKg
        FSSZEgh621KuLMIGp3CIrVbzrsztSbujU4HdSe5isD25
X-Google-Smtp-Source: APXvYqzRlVuJ3F6OK1gefKIM577/C7DSA1BBJ5S4Or2vsMlTF9aPZpxmvjEnWao/1Ep92xY68kWq/jv8OB3VBS8+2Ao=
X-Received: by 2002:a05:6830:1116:: with SMTP id w22mr9391597otq.63.1576766372387;
 Thu, 19 Dec 2019 06:39:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Thu, 19 Dec 2019 06:39:31 -0800 (PST)
In-Reply-To: <000eaa2a-4798-a855-93a9-c9679b8860c8@newmedia-net.de>
References: <20191216092207.31032-1-john@phrozen.org> <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
 <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
 <d24c7821-4e5e-28b5-5d1d-f076cfd762fc@newmedia-net.de> <CAKR_QVLKfoo15EqszGSZ9zf6YnfEkih9=PeB0d92k3i0SJZfxQ@mail.gmail.com>
 <000eaa2a-4798-a855-93a9-c9679b8860c8@newmedia-net.de>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 19 Dec 2019 15:39:31 +0100
Message-ID: <CAKR_QV+Le2zRvnGz4EiMKtXY8HTzH9eru86n6kN+5A9XSF7y3A@mail.gmail.com>
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading support
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, John Crispin <john@phrozen.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

in core.c there is also needed ethernetmode check in
ath10k_core_init_firmware_features

ar->wmi.rx_decap_mode = ATH10K_HW_TXRX_NATIVE_WIFI

replace with

if (ethernetmode)
	ar->wmi.rx_decap_mode = ATH10K_HW_TXRX_ETHERNET
else
	ar->wmi.rx_decap_mode = ATH10K_HW_TXRX_NATIVE_WIFI

QSDK driver sets it like that when using eth mode
