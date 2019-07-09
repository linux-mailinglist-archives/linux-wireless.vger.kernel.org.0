Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE9596389A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfGIP1m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 11:27:42 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:40936 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIP1m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 11:27:42 -0400
Received: by mail-io1-f50.google.com with SMTP id h6so35799224iom.7
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jul 2019 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aEBaxoEKPvzifbSSScR1G9MBonGQBjoeSedIUS+8Y5I=;
        b=ARzxmSml4J0o2GyAyqQqPajkVXnbzWFz0CojQnEjijS4nU6GYKHGLqecjUniSqy4AD
         SGE+XaJqTdZHp2fhck1XieaV6JB7u5Ny8MFji4SkgCWaYJLU1rXEDx18PsThbHOQZ2Cp
         U+lvIcRwXoB+f+GBquvxOjSW5hHoBNGd7PRvnhMB0mPbyBz5nXIqI7ts6LCNXh9WUhLF
         63k5ch7brM2Rxngpb5lqodABhfuo69/LkHOMdBQc7tJVzOdNEkU47kSMSC2g0f5soVXK
         Oy4cRT3KSRz0er0nw/4SufIdQx4U1IcP6IA+jIA93YEnLMCREilR4EZxVd8AXjFyPVnP
         iSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aEBaxoEKPvzifbSSScR1G9MBonGQBjoeSedIUS+8Y5I=;
        b=lGO3EJaBjfXb33pnSm5u1yH2gwA184IaGKJTcB7f+aGszpytJezcnVEH2wJDEXa6NV
         kUIvXBnj6Glt1SwjH6HdCq+p3bP+fwFSpJO42uQZ6U5fhx2mYvHfgSFCJ5uFhpK0yfID
         +B00jmdq8BM7bmpAYd2lSS9YBrhtGOupjF4MgdI/3GJGJ8fFxf9O1G4HeJEkVu6asjnv
         DoLSPBAd813p/aNCrZKwnqOA7TF9lBHgGU/CAX/vUjpn35NUyLY1vgrstpE+DSocvLAq
         q9moiwf00QA6UkgHgfw/73qpuJQta6m+UtRqBgA7Jhnzm6eNn6ItXaDUUw4fXWvca8IR
         W4Hw==
X-Gm-Message-State: APjAAAV8L+iOLsTAMkZj2BmAQ7MEweGy1zd6heuvs1MVY1BNyzuoEPlS
        rkRhw2Kx0I/0COv0bGt1Uv0FB2i+
X-Google-Smtp-Source: APXvYqxigQktEZJAd2cV69+WPKq35HhZyRDpvJKuQrg/cojcfeGxyEpb1oERkS+95LbwfQTbwnA3fg==
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr1113730ios.84.1562686061487;
        Tue, 09 Jul 2019 08:27:41 -0700 (PDT)
Received: from new-host-2.home (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m10sm26628054ioj.75.2019.07.09.08.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 08:27:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] nl80211: Update uapi for CMD_FRAME_WAIT_CANCEL
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20190701153317.27170-1-denkenz@gmail.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <8ee48245-f4b6-2faa-25ac-d2ffe9673b4f@gmail.com>
Date:   Tue, 9 Jul 2019 10:27:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190701153317.27170-1-denkenz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ping?

Regards,
-Denis
