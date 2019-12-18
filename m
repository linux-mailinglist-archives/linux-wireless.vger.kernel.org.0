Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8212579E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 00:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRXSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 18:18:37 -0500
Received: from nbd.name ([46.4.11.11]:47846 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLRXSh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 18:18:37 -0500
Received: from pd95fd447.dip0.t-ipconnect.de ([217.95.212.71] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihiaQ-0003nv-5u; Thu, 19 Dec 2019 00:18:34 +0100
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading
 support
To:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20191216092207.31032-1-john@phrozen.org>
 <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
 <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <d2e4207c-1cd6-198e-84df-21496f0be378@phrozen.org>
Date:   Thu, 19 Dec 2019 00:18:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/12/2019 23:45, Tom Psyborg wrote:
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
> 

superseded due to johill's fixup of the patch, new version coming up
	John
