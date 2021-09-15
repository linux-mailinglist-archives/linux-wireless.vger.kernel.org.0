Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72D40C239
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhIOJAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 05:00:38 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:19810 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbhIOJA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 05:00:27 -0400
X-Greylist: delayed 726 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 05:00:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631695621;
    s=strato-dkim-0002; d=pixelbox.red;
    h=In-Reply-To:Date:Message-ID:Cc:To:From:References:Subject:Cc:Date:
    From:Subject:Sender;
    bh=6vvsQu4kQ5uaTSfeuBssEq7ZHpGb8nbZE1QTnVzHEGg=;
    b=GudV4LrmguDJZRxNH4y+HtXqUgk1+pI6ehtV50Glt3K0gHM2ult8UX2tv9IArUJUii
    kO3guTttMKhnGFk+kD8UJT4d1ptZeVuXAXLtAye3aUhf0HaBVXT+VHURWUUJx3/KoJ5S
    xvhueVUM0yg1tpU4Wkb+N0zrYzVKYf/S2TLRVoe18jMsset6i+2Bj/4SoQGniQ9aeroQ
    iKDNo62C8d6fLPQVub7O0s+41d9ZdSpOUfJbI7XWKDpfhDrYTYA5usQX024vRXlkfexy
    wH6GQpHnUWtgyL11CIz8gwLqmp4jhycKGdRw5/ByIuhTeObn1d/mk4peAvTOS7Ft0ooV
    qFaw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":PGkAZ0+Ia/aHbZh+i/9QzqYeH5BDcTFH98iPnCvV+7P5vDkn1QYVmmALvzR3jit8GeLSAHOfHP4hhbYGc15VV1Pk4ZI9IfywPogd"
X-RZG-CLASS-ID: mo00
Received: from 8.8.8.8
    by smtp.strato.de (RZmta 47.33.1 AUTH)
    with ESMTPSA id 002a89x8F8l1Z3r
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 15 Sep 2021 10:47:01 +0200 (CEST)
Subject: [Question] rtw88: 8822c: RFE type3 support?
References: <e887433fe7b64e21bc8687b5d13fc180@christ-es.de>
From:   Peter Fink <pedro@pixelbox.red>
To:     linux-wireless@vger.kernel.org
Cc:     tony0620emma@gmail.com
X-Forwarded-Message-Id: <e887433fe7b64e21bc8687b5d13fc180@christ-es.de>
Message-ID: <82030168-84a0-453f-f768-dce25a762113@pixelbox.red>
Date:   Wed, 15 Sep 2021 10:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e887433fe7b64e21bc8687b5d13fc180@christ-es.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I would like to have driver support for a RTL8822CU device which uses 
RFE type 3.

I know that the usb devices are not supported by rtw88 drivers right 
now, but there are repositories out there like 
https://github.com/ulli-kroll/rtw88-usb 
<https://github.com/ulli-kroll/rtw88-usb> which could take care of that 
until the usb devices are also supported upstream.

1) What are the RFE types basically about and what does it stand for? 
What are the differences apart from values in tables?

2) Is it worth trying to simply use/convert the corresponding tables 
from the Realtek driver (doesn't compile) I got from the manufacturer at 
https://drive.google.com/uc?id=18sNSSjY6rHwPI2MYtXUsnMNDB_ir3Hpy&export=download 
<https://drive.google.com/uc?id=18sNSSjY6rHwPI2MYtXUsnMNDB_ir3Hpy&export=download>and 
put them in rtw8822c_table.c? Or would I be wasting my time without 
access to proper documentation?

-> I saw that e.g. rtw8822c_agc is not exactly the same in this driver 
and the kernel code. I can't tell - is this relevant?

-> rtw8822c_bb seems to match array_mp_8822c_phy_reg, but has 
differences as well.

-> rtw8822c_array_mp_cal_init is different, too.

-> rtw8822c_bb_pg_type0 is exactly the same as array_mp_8822c_phy_reg_pg

-> rtw8822c_dpk_* I didn't check in detail, because it's partly 
conditional in the Realtek driver

-> And I guess array_mp_8822c_txpwr_lmt has to be translated to 
rtw8822c_txpwr_lmt_type3:

Realtek driver: #ifdef CONFIG_8822C const char 
*array_mp_8822c_txpwr_lmt[] = {
"FCC", "2.4G", "20M", "CCK", "1T", "01", "72",
"ETSI", "2.4G", "20M", "CCK", "1T", "01", "60",
"MKK", "2.4G", "20M", "CCK", "1T", "01", "68",
"IC", "2.4G", "20M", "CCK", "1T", "01", "72",
"KCC", "2.4G", "20M", "CCK", "1T", "01", "76",
"ACMA", "2.4G", "20M", "CCK", "1T", "01", "60",
"CHILE", "2.4G", "20M", "CCK", "1T", "01", "72",
"UKRAINE", "2.4G", "20M", "CCK", "1T", "01", "60",
"MEXICO", "2.4G", "20M", "CCK", "1T", "01", "72",
"CN", "2.4G", "20M", "CCK", "1T", "01", "60","FCC", "2.4G", "20M", "CCK", "1T", "02", "72", ... versus 
rtw88/rtw8822c_table.c: static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
	{ 0, 0, 0, 0, 1, 72, },
	{ 2, 0, 0, 0, 1, 60, },
	{ 1, 0, 0, 0, 1, 68, },
	{ 3, 0, 0, 0, 1, 72, },
...


1: Regulatory_domain (0=FCC,...)
2: Band (0=2.4G, 1=5G)
3: Band width (0=20MHz,...)
4: Rate section (0=CCK, OFDM,...)
5: Channel index (I guess 1=01,...)
6: Power limit (obvious...)

My guess is the 1T refer to "antenna 1/transmit".
In the Realtek driver there is also a "2T", so likely a second antenna/rf output path. How is this accounted for in the rtw88 driver?
If you are not telling me to stop wasting my time and somebody could 
hint me in the right direction how to to handle the 1T/2T part of the 
table, then I'm willing to try my luck...

Thanks in advance & best regards, Peter

