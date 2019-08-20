Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDAF966CE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfHTQvs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 12:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHTQvs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 12:51:48 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47FCA4705B
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 16:51:48 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id l15so4504851edw.15
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2019 09:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7yqGrrOc/g3cSTBCdVhyf3kJZ/EhjTm0pASCf/Kg64M=;
        b=FyUKeGXDfyl3Nf9iEV13WCpqjxqL8u2JjufzT3SqrsiqSX0MdlUF4SR0IrFHy5kC2z
         XKtq4mBRt2aeHkrmp4BASllmoHesk2lgoPdELCBO1uFQk1CQQNh0vwc5jtqeB9XEIbiM
         dHbbwCraOHmyONB9pes5xSqtbn0ETyBhHXVoRHSPti08JfUICDyq6MvWmKBg/jyY/4v6
         Rym//qdx1NnZFaeSlZQUWNfMrIJw8fCcUqgLAB7vCF6euRFm2XU8nHSPhF7mffwkeFF4
         n7SCb1gWOMFYcfFScSy+wa0MnnV2fRTPXwYGRV+sqcKHHrVduYPS7ZIu8v4KdR+M9qzo
         RfwQ==
X-Gm-Message-State: APjAAAVKDdhEKisXey2sj2m4kJQMNSwrFbgkbWuRyEID7LuRfbkoenNH
        IqL0wgM+VYaAPt/vBX4L9Ve5sAFL6G/stWEihuKIUBfIWCFPYmgSn7exrTy2ZQcRj03DQHqzPQ4
        D33dO5ddc0Fr7HL8PpPT8UmvLxb0=
X-Received: by 2002:a17:906:5ad2:: with SMTP id x18mr27336985ejs.127.1566319907060;
        Tue, 20 Aug 2019 09:51:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvYkN1pmlPM7dcZgxoE0bmPzLKoZUK/pujbfVW3EWGUfjN4z3BHtpo7QDSOe3ACQUV9XrgLA==
X-Received: by 2002:a17:906:5ad2:: with SMTP id x18mr27336974ejs.127.1566319906883;
        Tue, 20 Aug 2019 09:51:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id va28sm2695613ejb.36.2019.08.20.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 09:51:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7ED39181CE4; Tue, 20 Aug 2019 18:51:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org> <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Aug 2019 18:51:45 +0200
Message-ID: <8736hvu6e6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[... snip ... ]

> +static const struct ieee80211_ops ath11k_ops = {
> +	.tx				= ath11k_mac_op_tx,

No wake_tx_queue? :(

-Toke
