Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900B632EE0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFCLld convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 07:41:33 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.210]:51263 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbfFCLld (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 07:41:33 -0400
Received: from [67.219.247.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-d.us-east-1.aws.symcld.net id 88/95-23491-A6705FC5; Mon, 03 Jun 2019 11:41:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRWlGSWpSXmKPExsXi5LtOQDeL/Wu
  MQccWNYuPGz6xWLxZcYfdgcmjv3cbi8fnTXIBTFGsmXlJ+RUJrBnLX8xlKegQqLi4bzJbA+MW
  3i5GLg4hgVWMEntfzmWGcPYwSnz/0MzexcjJwSZgKLF6wREwW0RAV+LipNssIDazgKvEmfuvm
  UFsYYEQiQ/dvcwQNZESM+dvY4Ow9SRWHJwAZrMIqEjsXvuaEcTmFdCU+Pm8iRXEZhSQlXjRPo
  EJYqa4xK0n88FsCQEBiSV7zjND2KISLx//A6rn4BAFmtOzuwgirCAx9SLEGGYBHYkFuz+xQdj
  mElNnr4E6U1ti2UKIM3kFBCVOznwCFhcCGrNtSjfbBEbRWUg2z0IyahaSUbOQjJqFZNQCRtZV
  jOZJRZnpGSW5iZk5uoYGBrqGhkZArGtoYaiXWKWboldarJuaWFyiC+SWF+sVV+Ym56To5aWWb
  GIExl1KAffWHYxTj7zWO8QoycGkJMpb+O5jjBBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3mvMX2
  OEBItS01Mr0jJzgCkAJi3BwaMkwtvGBpTmLS5IzC3OTIdInWI05jiw6OFcZo6HrZ/nMgux5OX
  npUqJ81qBlAqAlGaU5sENgqWmS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeYNYgKbwZOaV
  wO17BXQKE9Ap/rc/gZxSkoiQkmpg2vNTnt/9+ZwtZxN3M4umMjpk3np9T2Dr8dinx+TO6Hgu/
  6GScetpbdx9t2dO+62/ak533V8rYyTuJqFkXGhmZT9RVPnrmV8smUeTt+1dvuG/4L6vSwuXL5
  kezrp7UlTbmj1TJq3OjtitEi8ny7S//tLWdWoZITcYvpzYIdk681fFR92dIVUT3E5ulup62XN
  9o2C1lkOg1vlb7V82308yl+zdfM5f93h9wtzVnYK8PNN1dKZrbT/Ke0B/8pKyj+yvpeRD5OaZ
  XajuL3nT8fgr9/TnKYV3fpTmWCkWv3nceewRc6OiDGfGnccOQt5Va16fNv18Rz10r/W1hr+Xu
  xySTy+ufFV6OPpN2RXPH2wpU5RYijMSDbWYi4oTAanxNpvIAwAA
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-6.tower-425.messagelabs.com!1559562090!397051!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30384 invoked from network); 3 Jun 2019 11:41:30 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-6.tower-425.messagelabs.com with SMTP; 3 Jun 2019 11:41:30 -0000
Received: from MTK-SMS-XCH05.digi.com (10.10.8.199) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 3 Jun 2019
 06:41:30 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH05.digi.com ([fe80::a576:56af:8463:b976%15]) with mapi id
 14.03.0415.000; Mon, 3 Jun 2019 06:41:29 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [PATCH] Revert "cfg80211: fix processing world regdomain when non
 modular"
Thread-Topic: [PATCH] Revert "cfg80211: fix processing world regdomain when
 non modular"
Thread-Index: AQHVGgFI810D8jFG1Uy8KCwn3eEVJw==
Date:   Mon, 3 Jun 2019 11:41:28 +0000
Message-ID: <20190603114127.GA8091@a1-hr>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [188.6.70.133]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <953ACBF925A74E4D8D9662A987F7BE57@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 96cce12ff6e0bc9d9fcb2235e08b7fc150f96fd2.

Re-triggering a reg_process_hint with the last request on all events,
can make the regulatory domain fail in case of multiple WiFi modules. On
slower boards (espacially with mdev), enumeration of the WiFi modules
can end up in an intersected regulatory domain, and user cannot set it
with 'iw reg set' anymore.

This is happening, because:
- 1st module enumerates, queues up a regulatory request
- request gets processed by __reg_process_hint_driver():
  - checks if previous was set by CORE -> yes
    - checks if regulator domain changed -> yes, from '00' to e.g. 'US'
      -> sends request to the 'crda'
- 2nd module enumerates, queues up a regulator request (which triggers
the reg_todo() work)
- reg_todo() -> reg_process_pending_hints() sees, that the last request
is not processed yet, so it tries to process it again.
__reg_process_hint driver() will run again, and:
  - checks if the last request's initiator was the core -> no, it was
the driver (1st WiFi module)
  - checks, if the previous initiator was the driver -> yes
    - checks if the regulator domain changed -> yes, it was '00' (set by
core, and crda call did not return yet), and should be changed to 'US'

------> __reg_process_hint_driver calls an intersect

Besides, the reg_process_hint call with the last request is meaningless
since the crda call has a timeout work. If that timeout expires, the
first module's request will lost.

Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
 net/wireless/reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4831ad745f91..b00ebf6fc696 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2788,7 +2788,7 @@ static void reg_process_pending_hints(void)
 
 	/* When last_request->processed becomes true this will be rescheduled */
 	if (lr && !lr->processed) {
-		reg_process_hint(lr);
+		REG_DBG_PRINT("Pending regulatory request, waiting for it to be processed...\n");
 		return;
 	}
 
