Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3B6D5FFE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbjDDMTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjDDMTH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 08:19:07 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680535B7
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 05:12:16 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id C40C42003D0;
        Tue,  4 Apr 2023 14:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1680610334;
        bh=7NWpOcn9QiBYFAagmNHTHI3hrTpfUbxNfFKSXybAGKA=;
        h=Date:To:Cc:From:Subject:From;
        b=tucR3J1sTqYINMTMLHfxpVQMZW358JEj5hBB34eCBBfAdkO9AMckqAEqRdEOWlq1h
         dU7S+dPjh7zZhE0Ej3HhoNILGdLBjGe0MD0paLKYICOCG/vdbEjTs0L+qqURokI4gK
         0bS9NZ53a/rfG0wGlBgeixgv1hcBUVIOZfA2Qf4qFqobFjSub2wPkFXHpbk6ikE9Gt
         ilEIfKBjfxFpokjCb5inKNYCsgKkMM7QagF/ydfjoLNOqZYdWG62KMIYidG1D9ezfR
         Ou7zzNJPZTI1fzQa+454hGR5XaF74eKIbEhSuKU9XHdQO3keZPqZfGkxipnCNeRfFg
         Y9lBqiK8SHBgg==
Content-Type: multipart/mixed; boundary="------------7IJeKyn22GBfuRO5zvlut95s"
Message-ID: <cbbd4a70-850d-cd1e-9809-1d115378fe09@free.fr>
Date:   Tue, 4 Apr 2023 14:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     linux-amlogic@lists.infradead.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Arnaud Vrac <avrac@freebox.fr>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Throughput & CPU usage of WiFi download
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NUMERIC_HTTP_ADDR,
        SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------7IJeKyn22GBfuRO5zvlut95s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

I've been benchmarking various aspects of an SEI530 board,
and wanted to share some of the results with the list.

The main objective was to compare WiFi download performance
on mainline/BR2 and vendor/android systems.

(Mainline system was generated using pop-br2-ext-tree.zip.
brcmfmac4359-sdio.* left out for size.)


HW spec
Board: SEI530 (SEI510 variant)
SoC: S905X2
WiFi: AP6398SR3-J (SDIO BCM4359/9)

Test setup
WiFi AP using 5Ghz channels 120 (primary) + 116 (secondary)
BENCHMARK = "curl --silent -o /dev/null http://192.168.1.254:8095/fixed/10G"
Kernel booted with
1) performance governor (no DVFS)
2) nohlt (keep counting cycles in idle)


(Full results at the end)

Observations:
- vendor system manages 245 Mbps, using 40% CPU
- mainline system manages 60 Mbps, using 10% CPU
- vendor system limited to 62 Mbps, uses 9% CPU

1) Neil Armstrong mentioned that vendor kernel reaches
higher throughput by playing tricks with some pads?
(Not sure I understood that well, haven't looked at the code)

2) SDIO is clocked higher on vendor system, but could
lead to instabilities on some boards?

Interesting possible followups
- try clocking SDIO higher on mainline system
- measure CPU usage at 120 Mbps, does it scale linearly to 20%?
- android curl seems to use smaller buffers?


TEST RESULTS

-- mainline/BR2 (v6.2)

time perf record -a -F 1009 $BENCHMARK
perf report -s pid -n --header

10_GB in 1338.127552_s = 59.8_Mbps

# Overhead       Samples      Pid:Command
  90.0445%       4863024        0:swapper = IDLE
   7.2362%        390807       56:irq/17-ffe03000
   1.9282%        104136       59:kworker/u9:0-br
   0.6965%         37616      142:curl
   0.0722%          3897      114:ksdioirqd/mmc2
   0.0168%           908      141:perf


-- vendor/android (4.9.180 + vendor patches)

time simpleperf record -a -f 1009 $BENCHMARK
simpleperf report --sort pid,comm

10_GB in 326.54_s = 245_Mbps

