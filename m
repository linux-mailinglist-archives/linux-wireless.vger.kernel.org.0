Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B864BE8B47
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 15:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbfJ2Ozq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 10:55:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43200 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389131AbfJ2Ozp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 10:55:45 -0400
Received: from mail-yb1-f198.google.com ([209.85.219.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPSuN-0007lI-RK
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 14:55:43 +0000
Received: by mail-yb1-f198.google.com with SMTP id y64so7192962ybf.2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 07:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmgAwQ167jcpFlAuZhdV1sMm22pvfQc6hd2sKALIync=;
        b=cFucqH3DOF5hz66htmwdjiAj7r3AXUoENRMRDWXkBYKSJm1MXI4sxr8yFufEyga0Br
         3Rdx/aekPB93r4XsoNyKlX1XZu3qLpbf1vEbUD74ZXWwfXYWUpAGWfg5wFVZML3OsYIJ
         tE6RWzGhu7F47JEDWsvf8YPmoGknDRs9DI1kvqm0AO1gvDQBpJmIU/nY+DBiy1BqFfUd
         5nbEvHGhNL1bv+BDJDGrX2388lR9hManAYPURiKr9MH8zXo6+39oHWVFSmi7oQUw7nZ3
         13cDZNMaa10mc0a8Am49MajTPoKpRzkXIE0Ot+WEvkdgg2wmHeQSDAxSAznfdCgKO+mt
         PTOA==
X-Gm-Message-State: APjAAAW8jj0rVVwSTZsv7Ku8oE3bwPj5AmiCn5AoeHv85VFpUGv8Ie3O
        BQkv+ftpxrCmIWbpO2aB5oUETBi/GgfDnll1PV3W4zmAC0Z8GnNHYbOjMMqKK6zM4sDmuXvk63N
        jtsjODy7BsYAyFdAdoxAQBQUJhevOCOtecvjYkYxGr5iq
X-Received: by 2002:a25:487:: with SMTP id 129mr20969901ybe.138.1572360942744;
        Tue, 29 Oct 2019 07:55:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyowYE+KbDDI8jGTrDLydAbF+HPThGD7BTcqUj/dAZDobpbPLi8vw5bhjhdwbvC25LVRTEKFg==
X-Received: by 2002:a25:487:: with SMTP id 129mr20969867ybe.138.1572360942238;
        Tue, 29 Oct 2019 07:55:42 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id y142sm13412198ywy.80.2019.10.29.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:55:41 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:55:40 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Olli Niemikorpi <mr.oole@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: Wireless-regdb: Update regulatory rules for Finland (FI) on 5GHz
Message-ID: <20191029145540.GS30813@ubuntu-xps13>
References: <CAFXqH2MPhju-GNfwhcubLssZP5CuQAdENtQQ2TdgTNk0pur=Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXqH2MPhju-GNfwhcubLssZP5CuQAdENtQQ2TdgTNk0pur=Gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 16, 2019 at 12:35:16AM +0300, Olli Niemikorpi wrote:
> Hi,
> 
> Based on https://w.wol.ph/2015/08/28/maximum-wifi-transmission-power-country/
> , maximum output power for 5Ghz is 30 dBm from channel 100 and above.
> However, only 27 dBm is maximum in wireless-regdb. Could you please
> fix it?

Transmit power control (TPC) is required in this band, see [1]. Since
Linux does not implement TPC, the maximum EIRP must be reduced by 3 dBm,
so the value in the database is correct.

Thanks,
Seth

[1] https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
