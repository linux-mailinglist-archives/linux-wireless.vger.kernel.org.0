Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25776ABEED
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbfIFRoS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 13:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391831AbfIFRoR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 13:44:17 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B1D57BDB1
        for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2019 17:44:17 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id w15so3992527edv.17
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2019 10:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/HtxSJt1YrFil0tuaTwi2TJQYRMrSy1O0BSYHrcjcZs=;
        b=crlSpU55fkCWJbF+kALR0vGr8ySTBq7pSBFei/v9jEXbgKxHt8TJwj32LgO/4Uksrl
         UClh0XqZhWCpnqPDd8dzLR1+ywsCsLNvqcjs9e7Vcr6OFGlWRdPl6sJntkWi2e3HpCD8
         n+qCqrHyLP7dDFToslT8V3vbmcdJUl6rKscg3IYMyE+WjMrYxbfhJJQAEwb3BFVuLck3
         A4z8eKHUmFZWaQoZZIqsET1HFd4wKNIqyYv3MUWPlOXOzudJ0mhANdsbkOQlSYfyfYif
         c2w1ohDlSQVID5byEXwR/JPbqx2DQ76bl6TwA79TX4KwRaUcnt86ZUTW7ngoocqHkXGt
         hHfw==
X-Gm-Message-State: APjAAAVLmHAKQJrYp96f06cWvJhqPFqPxxaPTj2jq1RfZZ/BlA+UVwVN
        bpgcCwXSTMXF8cRtF3yNGOkbD2cmBgD+maPMkxNcmsZK+ifzq5Cx3pocnKGWAsXjAwqNss1GYX8
        gdse0b6iX14auhhLNxfiOLZBnpXI=
X-Received: by 2002:a17:906:5a8d:: with SMTP id l13mr8490159ejq.219.1567791856034;
        Fri, 06 Sep 2019 10:44:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxybV9Hn5WzS4dQeZB8uvgi3hMB1KO/f0Ln2ZN75wb8qTo9g57U8oZiZJIpMTjLS5G3+YO1xA==
X-Received: by 2002:a17:906:5a8d:: with SMTP id l13mr8490144ejq.219.1567791855881;
        Fri, 06 Sep 2019 10:44:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id ay8sm627122ejb.4.2019.09.06.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 10:44:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 55FD718061D; Fri,  6 Sep 2019 18:44:14 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: Re: [PATCH] mt76: mt7615: enable SCS by default
In-Reply-To: <5933942ffd23f71b925cc6be26e9918fd663ed46.1567783646.git.lorenzo@kernel.org>
References: <5933942ffd23f71b925cc6be26e9918fd663ed46.1567783646.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 06 Sep 2019 18:44:14 +0100
Message-ID: <87mufhz5e9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Enable Smart Carrier Sense algorithm by default in order to improve
> performances in a noisy environment

What does that do (the algorithm, that is)? :)

-Toke
