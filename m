Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25E57879F1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 23:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbjHXVKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243347AbjHXVKZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 17:10:25 -0400
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 14:10:22 PDT
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A41BC9
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 14:10:22 -0700 (PDT)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id CF6C81E73D
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 23:01:25 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
        id CDCB91EB18; Thu, 24 Aug 2023 23:01:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Score: -1.0
Received: from sara.hytechdrive.se (h-81-170-152-149.A163.priv.bahnhof.se [81.170.152.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id C3DA71E632
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 23:01:24 +0200 (CEST)
Date:   Thu, 24 Aug 2023 23:01:24 +0200 (CEST)
From:   Peter Astrand <astrand@lysator.liu.se>
To:     linux-wireless@vger.kernel.org
Subject: wl18xx: firmware security, very unstable with multiple roles
Message-ID: <c29af1f0-6941-34a-3c52-95ad2e9f7555@lysator.liu.se>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1437493864-787929770-1692700913=:14135"
Content-ID: <1dff26fc-6f1-62c8-8c53-b8f594edffd0@lysator.liu.se>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1437493864-787929770-1692700913=:14135
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <3f957d6e-34f3-c3a4-364c-4ea611d0932e@lysator.liu.se>


Hi. We have been working with the TI WL1807MOD for quite some time now, in 
a custom i.MX6 system. We are using a configuation with both Mesh and 
AP/WiFi roles, based on hostapd and wpa_supplicant 2.10. Mesh size is ~10 
nodes.

Unfortunately, in our experience, the wl18xx (WiLink) solution has 
numerous issues. One major problem is that TI only supports the 4.19.38 
kernel. Although 4.19 is a LTS/SLTS release, 4.19.38 has hundreds of 
vulnerabilites fixed in later 4.19 versions. WiLink also requires a number 
of patches on top of 4.19.38. Many of these are of low quality: Some 
without description, some changing code that was added by earlier patches. 
Most of these have been rejected by the upstream Linux or not submitted 
for inclusion (see 
https://github.com/astrand/wilink8-wlan-build-utilites/wiki) .

For us, 4.19 is too old; we need at least Linux 5.x. This has proved to be 
a major challenge. Currently, we are using 5.10.72, except for adding 
.beacon_int_min_gcd = 1 to the wl18xx_iface_combinations (corresponds to 
TI patch 0018). We have tried 5.4.X kernels we as well, with different 
combinations of TI patches. Unfortunately, the problems are still present:


1)
The firmware policy is problematic, and causes security issues: The kernel 
requires firmware 8.9.x.x.58 or later. The repository and
changelog is incomplete 
(https://git.ti.com/cgit/wilink8-wlan/wl18xx_fw/), but since that 
version there has been several security related bugfixes for the 
firmware. Compatibility between modern kernels and modern firmware 
versions are "unknown". The latest firmware release (which 
includes fragattack fix) does not work at all with upstream kernels due 
to API change, unless 
https://git.ti.com/cgit/wilink8-wlan/build-utilites/tree/patches/kernel_patches/4.19.38/0023-wlcore-Fixing-PN-drift-on-encrypted-link-after-recov.patch?h=r8.8 
is applied. Again, this patch is only provided for 4.19.38, which means 
that many users are more or less excluded from deploying these bug- and 
security fixes provided by the latest firmware. Ideally, I think it 
would be good if the "0023" patch above could be rewritten and applied, 
so that the kernel would support both new and old firmware versions. What 
do you think?


2)
It is very common that communication stops and 
/sys/kernel/debug/ieee80211/phy0/wlcore/tx_queue_len climbs to 100-500. This has been reported on 
https://e2e.ti.com/support/wireless-connectivity/wi-fi-group/wifi/f/wi-fi-forum/957174/wl1835mod-wl1835-firmware-gets-stuck-and-does-not-recover-when-bringing-up-large-mesh-10-peers-within-range/ 
. Unfortunately, the "solution" was to run 4.19.38 with WiLink patches. 
Currently, we are monitoring tx_queue_len and restarting the network 
interfaces if tx_queue_len is too high for too long, but this is error 
prone and causes downtime. 


3)
Warnings such as:
[ 3536.621345] wlcore: WARNING corrupted packet in RX: status: 0x1 len: 88
...are printed "all the time". Is this expected? 


4)
We have suffered from panics of type:
skbuff: skb_under_panic: text:c7703318 len:158 put:16 head:cf7a8af6 data:10cc3c43 tail:0x9c9d269c end:0x9c9d2740 dev:wlan0_mesh