Overhead  Sample  Pid    Command
59.43%    680339  0      swapper = IDLE
12.59%    156593  15378  curl
11.42%    136024  4392   dhd_rxf
7.57%     88047   4391   dhd_dpc
2.52%     29977   2094   irq/51-meson-am
1.38%     16467   10541  system_server
0.75%     10394   17     ksoftirqd/1
0.73%     9282    15377  simpleperf
0.60%     9226    6      ksoftirqd/0
0.38%     4701    14865  kworker/0:0
0.14%     2055    29     ksoftirqd/3
0.13%     1636    3411   HwBinder:3411_1
0.13%     1760    23     ksoftirqd/2
0.12%     1484    10782  dmx_data_thread
0.12%     1469    3381   composer@2.3-se
0.10%     1329    15425  Jit thread pool


Same benchmark, rate limited to 8 MB/s
time simpleperf record -a -f 1009 $BENCHMARK --limit-rate 8M
simpleperf report --sort pid,comm

10_GB in 1290.22_s = 62 Mbps

Overhead  Sample   Pid    Command
91.68%    3687632  0      swapper = IDLE
2.67%     107057   4392   dhd_rxf
1.90%     74721    4391   dhd_dpc
1.00%     41650    22975  curl
0.70%     29239    10541  system_server
0.68%     27406    2094   irq/51-meson-am
0.58%     24781    22974  simpleperf
0.10%     4222     17     ksoftirqd/1
0.10%     4070     10782  dmx_data_thread
--------------7IJeKyn22GBfuRO5zvlut95s
Content-Type: application/zip; name="pop-br2-ext-tree.zip"
Content-Disposition: attachment; filename="pop-br2-ext-tree.zip"
Content-Transfer-Encoding: base64

