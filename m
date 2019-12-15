Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30911FBBF
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 00:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfLOXHt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 18:07:49 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:43885 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLOXHt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 18:07:49 -0500
Received: by mail-io1-f48.google.com with SMTP id s2so4965632iog.10;
        Sun, 15 Dec 2019 15:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6kzFgmpoKa4eJKzshTXvk6xaL09WxEEorGAF72I+lSA=;
        b=t8sFC6+hu4YVQkqiYXMPtKg/xQR1sNqq7uwI3MBtZtbn7CNJ2rVpGs3SSzmqa0HIw7
         Ey0N1i/kxBuDMvQ3MozGQxt4Wvx3LpIcnYjUWsLA6XQc0Ch/byIPyIijupypR94VT/lH
         H11gLe0YxVz23ecgIAR48+CJvTTf+MQrKxPzMFwWwDSSBWpoMg0bxGUYvnGUQ6Ysbayu
         algqeP/5kEzAuFQIrOIOFxujuJJgcKQOz+ulXQyDD6UDdeQK9sWk1XYPRcHZ7Ts8WM3C
         p8yHTZqgZEYIE62rJqWBd0iSVIBeOm201kjWvODr/WEgZq9BiW45VuH9XrJShB2A7OIF
         dv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6kzFgmpoKa4eJKzshTXvk6xaL09WxEEorGAF72I+lSA=;
        b=RF15eJoAEq7qLwihPInn+F4nNJbTW1C2QMQcQIrimwOAExaBAqEWe+d9+IMyqEPBoN
         YRwrkctAXA9UEdFBY3YsrUIkStcxONCQtZdpO7+q/ncKL3n9rx8JATZ7slrHHV7/1i2C
         zY2Yp1AHkNKhPAEMCvokQyHEiL1pJPKf+pob62M+5Zdno/OAebWq9td7iZkPMSpL6h2c
         UBAbHE4wu2YVF5CjGTAd7/C8rFsM/oJbiSL3I6OHw0Dwcqu2er+bB+DeNwTYjgG9K9zC
         axAKlGxSAs082bEajn0RtvUBF56ErzA0X8PCg6bPxK2UTo4IwUWyQ8hTlgqsmB6OHhzS
         iQKg==
X-Gm-Message-State: APjAAAUdZm7ZQOxYXPGIu7hpxxVv0gOoEgS/CSsPcjGAVEfW3n1dRZq+
        z9Ofq2DRokeBVuK+Qfivp3Ln9DTRV1JqoOxycqCAjA==
X-Google-Smtp-Source: APXvYqwIdQR9g6ipiw9JT7HYBN0+ANqAQU1uN3fqhDItUbq74QvaH6OSgNWa068/88Z6NU3Hpl1DUC+zldPaRFacXbk=
X-Received: by 2002:a02:3b14:: with SMTP id c20mr9787617jaa.10.1576451268237;
 Sun, 15 Dec 2019 15:07:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:aafc:0:0:0:0:0 with HTTP; Sun, 15 Dec 2019 15:07:47
 -0800 (PST)
From:   JH <jupiter.hce@gmail.com>
Date:   Mon, 16 Dec 2019 10:07:47 +1100
Message-ID: <CAA=hcWSbSWEqVYFBXga4SpLwohjUWv9=rKStj=4GfVCtJ_Eo4w@mail.gmail.com>
Subject: Which LTS support Lily W1 WiFi module?
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am going to install Linux to an embedded device which has a uBlox
Lily Wifi W1 module, I am using kernel module mwifiex_sdio, mwifiex
and mrvl/sd8887 firmware, Appreciate tips if anyone is able to run
Lily W1 in version 4.19, if not, is it supported by 5.4?

Thank you.

Kind regards,

- jh