This has been reported here:
https://e2e.ti.com/support/wireless-connectivity/wi-fi-group/wifi/f/wi-fi-forum/1190025/wl1807mod-mesh-and-ap-incompatible-with-5-4-56-and-occasional-skbuff-skb_under_panic

We were able to reproduce this even with 4.19, but TI have not provided 
any fix. In the end, we wrote a patch ourselves to fix this; attached. 
Does this make any sense? If so, we can do a proper submit with 
Signed-off-by etc.


5)
Lost DHCPOFFERs. hostapd+dnsmasq providing AP+DHCP service on top of 
wl18xx. AP system sees DHCPDISCOVER and sends DHCPOFFER, but this offer 
never reaches the client. This has been verified both with a Windows 
laptop as well as another Linux system as client. Thus it seems like 
wl18xx does not transmit properly. This exact problem has been described 
here:

https://e2e.ti.com/support/wireless-connectivity/wi-fi-group/wifi/f/wi-fi-forum/1158120/wl1807mod-dhcp-server-not-working-in-wifi-ap-mode-when-sdio-clock-frequency-is-50mhz/

Here the problem could be solved by using a lower than 50 Mhz SDIO 
frequency. Unfortunately, this does not help on our system. 


6) Occasionally, we get kernel warnings like:
[55467.283136] WARNING: CPU: 0 PID: 6929 at drivers/net/wireless/ti/wlcore/main.c:5244 wlcore_pending_auth_complete_work+0x74/0xe8 [wlcore]



Grateful for any comments. 


Br,
Peter Astrand
---1437493864-787929770-1692700913=:14135
Content-Type: desc=windows/x-unknown; name=skb_push.patch
Content-Transfer-Encoding: BASE64
Content-ID: <12fc364-90ed-5957-9ddd-c346cadfd80@lysator.liu.se>
Content-Description: 
Content-Disposition: attachment; filename=skb_push.patch

