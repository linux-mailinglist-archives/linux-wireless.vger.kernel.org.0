Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF8107437
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKVOsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 09:48:47 -0500
Received: from canardo.mork.no ([148.122.252.1]:41259 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKVOsr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 09:48:47 -0500
X-Greylist: delayed 777 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 09:48:46 EST
Received: from miraculix.mork.no ([IPv6:2a02:2121:282:b3eb:68e2:39ff:fe1c:1a78])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xAMEZdID032622
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Nov 2019 15:35:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1574433340; bh=2BpQFlpj3p3Pl/E0JLnP4XMiMR63AtMyntef50UKSuM=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=HibessQ4CjsRCwg4+6CeNmBbFHvp+xrwWKvY/UOe55DzVAAh5nWvR8Hx2OmNVS7xe
         mvvgfV7pY9ao7X2HiDssVzJqOxCHaNlvUZmfLnLeR9nNEWlhzS876IMsYNguX83qsb
         2BZ3GFiLxMGyPnjX9QKBgs4ykV709Xa48PLpLjxI=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iYA21-0007MY-JP; Fri, 22 Nov 2019 15:35:33 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Andrey Shevchenko <ashevchenko@quantenna.com>
Subject: Re: [PATCH v2 2/2] qtnfmac: add support for Topaz chipsets
Organization: m
References: <20181016102349.26544-1-sergey.matyukevich.os@quantenna.com>
        <20181016102349.26544-3-sergey.matyukevich.os@quantenna.com>
        <CAOiHx=nBWr4GNh61WV+SAY-++Z6es-HX3_pd70DB_N33bVK1tw@mail.gmail.com>
        <41b4f41f-37ae-ef5f-476c-eb616d6a3da1@quantenna.com>
        <CAOiHx=myYOAYPm0KwS3wP+sPLaQH9obUv0wbdteCx6REJPKQgw@mail.gmail.com>
        <37ee7285-5856-6a77-3a29-92b86886c48c@quantenna.com>
        <0101016e8de4774f-c81ce2c1-f2c7-40d4-83b2-f8f8a49b1f8a-000000@us-west-2.amazonses.com>
Date:   Fri, 22 Nov 2019 15:35:33 +0100
In-Reply-To: <0101016e8de4774f-c81ce2c1-f2c7-40d4-83b2-f8f8a49b1f8a-000000@us-west-2.amazonses.com>
        (Kalle Valo's message of "Thu, 21 Nov 2019 12:16:30 +0000")
Message-ID: <87k17s3rnu.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:
> Igor Mitsyanko <igor.mitsyanko.os@quantenna.com> writes:
>> On 11/19/19 8:12 AM, Jonas Gorski wrote:
>>> Any update on this? The support now had its first anniversary, and
>>> still no firmware available for it.
>>>=20
>>> Maybe you could put it up in a (temporary) download location at
>>> Quantenna until you get around to the second attempt?
>>
>> Hi Jonas, Quantenna was recently acquired by ON Semiconductor and this=20
>> was put on hold during the integration. I have gone back to our legal /=
=20
>> IT department to work on this again.
>
> Thanks, and please put priority on this. It's really bad that if there's
> an upstream driver but users can't use it because of lack of firmware.

And it's particularily meaningless since most of the firmware source is
available for download from e.g
https://kb.netgear.com/2649/NETGEAR-Open-Source-Code-for-Programmers-GPL
, or other vendors using these modules.

The "Netgear R7500" firmware archives include the GPL distribution of a
few Quantenna Topaz firmware versions:

  qtn sdk v36.6.0.23: 1.0.0.46,
  qtn sdk v36.6.0.28: 1.0.0.52,
  qtn sdk v36.6.0.30: 1.0.0.68, 1.0.0.70,
  qtn sdk v36.7.3.23: 1.0.0.76, 1.0.0.82,
  qtn sdk v37.3.1.25: 1.0.0.94, 1.0.0.108, 1.0.0.110 , 1.0.0.112, 1.0.0.116=
, 1.0.0.122,
  qtn sdk v37.3.2.44: 1.0.0.124

These are pretty complete and directly buildable/usable.  Now I only
have an RGMII connected Topaz module so I am unable to test these
firmwares with the PCIe driver, but I assume they will work with it.

Having some officially sanctioned image in linux-firmware would be nice.



Bj=C3=B8rn
