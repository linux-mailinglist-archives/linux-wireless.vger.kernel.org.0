Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D351E6F0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEOCwx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 22:52:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35541 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEOCwx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 22:52:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so1640449qtk.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 19:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcleYVt6hTdEREV6sXFakwa/d5DgpphuD5jXkPsQGZ8=;
        b=SVPhhLipkFrwz/Az+YlbUdbk6oFT9qRb8xuCQBmtzqHcFkEnDUt6YKVa6/6VlB0Q7Y
         qeTa+ticTAxUQVbmDL0NGP9qIN8BRE12cxj8+ymnDCR7RrHG9Cqn+JZ30cQo6O4grIwX
         gZXD+k+RHV/cSg3Sy6DZW9bYoXKJjCpqeADVtcixDjYc0LAWKj8h9Ui0MNKz2TYpBgUk
         pwAMxACVupsgqUMc+Fn7ZBTsxO12Q9kxtZskgv6JUgw7Gq9RHR17LwtTTaRKSVr4dRci
         hqLyfl2X2yY9Foimz6n+hVLB0fZDVFboMby/iuDNTMnkIuMbBJoMkLgaIY8MEsojGloX
         So3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcleYVt6hTdEREV6sXFakwa/d5DgpphuD5jXkPsQGZ8=;
        b=QkmK/RacOa313eSIy6GO3/En7dfe6cKgwkasm9Jq32qgv2ge7veqePbR4p8qkfn+Ly
         oSSbAJZy1yb72NMr6NpgHtIzlz/3JpZF56Ybn4b5Dnu8d63Spl8et2F6g7C38NrV7ceA
         9loYvE2x7gXear82AaGHBxS7qKb29zi8N7JzTIUwenw2MQohf06QF+JnJtdH3KIyEaK+
         OvczeuKzOCbRET7AP8+TEG9DOLT1SLfo/95DxHajP+H0FauPbvSHLYAtMCeAg9UNHQc3
         3kPDKxAzcdeevXQLfqAZEn5pOLa4QXJlZ5Y9Fe2OgRJqXnwhXCEBn9noxe1Uqe5tI3LB
         AnCw==
X-Gm-Message-State: APjAAAXwPce7k2uvZATL59PyjpNuYUgUvCPgDrlQiPq2UUdrOIWOLWo3
        xla3ouby8OP3quqZbB6XKRb+Vwop4lUKckrHycjQNQ==
X-Google-Smtp-Source: APXvYqwrpLPbZVtglSltceUZH0uVDRPmm7OFqo7KTLK5sqDkLke+lBZBigmBY8akguydnCoInIrIytziyT/cEiWeKEQ=
X-Received: by 2002:ac8:60d4:: with SMTP id i20mr26446993qtm.376.1557888772194;
 Tue, 14 May 2019 19:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <1556524457-17469-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1556524457-17469-1-git-send-email-wgong@codeaurora.org>
From:   Claire Chang <tientzu@google.com>
Date:   Wed, 15 May 2019 10:52:41 +0800
Message-ID: <CALiNf29_GwSEUJ_vdp+_1DeDyFZj0uuUY9kYh94w4P_eeDT=8g@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: add support for simulate crash on SDIO chip
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tested-by: Claire Chang <tientzu@chromium.org>

If this patch adds support for detecting the real firmware assert,
maybe the title should be "add support for _crash recovery_ on SDIO
chip"
