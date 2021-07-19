Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF93CCBC3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jul 2021 02:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhGSAXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jul 2021 20:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhGSAXp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jul 2021 20:23:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E423C061762
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jul 2021 17:20:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b13so25051214ybk.4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jul 2021 17:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOKhyIKX9sphpbuF3/QUSDAb1YKCTGuThTsMrD+moKI=;
        b=Y3waDBn3jf/40yjXcY00Vbz1VdxQTOdqCYyDL2ObjL1tX85o7Y2NUH3f9VcsiLHYZG
         L6NWF+N6KmGzWN8z08EBWHTACoah8K5Mi4yljLE/CbrPTf4Buu6Yc/1Z/FSXnsY0rvpY
         J4FKfERD7iJM6HQK0yXnu0bD8rM5D0uO55pzI3TXqCQMVEPoZm1uJ7864SeuzsU4rWsN
         vofH8PGWkppqvhNDygkkx9qOYkTqoO0PxALg5mJo85JJxPxvpqtCKTbrn4910MPsoGps
         WPU7oTcW969/KWAZ3kYJ4BaoZU7HmiN725j8hE/89pLttM4zRSsM7sceuJmLb0xirWBz
         2eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOKhyIKX9sphpbuF3/QUSDAb1YKCTGuThTsMrD+moKI=;
        b=n3ukWUxelJZOYIJRoN3dMII2hvHvbDljl3dtn/GTOzwvhlQFScqbIjoHGgtfEdKF/e
         P5RnDBaqPMMkBH1jZDIBsxfbtpjGV3wOwdB7ODldv/ijgnaOHccHg9s6heKM7wrsRRH6
         APGm3zFIC4as8QZUwYG8IJsmYII1epZ4QClyskI/XEVcJZ5TzYWM8a5w0HaTekawccVm
         7675vLK4GINPLE43eJuDlEaM/Nm7rn+TO+YSOVywcXWr2QFsekxKqFR1rJQc3BtBLEop
         Caz9oP/1lyI32DuLT3Y4ACvf8KFqoKY0zxoC+GRmOBjZXRtLtHJ/T+QzPrbL/ImXsqv4
         SdVA==
X-Gm-Message-State: AOAM53031AVKEwW/XDIs8AMsQtISbuQLJEl4hd3o83M19aCm1TIGbIKy
        Ce0qIi1RfPM00Q7PSEwTtSay8mYQMm0qu5fY5yo=
X-Google-Smtp-Source: ABdhPJzDNxED0VHa73pf7y1qfGeb9tc9yYeXm8HPQmkWwMSC5PDhccIGeo2AwyUn+XsLNuDUIX8whfUoJa23XXOmmqY=
X-Received: by 2002:a25:ae42:: with SMTP id g2mr26599269ybe.307.1626654044653;
 Sun, 18 Jul 2021 17:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
In-Reply-To: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
From:   Timo Witte <timo.witte@gmail.com>
Date:   Mon, 19 Jul 2021 02:20:34 +0200
Message-ID: <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The bundesnetzagentur has assigned WiFi 6E frequencies for germany you
this is the
publication of that change:
https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf?__blob=publicationFile&v=3

Following frequencies have been assigned for general use:
5945 - 6425 Mhz
maximum (200 mW)
No outdoor usage is allowed for 200mW

For "very low power devices" outdoor usage
is allowed, but only with (25 mW)
same frequency range 5945 - 6425

There is no DFS requirement.

Best regards,
Timo
