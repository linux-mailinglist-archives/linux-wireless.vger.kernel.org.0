Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE57395E50
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 14:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfHTMXO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 08:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfHTMXO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 08:23:14 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCAD6C04DBCD
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 12:23:13 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id e9so4044826edv.18
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 05:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iSdS+7DcgO9sZjEWZf2j9AguesTvtM0dsT3F9qr+OE0=;
        b=qo9Lnk/ouFj4KccMYg72bGq/aUTaR+6S5JNv7Mp+bMnZ3Tv+5xh+tuatU6/L081DN7
         wxHlpJrVIS+mPrQF6GiIaXx/A0u7DZBqbOb/zu/S8vSsTmDoZ6QDbdMOiIZmXlmp5gSF
         P+1emiicJtH/goZoEAE6sUugi1FDeVxD0DEXn0AiNdlJbqNOZZ+G1feKGhj9+fp+Ux1z
         2eKDF7/FXuAWd4s96pyWSDt+uUc7c1pjC5h3ur1vq/iQTdr39+NfWZxoSge8XJ+fi8TB
         A8Rh6HK9mKFmFO+/X/rEnCmQS+bW+I/3q2QiDlMCCRCW/8nSbzDGvrv52rcqxmbN2Yxe
         c4jA==
X-Gm-Message-State: APjAAAXd0YMia9GESAK2P202frZejoRWRK7+MCdH19GEE2CIhN3ye079
        fth83o3Hq2vUaZGggQ2Mlf5fys0iCGkz6VfN1+p5UXTg0CTAKYvS6Y2FftMrTRboCpaCKqftCs3
        HyNeAqbSKM9dqvrqHdolhdMS1QgU=
X-Received: by 2002:a17:906:30d8:: with SMTP id b24mr23012337ejb.33.1566303792568;
        Tue, 20 Aug 2019 05:23:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybUcJ8v+8z3nxTgQG72iDhsNy6in985LhX0wTWPhraEs+1qQR1uF9cJOarTnXMnIOJCbwVXw==
X-Received: by 2002:a17:906:30d8:: with SMTP id b24mr23012294ejb.33.1566303791951;
        Tue, 20 Aug 2019 05:23:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h13sm2338338edw.78.2019.08.20.05.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:23:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE34A181CE4; Tue, 20 Aug 2019 14:23:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
In-Reply-To: <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Aug 2019 14:23:10 +0200
Message-ID: <87ef1gt49d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The max bundle size support by firmware is 32, change it from 8 to 32
> will help performance. This results in significant performance
> improvement on RX path.

What happens when the hardware doesn't have enough data to fill a
bundle? Does it send a smaller one, or does it wait until it can fill
it?

-Toke
