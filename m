Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE573FB754
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 15:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhH3Nyo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 09:54:44 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:39148 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhH3Nyn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 09:54:43 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.65.202])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 16CB91A007B;
        Mon, 30 Aug 2021 13:53:49 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DF58D8006C;
        Mon, 30 Aug 2021 13:53:48 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 32EFF13C2B1;
        Mon, 30 Aug 2021 06:53:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 32EFF13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1630331628;
        bh=Qopc5UCPbJi+lUhL6ff7J0Lso2pTOrHH4hv/J5AfGxA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=oceU6VmGz0wHTQOlfNtiNzSLH2tU15GNYTGVaIfJEDFfDUDapzWV0TfMVoiPDPhSi
         5ejtSSoA3xNUpFLLAW/xh/EnenBDTS5lWyorSHK2y7p+bIVTRpdbVrKnysKeV/S2Zr
         H65got8ihtcHwgHSsAvHFwDkpRBPCKmdE13RuSTo=
Subject: Re: Delay sending packets after a wireless roam
To:     Michael Johnson <mjohnson459@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CACsRnHWa47zpx3D1oDq9JYnZWniS8yBwW1h0WAVZ6vrbwL_S0w@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <42b5d899-b791-1fed-b2a0-1e96028f5eb5@candelatech.com>
Date:   Mon, 30 Aug 2021 06:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CACsRnHWa47zpx3D1oDq9JYnZWniS8yBwW1h0WAVZ6vrbwL_S0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1630331629-gde3hp27B0lY
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/21 3:23 AM, Michael Johnson wrote:
> Hi all,
> 
> I'm having an odd issue with wireless roaming whereby any time I roam
> from one access point to another I start receiving packets almost
> instantly but experience a delay of roughly 1 second before I can send
> packets out. I think I've narrowed it down to somewhere kernel related
> but I'm struggling to know where to look next.
> 
> Firstly, I started seeing this delay after upgrading from Ubuntu 16.04
> (so 4.15 kernel) to 20.04 (tested with 5.4, 5.8 and 5.11) but I also
> tested this on Kali 2021.2 (5.10).
> I see the delay with intel (iwlwifi), qualcomm (ath10k), and realtek cards.
> I've also used both iwd and wpa_supplicant, with and without
> systemd-networkd and NetworkManager.
> I've been using ICMP for testing but I've also tried a python script
> for sending udp packets with the same result.
> 
> Here is the output of the simplest test that still shows the issue
> (ping + tcpdump + iwd + 5.11.0-27-generic):
> https://pastebin.com/92TKKktb
> 
> My naive tl;dr of that data is:
> 
> 30.322638 - we start to roam which falls between icmp_seq=121 and icmp_seq=122.
> 30.415411 - roam is complete
> 30.424277 - iwd is sending and receiving neighbor reports over the link
> 31.358491 - an ARP request is sent out  (should the ARP cache be
> cleared on a roam?)
> 31.367930 - ARP response
> 31.368009 - packets start being sent again as soon as we get the ARP response
> 
> Can anyone help me understand what might be happening between the
> interface going "up" at 30.415411 and the ARP request at 31.358491
> please?
> Also, does anyone else see something in their environment?

I think ARP cache should be cleared on roam...I'm not sure how best to do that
though.  wid/supplicant could make the call to clear as soon as roam happens?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
