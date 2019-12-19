Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED06125B81
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 07:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfLSGgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 01:36:20 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:44099 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfLSGgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 01:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=RxZXmpD1r5rWdodi5dIRAPji6QPoqfkPDV/+JsbJV4M=;
        b=Mz32dpDnzVbeozVnxjqqewgVDMUfAjJjcrJaGzTGf0DXrQ9k7g9WScuanIbSeyjU1H7YYD5j968pjpGfwgpqHKg6pKl97/6JqF0SySlvHGIccwFvLGFoXl9npxs2dNKaLDxSQCl1jUC+h1dgOGOZaR0Ql0mCVd3Qo5Dt5BLUaik=;
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading
 support
To:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     John Crispin <john@phrozen.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20191216092207.31032-1-john@phrozen.org>
 <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
 <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <d24c7821-4e5e-28b5-5d1d-f076cfd762fc@newmedia-net.de>
Date:   Thu, 19 Dec 2019 07:36:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2003:c9:3f2c:4f00:bc20:1f41:7042:9c0e]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1ihpOe-0003GP-Hi; Thu, 19 Dec 2019 07:34:52 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 18.12.2019 um 23:45 schrieb Tom Psyborg:
> ccing Johannes Berg since upstream change (mac80211-next) breaks build:
>
> In the commit log its written: remove SUPPORTS_80211_ENCAP HW flag
>
> Any sane reasons for doing that? mac80211 fails to build because of
> removed flags, this is on backports-5.3-rc4
>
> Other than that the feature delivers the promised:
> QCA9880 iperf between wired and wireless machine
> native mode 449Mbps
> ethernet mode 522Mbps
johns patch does not work for qca9880 wave 1 chipsets. it works only for 
10.4 firmares like 9984, ipq40xx  etc. the 9880 has no benefit from it 
and has no effect.

so your test seem to have false results

Sebastian

>