UEsDBAoAAAAAAElqhFYAAAAAAAAAAAAAAAARABwAcG9wLWJyMi1leHQtdHJlZS9VVAkAA3kH
LGSFByxkdXgLAAEE6AMAAAToAwAAUEsDBAoAAAAAAHeSfVagZVl7CgAAAAoAAAAeABwAcG9w
LWJyMi1leHQtdHJlZS9leHRlcm5hbC5kZXNjVVQJAAMhZSRkOsUqZHV4CwABBOgDAAAE6AMA
AG5hbWU6IFBPUApQSwMEFAAAAAgA4YuDVofuoBitAAAA8AAAACAAHABwb3AtYnIyLWV4dC10
cmVlL21ha2Vfa2VybmVsLmltZ1VUCQADNfEqZGYHLGR1eAsAAQToAwAABOgDAABVjT0LwjAU
Rff8iie6JmkjLoKDopuIiKCbJM1rGpqPYl7/v9VBdLncC+dw5zNpfJKlY84TNCEnhKmtpZxS
mNEH+8yZREKS3wXcgKrUUlQKOLc4UAc1ayx8CRZ1j7C7qMfhfj1cTtvjZnG+7aUQMOThYbFt
cmq9Y+QjwgfWIbA5tLqQeV+0QZcOLBnIIw0jSR+1wyIjlpy4q5XmBf2qrsTE/Iqf+Hd6fCYM
wkfHXlBLAwQUAAAACABgf35WqaLUCW8AAAClAAAAHgAcAHBvcC1icjItZXh0LXRyZWUvcG9z
dC1pbWFnZS5zaFVUCQADo5UlZHLFKmR1eAsAAQToAwAABOgDAABTVtRPyszTL87gSkzKzy/J
zE1X0NVNLkpNLElVUHHy9HMM8nQNjnfxDNLPTi3KS83RA6mI4VJQ0E0DygcZxbtGhLgG+Tn6
xAf4B8QHOIZ46EPN0UtOg6oswqUypTQ3txJhYjaajZ65iempeulVXABQSwMECgAAAAAA4G1+
VpMG1zIBAAAAAQAAABoAHABwb3AtYnIyLWV4dC10cmVlL2R1bW15LmltZ1VUCQADtHYlZHLF
KmR1eAsAAQToAwAABOgDAAAKUEsDBBQAAAAIAMFzflbB7TscHgAAACgAAAAcABwAcG9wLWJy
Mi1leHQtdHJlZS9ib290aW1nLmNmZ1VUCQADyYAlZHLFKmR1eAsAAQToAwAABOgDAADLTi3K
S81JTEkpUrBVMKgwNDIAAa6SxPRihCBQAABQSwMECgAAAAAAfZJ9VgAAAAAAAAAAAAAAABoA
HABwb3AtYnIyLWV4dC10cmVlL0NvbmZpZy5pblVUCQADLmUkZFcHLGR1eAsAAQToAwAABOgD
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
uQ/kIFX6GnXK4KdY9WXxFBJS4qA0fJF2PmcTfhZho4DNY6w2PFvLY4f9qu9RLPDpqnKqbotC
1C6NyzcUjXA3laY6Omm2qHYK9z+wqHLy3qCoardvYMncKMXEaQNjWXELaYyP2wU162vfv1ia
Zb2uOX8TNmco/IjishEqzJUkl37uf1BLAwQKAAAAAAAFeH5WAAAAAAAAAAAAAAAAGAAcAHBv
cC1icjItZXh0LXRyZWUvdGFyZ2V0L1VUCQAD2YclZFnFKmR1eAsAAQToAwAABOgDAABQSwME
CgAAAAAAzHV+VgAAAAAAAAAAAAAAABwAHABwb3AtYnIyLWV4dC10cmVlL3RhcmdldC9saWIv
VVQJAAOghCVkWcUqZHV4CwABBOgDAAAE6AMAAFBLAwQKAAAAAADMdX5WAAAAAAAAAAAAAAAA
JQAcAHBvcC1icjItZXh0LXRyZWUvdGFyZ2V0L2xpYi9maXJtd2FyZS9VVAkAA6CEJWRZxSpk
dXgLAAEE6AMAAAToAwAAUEsDBAoAAAAAAI1uhFYAAAAAAAAAAAAAAAAqABwAcG9wLWJyMi1l
eHQtdHJlZS90YXJnZXQvbGliL2Zpcm13YXJlL2JyY20vVVQJAAN6Dyxkew8sZHV4CwABBOgD
AAAE6AMAAFBLAwQKAAAAAACNboRWAAAAAAAAAAAAAAAAPwAcAHBvcC1icjItZXh0LXRyZWUv
dGFyZ2V0L2xpYi9maXJtd2FyZS9icmNtL2JyY21mbWFjNDM1OS1zZGlvLnR4dFVUCQADeg8s
ZHoPLGR1eAsAAQToAwAABOgDAABQSwMECgAAAAAAImuEVgAAAAAAAAAAAAAAAD8AHABwb3At
YnIyLWV4dC10cmVlL3RhcmdldC9saWIvZmlybXdhcmUvYnJjbS9icmNtZm1hYzQzNTktc2Rp
by5iaW5VVAkAAw8JLGQsCSxkdXgLAAEE6AMAAAToAwAAUEsDBAoAAAAAAEhuhFYAAAAAAAAA
AAAAAAAdABwAcG9wLWJyMi1leHQtdHJlZS90YXJnZXQvcm9vdC9VVAkAA/cOLGQFDyxkdXgL
AAEE6AMAAAToAwAAUEsDBAoAAAAAAEhuhFZuHcFxMAAAADAAAAAlABwAcG9wLWJyMi1leHQt
dHJlZS90YXJnZXQvcm9vdC93cGEuY29uZlVUCQAD9w4sZAUPLGR1eAsAAQToAwAABOgDAABj
b3VudHJ5PUZSCm5ldHdvcms9ewoJc3NpZD0ibWFyYzUiCglwc2s9ImZvbyIKfQpQSwMEFAAA
AAgASlp1Vr/dHQU1AAAAOgAAACQAHABwb3AtYnIyLWV4dC10cmVlL3RhcmdldC9yb290L3dp
Zmkuc2hVVAkAA2uEGWRZxSpkdXgLAAEE6AMAAAToAwAAKy9IjC8uLSjIyUxOzCtR0M1UKM9J
zDNQ0E1WKC9I1EvOz0tT0HVSUFNTKE3JSC5IhqvgAgBQSwECHgMKAAAAAABJaoRWAAAAAAAA
AAAAAAAAEQAYAAAAAAAAABAA/UEAAAAAcG9wLWJyMi1leHQtdHJlZS9VVAUAA3kHLGR1eAsA
AQToAwAABOgDAABQSwECHgMKAAAAAAB3kn1WoGVZewoAAAAKAAAAHgAYAAAAAAABAAAAtIFL
AAAAcG9wLWJyMi1leHQtdHJlZS9leHRlcm5hbC5kZXNjVVQFAAMhZSRkdXgLAAEE6AMAAATo
AwAAUEsBAh4DFAAAAAgA4YuDVofuoBitAAAA8AAAACAAGAAAAAAAAQAAAMCBrQAAAHBvcC1i
cjItZXh0LXRyZWUvbWFrZV9rZXJuZWwuaW1nVVQFAAM18SpkdXgLAAEE6AMAAAToAwAAUEsB
Ah4DFAAAAAgAYH9+Vqmi1AlvAAAApQAAAB4AGAAAAAAAAQAAAMCBtAEAAHBvcC1icjItZXh0
LXRyZWUvcG9zdC1pbWFnZS5zaFVUBQADo5UlZHV4CwABBOgDAAAE6AMAAFBLAQIeAwoAAAAA
AOBtflaTBtcyAQAAAAEAAAAaABgAAAAAAAEAAAC0gXsCAABwb3AtYnIyLWV4dC10cmVlL2R1
bW15LmltZ1VUBQADtHYlZHV4CwABBOgDAAAE6AMAAFBLAQIeAxQAAAAIAMFzflbB7TscHgAA
ACgAAAAcABgAAAAAAAEAAAC0gdACAABwb3AtYnIyLWV4dC10cmVlL2Jvb3RpbWcuY2ZnVVQF
AAPJgCVkdXgLAAEE6AMAAAToAwAAUEsBAh4DCgAAAAAAfZJ9VgAAAAAAAAAAAAAAABoAGAAA
AAAAAAAAALSBRAMAAHBvcC1icjItZXh0LXRyZWUvQ29uZmlnLmluVVQFAAMuZSRkdXgLAAEE
6AMAAAToAwAAUEsBAh4DCgAAAAAA4YF+VgAAAAAAAAAAAAAAABkAGAAAAAAAAAAQAP1BmAMA
AHBvcC1icjItZXh0LXRyZWUvY29uZmlncy9VVAUAA2WZJWR1eAsAAQToAwAABOgDAABQSwEC
HgMUAAAACABvf35WWYwo4E4BAADvAgAAJgAYAAAAAAABAAAApIHrAwAAcG9wLWJyMi1leHQt
dHJlZS9jb25maWdzL3BvcF9kZWZjb25maWdVVAUAA8KVJWR1eAsAAQToAwAABOgDAABQSwEC
HgMKAAAAAADaVX5WAAAAAAAAAAAAAAAAGQAYAAAAAAAAABAA/UGZBQAAcG9wLWJyMi1leHQt
dHJlZS9wYXRjaGVzL1VUBQADfEwlZHV4CwABBOgDAAAE6AMAAFBLAQIeAwoAAAAAAOpVflYA
AAAAAAAAAAAAAAAfABgAAAAAAAAAEAD9QewFAABwb3AtYnIyLWV4dC10cmVlL3BhdGNoZXMv
bGludXgvVVQFAAOXTCVkdXgLAAEE6AMAAAToAwAAUEsBAh4DFAAAAAgA6lV+VqNs3Cm5AgAA
kgYAADcAGAAAAAAAAQAAALSBRQYAAHBvcC1icjItZXh0LXRyZWUvcGF0Y2hlcy9saW51eC9k
ZXZpY2UtdHJlZS1maXh1cHMucGF0Y2hVVAUAA5dMJWR1eAsAAQToAwAABOgDAABQSwECHgMK
AAAAAACDkn1WAAAAAAAAAAAAAAAAHAAYAAAAAAAAAAAAtIFvCQAAcG9wLWJyMi1leHQtdHJl
ZS9leHRlcm5hbC5ta1VUBQADNWUkZHV4CwABBOgDAAAE6AMAAFBLAQIeAxQAAAAIAHdsflYT
2UaDvQQAAOMOAAAeABgAAAAAAAEAAAC0gcUJAABwb3AtYnIyLWV4dC10cmVlL2tlcm5lbC5j
b25maWdVVAUAAxJ0JWR1eAsAAQToAwAABOgDAABQSwECHgMKAAAAAAAFeH5WAAAAAAAAAAAA
AAAAGAAYAAAAAAAAABAA/UHaDgAAcG9wLWJyMi1leHQtdHJlZS90YXJnZXQvVVQFAAPZhyVk
dXgLAAEE6AMAAAToAwAAUEsBAh4DCgAAAAAAzHV+VgAAAAAAAAAAAAAAABwAGAAAAAAAAAAQ
AP1BLA8AAHBvcC1icjItZXh0LXRyZWUvdGFyZ2V0L2xpYi9VVAUAA6CEJWR1eAsAAQToAwAA
BOgDAABQSwECHgMKAAAAAADMdX5WAAAAAAAAAAAAAAAAJQAYAAAAAAAAABAA/UGCDwAAcG9w
LWJyMi1leHQtdHJlZS90YXJnZXQvbGliL2Zpcm13YXJlL1VUBQADoIQlZHV4CwABBOgDAAAE
6AMAAFBLAQIeAwoAAAAAAI1uhFYAAAAAAAAAAAAAAAAqABgAAAAAAAAAEAD9QeEPAABwb3At
YnIyLWV4dC10cmVlL3RhcmdldC9saWIvZmlybXdhcmUvYnJjbS9VVAUAA3oPLGR1eAsAAQTo
AwAABOgDAABQSwECHgMKAAAAAACNboRWAAAAAAAAAAAAAAAAPwAYAAAAAAAAAAAAtIFFEAAA
cG9wLWJyMi1leHQtdHJlZS90YXJnZXQvbGliL2Zpcm13YXJlL2JyY20vYnJjbWZtYWM0MzU5
LXNkaW8udHh0VVQFAAN6DyxkdXgLAAEE6AMAAAToAwAAUEsBAh4DCgAAAAAAImuEVgAAAAAA
AAAAAAAAAD8AGAAAAAAAAAAAALSBvhAAAHBvcC1icjItZXh0LXRyZWUvdGFyZ2V0L2xpYi9m
aXJtd2FyZS9icmNtL2JyY21mbWFjNDM1OS1zZGlvLmJpblVUBQADDwksZHV4CwABBOgDAAAE
6AMAAFBLAQIeAwoAAAAAAEhuhFYAAAAAAAAAAAAAAAAdABgAAAAAAAAAEAD9QTcRAABwb3At
YnIyLWV4dC10cmVlL3RhcmdldC9yb290L1VUBQAD9w4sZHV4CwABBOgDAAAE6AMAAFBLAQIe
AwoAAAAAAEhuhFZuHcFxMAAAADAAAAAlABgAAAAAAAEAAAC0gY4RAABwb3AtYnIyLWV4dC10
cmVlL3RhcmdldC9yb290L3dwYS5jb25mVVQFAAP3DixkdXgLAAEE6AMAAAToAwAAUEsBAh4D
FAAAAAgASlp1Vr/dHQU1AAAAOgAAACQAGAAAAAAAAQAAAMCBHRIAAHBvcC1icjItZXh0LXRy
ZWUvdGFyZ2V0L3Jvb3Qvd2lmaS5zaFVUBQADa4QZZHV4CwABBOgDAAAE6AMAAFBLBQYAAAAA
FwAXAFYJAACwEgAAAAA=

--------------7IJeKyn22GBfuRO5zvlut95s--
