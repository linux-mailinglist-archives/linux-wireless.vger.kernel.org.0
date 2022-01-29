Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C927C4A2E0F
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiA2LLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:11:13 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:44847 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233626AbiA2LLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:11:13 -0500
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jan 2022 06:11:12 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4JmBJW5cQGz20fK;
        Sat, 29 Jan 2022 12:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
        t=1643454203; bh=iKKsi0O5ZHWPlxHTXvtoEuzMn6zp9W3UKY697HshKQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
         Subject;
        b=KhlbEc8RrrDU87laxYB+s6uREAJvtbCaDFDME69Ys9NcKgYlNNGiv1bc1D9wvBpdg
         DYc96G0mlVz4znC5c48+kzEtpm6yYjQ+Qwptm/ECJVL/NcgjpAtm6l9L0v9HU9MphC
         niI+W7vJ/sSnyd9B7SWgCO+BvhM9Fzq0YreopL9JpEEgUYagfuqS671qblHqJETkFF
         hrRlMbQNN9TnMdtu+1OXJ0l5orsDem9pZB2jTTzjhD2Uevsf9ADwprMrMyonMFBnqE
         P9yGuSi6V/mL4dQpudKK7Qve8tYsYEiUS9zUL1pbWOF0L5y1opez5WMlHkB0OfT/LN
         NykRdzUNd+yJg==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.fau.de [131.188.11.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19p1wXjjrWAvTTtwUQIoSLG27RMFCxlEtM=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4JmBJT1Q0Mz20cj;
        Sat, 29 Jan 2022 12:03:21 +0100 (CET)
Received: from
 CP81zwvSkltS2aMnmDW1Y/RLsOLdkrmkt469XFpA/qGHqu1/cp4ibBrkwVd1yprYykfOktO0XWHbiMyA2jvK2gOo/r/H+f7h7ivHeYZ2KDQ=
 (5r8OcEGK/GWMz2KRr1vme1OlyvSP1zaHYh5+1tqWtr8d3pzX5I96vqeNUON7C10/gonZohOuajnrIKms+iKdKA==)
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Sat, 29 Jan 2022 12:03:21 +0100
MIME-Version: 1.0
Date:   Sat, 29 Jan 2022 12:03:21 +0100
From:   =?UTF-8?Q?Sch=C3=BCll=2C_Daniel?= <daniel.schuell@fau.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [r8188eu] Worse performance with 5.15
In-Reply-To: <0ef8d27e-d430-8016-e52a-fc2dbd87809a@lwfinger.net>
References: <b94c25aff028cfc4c9e69cbe1035522c@fau.de>
 <0ef8d27e-d430-8016-e52a-fc2dbd87809a@lwfinger.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ba4e758af458bfbce51b8df79898f783@fau.de>
X-Sender: daniel.schuell@fau.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-01-29 04:55, Larry Finger wrote:
> On 1/28/22 16:13, Schüll, Daniel wrote:
>> 
>> After upgrading to the 5.15 kernel I noticed a drop in throughput when 
>> using my wifi dongle.
>> I'm using a TP-Link TL-WN725N-v2 (USB ID: 0bda:8179).
>> 
>> On the 5.15 kernel I was only able to get around 30 MBit/s in download 
>> (using google's speedtest).
>> After downgrading back to the 5.13 kernel I was back to 95 MBit/s I 
>> used to have (close to the max from my ISP).
>> 
>> A bit of research revealed, that you did a major overhaul of the 
>> r8188eu driver in 5.15.
>> I then compiled the old rtl8188eu driver from the 5.13 sources for 
>> 5.15, loaded it on 5.15 and was able to get 95 MBit/s again.
>> Finally I also tried the newest version of the new r8188eu driver 
>> (Commit fa78315452) on 5.15, but still only got 30 MBits/s.
>> All test used the same location of AP and dongle and were done 
>> multiple times, so influence from other wifi devices is negligible.
>> Seeing that the issue is fixable by using an other driver module on 
>> the same kernel, it seems very likely,
>> that the issue is in the driver and not in the setup or other kernel 
>> changes.
>> 
>> Is the throughput a known regression?
> 
> Daniel,
> 
> This throughput regression is not known to me. I have not been very
> involved with the changes being made to r8188eu, but I do test it
> regularly to ensure that it can still make a connection. With my
> tests, I do not recall getting a speed over 40-45 Mbps connecting to a
> local LibreSpeed instance connected to my AP via a 1 GHz wired line.
> As I recall, I never have gotten anything near 95 Mbps.
> 
> I generated a 5.13 kernel, and it did not get over 30 Mbps. I get the
> same download speed from Speedtest.net. As my up connection only runs
> at 12 Mbps, that is what I always get when using an external
> connection.

that's interesting. Can you confirm that you are using the 40 MHz 
frequency range?
My AP is an AVM FritzBox!3390. In its menu I can see that the wifi 
dongle is using the following configuration: 2.4 GHz, n, 40 MHz, WPA2, 1 
x 1
With the one antenna of the rtl8188eu and 40 MHz the theoretical limit 
is 150 Mbps.

I also retested with a local iperf server on the fritzbox.
This is where things get strange. With the new r8188eu driver iperf over 
TCP gives me ~60 Mbps.
While google's speedtest still gives me only ~30 Mbps (I also tested 
various other in-browser tests with same results).
With the old driver rtl8188eu again I get ~95 Mbps over iperf and 
in-browser.

Regards,
Daniel
