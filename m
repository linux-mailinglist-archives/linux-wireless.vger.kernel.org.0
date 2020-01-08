Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E446A133F8D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgAHKpx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jan 2020 05:45:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36104 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgAHKpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jan 2020 05:45:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so2231990oic.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2020 02:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+By7NrQmfZQ1g4MO8d3R+M35m5DiMvl+xvSs0kwnPOI=;
        b=NWl3x2DYvSBgy5NDRthkQvCaenEBWaEm7RotpNt9i/1NvZNu8kJJjnJ1RMWqKSRH1K
         cJ6XC0obsKrdXP48BtgeGy1PoiEfTb9xLy3519Ag8aWMv+1PHR5ei8cFhLaFPqSRFjJf
         kkVSHy3jcCOz2TBVJgSS8rgkF+8tcgXt+XetnmdQ4JlBw8656D+qaqegPGXeH5GO4YzO
         JVKv9xDV/ir83SQXeQQlpAqfezpHTYyJbt5stazu/SSBiN2DKyg+GvLVVWNQ1/Kv6lXM
         mWURwqrKT9k3Jn/7Vrm0iBwruA8Jqy0P7rGljm+ZlK/9BYvQj/jsuh4MJsS7SwB0wBZV
         D3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+By7NrQmfZQ1g4MO8d3R+M35m5DiMvl+xvSs0kwnPOI=;
        b=kCQpiiUrgCZp1BXCs/UQGmBWDs5dzOw5+8H3F3eHgFCqUtWNk51BTbs67VFhTW0mlQ
         lp1V0+4D57rB5gRqVhDNa29e04YANwUrYeGiyuQYaofqAF/2DcEaMGIqCfq7YnY1lA4z
         oqghgsPcrNoy+wbwJGJ+2qSV8ZmBD9roXZep28LQe9fMpGCuw1R49IqmwM8htpGKw2oD
         6kZ6PZAWJ55vsTtrmJDZfDMUcEv+3WpcFeEAZUIHkuSw1NHv0kh5s/3SuHJ8iz/TBHlN
         149N6Nz0FfAOkz4w8yxUC1KnKwR+RPfmWFtasDANI4jRAAV+OsXWLukY93duM20xyifG
         D47A==
X-Gm-Message-State: APjAAAWk0Fz3qfCMA/RANyDcc5VARdYnu+5p2rJMx/YmeNuD5WoHiLy2
        Dh9cpLZ9eypNbbMYF5Qv3GRW/Uu0yH1qKENyECJB+a+7
X-Google-Smtp-Source: APXvYqyC/jdXGiAwmN3rQfXpYQyMduWDRiIll0FjRnKpRze2P7PxsYYd7ykx97UZCgeXjza5Cc8Tqoy9DYNCQfORFug=
X-Received: by 2002:aca:ec4f:: with SMTP id k76mr2405337oih.156.1578480352223;
 Wed, 08 Jan 2020 02:45:52 -0800 (PST)
MIME-Version: 1.0
References: <1576221593-1086-1-git-send-email-yiboz@codeaurora.org> <1576221593-1086-4-git-send-email-yiboz@codeaurora.org>
In-Reply-To: <1576221593-1086-4-git-send-email-yiboz@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 8 Jan 2020 02:46:31 -0800
Message-ID: <CAMrEMU8qoD=-45sePbp+W+F+5mQmviMQaZjzXe_Ph2cNjan+OA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mac80211: fix low throughput in multi-clients situation
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Is there a risk of division by zero?

I'm curious about IEEE80211_AIRTIME_QUANTUM in this multiple sta
scenario, should weight maybe be the depth of the queue or something
like that? Using real time delta I assume is not performant?
