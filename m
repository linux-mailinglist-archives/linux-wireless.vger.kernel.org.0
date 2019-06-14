Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2782245DE4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfFNNQG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 09:16:06 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:41983 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727918AbfFNNQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 09:16:05 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-west-2.aws.symcld.net id AC/D3-08344-31E930D5; Fri, 14 Jun 2019 13:16:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRWlGSWpSXmKPExsXi5LtOQFd4HnO
  swboXPBYfN3xisXiz4g67A5NHf+82Fo/Pm+QCmKJYM/OS8isSWDNOLzrDWNAsUHH5zSqWBsb1
  vF2MnBxCAqsZJVbMEe5i5AKy9zJK3Ll1gx0kwSZgKLF6wREwW0RAV+LipNssIDazgKvEmfuvm
  UFsYYFwifVLz0LVxEicuvaABcLWk5j6/iaYzSKgKrF01SE2EJtXQEvi89XdYPWMArISL9onME
  HMFJe49WQ+mC0hICCxZM95ZghbVOLl43+sXYwcHKICKhI9u4sgwgoSfZ3dzBCtOhILdn9ig7D
  NJc582gZ1prbEsoUQZ/IKCEqcnPmEBeJfFYltU7rZJjCKzkKyeRaSUbOQjJqFZNQsJKMWMLKu
  YjRPKspMzyjJTczM0TU0MNA1NDTSNTQ21zU100us0k3WKy3WLU8tLtE10kssL9YrrsxNzknRy
  0st2cQIjLqUgk6LHYzHjrzWO8QoycGkJMrrXMIcK8SXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC9+
  AcoJxgUWp6akVaZg4wAcCkJTh4lER4H80GSvMWFyTmFmemQ6ROMRpzTHg5dxEzx9rtSxYxC7H
  k5eelSonz2oNMEgApzSjNgxsES0yXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzSoBM4cnM
  K4Hb9wroFCagU2ZtYAI5pSQRISXVwLRp/ZSZmneeC9Yd0haaKX758CPllbPzNpdkr+RbZHY8L
  ajWwmPBTLnvP75s4ZAvc10aZ9l9oHfC3b9190OyEzMW+PJEidXPTCnfckt7qcWU9HcMwqtYQo
  8X1AjxfF/+t4RZc9GJbXVHReqqThw55+7mrZCjnNacFdmw/k7L8ZuBR1SyLedMPRYQOvvOHI3
  6vwt43n93nZS6QmIVN/MGvQkZssoT/OYt/srindC1LdP/m9NNv+YzTpbyLIVSF1pWrFb8eGTW
  9lSP3zqhlquumqyOuHCl5MbLA79k7Z6fPBWtInvv9Yu1fY6pdpbWQnkFP4V9bu6bJfPzpt+d/
  0WyxZyaf5Wn5V7hfccmFabJV6/EUpyRaKjFXFScCAC/235+xwMAAA==
X-Env-Sender: Robert.Hodaszi@digi.com
X-Msg-Ref: server-8.tower-365.messagelabs.com!1560518161!3714100!2
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27013 invoked from network); 14 Jun 2019 13:16:03 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-8.tower-365.messagelabs.com with SMTP; 14 Jun 2019 13:16:03 -0000
Received: from MTK-SMS-XCH01.digi.com (10.10.8.195) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 14 Jun 2019
 08:16:01 -0500
Received: from MTK-SMS-XCH02.digi.com ([fe80::4960:cfbf:ad5e:3cdb]) by
 MTK-SMS-XCH01.digi.com ([fe80::cca7:5299:c88e:1c40%20]) with mapi id
 14.03.0439.000; Fri, 14 Jun 2019 08:16:01 -0500
From:   "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] Revert "cfg80211: fix processing world regdomain when
 non modular"
Thread-Topic: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
Thread-Index: AQHVIrNP/gN6lxCOEkmu6xBChwu2Hg==
Date:   Fri, 14 Jun 2019 13:16:01 +0000
Message-ID: <20190614131600.GA13897@a1-hr>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [172.27.2.101]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AAC65845643F6E4DAA77C2DEC81C223B@digi.com>
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
index 4831ad745f91..327479ce69f5 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2788,7 +2788,7 @@ static void reg_process_pending_hints(void)
 
 	/* When last_request->processed becomes true this will be rescheduled */
 	if (lr && !lr->processed) {
-		reg_process_hint(lr);
+		pr_debug("Pending regulatory request, waiting for it to be processed...\n");
 		return;
 	}
 
