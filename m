Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E46375E0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2019 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFFOAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jun 2019 10:00:03 -0400
Received: from staff.inrete.it ([85.89.129.9]:37368 "EHLO mintbk2.inrete.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727009AbfFFOAD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jun 2019 10:00:03 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 10:00:02 EDT
Received: (from root@localhost)
        by mintbk2.inrete.it (8.14.3/8.13.4/Debian-3sarge1) id x56DnxM4026733
        for <linux-wireless@vger.kernel.org>; Thu, 6 Jun 2019 15:49:59 +0200
Received: from GBmac18.local (ingw.inrete.it [85.89.128.3])
        Inrete IControl (IControlServer: mintbk2 SrcIp: 85.89.128.3 SrcIpType: Trusted SrcIpRelay: yes RblListed: NotTested ResolvedAs:  UserType: Local UserHeaderType: Local Authenticated: yes)
        (authenticated bits=0)
        by mintbk2.inrete.it (8.14.9/8.13.4/Debian-3sarge1) with ESMTP id x56Dnrdp026278
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
        for <linux-wireless@vger.kernel.org>; Thu, 6 Jun 2019 15:49:53 +0200
X-Icontrol: Sent by Inrete Icontrol
To:     linux-wireless@vger.kernel.org
From:   Giorgio Bernardi <giorgio.bernardi@inrete.it>
Subject: Update to wireless-regdb about Italy
Message-ID: <10b9bea0-ecc7-75d4-91e6-d6f11fc3ef0c@inrete.it>
Date:   Thu, 6 Jun 2019 15:49:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-IControl-Milter-Checked: yes (IControlServer: mintbk2 SrcIpType: Trusted SrcIpHeaderType: Undefined Authenticated: yes)
X-IControl-Milter-SPF-Checked: yes (IControlServer: mintbk2 HeloSPFType: unknown FromSPFType: none HeloHeaderSPFType: Undefined FromHeaderSPFType: none)
X-IControl-Milter-MD5SUM: 7ce2ea33117e2fd542846e1c2d1c5212
X-Inrete-Amavisjob-Virus-Scanned: PDAmail Multiple Antivirus with ClamAv
X-Inrete-Amavisjob-Service-Runned: 6 (x56Dnrdp026278)
X-Inrete-Amavisjob-Service-Disabled: No Service disabled (x56Dnrdp026278)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

I'm Italian and I work in Italy, I realize that nowadays the regdb entry 
for Italy is as follows:

country IT: DFS-ETSI
     (2402 - 2482 @ 40), (20)
     (5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
     (5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
     (5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
     # 60 GHz band channels 1-4, ref: Etsi En 302 567
     (57000 - 66000 @ 2160), (40)

And it misses the lines:

     # Short Range Devices (SRD) (ETSI EN 300 440)
     (5725 - 5875 @ 80), (25 mW)

Common to may European Countries.

I dug a bit in the current Italian regulation that is online on the 
website of the
Ministry of Economic Development: https://www.mise.gov.it/index.php/en/

In the section about the "National Plan of Frequencies" (only in 
Italian) at the URL:

https://www.mise.gov.it/index.php/it/comunicazioni/radio/pnrf-piano-nazionale-di-ripartizione-delle-frequenze

Two PDF files are linked:

--Tabelle di attribuzione Tabella B (27,50 MHz – 10.000 MHz) (pdf)
https://www.mise.gov.it/images/stories/documenti/Tabella_B_2750_MHz-10000_Mhz.pdf
Which at page 28 allows the use for ISM according to the general 
European legislation: 2006/771/CE ERC/REC 70-03

--Note (esplicative, di carattere tecnico e con attribuzioni in deroga 
al piano) (pdf)
https://www.mise.gov.it/images/stories/documenti/NOTE-pnrf.pdf
Which at page 334, in the paragraph 3.2.3 states in a explicit way the 
permit to operate the in the band 5.725 ÷ 5.875 MHz,
with SRD and max power at 25 mW.

According to this regulation there's no reason not to have the:
  (5725 - 5875 @ 80), (25 mW)
Inserted for Italy in the regdb

Who can do it ?

-- 

Giorgio Bernardi

