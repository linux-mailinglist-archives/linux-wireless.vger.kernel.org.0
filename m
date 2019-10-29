Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A2E89A4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 14:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfJ2Ng1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 09:36:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388579AbfJ2Ng1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 09:36:27 -0400
Received: from mail-yb1-f200.google.com ([209.85.219.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPRfd-0004jT-5A
        for linux-wireless@vger.kernel.org; Tue, 29 Oct 2019 13:36:25 +0000
Received: by mail-yb1-f200.google.com with SMTP id y6so10564608ybm.12
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2019 06:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwtNqWivpFIQgbUVsKN05tdEedk/c2ICmFFDz7gAHHg=;
        b=S/F2TKrtKZ5Svw4p7WP05a5doKRK1XuAlyxfnym1a0XKNwSQvKaqsfBkl2EqMS1JyW
         3A2Pua/Gbku7qfSiStGvUzBxQOZqBO7XCsVJJZNtEfQJYh4HzHmubtLzMUA9iJ7Utpds
         hFu7rABZDW7VGOo1PH5mRaFGd62XArkwpAYdOZP2CcKEXdU8QK21KYe+hgNHYTDdk0HV
         JtwQmd2coOumA1npnGPmmG6rNM/gB2vuGqQ9bnwELGIDoCGHr2gEcvqlAvpYhFgjEtq+
         moAYETc8xKKkggboNdlQ6S/NZmaumDxTf3zE7AAlUbip5aJ4TjIiyv+Pxpxd9Es+M1Cg
         CZLg==
X-Gm-Message-State: APjAAAXhNDUeeoLiYvM8pSNA8w9GAFnS7+9kYpMrTqa014KRs+y/OLdU
        YxSLQJHbXM7G3Q7abpYc7Z1FJSicRmIeOxoDE6VZcIL/ALcubITkM1d1xoPQCqISqZjOkmrdnQo
        PFFuiCiOjndND91CFOF9A/SVePw+DT48vQOD+VUNI10Ty
X-Received: by 2002:a81:500a:: with SMTP id e10mr17707257ywb.58.1572356184089;
        Tue, 29 Oct 2019 06:36:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWRUgkWNbdDnzVotQDun7zMckaFR1TaoB4O5PCly4//oAwUlzOU76kcVYnSSfbVTEjaG0pKg==
X-Received: by 2002:a81:500a:: with SMTP id e10mr17707210ywb.58.1572356183528;
        Tue, 29 Oct 2019 06:36:23 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id x201sm17900019ywx.34.2019.10.29.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:36:22 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:36:21 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Russian entry is incorrect. According to the last
 regulations document of Feb 29, 2016, 160 MHz channels and 802.11ad are
 allowed.
Message-ID: <20191029133621.GP30813@ubuntu-xps13>
References: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 24, 2019 at 11:48:10AM +0300, Dmitry Tunin wrote:
> http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf
> 
> Note that there was never a DFS requirement in Russia, but always was
> NO-OUTDOOR on 5GHz.
> Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> Also Russia has never been regulated by ETSI.
> 
> EIRP has been reduced by 4dBm because of TPC requirement.
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

Sorry for the delay. Applied, with some slight adjustments to the commit
message. Thanks!
