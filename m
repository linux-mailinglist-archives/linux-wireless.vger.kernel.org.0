Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E41095CF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfKYWuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:50:19 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:40672 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYWuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:50:19 -0500
Received: from [192.168.43.60] (unknown [172.58.46.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B099413C359
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:50:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B099413C359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1574722218;
        bh=TzOZlfKPdw9uoWQ5iCuYYswkj2CphrOF3TefTt99jWY=;
        h=Date:From:To:Subject:From;
        b=V9R34+RuwadmZJa0Eyr7FKlC40QCWz4HoHso6ITgKp+VIUepO7oLs7NplUZa9hYLX
         fJ2cCGYTYwlYamGpyl1GcoKSe01YDwG1xIraDgFvUUL/uKlRAlqJJ6BAOtdL9P2GcN
         te4jd/sKEvVhJyow4Im5YYS7wTKtO2uP2fbnMkfc=
Message-ID: <5DDC5AB4.2010500@candelatech.com>
Date:   Mon, 25 Nov 2019 14:50:28 -0800
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: ax200 signal average is wrong sign in 5.2.21+ kernel
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Looks like ax200 has wrong signal avg (positive instead of neg):

[root@lf0350-9438 ~]# iw wlan1 station dump
Station 0c:9d:92:02:42:e4 (on wlan1)
	inactive time:	5388 ms
	rx bytes:	1078599
	rx packets:	16341
	tx bytes:	21516
	tx packets:	184
	tx retries:	0
	tx failed:	0
	beacon loss:	0
	beacon rx:	15580
	rx drop misc:	0
	signal:  	-28 [-28, -28] dBm
	signal avg:	29 dBm

Any idea if there is already a fix for this somewhere?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

