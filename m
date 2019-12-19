Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF9125F90
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 11:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLSKoJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 05:44:09 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:48409 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLSKoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 05:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=OsohWArkWEPoVS5FuJVbMQnUzuUpi+LDCzCNrpipREo=;
        b=hk7wgjV5PMFoURiB+dqYPuMjG+bE0b47BfJIKA3InTw6LwRy5ff3I/gF6HKeDuWjxJnDrVvQkPohtB6wORlIxZcWfXKO3ftFGdLLjVIEx/r6VxwhvUzodqagKKE3xTA5G+x/NrY10L0YoGrn4P0k3UbBTaJnRivYg1AET+8laVE=;
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading
 support
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, John Crispin <john@phrozen.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20191216092207.31032-1-john@phrozen.org>
 <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
 <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
 <d24c7821-4e5e-28b5-5d1d-f076cfd762fc@newmedia-net.de>
 <CAKR_QVLKfoo15EqszGSZ9zf6YnfEkih9=PeB0d92k3i0SJZfxQ@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <000eaa2a-4798-a855-93a9-c9679b8860c8@newmedia-net.de>
Date:   Thu, 19 Dec 2019 11:44:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAKR_QVLKfoo15EqszGSZ9zf6YnfEkih9=PeB0d92k3i0SJZfxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2a01:7700:8040:3500:48a8:bbb8:ef3d:ceb1]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1ihtGT-0007Xt-PP; Thu, 19 Dec 2019 11:42:41 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> no way. check that you applied code correctly and enabled ethernetmode
> parameter. iperf or ping also wouldn't start from wired machine in
> ethernetmode unless pinged from wireless machine first
let me verify this again. maybe i'm wrong.
>
