Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26281128447
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLTWG7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 17:06:59 -0500
Received: from c.mail.sonic.net ([64.142.111.80]:52240 "EHLO c.mail.sonic.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfLTWG7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 17:06:59 -0500
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Dec 2019 17:06:59 EST
Received: from [192.168.42.66] (173-228-4-7.dsl.dynamic.fusionbroadband.com [173.228.4.7])
        (authenticated bits=0)
        by c.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id xBKLuImh004978
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Dec 2019 13:56:20 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Correct radiotap header for 802.11ad
From:   Guy Harris <guy@alum.mit.edu>
In-Reply-To: <4cf0c2a4a2d1cd92dff4f1a791d74523e446cf01.camel@sipsolutions.net>
Date:   Fri, 20 Dec 2019 13:56:16 -0800
Cc:     "radiotap@netbsd.org" <radiotap@netbsd.org>,
        Simon Barber <simon@superduper.net>,
        Richard Sharpe <realrichardsharpe@gmail.com>,
        linux-wireless@vger.kernel.org, Maya Erez <merez@codeaurora.org>,
        wil6210@qti.qualcomm.com
Content-Transfer-Encoding: 8BIT
Message-Id: <AC268742-D34D-411A-A170-B807010E13E6@alum.mit.edu>
References: <CACyXjPzq-ePB1ux6wi_Rv3onPKXomcJcm15XJwA51u0E4W2txw@mail.gmail.com>
 <38F46E1D-1C4A-48DC-A906-9522006E8474@alum.mit.edu>
 <1606812C-649C-4C06-ABE0-AE2F4474BCD0@alum.mit.edu>
 <1440402013.3735.1.camel@sipsolutions.net>
 <CACyXjPwSZPV+U_=zQpDBpeBnhMntzEFhyJnBOw3-N8qPfyHc1A@mail.gmail.com>
 <55DE44EB.6080603@superduper.net>
 <126B842D-05EA-4510-BC9B-DB1A4AABEC12@alum.mit.edu>
 <1135A126-6A5A-4C84-A52D-13C0387609CC@alum.mit.edu>
 <1442507879.2821.9.camel@sipsolutions.net>
 <C5FF46C6-BDEE-41D8-B7E1-1EFFE9411DE3@alum.mit.edu>
 <4cf0c2a4a2d1cd92dff4f1a791d74523e446cf01.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Sonic-CAuth: UmFuZG9tSVb7wgtVfHcrCfsU7J35lsQEiXr5q3QBNggUhaW39lCqs5yQ8Ab01ERMy+oFdIcBpQ73VHRst3c3k/gyyxsX1kD/
X-Sonic-ID: C;Snb9jHMj6hGWNCGeTRzYKg== M;GAJwjnMj6hGWNCGeTRzYKg==
X-Spam-Flag: No
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Dec 11, 2019, at 12:32 AM, Johannes Berg <johannes@sipsolutions.net> wrote:

> On Tue, 2019-12-10 at 15:51 -0800, Guy Harris wrote:
>> On Sep 17, 2015, at 9:37 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> Reviving an old thread :-)

Yes - it came up with the Wireshark bug in question.

>> But a presumably-Linux system does appear to use it; see Wireshark bug
>> 
>> 	https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=16272
>> 
>> For now, I'll throw a hack into Wireshark to treat a signal >= 60 GHz
>> as meaning 11ad, 
> 
> I don't think that's quite right - you'll need to do something like >=
> 56 GHz.

Yes - there's a macro in Wireshark to test whether a frequency is in the 11ad range; it was testing for frequencies between 57 and 66 GHz.  I changed the code to use that.

I also changed it to test for 57 to 71 GHz; apparently, some regulatory domains have added (US) or may add (Canada, EU) more frequencies to the range allowed.
