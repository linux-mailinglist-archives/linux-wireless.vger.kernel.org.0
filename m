Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7F1C3FF6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgEDQdq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 12:33:46 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:58562 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgEDQdp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 12:33:45 -0400
Received: from [192.168.178.34] (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 26FA4580243;
        Mon,  4 May 2020 18:33:44 +0200 (CEST)
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
To:     Sven Eckelmann <sven@narfation.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        kvalo@codeaurora.org
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <1760068.xeLkAeoAig@bentobox>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <5a4c9924-e727-30e7-8409-967c361c2fae@tu-ilmenau.de>
Date:   Mon, 4 May 2020 18:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1760068.xeLkAeoAig@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/20 6:29 PM, Sven Eckelmann wrote:
> On Monday, 4 May 2020 17:41:21 CEST Markus Theil wrote:
>> ath10k currently reports survey results for the last interval between each
>> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
>> can lead to unexpectedly small results, e.g. when hostapd uses survey
>> data and iw survey dump is invoked in parallel. Fix this by returning
>> cumulative results, that don't depend on the last invocation. Other
>> drivers, e.g. ath9k or mt76 also use this behavior.
> It is (unfortunately) not that trivial:
>
> See code and comments from other people:
>
> * https://patchwork.kernel.org/cover/11150285/
> * https://patchwork.kernel.org/patch/11150287/
> * https://patchwork.kernel.org/patch/11150289/
>
> Kind regards,
> 	Sven
Thanks a lot for pointing this out! I was not aware of your patch.

