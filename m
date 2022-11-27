Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E124639BC1
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Nov 2022 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiK0QaP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Nov 2022 11:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0QaO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Nov 2022 11:30:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1BACE36
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 08:30:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so13989031lfi.7
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 08:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SvhEDg7nlB0QCkN4oC0+1FiiLHRH55DwZAktfnRtV+o=;
        b=TV8MW9hwOoirXyrHUZVOTHhMPWM2dAm174COtAmVvRDaFHIl3c1FrDCkQhFvCFYa/d
         4Lmu2Rf4Sc5dH6ZQjGFaiG4gVQ3gwSyJ3etQCYBUGIF/vTTHr92+65L7bFFmskcz/UTZ
         uU4cxyqUiCE324laq46Ag1kLFFEBacLZuV4K3Ic3Kv//8kNNQ06EIQZV1BTlSY8/qnrQ
         HGyaZEb+xSU6k/MmAFjY1xi4qY+z85sl1mJvQNGzkWxUsIOPC7gDTf0nEzLNlBA+vGQI
         XfTbwsT3J7At5spWcM0CmIhh36oYoJ52mKoZ2SEH4LXNH978v9xrupNIXFMkP/tp9CLZ
         Ln+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvhEDg7nlB0QCkN4oC0+1FiiLHRH55DwZAktfnRtV+o=;
        b=ufc5jKQc0QFzeerpMLDWXbIlXOLARX24+i9RucLp34STNGyTdK05MAlviRAOqo4B7Q
         /ZWQ0eVaA2+m5ooB3rBYymz+oKMBgPVfMJCwwMt0HQztd3O0Ub7tktEwEM/2LPSp4BHI
         woTGV88tLnZYoCE07XId9JSZ0XjF+62GPfnxo8rWNAuamTt19Xdtc0OabJzMTZ+Cl5R+
         rbzae1Q61asVxAP4xzn7Kg2jOvop22RLHF38q48uhkbkTETCAA4EatZkjqy/o8OnCvLx
         QTPlHKsoASy73HmqgMdTCL77dIwoLKb9fhUiqJ3eCKIp6wN1TQKUKLyYH4mD6E+OGFmv
         NLwQ==
X-Gm-Message-State: ANoB5pkrnx+nsYMATDLiDadkKsLz6du4YWqWe8QPgKhEPxjBxSXobSdE
        d2vbTe2OyjSjYw2E0fSd/Q6UO+TPl04EVIcMS44qV3lSeyo=
X-Google-Smtp-Source: AA0mqf4jTGREaX6CUIzesUVJY9C+m/MjErHLVUrHBudCDx5ghKKedkwE/6gN5rbVvV8g8AZOCh0PZjutfU383WN4OFU=
X-Received: by 2002:ac2:4f8e:0:b0:4b1:2190:829b with SMTP id
 z14-20020ac24f8e000000b004b12190829bmr5815167lfs.334.1669566607504; Sun, 27
 Nov 2022 08:30:07 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Sun, 27 Nov 2022 20:29:56 +0200
Message-ID: <CADUzMVbgf2dcu0yM=XO37GbTvgGK=mJpfELHrqDqbBECSuLKJg@mail.gmail.com>
Subject: Re: PRO/Wireless 2200BG Intel WPA3 SSID connection problem #1
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Well, keep in mind that WPA3 requires all kinds of new things, and the
> *most recent* NIC you tried is already ~11 years old afaict.
Yes and no. Yes it needs new things. No this is not the case here. I
tested cards from 2021 back to 2003.

> This probably means they use SW crypto for everything.
Sounds good to me since it works.

> What makes you believe that?
The fact that some just work. Why not use SW crypto on legacy devices?

> Umm, no? Why would we break NICs that work well with most existing
> networks, just not WPA3 ones?
You got it wrong here. What I mean is to use a flag that some devices
are not WPA3 compatible. That way when an attempt to connect at such
an SSID would print a message suggesting to use a WPA2 network. This
will help novice users and save time from bug reports. Most routers
now support WPA3.

> Unlikely. The newest Intel NIC in your list was 6205, which was released
> in 2011.
That is a good one :) I have much more hardware than I need. I just
sent what made errors here. Rest assured that I have tested all intel
cards including mPCIe and CNVi M2 except the AX411. Also do not own
any wimax ones from Intel and Marvell based cards. To be honest,
tomorrow I will receive two more mPCIe cards having PCIe adapter using
Mediatek chips for testing since we had only two of them borrowed from
ADSL routers and are locked at 5GHz only operation. But they connected
successfully to a 5GHz WPA3 SSID.

> Well, you should look at wpa_supplicant logs.
Will do tomorrow as I will switch to custom 6.0 as well since I have
another one card facing issues. A Cardbus based Atheros ath9k failing
WPA3 without any logs so will hopefully check both.

> And btw, your clock is off by a day:
Debian default time zone was set to US by default but switched to MX
Linux today since I could not bare Gnome! Used the right time zone now
