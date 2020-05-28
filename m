Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEB1E68D9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405655AbgE1RuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405580AbgE1RuU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 13:50:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44AC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 10:50:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeMfZ-00519C-5Q; Thu, 28 May 2020 19:50:17 +0200
Message-ID: <d8fe8e99def9c17099e98e3d467b259ee4229fcf.camel@sipsolutions.net>
Subject: Re: [PATCH 12/24] mac80211: avoid using ext NSS high BW if not
 supported
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Date:   Thu, 28 May 2020 19:50:15 +0200
In-Reply-To: <20200528165011.0e55d40c3ccc.I6fd0b4708ebd087e5e46466c3e91f6efbcbef668@changeid> (sfid-20200528_165447_100324_6B699F5D)
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
         <20200528165011.0e55d40c3ccc.I6fd0b4708ebd087e5e46466c3e91f6efbcbef668@changeid>
         (sfid-20200528_165447_100324_6B699F5D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> If the AP advertises inconsistent data, namely it has CCFS1 or CCFS2,
> but doesn't advertise support for 160/80+80 bandwidth or "Extended NSS
> BW Support", then we cannot use any MCSes in the the higher bandwidth.
> Thus, avoid connecting with higher bandwidth since it's less efficient
> that way.

So ... this broke the tests :)

But really the code here seems consistent. What was in the tests is that
the AP doesn't actually advertise 160 or 80+80 capability, so need to
fix it like this:

diff --git a/tests/hwsim/test_ap_tdls.py b/tests/hwsim/test_ap_tdls.py
index 05c4ca3e48b1..ea14a08b232f 100644
--- a/tests/hwsim/test_ap_tdls.py
+++ b/tests/hwsim/test_ap_tdls.py
@@ -413,6 +413,7 @@ def test_ap_open_tdls_vht80(dev, apdev):
               "hw_mode": "a",
               "channel": "36",
               "ht_capab": "[HT40+]",
+              "vht_capab": "[VHT160]",
               "ieee80211n": "1",
               "ieee80211ac": "1",
               "vht_capab": "",
@@ -452,7 +453,7 @@ def test_ap_open_tdls_vht80plus80(dev, apdev):
               "ht_capab": "[HT40+]",
               "ieee80211n": "1",
               "ieee80211ac": "1",
-              "vht_capab": "",
+              "vht_capab": "[VHT160-80PLUS80]",
               "vht_oper_chwidth": "3",
               "vht_oper_centr_freq_seg0_idx": "42",
               "vht_oper_centr_freq_seg1_idx": "155"}
@@ -494,6 +495,7 @@ def test_ap_open_tdls_vht160(dev, apdev):
               "hw_mode": "a",
               "channel": "104",
               "ht_capab": "[HT40-]",
+              "vht_capab": "[VHT160]",
               "ieee80211n": "1",
               "ieee80211ac": "1",
               "vht_oper_chwidth": "2",
diff --git a/tests/hwsim/test_ap_vht.py b/tests/hwsim/test_ap_vht.py
index 358e192de64f..2b691ff71025 100644
--- a/tests/hwsim/test_ap_vht.py
+++ b/tests/hwsim/test_ap_vht.py
@@ -361,6 +361,7 @@ def test_ap_vht160(dev, apdev):
                   "hw_mode": "a",
                   "channel": "36",
                   "ht_capab": "[HT40+]",
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "2",
@@ -436,6 +437,7 @@ def test_ap_vht160b(dev, apdev):
                   "hw_mode": "a",
                   "channel": "104",
                   "ht_capab": "[HT40-]",
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "2",
@@ -538,6 +540,7 @@ def run_ap_vht160_no_dfs(dev, apdev, channel, ht_capab):
                   "hw_mode": "a",
                   "channel": channel,
                   "ht_capab": ht_capab,
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "2",
@@ -550,7 +553,7 @@ def run_ap_vht160_no_dfs(dev, apdev, channel, ht_capab):
             cmd = subprocess.Popen(["iw", "reg", "get"], stdout=subprocess.PIPE)
             reg = cmd.stdout.readlines()
             for r in reg:
