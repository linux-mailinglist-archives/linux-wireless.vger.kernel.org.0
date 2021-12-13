Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520384732E3
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhLMRZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 12:25:35 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:51988 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235816AbhLMRZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 12:25:34 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.128])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EB7E81C0071;
        Mon, 13 Dec 2021 17:25:32 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2158A78008A;
        Mon, 13 Dec 2021 17:25:32 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 88D5B13C2B3;
        Mon, 13 Dec 2021 09:25:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 88D5B13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1639416331;
        bh=nP/ES9vi1iyYepPZ3LsVzOzt9/DnbhAKP0SWqwHL148=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dD3gXSWw5XEIDW/04LQr/eoWy0t/fx7sPMAiJhYgSbCPyZs0EG0yHP3hh6YAuH3h6
         f0ksucUNYrdOpLkzi6gVtie80EkAsI2cLXQ6ytGfBig3C63A2i8WAtPlPQNtD/2miR
         C/15vrRBZMsDmiau+qiKlpD9g3a9MLwJVVCP9W5w=
Subject: Re: Frame injection on ath9k
To:     Sven Eckelmann <sven@narfation.org>,
        Roberto Riggio <roberto.riggio@gmail.com>
Cc:     linux-wireless@vger.kernel.org, sw@simonwunderlich.de
References: <CAKkT90b_C+B-2RY2BDO9tiQJh_Vv8y95JuVGADhc+ML-bSqxmQ@mail.gmail.com>
 <4481549.kEIK8Ajiyv@ripper>
 <CAKkT90ZoMA-FYtMqqu9hm8W--g1Wj1RpkkxzT=OO4zE7VaVP=Q@mail.gmail.com>
 <3275297.oaIAGnzijj@sven-l14>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f902b4cc-cf83-4848-fe16-6b1e061ad1fc@candelatech.com>
Date:   Mon, 13 Dec 2021 09:25:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3275297.oaIAGnzijj@sven-l14>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1639416333-6MG6KsO87dey
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/13/21 9:05 AM, Sven Eckelmann wrote:
> On Monday, 13 December 2021 17:49:38 CET Roberto Riggio wrote:
>> Thanks Sven for the follow-up. Do you know if besides on the ath9k
>> driver the frame injection is supported also on the ath10k driver?
> 
> Yes, but not with rate selection.
> 
> There is support for this in ath10k-ct but I am not sure if this only
> supported for specific ath10k-ct firmware variant - or if you just need to
> have recent ath10k-ct firmware. The relevant feature is called
> ATH10K_FW_FEATURE_HAS_TX_RC_CT and the relevant code is in ath10k-ct since
> 2018.

Any relatively recent (last few years) ath10k-ct firmware should support this
for wave-2.  wave-1 ath10k-ct has some slightly more limitted support for the same
feature.  I think all variants would support this, but we test internally with the -htt-mgt
version that pushes all the management frames over the data packet transport, so I suggest
using that.

Thanks,
Ben

> 
> Kind regards,
> 	Sven
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