ZGlmZiAtTmFydSBvcmcvZHJpdmVycy9uZXQvd2lyZWxlc3MvdGkvd2xjb3Jl
L2NtZC5jIG1vZC9kcml2ZXJzL25ldC93aXJlbGVzcy90aS93bGNvcmUvY21k
LmMKLS0tIG9yZy9kcml2ZXJzL25ldC93aXJlbGVzcy90aS93bGNvcmUvY21k
LmMJMjAyMy0wMi0yMCAwNzo1Mjo0OC4yMzQ5NjY0MzMgKzAxMDAKKysrIG1v
ZC9kcml2ZXJzL25ldC93aXJlbGVzcy90aS93bGNvcmUvY21kLmMJMjAyMy0w
Mi0yMiAxMzozOToyOS4zNDMyOTk2ODQgKzAxMDAKQEAgLTEyNzgsMTUgKzEy
NzgsMjkgQEAKIAl9CiAKIAlpZiAoZXh0cmEpIHsKLQkJdTggKnNwYWNlID0g
c2tiX3B1c2goc2tiLCBleHRyYSk7Ci0JCW1lbXNldChzcGFjZSwgMCwgZXh0
cmEpOworCQlpZiAoc2tiX2hlYWRyb29tKHNrYikgPCBleHRyYSAmJiBwc2ti
X2V4cGFuZF9oZWFkKHNrYiwgZXh0cmEsIDAsIEdGUF9BVE9NSUMpKSB7CisJ
CQl3bDEyNzFfZXJyb3IoInNrYiBwdXNoIGRlYnVnLCB0aS9jbWQjMVxuIik7
CisJCQlyZXQgPSAtRU5PTUVNOworCQkJZ290byBvdXQ7CisJCX0KKwkJbWVt
c2V0KHNrYl9wdXNoKHNrYiwgZXh0cmEpLCAwLCBleHRyYSk7CiAJfQogCiAJ
LyogUW9TIGhlYWRlciAtIEJFICovCi0JaWYgKHdsdmlmLT5zdGEucW9zKQor
CWlmICh3bHZpZi0+c3RhLnFvcykgeworCQlpZiAoc2tiX2hlYWRyb29tKHNr
YikgPCBzaXplb2YoX19sZTE2KSAmJiBwc2tiX2V4cGFuZF9oZWFkKHNrYiwg
c2l6ZW9mKF9fbGUxNiksIDAsIEdGUF9BVE9NSUMpKSB7CisJCQl3bDEyNzFf
ZXJyb3IoInNrYiBwdXNoIGRlYnVnLCB0aS9jbWQjMlxuIik7CisJCQlyZXQg
PSAtRU5PTUVNOworCQkJZ290byBvdXQ7CisJCX0KIAkJbWVtc2V0KHNrYl9w
dXNoKHNrYiwgc2l6ZW9mKF9fbGUxNikpLCAwLCBzaXplb2YoX19sZTE2KSk7
Ci0KKwl9CiAJLyogbWFjODAyMTEgaGVhZGVyICovCisJaWYgKHNrYl9oZWFk
cm9vbShza2IpIDwgc2l6ZW9mKCpoZHIpICYmIHBza2JfZXhwYW5kX2hlYWQo
c2tiLCBzaXplb2YoKmhkciksIDAsIEdGUF9BVE9NSUMpKSB7CisJCXdsMTI3
MV9lcnJvcigic2tiIHB1c2ggZGVidWcsIHRpL2NtZCMzXG4iKTsKKwkJcmV0
ID0gLUVOT01FTTsKKwkJZ290byBvdXQ7CisJfQogCWhkciA9IHNrYl9wdXNo
KHNrYiwgc2l6ZW9mKCpoZHIpKTsKIAltZW1zZXQoaGRyLCAwLCBzaXplb2Yo
KmhkcikpOwogCWZjID0gSUVFRTgwMjExX0ZUWVBFX0RBVEEgfCBJRUVFODAy
MTFfRkNUTF9UT0RTOwpkaWZmIC1OYXJ1IG9yZy9kcml2ZXJzL25ldC93aXJl
bGVzcy90aS93bGNvcmUvdHguYyBtb2QvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
dGkvd2xjb3JlL3R4LmMKLS0tIG9yZy9kcml2ZXJzL25ldC93aXJlbGVzcy90
aS93bGNvcmUvdHguYwkyMDIzLTAyLTIwIDA3OjUyOjQ4LjI1MDk2NjMzNiAr
MDEwMAorKysgbW9kL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3RpL3dsY29yZS90
eC5jCTIwMjMtMDItMjIgMTM6NDA6MzkuNDU0OTc2NTI5ICswMTAwCkBAIC0y
MTAsNiArMjEwLDEzIEBACiAJdG90YWxfYmxvY2tzID0gd2xjb3JlX2h3X2Nh
bGNfdHhfYmxvY2tzKHdsLCB0b3RhbF9sZW4sIHNwYXJlX2Jsb2Nrcyk7CiAK
IAlpZiAodG90YWxfYmxvY2tzIDw9IHdsLT50eF9ibG9ja3NfYXZhaWxhYmxl
KSB7CisJCWlmIChza2JfaGVhZHJvb20oc2tiKSA8ICh0b3RhbF9sZW4gLSBz
a2ItPmxlbikgJiYKKwkJICAgIHBza2JfZXhwYW5kX2hlYWQoc2tiLCAodG90
YWxfbGVuIC0gc2tiLT5sZW4pLCAwLCBHRlBfQVRPTUlDKSkgeworCQkJd2wx
MjcxX2ZyZWVfdHhfaWQod2wsIGlkKTsKKwkJCWRldl9rZnJlZV9za2Ioc2ti
KTsKKwkJCXdsMTI3MV9lcnJvcigic2tiIHB1c2ggZGVidWcsIHRpL3R4XG4i
KTsKKwkJCXJldHVybiAtRU5PTUVNOworCQl9CiAJCWRlc2MgPSBza2JfcHVz
aChza2IsIHRvdGFsX2xlbiAtIHNrYi0+bGVuKTsKIAogCQl3bGNvcmVfaHdf
c2V0X3R4X2Rlc2NfYmxvY2tzKHdsLCBkZXNjLCB0b3RhbF9ibG9ja3MsCg==

---1437493864-787929770-1692700913=:14135--