-                if "5490" in r and "DFS" in r:
+                if b"5490" in r and b"DFS" in r:
                     raise HwsimSkip("ZA regulatory rule did not have DFS requirement removed")
             raise Exception("AP setup timed out")
 
@@ -616,6 +619,7 @@ def test_ap_vht80plus80(dev, apdev):
                   "hw_mode": "a",
                   "channel": "52",
                   "ht_capab": "[HT40+]",
+                  "vht_capab": "[VHT160-80PLUS80]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "3",
@@ -633,6 +637,7 @@ def test_ap_vht80plus80(dev, apdev):
                   "hw_mode": "a",
                   "channel": "36",
                   "ht_capab": "[HT40+]",
+                  "vht_capab": "[VHT160-80PLUS80]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "3",
diff --git a/tests/hwsim/test_he.py b/tests/hwsim/test_he.py
index ce31992905a0..28123e853ca1 100644
--- a/tests/hwsim/test_he.py
+++ b/tests/hwsim/test_he.py
@@ -428,6 +428,7 @@ def test_he160(dev, apdev):
                   "hw_mode": "a",
                   "channel": "36",
                   "ht_capab": "[HT40+]",
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "ieee80211ax": "1",
@@ -500,6 +501,7 @@ def test_he160b(dev, apdev):
                   "hw_mode": "a",
                   "channel": "104",
                   "ht_capab": "[HT40-]",
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "ieee80211ax": "1",
@@ -605,6 +607,7 @@ def run_ap_he160_no_dfs(dev, apdev, channel, ht_capab):
                   "hw_mode": "a",
                   "channel": channel,
                   "ht_capab": ht_capab,
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "ieee80211ax": "1",
@@ -620,7 +623,7 @@ def run_ap_he160_no_dfs(dev, apdev, channel, ht_capab):
             cmd = subprocess.Popen(["iw", "reg", "get"], stdout=subprocess.PIPE)
             reg = cmd.stdout.readlines()
             for r in reg:
-                if "5490" in r and "DFS" in r:
+                if b"5490" in r and b"DFS" in r:
                     raise HwsimSkip("ZA regulatory rule did not have DFS requirement removed")
             raise Exception("AP setup timed out")
 
@@ -689,6 +692,7 @@ def test_he80plus80(dev, apdev):
                   "hw_mode": "a",
                   "channel": "52",
                   "ht_capab": "[HT40+]",
+                  "vht_capab": "[VHT160-80PLUS80]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "ieee80211ax": "1",
@@ -710,6 +714,7 @@ def test_he80plus80(dev, apdev):
                   "hw_mode": "a",
                   "channel": "36",
                   "ht_capab": "[HT40+]",
+                  "vht_capab": "[VHT160-80PLUS80]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "ieee80211ax": "1",
diff --git a/tests/hwsim/test_ocv.py b/tests/hwsim/test_ocv.py
index 1f185d7e906a..69e76762b8d7 100644
--- a/tests/hwsim/test_ocv.py
+++ b/tests/hwsim/test_ocv.py
@@ -259,6 +259,7 @@ def run_wpa2_ocv_vht160(dev, apdev):
                   "channel": channel,
                   "country_code": "ZA",
                   "ht_capab": capab,
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "2",
@@ -301,6 +302,7 @@ def run_wpa2_ocv_vht80plus80(dev, apdev):
                   "channel": channel,
                   "country_code": "US",
                   "ht_capab": capab,
+                  "vht_capab": "[VHT160-80PLUS80]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "3",
diff --git a/tests/hwsim/test_rrm.py b/tests/hwsim/test_rrm.py
index 2b43c4c5914c..b9de82de577b 100644
--- a/tests/hwsim/test_rrm.py
+++ b/tests/hwsim/test_rrm.py
@@ -1729,6 +1729,7 @@ def test_rrm_beacon_req_passive_scan_vht160(dev, apdev):
                   "hw_mode": "a",
                   "channel": "104",
                   "ht_capab": "[HT40-]",
+                  "vht_capab": "[VHT160]",
                   "ieee80211n": "1",
                   "ieee80211ac": "1",
                   "vht_oper_chwidth": "2",

johannes

