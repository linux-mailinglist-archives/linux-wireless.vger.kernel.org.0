Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B263464AC6
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 10:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbhLAJkw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 04:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbhLAJkt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 04:40:49 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC4C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 01:37:28 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id y5so47556753ual.7
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 01:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NjK7dgQQoHJLX3lmmnyF55bR4KmnX0Uvx1iO7Htr9E0=;
        b=j3/FbM1gMMOb6mBXxW6exrgPAbSasgOpfcm8ymCPmkdLyyBW4lPVox5xtoTNA9YosT
         M2lckjytrh4we9fM8JVNQ5S5g3lY8l0nVDe90EnBc/Nl5JEMXrByeYCYauSTK3gixp7Y
         QfplsWIFzDGr4RJR8PLaORa+hhnC8TgXyivij48BgvXEiVRy0nwhikAzrdIrVd5szh0v
         0MW/Ui549mM4asL25RblP5r7mtvqY2nQSxLdA9/EWJlAdsPoq3dQzuJApt+AMCBR7Rha
         /T1FxlfYEIADoaEnQnKn7EHbq4xUr8UXSInLGYMN70BfJphkztf0OK0TvXyqh83Qp6L/
         suUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NjK7dgQQoHJLX3lmmnyF55bR4KmnX0Uvx1iO7Htr9E0=;
        b=l0YbAkF2bYDX4tpmkVN0d7cFtGScPkgbRnE4/pAz+5AF9XK4xU3+2VzhtbTXXERA76
         DB3Mk8FxsuG26xk4Pwua684o8Rg1uQOvPPG2G8DhthqILRL+LMrPw0vGAWlt92lhp1yh
         trEvxcB3zesmNqQLqBA6qE2nMS2Oqnc4NuH/cRatfhPppSXWb3jvTYDL055nMQm7DNle
         bXI1Hx9ip/v1rCCzPZPGvaclNra09AarQ0p7Dpbk5vjMzh5KskJFqcTlUulamk0XBnSI
         lHG3vl+WMx6MgYMmw3Ek45U/1e4yyjXXykUTMn3Z0CJOV+kCDGcXASOWbeEgwwLCKdJB
         Pcuw==
X-Gm-Message-State: AOAM532SxmfGjRXNMBr87R/o8jfFrTD1K3yJ4fVW7vWWqczO0OQuIvaQ
        N45mq8sc7BuGvQabPrlafnmln6PJt++p/TZojc6R/ai0
X-Google-Smtp-Source: ABdhPJwsVkkt23azptxJ2JMIFtTZPdtb7KNDkpXA1SpjUTO6MA506mdDF25/26LDnWOkn+7Hs2WKIWd4dmUWhoig5hY=
X-Received: by 2002:a05:6102:c10:: with SMTP id x16mr5970443vss.38.1638351447616;
 Wed, 01 Dec 2021 01:37:27 -0800 (PST)
MIME-Version: 1.0
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Wed, 1 Dec 2021 20:36:51 +1100
Message-ID: <CAA=hcWTj8-WEUDgnLdBuSNPhF5w1DdcR8iMsEoxZc5KMczkdvg@mail.gmail.com>
Subject: Linux firmware sd8801 problems on kernel 5.10
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I was able to run firmware sd8801_uapsta.bin on kernel 4.19, but after
upgrading to 5.10, that firmware is no longer functional, constantly
connected / disconnected the WiFi modem:

[ 2456.553366] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'JupiterIoT' bssid 34:08:04:12:b1:a2
[ 2456.577515] mwifiex_sdio mmc0:0001:1: info: associated to bssid
34:08:04:12:b1:a2 successfully
[ 2456.590492] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
[ 2456.625367] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
[ 2459.599572] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 34:08:04:12:b1:a2: reason code 2
[ 2461.889309] mwifiex_sdio mmc0:0001:1: info: trying to associate to
'JupiterIoT' bssid 34:08:04:12:b1:a2
[ 2461.915404] mwifiex_sdio mmc0:0001:1: info: associated to bssid
34:08:04:12:b1:a2 successfully
[ 2461.927965] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
[ 2461.953056] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
[ 2464.936578] mwifiex_sdio mmc0:0001:1: info: successfully
disconnected from 34:08:04:12:b1:a2: reason code 2

Has anyone used linux-firmware-sd8801 on kernel 5.10 or am I the only
one in trouble?

Thank you.

Kind regards,

- jupiter
