Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C7120E8E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfLPPw0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 10:52:26 -0500
Received: from nbd.name ([46.4.11.11]:52626 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfLPPwZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 10:52:25 -0500
Received: from pd95fd428.dip0.t-ipconnect.de ([217.95.212.40] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1igsfV-0000kE-Ix; Mon, 16 Dec 2019 16:52:22 +0100
Subject: Re: [PATCH v2 2/7] nl80211: add handling for BSS color
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20191213155802.25491-1-john@phrozen.org>
 <20191213155802.25491-2-john@phrozen.org>
 <a67dd924ebb638a8ba2b742a07fd3d1db34732ce.camel@sipsolutions.net>
From:   John Crispin <john@phrozen.org>
Message-ID: <fc64ea0b-d2c3-79a3-6973-c822078db01f@phrozen.org>
Date:   Mon, 16 Dec 2019 16:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a67dd924ebb638a8ba2b742a07fd3d1db34732ce.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/12/2019 10:56, Johannes Berg wrote:
> 
> Also, not directly related to any code, can't the BSS color change, and
> thus you need a method to update it?

Coming shortly once I start working on the collission events and then 
the hostapd color change algorithm
	John
