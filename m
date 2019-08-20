Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEAE95E58
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfHTMYC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 08:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMYC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 08:24:02 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBB366CFCD
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 12:24:01 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id e9so4046088edv.18
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 05:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kmKPHTCzyy6ANatEc2iel5jOxAG7QMqVRpdxW3s1buE=;
        b=mD+pQoBAItTGwpsgBaoSWHHiafS4QQw1AFv9WkLDiqRkNz8YutTVnZt7Hk2/CR2JPq
         jMXyHuOzlQBCwHsYv+qtb6pTvhjiwmZibVk3LtdllL8MoUVBe8RoZYAne6Pn51KkFucZ
         /nBGkc+NKG00IWs7iB7bdUEJltTRStbz740D+e6jdadekpsRAAMJ/ZaQl8vEBSFS8NH7
         eaZ5GtLJwn+6qEx7twRLohFqv1bQpZEZBOxh3qtDYbn3G+OilIG/rsv+m+BVgAKZz5ox
         He/HPvu91kPiFYDWChWkqiQntulnJvt4qQjHkUTH6KGA4PLDBh2FlRB3hVocE7mDil6S
         zIYQ==
X-Gm-Message-State: APjAAAXEHgQQw8B9bDtrsM2eJ7RFB3qPnOWMDCcc4bZGvvRojr1KkLkT
        EDJD3k+3wrikYKExwwWWefy08OrfzbJOO0ieaPjngU58HZp1Xz+GB/AYwANioI9WItqB7lUnQN4
        p+4ytTzvZqifOTWo03vCfGNwHfcw=
X-Received: by 2002:a05:6402:50a:: with SMTP id m10mr9364396edv.173.1566303840321;
        Tue, 20 Aug 2019 05:24:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwc/mzxJ4/ZG/eZ+4iSY2PVNEH3DHKWFDx7z/DUURJS0reXNzpmnvLKKqcnHrnsuE0NrAt4BQ==
X-Received: by 2002:a05:6402:50a:: with SMTP id m10mr9364382edv.173.1566303840195;
        Tue, 20 Aug 2019 05:24:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 9sm2581333ejw.63.2019.08.20.05.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:23:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 270A5181CE4; Tue, 20 Aug 2019 14:23:59 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/7] ath10k: disable TX complete indication of htt for sdio
In-Reply-To: <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-5-git-send-email-wgong@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Aug 2019 14:23:59 +0200
Message-ID: <87blwkt480.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> Tx complete message from firmware cost bus bandwidth of sdio, and bus
> bandwidth is the bollteneck of throughput, it will effect the bandwidth
> occupancy of data packet of TX and RX.
>
> This patch disable TX complete indication from firmware for htt data
> packet, it results in significant performance improvement on TX path.

Wait, how does that work? Am I understanding it correctly that this
replaces a per-packet TX completion with a periodic one sent out of
band?

And could you explain what the credits thing is for, please? :)

-Toke
