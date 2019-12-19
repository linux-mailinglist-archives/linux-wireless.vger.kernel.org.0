Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947BA1263D8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLSNpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:45:54 -0500
Received: from nbd.name ([46.4.11.11]:35492 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLSNpy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:45:54 -0500
Received: from pd95fd34f.dip0.t-ipconnect.de ([217.95.211.79] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ihw7k-0008Ra-VF; Thu, 19 Dec 2019 14:45:53 +0100
Subject: Re: [RESEND 6/9] ath11k: add debugfs for TWT debug calls
To:     Kalle Valo <kvalo@codeaurora.org>, vthiagar@codeaurora.org
Cc:     linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20191204053713.3064-1-john@phrozen.org>
 <20191204053713.3064-7-john@phrozen.org>
 <0101016ecf7e75e3-b26c2edc-e278-4fbc-97d5-fc7f678c240f-000000@us-west-2.amazonses.com>
 <87eex078gs.fsf@kamboji.qca.qualcomm.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <5c00b087-f865-f663-cda0-91c196386366@phrozen.org>
Date:   Thu, 19 Dec 2019 14:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87eex078gs.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/12/2019 14:25, Kalle Valo wrote:
> vthiagar@codeaurora.org writes:
> 
>> On 2019-12-04 11:07, John Crispin wrote:
>>> These new debugfs files allow us to manually add/del/pause/resume TWT
>>> dialogs for test/debug purposes.
>>>
>>
>> Information such as how these debugfs entries are supposed to be used
>> could be helpful.
> 
> Yes, please always add instructions how the debugfs file is supposed to
> be used. Not only it helps the users but makes the review easier as
> well.
> 

I did in the V3 series --> https://patchwork.kernel.org/patch/11290751/
	John
