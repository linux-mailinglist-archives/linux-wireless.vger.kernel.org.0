Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076B441B884
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbhI1Um4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242734AbhI1Umz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 16:42:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BFFC06161C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Sep 2021 13:41:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g41so1431954lfv.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Sep 2021 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6a9VrMEupMnYKAh2ZE2+a6Hw3bwXnoHKG1+wGsmFKSM=;
        b=Ifc45YiMdo2WMqinyBnr8d4dlchkfcjvmOBTkDoE44fuyNGwa38btqpkQDnP26dKS9
         0jQOxC74k3DZYFFC7WGHe/UXnWs+dx0gpoam/Jo3gQ2FJadOMv56+p5tSjje29gjgs02
         aoTSQd5GrLkWz+Q9onPD+JDuC784+Fx/MnfDc9pwwAk9d9+8dCGU09q65BHrn8jdAr2s
         A+rZNVcy4RliYxaPuwl6XwoGDPEwAs6Rc6nT+sJIPsOuqNUdM1+SCLfhP4inKCe4Wsga
         KzLImH1Ja25/4RnxZ5sXC1X3iaKAVKU8XIbUICUNTENK1xqFj/pa4dIVOMmi73n+aIxM
         13CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6a9VrMEupMnYKAh2ZE2+a6Hw3bwXnoHKG1+wGsmFKSM=;
        b=fe/NLwo1yzqPGBj6IMe70LR0PD3pBitTlp8EaY8lDgOt5YHWMlaiMAELGMGUkB1Dhg
         XjxhNrTgbQ+Q1GxAa0rMr+YakHQ6YX+IqYjxj6GiszpRIqitQkoKXQ2zLcpOeATsiWhL
         TiXK3vCnwv4MZrRpMvzKPSanD3AVJytQ/m9aZAv4bbr+rqM8Zkaksk4qDG54/vhWcFnB
         wCll+OZW+HVe/kYlGySpml2t2aAekLZ3ztTVXMhsenD7JSIRs8RXRbcAD53TgBjqW8Nn
         zY5O9EnNghhNFz2RY5P47wRFARQcuA1+chWXp/NE502PHlFplUgFR1Mac5ymIWeEkr5u
         vC1Q==
X-Gm-Message-State: AOAM530ZzpRxJFJ8OsBefjyCHM9XKjs88hfVMY1yfVpA7INWYoeIjh59
        o5Zum8/dZjwDDd5bvRyLkfUDgckQSYM=
X-Google-Smtp-Source: ABdhPJzrEUcXBmcmZbksjTQ7hRBfXNKSoQ3W/nsRQBN6gDclCe5gJoFiOourxh7g4tyZXUE04IAqNg==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr8207632lfe.442.1632861673499;
        Tue, 28 Sep 2021 13:41:13 -0700 (PDT)
Received: from [192.168.2.145] (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.googlemail.com with ESMTPSA id j24sm5980lfh.302.2021.09.28.13.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 13:41:13 -0700 (PDT)
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        andreas <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: How to upstream Broadcom WiFi firmware files?
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Message-ID: <58d7f0c9-3869-4dbd-7de5-06fe6c729697@gmail.com>
Date:   Tue, 28 Sep 2021 23:41:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

We have Android devices that are well supported by upstream kernel and
other upstreams. The biggest missing part is the WiFi firmware files of
Broadcom chips, which don't work using stock binary firmware provided by
linux-firmware package. We need per-board firmware files for them. The
NVRAM configs are also missing. The main problem is that the license of
those firmware files is unknown, the NVRAM files have copyrights and
that's it. The devices in question are nearly 10 years old and are long
time unsupported by vendors. Is it possible to upstream those firmware
files and how it can be done?
