Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4471B940C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 17:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403973AbfITPer (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Sep 2019 11:34:47 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:44067 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403944AbfITPeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Sep 2019 11:34:46 -0400
Received: by mail-vs1-f43.google.com with SMTP id w195so4945627vsw.11
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2019 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jImOm2OTLXeR11KmWdQ/IRHS7k0fdp+xB7mnaPaZnAU=;
        b=TmNloiXC5KHIyepbblw52O6MuDkE5TGcVsJJhCLgAmaN5H9qrF66sSj2eELGuAHRfo
         QO7hBRdb9H99sWd22n3g2FSCq2n90w2PuWxvT0tbhKlvAh0Tmy0d+xpzOCv/nN5BJrK+
         2jSCeXclRMkBp1tA8qpPeXgA26+Gh33KUlJEpTq5OUoAnRYyDo1swqnAS9s6E1Bf4Z0W
         Q3gnTGAPcy/5ImjtwhVSyuZtayQ8By3Asf8YE/Ww8Btqa1XxVz2ArjLwCKjk3hD4exW2
         WBkWsf7dZHa9TZ7W7bxlgYsoExqNkpcSGrqzLiMbeIBdsQJQIOO7oqKIjPbXDfWYYWET
         4YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jImOm2OTLXeR11KmWdQ/IRHS7k0fdp+xB7mnaPaZnAU=;
        b=DaSk+BN6GyvM1Oq38d2edBFiaUhLPwxC6DaIBQKzG9BZ91SV+UhlbbMgso+FFJWJCL
         3sY4LUFu9ukoYGDgKvtVnF+N70h8KxIv4osMqZtpmPHNVWDqihjyUA1c3RbQEw9jqpBC
         1XJaOnyBjmySjgSL3uqqmb92BlnbEa4XYHJfDNYBGUtcONu3FrXeUJ5iELV79slFkkbS
         NuFQXKaqZc3+8ry4Qyzkmsl9MIdGfsaueE/de3SGSTXJXfUYHg3lON8TNFyZAy9RY4WI
         r/sqjFrDXM/aRxwdkn/SoB9BJwnn6+XgMHdRykX8i91C+eb6pu7m4LAxmVHnYeesi2aH
         bxvQ==
X-Gm-Message-State: APjAAAVRF3nVvyerOMmdASzwXeS8+66Y8o3T0oLdT25aVFo1g8PaCr97
        IDQJGV7ZkOmJ5okVX1+V8Ho9hrigEZHQO2XJstvSvqjyQt8=
X-Google-Smtp-Source: APXvYqxt6zoH97UbUXc56Z51N0TsAG+FaIeUlX0DxqnQw7Rdz5bgxSCM3JnEhu70IApH1e2nINzyBKy2NYA+cjk6l1A=
X-Received: by 2002:a67:e352:: with SMTP id s18mr2982819vsm.81.1568993685642;
 Fri, 20 Sep 2019 08:34:45 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Antunes <baantunes@gmail.com>
Date:   Fri, 20 Sep 2019 16:34:34 +0100
Message-ID: <CABUTiXX6D=Hoaue2pLPvctdQy2Pv_Pdjj2ysXp5QE3138DTZEw@mail.gmail.com>
Subject: Virtual interfaces intel AX200
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Does anyone knows if the new intel AX200 or intel AX201 have support
for multiple virtual interfaces?
Is there any intel Wi-Fi device that does support it?

Thanks in advance.

Best regards,
Bruno
