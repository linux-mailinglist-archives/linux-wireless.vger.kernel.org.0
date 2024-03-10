Return-Path: <linux-wireless+bounces-4528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E24877882
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 21:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A1B207E7
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Mar 2024 20:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF8374C2;
	Sun, 10 Mar 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMd349Is"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475061E891
	for <linux-wireless@vger.kernel.org>; Sun, 10 Mar 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710103191; cv=none; b=gOgXEL1qpsvpRecQcaR3oyIVBE/E1uyurLoG/RUGpac/F4yC7/P6oNw+KuKcSWnIIF/csGq82EgpnLiKMgHrnm+L3Fo3dqwxUiiFmHJ8j6CiiXyf6Qr8aPDTAcWxihY4wlJIqvI/+DSmCVbnETrhK31+qov2GDqAL2B/L0Ao1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710103191; c=relaxed/simple;
	bh=bE57uGoKTgZbl7o+rf+80AoPaI7SeYVO/RrWb1NXJRQ=;
	h=Message-ID:From:Date:To:Subject; b=RQaAj6/t2RxA84G23SSuaWo6mITRAYNomI/8dQye8Hg+QeD6vx9Pv+harO2a1FEqJc9eKowN3MXxYop+1AZCK4Rx2Gp3cWcL2KgleSm0srhoV44Bt9+FLA5URIs3oBMyEF8VdRUwMjle1tC4Bnsh2++ZHpn/PDVCKm2IJCS+Ivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMd349Is; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d2fad80eacso28704521fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Mar 2024 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710103182; x=1710707982; darn=vger.kernel.org;
        h=subject:to:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T5+XTDWR7JP5kJJ79z/e1+id3ujhi50TzIW4neUB28=;
        b=LMd349Is8FvGuBwEs+Ig+6960VonTfc8YacG9lzdvhVyri1KraaTpIZlXkV4JL2jag
         ifF5RudyN3IsQBVvdImo7Z/aAP9Harw02VGVtsY4FL63IYFAEaNQBENAOUZyDOg+OQpu
         bmo867vQTtU6dL2xyHF3C1jVQ5pN0UbKFvl8h13vKE2IQ1oM6gIasWAd0vLCLxWkTjSE
         2EU0FkKrMu3CqRJ4xpsKwdOJaFns3HKBJhhQgkGkBLUbW+9IHaV2nvhfvS0+rOBomSNF
         wbYIM4rnY7rBxzOL1lX0fkH7xksSQ6wBLNGxYiqAsVg3Esfz9vfwFevHvKu3BzgZ9339
         euig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710103182; x=1710707982;
        h=subject:to:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7T5+XTDWR7JP5kJJ79z/e1+id3ujhi50TzIW4neUB28=;
        b=QQKDSiJbspGTgS/zUglU9NgP3GObhAH/MrpyZct70oMIf5vqD8YBB3YzWLDW+B4fNw
         jKmjGswKWxyBXn63OZM1N06grehv4SD3FyuQ4aDKa9d3HdaTchrnMyD1HDaLm6zIqJ+4
         o7FEsT49ebm9ed44RicU/SBcV4/Y55tfTnqZB5tRDbQOsTPWyovVYkAVs4SmKEa6bAsr
         S6fYLs/4PJTRHjNYw7+JsbSKPuIivbC7ZuSjxqICUrj7f9+FLs6MIslmiCcqpg/o5h+e
         PVhgYJKQJJixWgGgvZt0/6vwxNiLmBD85IllYw12wYjmfSxGFUIz1UZCydvtRHsltssP
         QYHA==
X-Forwarded-Encrypted: i=1; AJvYcCXhTjVl8QCFZYpTUFEBGoHzN+wJSre+qI24atHuFGRXWAMJ5slduvBhCbYKikQ9qw+ScCljsfUbclEOvG5ppgvMQAtcpSXbE9ZQKycoCNo=
X-Gm-Message-State: AOJu0YxqILwhdMMgfqvYdibOt7Qx8PHXA+ojz5HpH35vBOfkqxUuw8Zh
	x3pLIjRkcGs9R6l730vpbW6iaPBe+XQcLYcyjGgAJtIWVbJj3qmG
X-Google-Smtp-Source: AGHT+IFXyj0EUmH//EsZKNhUhoSxZ+2nMLYAIUkKoTcURmHmI9BsFDa2Kwakth8DcJHJd6SSPyF1dw==
X-Received: by 2002:a05:6512:987:b0:513:2f96:72b5 with SMTP id w7-20020a056512098700b005132f9672b5mr2668180lft.33.1710103181362;
        Sun, 10 Mar 2024 13:39:41 -0700 (PDT)
Received: from localhost (nat-inorg.chem.msu.ru. [93.180.12.29])
        by smtp.gmail.com with ESMTPSA id p24-20020a19f018000000b005133cf64ee0sm778065lfc.142.2024.03.10.13.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:39:40 -0700 (PDT)
Message-ID: <a309ab9f291445a2a6682d1062f6cb19.legale.legale@gmail.com>
From: Isaev Ruslan <legale.legale@gmail.com>
Date: Sun, 10 Mar 2024 04:21:20 +0300
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Subject: [PATCH v11] Add JSON output options to 'iw' for scan results
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

branch: master

v11 changes:
- patch rebased to master branch
- iw_json_print.c: iw_printf() add double int format "%d.%d", "%i.%i" to parse as number
- scan.c: add json output for print_interworking(), print_11u_advert(), print_11u_rcon()

v10 changes:
- revert printable text for `iw <dev> scan` to original
- add iw_json_format_key() for json output. It will replace commas with
spaces, convert text to lowercase, remove multiple spaces, replace spaces
with _

Examples:
text output:
root@ru-fap650-a3:/tmp# ./iw phy0-ap0 scan | head -n250
00:0c:43:26:60:18:
        Ifname: phy0-ap0
        Status:
        TSF:
                usec: 321559832898
                dd: 3
                hh: 17
                mm: 19
                ss: 19
        Frequency: 5180
        Beacon Interval, TUs: 100
        Capability:
                ESS
                Privacy
                ShortPreamble
        Capability Raw Value: 0x0031
        Signal: -72.00 dBm
        Last Seen Ago, ms: 2740
        BSS Probe Response Data Frame:
                SSID:
                        SSID: tobe52
                Supported rates:
                        Rates:
                                6.0*
                                9.0
                                12.0*
                                18.0
                                24.0*
                                36.0
                                48.0
                                54.0
                DS Parameter set:
                        Channel: 36
                HT capabilities:
                        capabilities_value: 0x9ee
                        capabilities:
                                HT20/HT40
                                SM Power Save disabled
                                RX HT20 SGI
                                RX HT40 SGI
                                TX STBC
                                RX STBC 1-stream
                                Max AMSDU length: 7935 bytes
                                No DSSS/CCK HT40
                        max_ampdu_length: 65535
                        max_ampdu_exponent: 0x003
                        min_rx_ampdu_time_spacing: 4 usec
                        min_rx_ampdu_time_spacing_value: 0x005
                        ht_rx_mcs_idx_supported:
                                0-32
                HT operation:
                        Primary Channel: 36
                        Secondary Channel Offset: above
                        STA Channel Width: any
                        RIFS: 0
                        HT Protection: no
                        Non-GF Present: 0
                        OBSS Non-GF Present: 0
                        Dual Beacon: 0
                        Dual CTS Protection: 0
                        STBC Beacon: 0
                        L-SIG TXOP Protection: 0
                        PCO Active: 0
                        PCO Phase: 0
                RSN:
                        version: 1
                        group_cipher_data:
                                CCMP
                        Pairwise Ciphers Data:
                                CCMP
                        Authentication Suites Data:
                                PSK
                        Capabilities Raw Value: 0x0000
                        Capabilities:
                                1-PTKSA-RC
                                1-GTKSA-RC
                Extended capabilities:
                        Capabilities:
                                BSS Transition
                                Operating Mode Notification
                        Max Number Of MSSDUs In A-MSDU: -1
                BSS Load:
                        Station Count: 0
                        Channel Utilisation: 0
                        Available Admission Capacity: 31250
                WMM:
                        Version: 1
                        BE:
                                CW: 15-1023
                                AIFSN: 3
                        BK:
                                CW: 15-1023
                                AIFSN: 7
                        VI:
                                CW: 7-15
                                AIFSN: 2
                                TXOP_usec: 3008
                        VO:
                                CW: 3-7
                                AIFSN: 2
                                TXOP_usec: 1504
                Country:
                        Country: DB
                        Environment: Indoor/Outdoor
                        Channels:
                                36:
                                        First: 36
                                        End: 64
                                        Max power, dBm: 20
                                100:
                                        First: 100
                                        End: 140
                                        Max power, dBm: 20
                                149:
                                        First: 149
                                        End: 165
                                        Max power, dBm: 20
                VHT capabilities:
                        VHT Capabilities:
                                VHT Capabilities Raw Value: 0x33c379b1
                                Data: 7991
                        Supported Channel Width:
                        RX LDPC: true
                        short GI (80 MHz): true
                        TX STBC: true
                        SU Beamformer: true
                        SU Beamformee: true
                        +HTC-VHT: true
                        RX antenna pattern consistency: true
                        TX antenna pattern consistency: true
                        VHT RX MCS set:
                                1 streams: MCS 0-9
                                2 streams: MCS 0-9
                                3 streams: MCS 0-9
                                4 streams: MCS 0-9
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        VHT RX highest supported Mbps: 1560
                        VHT TX MCS set:
                                1 streams: MCS 0-9
                                2 streams: MCS 0-9
                                3 streams: MCS 0-9
                                4 streams: MCS 0-9
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        VHT TX Highest Supported Mbps: 1560
                        VHT extended NSS Supported: (null)
                VHT operation:
                        Channel Width: 1 (80 MHz)
                        Center Freq Segment 1: 42
                        Center freq Segment 2: 0
                        VHT Basic MCS Set: 0xffaa

tail part trimmed

Same with pretty json:
root@ru-fap650-a3:/tmp# ./iw -jj phy0-ap0 scan | head -n250
{
    "00:0c:43:26:60:18": {
        "ifname": "phy0-ap0",
        "status": "",
        "tsf": {
            "usec": 321643188840,
            "dd": 3,
            "hh": 17,
            "mm": 20,
            "ss": 43
        },
        "frequency": 5180,
        "beacon_interval_tus": 100,
        "capability": [ "ESS","Privacy","ShortPreamble" ],
        "capability_raw_value": "0x0031",
        "signal": "-79.00 dBm",
        "last_seen_ago_ms": 2550,
        "bss_probe_response_data_frame": {
            "ssid": {
                "ssid": "tobe52"
            },
            "supported_rates": {
                "rates": [ "6.0*","9.0","12.0*","18.0","24.0*","36.0","48.0","54.0" ]
            },
            "ds_parameter_set": {
                "channel": 36
            },
            "ht_capabilities": {
                "capabilities_value": "0x9ee",
                "capabilities": [ "HT20/HT40","SM Power Save disabled","RX HT20 SGI","RX HT40 SGI","TX STBC","RX STBC 1-stream","Max AMSDU length: 7935 bytes","No DSSS/CCK HT40" ],
                "max_ampdu_length": 65535,
                "max_ampdu_exponent": "0x003",
                "min_rx_ampdu_time_spacing": "4 usec",
                "min_rx_ampdu_time_spacing_value": "0x005",
                "ht_rx_mcs_idx_supported": [ "0-32" ]
            },
            "ht_operation": {
                "primary_channel": 36,
                "secondary_channel_offset": "above",
                "sta_channel_width": "any",
                "rifs": 0,
                "ht_protection": "no",
                "non-gf_present": 0,
                "obss_non-gf_present": 0,
                "dual_beacon": 0,
                "dual_cts_protection": 0,
                "stbc_beacon": 0,
                "l-sig_txop_protection": 0,
                "pco_active": 0,
                "pco_phase": 0
            },
            "rsn": {
                "version": 1,
                "group_cipher_data": [ "CCMP" ],
                "pairwise_ciphers_data": [ "CCMP" ],
                "authentication_suites_data": [ "PSK" ],
                "capabilities_raw_value": "0x0000",
                "capabilities": [ "1-PTKSA-RC","1-GTKSA-RC" ]
            },
            "extended_capabilities": {
                "capabilities": [ "BSS Transition","Operating Mode Notification" ],
                "max_number_of_mssdus_in_a-msdu": -1
            },
            "bss_load": {
                "station_count": 0,
                "channel_utilisation": 0,
                "available_admission_capacity": 31250
            },
            "wmm": {
                "version": 1,
                "be": {
                    "cw": "15-1023",
                    "aifsn": 3
                },
                "bk": {
                    "cw": "15-1023",
                    "aifsn": 7
                },
                "vi": {
                    "cw": "7-15",
                    "aifsn": 2,
                    "txop_usec": 3008
                },
                "vo": {
                    "cw": "3-7",
                    "aifsn": 2,
                    "txop_usec": 1504
                }
            },
            "country": {
                "country": "DB",
                "environment": "Indoor/Outdoor",
                "channels": {
                    "36": {
                        "first": 36,
                        "end": 64,
                        "max_power_dbm": 20
                    },
                    "100": {
                        "first": 100,
                        "end": 140,
                        "max_power_dbm": 20
                    },
                    "149": {
                        "first": 149,
                        "end": 165,
                        "max_power_dbm": 20
                    }
                }
            },
            "vht_capabilities": {
                "vht_capabilities": {
                    "vht_capabilities_raw_value": "0x33c379b1",
                    "data": "7991"
                },
                "supported_channel_width": {},
                "rx_ldpc": "true",
                "short_gi_(80_mhz)": "true",
                "tx_stbc": "true",
                "su_beamformer": "true",
                "su_beamformee": "true",
                "+htc-vht": "true",
                "rx_antenna_pattern_consistency": "true",
                "tx_antenna_pattern_consistency": "true",
                "vht_rx_mcs_set": {
                    "1_streams": "MCS 0-9",
                    "2_streams": "MCS 0-9",
                    "3_streams": "MCS 0-9",
                    "4_streams": "MCS 0-9",
                    "5_streams": "not supported",
                    "6_streams": "not supported",
                    "7_streams": "not supported",
                    "8_streams": "not supported"
                },
                "vht_rx_highest_supported_mbps": 1560,
                "vht_tx_mcs_set": {
                    "1_streams": "MCS 0-9",
                    "2_streams": "MCS 0-9",
                    "3_streams": "MCS 0-9",
                    "4_streams": "MCS 0-9",
                    "5_streams": "not supported",
                    "6_streams": "not supported",
                    "7_streams": "not supported",
                    "8_streams": "not supported"
                },
                "vht_tx_highest_supported_mbps": 1560,
                "vht_extended_nss_supported": "(null)"
            },
            "vht_operation": {
                "channel_width": "1 (80 MHz)",
                "center_freq_segment_1": 42,
                "center_freq_segment_2": 0,
                "vht_basic_mcs_set": "0xffaa"
            }
        }
    }
}

tail part trimmed

v9 changes:
- remove binary json/iw_json_printer

v8 changes:
- json_print.c rewritten.
- all printf() calls to print iw scan info replaced with new
iw_printf()

example text output:
root@ru-fap650-a3:/tmp# ./iw phy0-ap0 scan | head -n 30
00:0c:43:26:60:18:
        ifname: phy0-ap0
        status:
        TSF:
                usec: 278491388966
                dd: 3
                hh: 5
                mm: 21
                ss: 31
        freq: 5180
        beacon_interval_tus: 100
        capability:
                ESS
                Privacy
                ShortPreamble
        capability_raw: 0x0031
        signal: -78.00 dBm
        last_seen_ms_ago: 2540
        bss_probe_resp_data_frame:
                SSID:
                        SSID: tobe52
                Supported rates:
                        rates:
                                6.0*
                                9.0
                                12.0*
                                18.0
                                24.0*
                                36.0
                                48.0
root@ru-fap650-a3:/tmp#

example pretty json output:
root@ru-fap650-a3:/tmp# ./iw -jj phy0-ap0 scan | head -n 30
{
    "00:0c:43:26:60:18": {
        "ifname": "phy0-ap0",
        "status": "",
        "TSF": {
            "usec": 278643858296,
            "dd": 3,
            "hh": 5,
            "mm": 24,
            "ss": 3
        },
        "freq": 5180,
        "beacon_interval_tus": 100,
        "capability": [ "ESS","Privacy","ShortPreamble" ],
        "capability_raw": "0x0031",
        "signal": "-77.00 dBm",
        "last_seen_ms_ago": 2740,
        "bss_probe_resp_data_frame": {
            "SSID": {
                "SSID": "tobe52"
            },
            "Supported rates": {
                "rates": [ "6.0*","9.0","12.0*","18.0","24.0*","36.0","48.0","54.0" ]
            },

v7 changes:
- binaries json/a json/a.out removed

v6 changes:
- add iw_printf(const char *key, const char *fmt, ...)
- rewrite print_ssid_escaped() as a demo with new concept

void print_ssid_escaped(const uint8_t len, const uint8_t *data) {
	char *escaped_ssid = ssid_escape(len, data);
	iw_printf("SSID", "%s", escaped_ssid);
}

How it works:
	text output:
Tabs for text output is based on json depth. For example: ssid is depth 3
or something so 3 tabs will be printed before "SSID: %s"

	json output:
iw_printf will print number (without "") or text based on passed format.

For all number formats. Formats:  %d %i %p %hu etc will print without quotes
If else format is passed iw_print will print it with quotes. To make it work
some new functions added.

branch: v5.19

This commit introduces the ability to output scan results from 'iw' in
JSON format, similar to the 'ip' utility from the iproute2 package.
The addition aims to enhance the tool's usability and scriptability
by providing a structured data format option.

Two new command-line options are added:
- '-j': Outputs scan results in compact JSON format.
- '-jj': Outputs scan results in pretty-printed JSON format.

The implementation focuses on modifying the printing functions to format
the output as JSON without altering the existing netlink
response parsing logic. This patch demonstrates the concept with scan
results, showcasing the potential for expanding JSON support
to other 'iw' functionalities.

If these changes prove valuable, I am prepared to continue working on
extending JSON output support throughout the tool.
Feedback is welcome and appreciated.

Thank you.

Signed-off-by: Isaev Ruslan <legale.legale@gmail.com>
---
 Makefile             |    2 +-
 iw.c                 |   27 +-
 json/Makefile        |   19 +
 json/iw_json_print.c |  263 +++++++++
 json/iw_json_print.h |   35 ++
 json/json_writer.c   |  298 ++++++++++
 json/json_writer.h   |   76 +++
 json/main.c          |   49 ++
 scan.c               | 1289 ++++++++++++++++++++----------------------
 util.c               |  444 +++++++++------
 10 files changed, 1645 insertions(+), 857 deletions(-)
 create mode 100644 json/Makefile
 create mode 100644 json/iw_json_print.c
 create mode 100644 json/iw_json_print.h
 create mode 100644 json/json_writer.c
 create mode 100644 json/json_writer.h
 create mode 100644 json/main.c

diff --git a/Makefile b/Makefile
index 17be33f..42de11c 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,7 @@ CFLAGS += -Wdeclaration-after-statement
 CFLAGS += $(CFLAGS_EVAL)
 CFLAGS += $(EXTRA_CFLAGS)
 
-_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c)))
+_OBJS := $(sort $(patsubst %.c,%.o,$(wildcard *.c) json/json_writer.c json/iw_json_print.c))
 VERSION_OBJS := $(filter-out version.o, $(_OBJS))
 OBJS := $(VERSION_OBJS) version.o
 
diff --git a/iw.c b/iw.c
index 35308ba..98541fd 100644
--- a/iw.c
+++ b/iw.c
@@ -24,6 +24,8 @@
 #include "nl80211.h"
 #include "iw.h"
 
+#include "json/iw_json_print.h"
+
 /* libnl 1.x compatibility code */
 #if !defined(CONFIG_LIBNL20) && !defined(CONFIG_LIBNL30)
 static inline struct nl_handle *nl_socket_alloc(void)
@@ -181,7 +183,11 @@ static void __usage_cmd(const struct cmd *cmd, char *indent, bool full)
 static void usage_options(void)
 {
 	printf("Options:\n");
-	printf("\t--debug\t\tenable netlink debugging\n");
+	printf(""
+	"\t--debug\t\tenable netlink debugging\n"
+	"\t-j     \t\tjson output\n"
+	"\t-jj    \t\tjson pretty output\n"
+	"");
 }
 
 static const char *argv0;
@@ -592,6 +598,21 @@ int main(int argc, char **argv)
 		argv++;
 	}
 
+	if (argc > 0 && strcmp(*argv, "-j") == 0) {
+		json_obj_new(1, 0); //pretty print disabled
+		argc--;
+		argv++;
+	}
+
+	if (argc > 0 && strcmp(*argv, "-jj") == 0) {
+		json_obj_new(1, 1); //pretty print enabled
+		argc--;
+		argv++;
+	}
+
+	//call json_obj_new() anyway to track depth
+	if (!iw_json) json_obj_new(0, 0);
+
 	if (argc > 0 && strcmp(*argv, "--version") == 0) {
 		version();
 		return 0;
@@ -648,5 +669,9 @@ int main(int argc, char **argv)
 
 	nl80211_cleanup(&nlstate);
 
+	//close root json object and deinit jsonw
+	if(iw_json){
+		json_obj_del();
+	}
 	return err;
 }
diff --git a/json/Makefile b/json/Makefile
new file mode 100644
index 0000000..d7b0858
--- /dev/null
+++ b/json/Makefile
@@ -0,0 +1,19 @@
+CC = gcc
+CFLAGS = -Wall -Wextra -Iinclude
+
+SRC_DIR = .
+OBJ_DIR = .
+
+SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
+OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))
+
+all: iw_json_printer
+
+$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
+	$(CC) $(CFLAGS) -c $< -o $@
+
+iw_json_printer: $(OBJ_FILES)
+	$(CC) $(CFLAGS) $^ -o $@
+
+clean:
+	rm -f $(OBJ_DIR)/*.o iw_json_printer
diff --git a/json/iw_json_print.c b/json/iw_json_print.c
new file mode 100644
index 0000000..323342a
--- /dev/null
+++ b/json/iw_json_print.c
@@ -0,0 +1,263 @@
+/*
+* iw_json_print.c 
+* print text or json output, based on json_writer and json_print
+* License: BSD-2-CLAUSE
+*/
+#include "iw_json_print.h"
+#include <assert.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <ctype.h>
+
+int iw_json = 0;
+
+static json_writer_t *_jw;
+
+static void iw_json_print_intend() {
+    for (unsigned i = 0; i < _jw->depth; i++) {
+        printf("\t");
+    }
+}
+
+static const char *iw_json_format_key(const char *key, size_t keysize) {
+    //buffer
+    static char buf[1024];
+    size_t bufsize = sizeof(buf);
+
+    //check keysize
+    assert(keysize < bufsize);
+
+    // copy key to buffer
+    memcpy(buf, key, keysize);
+    buf[keysize] = '\0';
+
+    // replace comma with space
+    for (size_t i = 0; i < keysize; i++) {
+        if (buf[i] == ',') {
+            buf[i] = ' ';
+        }
+    }
+
+    // replace space with _ and convert uppercase letters to lowercase
+    size_t write_index = 0;
+    int prev_is_space = 0;
+    for (size_t i = 0; i < keysize; i++) {
+        char lower_char = tolower(buf[i]); // convert to lowercase
+        if (!isspace(lower_char)) {
+            buf[write_index++] = lower_char;
+            prev_is_space = 0;
+        } else {
+            if (!prev_is_space) {
+                buf[write_index++] = '_';
+            }
+            prev_is_space = 1;
+        }
+    }
+
+    buf[write_index] = '\0';
+
+    return buf;
+}
+
+void json_obj_new(int json, bool is_pretty) {
+	iw_json = json;
+	_jw = jsonw_new(stdout);
+	if (!_jw) {
+		perror("json object");
+		exit(1);
+	}
+	jsonw_pretty(_jw, is_pretty);
+	if(iw_json) jsonw_start_object(_jw);
+}
+void json_obj_del(void) {
+	if (_jw) {
+		if(iw_json) jsonw_end_object(_jw);
+		jsonw_destroy(&_jw);
+	}
+}
+
+json_writer_t *get_json_writer(void) {
+	return _jw;
+}
+void json_obj_open(const char *fmt, ...) {
+	char buf[1024];
+	va_list args;
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	if(!iw_json){
+		iw_json_print_intend();
+		printf("%s:\n", (*buf != '\0') ? buf : "object");
+		++_jw->depth;
+	} else {
+		if(*buf != '\0') jsonw_name(_jw, iw_json_format_key(buf, strlen(buf) + 1));
+		jsonw_start_object(_jw);
+	}
+
+	va_end(args);
+}
+
+void json_obj_close(void) {
+	if(iw_json){
+		jsonw_end_object(_jw);
+	}else{
+		assert(_jw->depth > 0);
+		--_jw->depth;
+	}
+}
+
+void json_arr_open(const char *fmt, ...) {
+	char buf[1024];
+	va_list args;
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	// if not empty
+	assert(buf);
+	if(!iw_json){
+		iw_json_print_intend();
+		printf("%s:\n", (*buf != '\0') ? buf : "array");
+		++_jw->depth;
+	} else {
+		if(*buf != '\0') jsonw_name(_jw, iw_json_format_key(buf, strlen(buf) + 1));
+		jsonw_start_array(_jw);
+	}
+
+	va_end(args);
+}
+
+void json_arr_close() {
+	if(iw_json){
+		jsonw_end_array(_jw);
+	}else{
+		assert(_jw->depth > 0);
+		--_jw->depth;
+	}
+}
+
+#define _PRINT_FUNC(type_name, type)                       \
+void json_print_##type_name(const char *key, type value) { \
+		if (!key)                                          \
+			jsonw_##type_name(_jw, value);                 \
+		else                                               \
+			jsonw_##type_name##_field(_jw, key, value);    \
+}
+
+_PRINT_FUNC(u8, uint8_t);
+_PRINT_FUNC(u16, uint16_t);
+_PRINT_FUNC(u32, uint32_t);
+_PRINT_FUNC(u64, uint64_t);
+_PRINT_FUNC(s8, int8_t);
+_PRINT_FUNC(s16, int16_t);
+_PRINT_FUNC(s32, int32_t);
+_PRINT_FUNC(s64, int64_t);
+_PRINT_FUNC(int, int);
+_PRINT_FUNC(uint, unsigned int);
+_PRINT_FUNC(float, double);
+_PRINT_FUNC(bool, bool);
+#undef _PRINT_FUNC
+
+void json_print_string(const char *key, const char *fmt, ...) {
+	va_list args;
+	va_start(args, fmt);
+
+	char buf[1024];
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	if (key) {
+		jsonw_string_field(_jw, iw_json_format_key(key, strlen(key) +1), buf);
+	} else {
+		jsonw_string(_jw, buf);
+	}
+
+	va_end(args);
+}
+
+void json_print_num(const char *key, const char *fmt, ...) {
+	va_list args;
+	va_start(args, fmt);
+
+	char buffer[1024];
+	vsnprintf(buffer, sizeof(buffer), fmt, args);
+	if (key) {
+		jsonw_num_field(_jw, iw_json_format_key(key, strlen(key) +1), buffer);
+	} else {
+		jsonw_num(_jw, buffer);
+	}
+
+	va_end(args);
+}
+
+enum format_type {
+	FORMAT_STRING,
+	FORMAT_NUMBER
+};
+
+// all number formats
+const char* num_formats[] = {
+  "%d",         // 4 bytes - int
+  "%i",         // 4 bytes - int
+  "%u",         // 4 bytes - unsigned int
+  "%f",         // 4 bytes - float
+  "%lf",        // 8 bytes - double
+  "%e",         // 4 bytes - float
+  "%E",         // 4 bytes - float
+  "%g",         // 4 bytes - float
+  "%G",         // 4 bytes - float
+  "%ld",        // 4 bytes - long int
+  "%li",        // 4 bytes - long int
+  "%lu",        // 4 bytes - unsigned long int
+  "%lld",       // 8 bytes - long long int
+  "%lli",       // 8 bytes - long long int
+  "%llu",       // 8 bytes - unsigned long long int
+  "%hhd",       // 1 byte - signed char
+  "%hhi",       // 1 byte - signed char
+  "%hhu",       // 1 byte - unsigned char
+  "%hd",        // 2 bytes - short int
+  "%hi",        // 2 bytes - short int
+  "%hu",        // 2 bytes - unsigned short int
+  "%Lf",        // 16 bytes - long double
+  "%zd",        // varies by system - size_t
+  "%zi",        // varies by system - ssize_t
+  "%zu",        // varies by system - size_t
+  "%p",         // varies by system - pointer
+  "%d.%d",      // double integer value
+  "%i.%i"       // double integer value
+};
+
+#define MAX_FORMAT_TYPE sizeof(num_formats) / sizeof(num_formats[0])
+static enum format_type get_format_type(const char* fmt) {
+	for (unsigned i = 0; i < MAX_FORMAT_TYPE; i++) {
+		if (strcmp(fmt, num_formats[i]) == 0) {
+			return FORMAT_NUMBER;
+		}
+	}
+	return FORMAT_STRING;
+}
+
+void iw_printf(const char *key, const char *fmt, ...) {
+	va_list args;
+	static char buf[1024];
+	va_start(args, fmt);
+	vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+
+	enum format_type type = get_format_type(fmt);
+
+	if (iw_json) {
+		switch (type) {
+			case FORMAT_NUMBER:
+				json_print_num(key, "%s", buf);
+				break;
+			case FORMAT_STRING:
+			default:
+				json_print_string(key, "%s", buf);
+				break;
+		}
+	} else {
+		//tab intend based on json depth
+		iw_json_print_intend();
+		key ? printf("%s: %s\n", key, buf) : printf("%s\n", buf);
+	}
+}
\ No newline at end of file
diff --git a/json/iw_json_print.h b/json/iw_json_print.h
new file mode 100644
index 0000000..7542624
--- /dev/null
+++ b/json/iw_json_print.h
@@ -0,0 +1,35 @@
+#ifndef _JSON_PRINT_H_
+#define _JSON_PRINT_H_
+#include "json_writer.h"
+
+extern int iw_json;
+
+json_writer_t *get_json_writer(void);
+
+void json_obj_new(int json, bool is_pretty);
+void json_obj_del(void);
+void json_obj_open(const char *fmt, ...);
+void json_obj_close(void);
+void json_arr_open(const char *fmt, ...);
+void json_arr_close(void);
+
+#define _PRINT_FUNC(type_name, type)         \
+	void json_print_##type_name(const char *key, type value)
+_PRINT_FUNC(u8, uint8_t);
+_PRINT_FUNC(u16, uint16_t);
+_PRINT_FUNC(u32, uint32_t);
+_PRINT_FUNC(u64, uint64_t);
+_PRINT_FUNC(s8, int8_t);
+_PRINT_FUNC(s16, int16_t);
+_PRINT_FUNC(s32, int32_t);
+_PRINT_FUNC(s64, int64_t);
+_PRINT_FUNC(int, int);
+_PRINT_FUNC(float, double);
+_PRINT_FUNC(bool, bool);
+#undef _PRINT_FUNC
+
+void json_print_string(const char *key, const char *fmt, ...);
+void json_print_num(const char *key, const char *fmt, ...);
+void iw_printf(const char *key, const char *fmt, ...);
+
+#endif /* _JSON_PRINT_H_ */
diff --git a/json/json_writer.c b/json/json_writer.c
new file mode 100644
index 0000000..79e49b9
--- /dev/null
+++ b/json/json_writer.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) //
+/*
+ * Simple streaming JSON writer
+ *
+ * This takes care of the annoying bits of JSON syntax like the commas
+ * after elements
+ *
+ * Authors:	Stephen Hemminger <stephen@networkplumber.org>
+ */
+#include "json_writer.h"
+#include <assert.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+
+/* indentation for pretty print */
+static void jsonw_indent(json_writer_t *self) {
+	unsigned int i;
+	for (i = 0; i < self->depth; ++i)
+		fputs("    ", self->out);
+}
+/* end current line and indent if pretty printing */
+static void jsonw_eol(json_writer_t *self) {
+	if (!self->pretty)
+		return;
+	putc('\n', self->out);
+	jsonw_indent(self);
+}
+/* If current object is not empty print a comma */
+static void jsonw_eor(json_writer_t *self) {
+	if (self->sep != '\0')
+		putc(self->sep, self->out);
+	self->sep = ',';
+}
+/* Output JSON encoded string */
+/* Handles C escapes, does not do Unicode */
+static void jsonw_puts(json_writer_t *self, const char *str) {
+	putc('"', self->out);
+	for (; *str; ++str)
+		switch (*str) {
+		case '\t':
+			fputs("\\t", self->out);
+			break;
+		case '\n':
+			fputs("\\n", self->out);
+			break;
+		case '\r':
+			fputs("\\r", self->out);
+			break;
+		case '\f':
+			fputs("\\f", self->out);
+			break;
+		case '\b':
+			fputs("\\b", self->out);
+			break;
+		case '\\':
+			fputs("\\\\", self->out);
+			break;
+		case '"':
+			fputs("\\\"", self->out);
+			break;
+		case '\'':
+			fputs("\\\'", self->out);
+			break;
+		default:
+			putc(*str, self->out);
+		}
+	putc('"', self->out);
+}
+/* Create a new JSON stream */
+json_writer_t *jsonw_new(FILE *f) {
+	json_writer_t *self = malloc(sizeof(*self));
+	if (self) {
+		self->out = f;
+		self->depth = 0;
+		self->pretty = false;
+		self->sep = '\0';
+	}
+	return self;
+}
+/* End output to JSON stream */
+void jsonw_destroy(json_writer_t **self_p) {
+	json_writer_t *self = *self_p;
+	assert(self->depth == 0);
+	fputs("\n", self->out);
+	fflush(self->out);
+	free(self);
+	*self_p = NULL;
+}
+void jsonw_pretty(json_writer_t *self, bool on) {
+	self->pretty = on;
+}
+/* Basic blocks */
+static void jsonw_begin(json_writer_t *self, int c) {
+	jsonw_eor(self);
+	putc(c, self->out);
+	++self->depth;
+	self->sep = '\0';
+}
+static void jsonw_end(json_writer_t *self, int c) {
+	assert(self->depth > 0);
+	--self->depth;
+	if (self->sep != '\0')
+		jsonw_eol(self);
+	putc(c, self->out);
+	self->sep = ',';
+}
+/* Add a JSON property name */
+void jsonw_name(json_writer_t *self, const char *name) {
+	jsonw_eor(self);
+	jsonw_eol(self);
+	self->sep = '\0';
+	jsonw_puts(self, name);
+	putc(':', self->out);
+	if (self->pretty)
+		putc(' ', self->out);
+}
+__attribute__((format(printf, 2, 3))) void jsonw_printf(json_writer_t *self, const char *fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	jsonw_eor(self);
+	vfprintf(self->out, fmt, ap);
+	va_end(ap);
+}
+/* Collections */
+void jsonw_start_object(json_writer_t *self) {
+	jsonw_begin(self, '{');
+}
+void jsonw_end_object(json_writer_t *self) {
+	jsonw_end(self, '}');
+}
+void jsonw_start_array(json_writer_t *self) {
+	jsonw_begin(self, '[');
+	if (self->pretty)
+		putc(' ', self->out);
+}
+void jsonw_end_array(json_writer_t *self) {
+	if (self->pretty && self->sep)
+		putc(' ', self->out);
+	self->sep = '\0';
+	jsonw_end(self, ']');
+}
+/* JSON value types */
+void jsonw_string(json_writer_t *self, const char *value) {
+	jsonw_eor(self);
+	jsonw_puts(self, value);
+}
+void jsonw_num(json_writer_t *self, const char *value) {
+	jsonw_printf(self, "%s", value);
+}
+void jsonw_bool(json_writer_t *self, bool val) {
+	jsonw_printf(self, "%s", val ? "true" : "false");
+}
+void jsonw_null(json_writer_t *self) {
+	jsonw_printf(self, "null");
+}
+void jsonw_float(json_writer_t *self, double num) {
+	jsonw_printf(self, "%g", num);
+}
+void jsonw_int(json_writer_t *self, int num) {
+	jsonw_printf(self, "%d", num);
+}
+void jsonw_uint(json_writer_t *self, unsigned int num) {
+	jsonw_printf(self, "%u", num);
+}
+void jsonw_xint(json_writer_t *self, uint64_t num) {
+	jsonw_printf(self, "%" PRIx64, num);
+}
+void jsonw_u8(json_writer_t *self, uint8_t num) {
+	jsonw_printf(self, "%hhu", num);
+}
+void jsonw_u16(json_writer_t *self, uint16_t num) {
+	jsonw_printf(self, "%hu", num);
+}
+void jsonw_u32(json_writer_t *self, uint32_t num) {
+	jsonw_printf(self, "%u", num);
+}
+void jsonw_u64(json_writer_t *self, uint64_t num) {
+	jsonw_printf(self, "%" PRIu64, num);
+}
+void jsonw_s8(json_writer_t *self, int8_t num) {
+	jsonw_printf(self, "%hhu", num);
+}
+void jsonw_s16(json_writer_t *self, int16_t num) {
+	jsonw_printf(self, "%hu", num);
+}
+void jsonw_s32(json_writer_t *self, int32_t num) {
+	jsonw_printf(self, "%u", num);
+}
+void jsonw_s64(json_writer_t *self, int64_t num) {
+	jsonw_printf(self, "%" PRId64, num);
+}
+/* Basic name/value objects */
+void jsonw_string_field(json_writer_t *self, const char *prop, const char *val) {
+	jsonw_name(self, prop);
+	jsonw_string(self, val);
+}
+void jsonw_num_field(json_writer_t *self, const char *prop, const char *val) {
+	jsonw_name(self, prop);
+	jsonw_num(self, val);
+}
+void jsonw_bool_field(json_writer_t *self, const char *prop, bool val) {
+	jsonw_name(self, prop);
+	jsonw_bool(self, val);
+}
+void jsonw_null_field(json_writer_t *self, const char *prop) {
+	jsonw_name(self, prop);
+	jsonw_null(self);
+}
+void jsonw_float_field(json_writer_t *self, const char *prop, double val) {
+	jsonw_name(self, prop);
+	jsonw_float(self, val);
+}
+void jsonw_int_field(json_writer_t *self, const char *prop, int num) {
+	jsonw_name(self, prop);
+	jsonw_int(self, num);
+}
+void jsonw_uint_field(json_writer_t *self, const char *prop, unsigned int num) {
+	jsonw_name(self, prop);
+	jsonw_uint(self, num);
+}
+void jsonw_xint_field(json_writer_t *self, const char *prop, uint64_t num) {
+	jsonw_name(self, prop);
+	jsonw_xint(self, num);
+}
+void jsonw_u8_field(json_writer_t *self, const char *prop, uint8_t num) {
+	jsonw_name(self, prop);
+	jsonw_u8(self, num);
+}
+void jsonw_u16_field(json_writer_t *self, const char *prop, uint16_t num) {
+	jsonw_name(self, prop);
+	jsonw_u16(self, num);
+}
+void jsonw_u32_field(json_writer_t *self, const char *prop, uint32_t num) {
+	jsonw_name(self, prop);
+	jsonw_u32(self, num);
+}
+void jsonw_u64_field(json_writer_t *self, const char *prop, uint64_t num) {
+	jsonw_name(self, prop);
+	jsonw_u64(self, num);
+}
+void jsonw_s8_field(json_writer_t *self, const char *prop, int8_t num) {
+	jsonw_name(self, prop);
+	jsonw_s8(self, num);
+}
+void jsonw_s16_field(json_writer_t *self, const char *prop, int16_t num) {
+	jsonw_name(self, prop);
+	jsonw_s16(self, num);
+}
+void jsonw_s32_field(json_writer_t *self, const char *prop, int32_t num) {
+	jsonw_name(self, prop);
+	jsonw_s32(self, num);
+}
+void jsonw_s64_field(json_writer_t *self, const char *prop, int64_t num) {
+	jsonw_name(self, prop);
+	jsonw_s64(self, num);
+}
+#ifdef TEST
+int main(int argc, char **argv) {
+	json_writer_t *wr = jsonw_new(stdout);
+	jsonw_start_object(wr);
+	jsonw_pretty(wr, true);
+	jsonw_name(wr, "Vyatta");
+	jsonw_start_object(wr);
+	jsonw_string_field(wr, "url", "http://vyatta.com");
+	jsonw_uint_field(wr, "downloads", 2000000ul);
+	jsonw_float_field(wr, "stock", 8.16);
+	jsonw_name(wr, "ARGV");
+	jsonw_start_array(wr);
+	while (--argc)
+		jsonw_string(wr, *++argv);
+	jsonw_end_array(wr);
+	jsonw_name(wr, "empty");
+	jsonw_start_array(wr);
+	jsonw_end_array(wr);
+	jsonw_name(wr, "NIL");
+	jsonw_start_object(wr);
+	jsonw_end_object(wr);
+	jsonw_null_field(wr, "my_null");
+	jsonw_name(wr, "special chars");
+	jsonw_start_array(wr);
+	jsonw_string_field(wr, "slash", "/");
+	jsonw_string_field(wr, "newline", "\n");
+	jsonw_string_field(wr, "tab", "\t");
+	jsonw_string_field(wr, "ff", "\f");
+	jsonw_string_field(wr, "quote", "\"");
+	jsonw_string_field(wr, "tick", "\'");
+	jsonw_string_field(wr, "backslash", "\\");
+	jsonw_end_array(wr);
+	jsonw_end_object(wr);
+	jsonw_end_object(wr);
+	jsonw_destroy(&wr);
+	return 0;
+}
+#endif
diff --git a/json/json_writer.h b/json/json_writer.h
new file mode 100644
index 0000000..b19ab91
--- /dev/null
+++ b/json/json_writer.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Simple streaming JSON writer
+ *
+ * This takes care of the annoying bits of JSON syntax like the commas
+ * after elements
+ *
+ * Authors:	Stephen Hemminger <stephen@networkplumber.org>
+ */
+#ifndef _JSON_WRITER_H_
+#define _JSON_WRITER_H_
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+/* Opaque class structure */
+typedef struct json_writer {
+	FILE *out;					/* output file */
+	unsigned int depth; 		/* nesting */
+	bool pretty;				/* optional whitepace */
+	char sep;					/* either nul or comma */
+} json_writer_t;
+
+/* Create a new JSON stream */
+json_writer_t *jsonw_new(FILE *f);
+/* End output to JSON stream */
+void jsonw_destroy(json_writer_t **self_p);
+/* Cause output to have pretty whitespace */
+void jsonw_pretty(json_writer_t *self, bool on);
+/* Add property name */
+void jsonw_name(json_writer_t *self, const char *name);
+/* Add value  */
+__attribute__((format(printf, 2, 3))) void jsonw_printf(json_writer_t *self, const char *fmt, ...);
+void jsonw_float_fmt(json_writer_t *self, const char *fmt, double num);
+
+void jsonw_string(json_writer_t *self, const char *value);
+void jsonw_num(json_writer_t *self, const char *value);
+void jsonw_bool(json_writer_t *self, bool val);
+void jsonw_null(json_writer_t *self);
+void jsonw_float(json_writer_t *self, double num);
+void jsonw_int(json_writer_t *self, int num);
+void jsonw_uint(json_writer_t *self, unsigned int);
+void jsonw_xint(json_writer_t *self, uint64_t num);
+void jsonw_u8(json_writer_t *self, uint8_t num);
+void jsonw_u16(json_writer_t *self, uint16_t num);
+void jsonw_u32(json_writer_t *self, uint32_t num);
+void jsonw_u64(json_writer_t *self, uint64_t num);
+void jsonw_s8(json_writer_t *self, int8_t num);
+void jsonw_s16(json_writer_t *self, int16_t num);
+void jsonw_s32(json_writer_t *self, int32_t num);
+void jsonw_s64(json_writer_t *self, int64_t num);
+
+/* Useful Combinations of name and value */
+void jsonw_string_field(json_writer_t *self, const char *prop, const char *val);
+void jsonw_num_field(json_writer_t *self, const char *prop, const char *val);
+void jsonw_bool_field(json_writer_t *self, const char *prop, bool value);
+void jsonw_null_field(json_writer_t *self, const char *prop);
+void jsonw_float_field(json_writer_t *self, const char *prop, double num);
+void jsonw_int_field(json_writer_t *self, const char *prop, int num);
+void jsonw_uint_field(json_writer_t *self, const char *prop, unsigned int num);
+void jsonw_xint_field(json_writer_t *self, const char *prop, uint64_t num);
+void jsonw_u8_field(json_writer_t *self, const char *prop, unsigned char num);
+void jsonw_u16_field(json_writer_t *self, const char *prop, uint16_t num);
+void jsonw_u32_field(json_writer_t *self, const char *prop, uint32_t num);
+void jsonw_u64_field(json_writer_t *self, const char *prop, uint64_t num);
+void jsonw_s8_field(json_writer_t *self, const char *prop, int8_t num);
+void jsonw_s16_field(json_writer_t *self, const char *prop, int16_t num);
+void jsonw_s32_field(json_writer_t *self, const char *prop, int32_t num);
+void jsonw_s64_field(json_writer_t *self, const char *prop, int64_t num);
+/* Collections */
+void jsonw_start_object(json_writer_t *self);
+void jsonw_end_object(json_writer_t *self);
+void jsonw_start_array(json_writer_t *self);
+void jsonw_end_array(json_writer_t *self);
+/* Override default exception handling */
+typedef void(jsonw_err_handler_fn)(const char *);
+#endif /* _JSON_WRITER_H_ */
diff --git a/json/main.c b/json/main.c
new file mode 100644
index 0000000..c6683a9
--- /dev/null
+++ b/json/main.c
@@ -0,0 +1,49 @@
+#include <stdio.h>
+#include <stdint.h>
+
+#include "iw_json_print.h"
+
+
+int main() {
+    // init json print without pretty print
+	printf("compact json\n");
+	json_obj_new(1, 0);
+	json_obj_open("tx");
+	json_print_u8("bytes", 255);
+	json_print_u32("packets", 65536);
+	json_print_s32("errors", 65536);
+	json_print_u64("dropped", 1);
+    json_arr_open("hobbies"); // create object entry hobbies with array
+    json_print_string(NULL, "%s", "Reading");
+    json_print_string(NULL, "%s", "Hiking");
+    json_print_string(NULL, "%s", "Coding");
+	json_arr_close();
+	json_obj_close();
+
+    json_obj_del();
+
+	printf("text output\n");
+	json_obj_new(0, 0);
+	iw_printf("k1", "%s", "Sleeping");
+    iw_printf("k2", "%u", 1241);
+	json_arr_open("my_array");
+	iw_printf(NULL, "%s", "Sleeping");
+    iw_printf(NULL, "%u", 1241);
+	json_arr_close();
+    json_obj_del();
+
+	printf("json pretty print\n");
+	json_obj_new(1, 1);
+	iw_printf("k1", "%s", "Sleeping");
+    iw_printf("k2", "%llu", 432425435435345435);
+	json_arr_open("my_array");
+	iw_printf(NULL, "%s", "Walking");
+    iw_printf(NULL, "%u", 1241);
+	json_arr_close();
+    json_obj_del();
+
+
+
+    return 0;
+}
+
diff --git a/scan.c b/scan.c
index a99a414..6a32dd7 100644
--- a/scan.c
+++ b/scan.c
@@ -12,6 +12,8 @@
 #include "nl80211.h"
 #include "iw.h"
 
+#include "json/iw_json_print.h"
+
 #define WLAN_CAPABILITY_ESS		(1<<0)
 #define WLAN_CAPABILITY_IBSS		(1<<1)
 #define WLAN_CAPABILITY_CF_POLLABLE	(1<<2)
@@ -546,14 +548,6 @@ static int handle_scan(struct nl80211_state *state,
 	return err;
 }
 
-static void tab_on_first(bool *first)
-{
-	if (!*first)
-		printf("\t");
-	else
-		*first = false;
-}
-
 struct print_ies_data {
 	unsigned char *ie;
 	int ielen;
@@ -562,9 +556,7 @@ struct print_ies_data {
 static void print_ssid(const uint8_t type, uint8_t len, const uint8_t *data,
 		       const struct print_ies_data *ie_buffer)
 {
-	printf(" ");
-	print_ssid_escaped(len, data);
-	printf("\n");
+		print_ssid_escaped(len, data);
 }
 
 #define BSS_MEMBERSHIP_SELECTOR_VHT_PHY 126
@@ -576,21 +568,18 @@ static void print_supprates(const uint8_t type, uint8_t len,
 {
 	int i;
 
-	printf(" ");
-
+	json_arr_open("Rates");
 	for (i = 0; i < len; i++) {
 		int r = data[i] & 0x7f;
-
-		if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80)
-			printf("VHT");
-		else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80)
-			printf("HT");
-		else
-			printf("%d.%d", r/2, 5*(r&1));
-
-		printf("%s ", data[i] & 0x80 ? "*" : "");
+		if (r == BSS_MEMBERSHIP_SELECTOR_VHT_PHY && data[i] & 0x80){
+			iw_printf(NULL, "VHT%s", data[i] & 0x80 ? "*" : "");
+		} else if (r == BSS_MEMBERSHIP_SELECTOR_HT_PHY && data[i] & 0x80){
+			iw_printf(NULL, "HT%s", data[i] & 0x80 ? "*" : "");
+		} else {
+			iw_printf(NULL, "%d.%d%s", r/2, 5*(r&1), data[i] & 0x80 ? "*" : "");
+		}
 	}
-	printf("\n");
+	json_arr_close();
 }
 
 static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
@@ -603,16 +592,14 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 		     ((__u64) data[3]) << 24 |
 		     ((__u64) data[4]) << 32;
 
-	printf("\n");
-	printf("\t\tCapabilities: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
-							     data[0], data[1],
-							     data[2], data[3],
-							     data[4]);
+	iw_printf("Capabilities Raw value", "0x%02x 0x%02x 0x%02x 0x%02x 0x%02x", data[0], data[1], data[2], data[3], data[4]);
+	json_arr_open("Capabilities");
+
 
 #define PRINT_RM_CAPA(_bit, _str) \
 	do { \
 		if (capa & BIT(_bit)) \
-			printf("\t\t\t" _str "\n"); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
 	PRINT_RM_CAPA(0, "Link Measurement");
@@ -644,14 +631,16 @@ static void print_rm_enabled_capabilities(const uint8_t type, uint8_t len,
 	PRINT_RM_CAPA(34, "FTM Range Report");
 	PRINT_RM_CAPA(35, "Civic Location Measurement");
 
-	printf("\t\tNonoperating Channel Max Measurement Duration: %i\n", data[3] >> 5);
-	printf("\t\tMeasurement Pilot Capability: %i\n", data[4] & 7);
+	json_arr_close();
+	iw_printf("Non operating Channel Max Measurement Duration", "%d", data[3] >> 5);
+	iw_printf("Measurement Pilot Capability", "%d", data[4] & 7);
+
 }
 
 static void print_ds(const uint8_t type, uint8_t len, const uint8_t *data,
 		     const struct print_ies_data *ie_buffer)
 {
-	printf(" channel %d\n", data[0]);
+	iw_printf("Channel", "%d", data[0]);
 }
 
 static const char *country_env_str(char environment)
@@ -671,28 +660,27 @@ static const char *country_env_str(char environment)
 static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf(" %.*s", 2, data);
-
-	printf("\tEnvironment: %s\n", country_env_str(data[2]));
+	iw_printf("Country", "%.*s", 2, data);
+	iw_printf("Environment", "%s", country_env_str(data[2]));
 
 	data += 3;
 	len -= 3;
 
 	if (len < 3) {
-		printf("\t\tNo country IE triplets present\n");
+		iw_printf("No Country IE Triplets Present", "true");
 		return;
 	}
 
+	json_obj_open("Channels");
 	while (len >= 3) {
 		int end_channel;
 		union ieee80211_country_ie_triplet *triplet = (void *) data;
 
 		if (triplet->ext.reg_extension_id >= IEEE80211_COUNTRY_EXTENSION_ID) {
-			printf("\t\tExtension ID: %d Regulatory Class: %d Coverage class: %d (up to %dm)\n",
-			       triplet->ext.reg_extension_id,
-			       triplet->ext.reg_class,
-			       triplet->ext.coverage_class,
-			       triplet->ext.coverage_class * 450);
+			iw_printf("Extension ID", "%d", triplet->ext.reg_extension_id);
+			iw_printf("Regulatory Class", "%d", triplet->ext.reg_class);
+			iw_printf("Coverage Class", "%d", triplet->ext.coverage_class);
+			iw_printf("Coverage Class Up To, dBm", "%d", triplet->ext.coverage_class * 450);
 
 			data += 3;
 			len -= 3;
@@ -705,11 +693,15 @@ static void print_country(const uint8_t type, uint8_t len, const uint8_t *data,
 		else
 			end_channel =  triplet->chans.first_channel + (4 * (triplet->chans.num_channels - 1));
 
-		printf("\t\tChannels [%d - %d] @ %d dBm\n", triplet->chans.first_channel, end_channel, triplet->chans.max_power);
-
+		json_obj_open("%d", triplet->chans.first_channel);
+		iw_printf("First", "%d", triplet->chans.first_channel);
+		iw_printf("End", "%d", end_channel);
+		iw_printf("Max power, dBm", "%d", triplet->chans.max_power);
+		json_obj_close();
 		data += 3;
 		len -= 3;
 	}
+	json_obj_close();
 
 	return;
 }
@@ -718,29 +710,27 @@ static void print_powerconstraint(const uint8_t type, uint8_t len,
 				  const uint8_t *data,
 				  const struct print_ies_data *ie_buffer)
 {
-	printf(" %d dB\n", data[0]);
+	iw_printf("dB", "%d", data[0]);
 }
 
 static void print_tpcreport(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf(" TX power: %d dBm\n", data[0]);
-	/* printf(" Link Margin (%d dB) is reserved in Beacons\n", data[1]); */
+	iw_printf("TX power, dBm", "%d", data[0]);
 }
 
 static void print_erp(const uint8_t type, uint8_t len, const uint8_t *data,
 		      const struct print_ies_data *ie_buffer)
 {
 	if (data[0] == 0x00)
-		printf(" <no flags>");
+		iw_printf("No Flags", "true");
 	if (data[0] & 0x01)
-		printf(" NonERP_Present");
+		iw_printf("Non ERP Present", "true");
 	if (data[0] & 0x02)
-		printf(" Use_Protection");
+		iw_printf("Use Protection", "true");
 	if (data[0] & 0x04)
-		printf(" Barker_Preamble_Mode");
-	printf("\n");
+		iw_printf("Barker Preamble Mode", "true");
 }
 
 static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -749,13 +739,13 @@ static void print_ap_channel_report(const uint8_t type, uint8_t len, const uint8
 	uint8_t oper_class = data[0];
 	int i;
 
-	printf("\n");
-	printf("\t\t * operating class: %d\n", oper_class);
-	printf("\t\t * channel(s):");
+	iw_printf("Operating Class", "%d", oper_class);
+	json_arr_open("Channels");
 	for (i = 1; i < len; ++i) {
-		printf(" %d", data[i]);
+		iw_printf(NULL, "%d", data[i]);
 	}
-	printf("\n");
+	json_arr_close();
+
 }
 
 static void print_cipher(const uint8_t *data)
@@ -763,59 +753,56 @@ static void print_cipher(const uint8_t *data)
 	if (memcmp(data, ms_oui, 3) == 0) {
 		switch (data[3]) {
 		case 0:
-			printf("Use group cipher suite");
+			iw_printf(NULL, "Use group cipher suite");
 			break;
 		case 1:
-			printf("WEP-40");
+			iw_printf(NULL, "WEP-40");
 			break;
 		case 2:
-			printf("TKIP");
+			iw_printf(NULL, "TKIP");
 			break;
 		case 4:
-			printf("CCMP");
+			iw_printf(NULL, "CCMP");
 			break;
 		case 5:
-			printf("WEP-104");
+			iw_printf(NULL, "WEP-104");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, ieee80211_oui, 3) == 0) {
 		switch (data[3]) {
 		case 0:
-			printf("Use group cipher suite");
+			iw_printf(NULL, "Use group cipher suite");
 			break;
 		case 1:
-			printf("WEP-40");
+			iw_printf(NULL, "WEP-40");
 			break;
 		case 2:
-			printf("TKIP");
+			iw_printf(NULL, "TKIP");
 			break;
 		case 4:
-			printf("CCMP");
+			iw_printf(NULL, "CCMP");
 			break;
 		case 5:
-			printf("WEP-104");
+			iw_printf(NULL, "WEP-104");
 			break;
 		case 6:
-			printf("AES-128-CMAC");
+			iw_printf(NULL, "AES-128-CMAC");
 			break;
 		case 7:
-			printf("NO-GROUP");
+			iw_printf(NULL, "NO-GROUP");
 			break;
 		case 8:
-			printf("GCMP");
+			iw_printf(NULL, "GCMP");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else
-		printf("%.02x-%.02x-%.02x:%d",
-			data[0], data[1] ,data[2], data[3]);
+		iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 }
 
 static void print_auth(const uint8_t *data)
@@ -823,127 +810,117 @@ static void print_auth(const uint8_t *data)
 	if (memcmp(data, ms_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("IEEE 802.1X");
+			iw_printf(NULL, "IEEE 802.1X");
 			break;
 		case 2:
-			printf("PSK");
+			iw_printf(NULL, "PSK");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, ieee80211_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("IEEE 802.1X");
+			iw_printf(NULL, "IEEE 802.1X");
 			break;
 		case 2:
-			printf("PSK");
+			iw_printf(NULL, "PSK");
 			break;
 		case 3:
-			printf("FT/IEEE 802.1X");
+			iw_printf(NULL, "FT/IEEE 802.1X");
 			break;
 		case 4:
-			printf("FT/PSK");
+			iw_printf(NULL, "FT/PSK");
 			break;
 		case 5:
-			printf("IEEE 802.1X/SHA-256");
+			iw_printf(NULL, "IEEE 802.1X/SHA-256");
 			break;
 		case 6:
-			printf("PSK/SHA-256");
+			iw_printf(NULL, "PSK/SHA-256");
 			break;
 		case 7:
-			printf("TDLS/TPK");
+			iw_printf(NULL, "TDLS/TPK");
 			break;
 		case 8:
-			printf("SAE");
+			iw_printf(NULL, "SAE");
 			break;
 		case 9:
-			printf("FT/SAE");
+			iw_printf(NULL, "FT/SAE");
 			break;
 		case 11:
-			printf("IEEE 802.1X/SUITE-B");
+			iw_printf(NULL, "IEEE 802.1X/SUITE-B");
 			break;
 		case 12:
-			printf("IEEE 802.1X/SUITE-B-192");
+			iw_printf(NULL, "IEEE 802.1X/SUITE-B-192");
 			break;
 		case 13:
-			printf("FT/IEEE 802.1X/SHA-384");
+			iw_printf(NULL, "FT/IEEE 802.1X/SHA-384");
 			break;
 		case 14:
-			printf("FILS/SHA-256");
+			iw_printf(NULL, "FILS/SHA-256");
 			break;
 		case 15:
-			printf("FILS/SHA-384");
+			iw_printf(NULL, "FILS/SHA-384");
 			break;
 		case 16:
-			printf("FT/FILS/SHA-256");
+			iw_printf(NULL, "FT/FILS/SHA-256");
 			break;
 		case 17:
-			printf("FT/FILS/SHA-384");
+			iw_printf(NULL, "FT/FILS/SHA-384");
 			break;
 		case 18:
-			printf("OWE");
+			iw_printf(NULL, "OWE");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else if (memcmp(data, wfa_oui, 3) == 0) {
 		switch (data[3]) {
 		case 1:
-			printf("OSEN");
+			iw_printf(NULL, "OSEN");
 			break;
 		case 2:
-			printf("DPP");
+			iw_printf(NULL, "DPP");
 			break;
 		default:
-			printf("%.02x-%.02x-%.02x:%d",
-				data[0], data[1] ,data[2], data[3]);
+			iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 			break;
 		}
 	} else
-		printf("%.02x-%.02x-%.02x:%d",
-			data[0], data[1] ,data[2], data[3]);
+		iw_printf(NULL, "%.02x-%.02x-%.02x:%d", data[0], data[1] ,data[2], data[3]);
 }
 
 static void _print_rsn_ie(const char *defcipher, const char *defauth,
 			  uint8_t len, const uint8_t *data, int is_osen)
 {
-	bool first = true;
 	__u16 count, capa;
 	int i;
 
 	if (!is_osen) {
 		__u16 version;
 		version = data[0] + (data[1] << 8);
-		tab_on_first(&first);
-		printf("\t * Version: %d\n", version);
-
+		iw_printf("version", "%d", version);
 		data += 2;
 		len -= 2;
 	}
 
 	if (len < 4) {
-		tab_on_first(&first);
-		printf("\t * Group cipher: %s\n", defcipher);
-		printf("\t * Pairwise ciphers: %s\n", defcipher);
+		iw_printf("group_cipher", "%s", defcipher);
+		iw_printf("Pairwise ciphers", "%s", defcipher);
 		return;
 	}
 
-	tab_on_first(&first);
-	printf("\t * Group cipher: ");
+	json_arr_open("group_cipher_data");
 	print_cipher(data);
-	printf("\n");
+	json_arr_close();
 
 	data += 4;
 	len -= 4;
 
 	if (len < 2) {
-		tab_on_first(&first);
-		printf("\t * Pairwise ciphers: %s\n", defcipher);
+		iw_printf("pairwise_ciphers", "%s", defcipher);
 		return;
 	}
 
@@ -951,20 +928,17 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	if (2 + (count * 4) > len)
 		goto invalid;
 
-	tab_on_first(&first);
-	printf("\t * Pairwise ciphers:");
+	json_arr_open("Pairwise Ciphers Data");
 	for (i = 0; i < count; i++) {
-		printf(" ");
 		print_cipher(data + 2 + (i * 4));
 	}
-	printf("\n");
+	json_arr_close();
 
 	data += 2 + (count * 4);
 	len -= 2 + (count * 4);
 
 	if (len < 2) {
-		tab_on_first(&first);
-		printf("\t * Authentication suites: %s\n", defauth);
+		iw_printf("Authentication Suites", "%s", defauth);
 		return;
 	}
 
@@ -972,66 +946,66 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	if (2 + (count * 4) > len)
 		goto invalid;
 
-	tab_on_first(&first);
-	printf("\t * Authentication suites:");
+	json_arr_open("Authentication Suites Data");
 	for (i = 0; i < count; i++) {
-		printf(" ");
 		print_auth(data + 2 + (i * 4));
 	}
-	printf("\n");
+	json_arr_close();
 
 	data += 2 + (count * 4);
 	len -= 2 + (count * 4);
 
 	if (len >= 2) {
 		capa = data[0] | (data[1] << 8);
-		tab_on_first(&first);
-		printf("\t * Capabilities:");
+		iw_printf("Capabilities Raw Value", "0x%.4x", capa);
+
+		json_arr_open("Capabilities");
 		if (capa & 0x0001)
-			printf(" PreAuth");
+			iw_printf(NULL, "PreAuth");
 		if (capa & 0x0002)
-			printf(" NoPairwise");
+			iw_printf(NULL, "NoPairwise");
 		switch ((capa & 0x000c) >> 2) {
 		case 0:
-			printf(" 1-PTKSA-RC");
+			iw_printf(NULL, "1-PTKSA-RC");
 			break;
 		case 1:
-			printf(" 2-PTKSA-RC");
+			iw_printf(NULL, "2-PTKSA-RC");
 			break;
 		case 2:
-			printf(" 4-PTKSA-RC");
+			iw_printf(NULL, "4-PTKSA-RC");
 			break;
 		case 3:
-			printf(" 16-PTKSA-RC");
+			iw_printf(NULL, "16-PTKSA-RC");
 			break;
 		}
 		switch ((capa & 0x0030) >> 4) {
 		case 0:
-			printf(" 1-GTKSA-RC");
+			iw_printf(NULL, "1-GTKSA-RC");
 			break;
 		case 1:
-			printf(" 2-GTKSA-RC");
+			iw_printf(NULL, "2-GTKSA-RC");
 			break;
 		case 2:
-			printf(" 4-GTKSA-RC");
+			iw_printf(NULL, "4-GTKSA-RC");
 			break;
 		case 3:
-			printf(" 16-GTKSA-RC");
+			iw_printf(NULL, "16-GTKSA-RC");
 			break;
 		}
 		if (capa & 0x0040)
-			printf(" MFP-required");
+			iw_printf(NULL, "MFP-required");
 		if (capa & 0x0080)
-			printf(" MFP-capable");
+			iw_printf(NULL, "MFP-capable");
 		if (capa & 0x0200)
-			printf(" Peerkey-enabled");
+			iw_printf(NULL, "Peerkey-enabled");
 		if (capa & 0x0400)
-			printf(" SPP-AMSDU-capable");
+			iw_printf(NULL, "SPP-AMSDU-capable");
 		if (capa & 0x0800)
-			printf(" SPP-AMSDU-required");
+			iw_printf(NULL, "SPP-AMSDU-required");
 		if (capa & 0x2000)
-			printf(" Extended-Key-ID");
-		printf(" (0x%.4x)\n", capa);
+			iw_printf(NULL, "Extended-Key-ID");
+		json_arr_close();
+
 		data += 2;
 		len -= 2;
 	}
@@ -1040,8 +1014,7 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 		int pmkid_count = data[0] | (data[1] << 8);
 
 		if (len >= 2 + 16 * pmkid_count) {
-			tab_on_first(&first);
-			printf("\t * %d PMKIDs\n", pmkid_count);
+			iw_printf("PMKIDs Count", "%d", pmkid_count);
 			/* not printing PMKID values */
 			data += 2 + 16 * pmkid_count;
 			len -= 2 + 16 * pmkid_count;
@@ -1050,23 +1023,23 @@ static void _print_rsn_ie(const char *defcipher, const char *defauth,
 	}
 
 	if (len >= 4) {
-		tab_on_first(&first);
-		printf("\t * Group mgmt cipher suite: ");
+		json_arr_open("Group MGMT Cipher Suite Data");
 		print_cipher(data);
-		printf("\n");
+		json_arr_close();
 		data += 4;
 		len -= 4;
 	}
 
  invalid:
 	if (len != 0) {
-		printf("\t\t * bogus tail data (%d):", len);
+		iw_printf("Bogus Tail Data Length", "%d", len);
+		json_arr_open("Bogus Tail Data");
 		while (len) {
-			printf(" %.2x", *data);
+			iw_printf(NULL, "%.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		json_arr_close();
 	}
 }
 
@@ -1079,7 +1052,6 @@ static void print_rsn_ie(const char *defcipher, const char *defauth,
 static void print_osen_ie(const char *defcipher, const char *defauth,
 			  uint8_t len, const uint8_t *data)
 {
-	printf("\n\t");
 	_print_rsn_ie(defcipher, defauth, len, data, 1);
 }
 
@@ -1092,7 +1064,6 @@ static void print_rsn(const uint8_t type, uint8_t len, const uint8_t *data,
 static void print_ht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_ht_capability(data[0] | (data[1] << 8));
 	print_ampdu_length(data[2] & 3);
 	print_ampdu_spacing((data[2] >> 2) & 7);
@@ -1138,31 +1109,32 @@ static void print_interworking(const uint8_t type, uint8_t len,
 			       const struct print_ies_data *ie_buffer)
 {
 	/* See Section 7.3.2.92 in the 802.11u spec. */
-	printf("\n");
 	if (len >= 1) {
 		uint8_t ano = data[0];
-		printf("\t\tNetwork Options: 0x%hx\n", (unsigned short)(ano));
-		printf("\t\t\tNetwork Type: %i (%s)\n",
-		       (int)(ano & 0xf), ntype_11u(ano & 0xf));
+		iw_printf("Network Options", "0x%hx", (unsigned short)(ano));
+		iw_printf("Network type, least significant 4 bits", "%i", (int)(ano & 0xf));
+		iw_printf("Network Type", "%s", ntype_11u(ano & 0xf));
+		json_arr_open("Data");
 		if (ano & (1<<4))
-			printf("\t\t\tInternet\n");
+			iw_printf(NULL, "Internet");
 		if (ano & (1<<5))
-			printf("\t\t\tASRA\n");
+			iw_printf(NULL, "ASRA");
 		if (ano & (1<<6))
-			printf("\t\t\tESR\n");
+			iw_printf(NULL, "ESR");
 		if (ano & (1<<7))
-			printf("\t\t\tUESA\n");
+			iw_printf(NULL, "UESA");
+		json_arr_close();
 	}
 	if ((len == 3) || (len == 9)) {
-		printf("\t\tVenue Group: %i (%s)\n",
-		       (int)(data[1]), vgroup_11u(data[1]));
-		printf("\t\tVenue Type: %i\n", (int)(data[2]));
+		iw_printf("Venue Group Raw Value", "%i", (int)(data[1]));
+		iw_printf("Venue Group", "%s", vgroup_11u(data[1]));
+		iw_printf("Venue Type", "%i", (int)(data[2]));
 	}
 	if (len == 9)
-		printf("\t\tHESSID: %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
+		iw_printf("HESSID", "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
 		       data[3], data[4], data[5], data[6], data[7], data[8]);
 	else if (len == 7)
-		printf("\t\tHESSID: %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
+		iw_printf("HESSID", "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
 		       data[1], data[2], data[3], data[4], data[5], data[6]);
 }
 
@@ -1173,28 +1145,26 @@ static void print_11u_advert(const uint8_t type, uint8_t len,
 	/* See Section 7.3.2.93 in the 802.11u spec. */
 	/* TODO: This code below does not decode private protocol IDs */
 	int idx = 0;
-	printf("\n");
 	while (idx < (len - 1)) {
 		uint8_t qri = data[idx];
 		uint8_t proto_id = data[idx + 1];
-		printf("\t\tQuery Response Info: 0x%hx\n", (unsigned short)(qri));
-		printf("\t\t\tQuery Response Length Limit: %i\n",
-		       (qri & 0x7f));
+		iw_printf("Query Response Info", "0x%hx", (unsigned short)(qri));
+		iw_printf("Query Response Length Limit", "%i", (qri & 0x7f));
 		if (qri & (1<<7))
-			printf("\t\t\tPAME-BI\n");
+			iw_printf("PAME-BI", "true");
 		switch(proto_id) {
 		case 0:
-			printf("\t\t\tANQP\n"); break;
+			iw_printf("Protocol ID", "ANQP"); break;
 		case 1:
-			printf("\t\t\tMIH Information Service\n"); break;
+			iw_printf("Protocol ID", "MIH Information Service"); break;
 		case 2:
-			printf("\t\t\tMIH Command and Event Services Capability Discovery\n"); break;
+			iw_printf("Protocol ID", "MIH Command and Event Services Capability Discovery"); break;
 		case 3:
-			printf("\t\t\tEmergency Alert System (EAS)\n"); break;
+			iw_printf("Protocol ID", "Emergency Alert System (EAS)"); break;
 		case 221:
-			printf("\t\t\tVendor Specific\n"); break;
+			iw_printf("Protocol ID", "Vendor Specific"); break;
 		default:
-			printf("\t\t\tReserved: %i\n", proto_id); break;
+			iw_printf("Protocol ID", "Reserved: %i", proto_id); break;
 		}
 		idx += 2;
 	}
@@ -1208,47 +1178,46 @@ static void print_11u_rcon(const uint8_t type, uint8_t len, const uint8_t *data,
 	int ln0 = data[1] & 0xf;
 	int ln1 = ((data[1] & 0xf0) >> 4);
 	int ln2 = 0;
-	printf("\n");
 
 	if (ln1)
 		ln2 = len - 2 - ln0 - ln1;
 
-	printf("\t\tANQP OIs: %i\n", data[0]);
+	iw_printf("ANQP OIs", "%i", data[0]);
 
 	if (ln0 > 0) {
-		printf("\t\tOI 1: ");
+		json_arr_open("OI 1");
 		if (2 + ln0 > len) {
-			printf("Invalid IE length.\n");
+			iw_printf(NULL, "Invalid IE length len: %d 2+ln0: %d", len, 2 + ln0);
 		} else {
 			for (idx = 0; idx < ln0; idx++) {
-				printf("%02hhx", data[2 + idx]);
+				iw_printf(NULL, "%02hhx", data[2 + idx]);
 			}
-			printf("\n");
 		}
+		json_arr_close();
 	}
 
 	if (ln1 > 0) {
-		printf("\t\tOI 2: ");
+		json_arr_open("OI 2");
 		if (2 + ln0 + ln1 > len) {
-			printf("Invalid IE length.\n");
+			iw_printf(NULL, "Invalid IE length len: %d 2 + ln0 + ln1: %d", len, 2 + ln0 + ln1);
 		} else {
 			for (idx = 0; idx < ln1; idx++) {
-				printf("%02hhx", data[2 + ln0 + idx]);
+				iw_printf(NULL, "%02hhx", data[2 + ln0 + idx]);
 			}
-			printf("\n");
 		}
+		json_arr_close();
 	}
 
 	if (ln2 > 0) {
-		printf("\t\tOI 3: ");
+		json_arr_open("OI 3");
 		if (2 + ln0 + ln1 + ln2 > len) {
-			printf("Invalid IE length.\n");
+			iw_printf(NULL, "Invalid IE length len: %d 2+ln0+ln1+ln2: %d", len, 2 + ln0 + ln1 + ln2);
 		} else {
 			for (idx = 0; idx < ln2; idx++) {
-				printf("%02hhx", data[2 + ln0 + ln1 + idx]);
+				iw_printf(NULL, "%02hhx", data[2 + ln0 + ln1 + idx]);
 			}
-			printf("\n");
 		}
+		json_arr_close();
 	}
 }
 
@@ -1266,8 +1235,6 @@ static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 		"Local Maximum Transmit Power For 160/80+80 MHz",
 	};
 
-	printf("\n");
-
 	if (local_max_tx_power_count + 2 != len)
 		return;
 	if (local_max_tx_power_unit_interp != 0)
@@ -1275,10 +1242,13 @@ static void print_tx_power_envelope(const uint8_t type, uint8_t len,
 	for (i = 0; i < local_max_tx_power_count + 1; ++i) {
 		int8_t power_val = ((int8_t)data[1 + i]) >> 1;
 		int8_t point5 = data[1 + i] & 1;
+		char power_name[64];
+		size_t power_name_size = sizeof(power_name);
+		snprintf(power_name, power_name_size, "%s, dBm", power_names[i]);
 		if (point5)
-			printf("\t\t * %s: %i.5 dBm\n", power_names[i], power_val);
+			iw_printf(power_name, "%i.%i", power_val, 5);
 		else
-			printf("\t\t * %s: %i dBm\n", power_names[i], power_val);
+			iw_printf(power_name, "%i", power_val);
 	}
 }
 
@@ -1302,22 +1272,19 @@ static void print_ht_op(const uint8_t type, uint8_t len, const uint8_t *data,
 		"20 MHz",
 		"any",
 	};
-
-	printf("\n");
-	printf("\t\t * primary channel: %d\n", data[0]);
-	printf("\t\t * secondary channel offset: %s\n",
-		ht_secondary_offset[data[1] & 0x3]);
-	printf("\t\t * STA channel width: %s\n", sta_chan_width[(data[1] & 0x4)>>2]);
-	printf("\t\t * RIFS: %d\n", (data[1] & 0x8)>>3);
-	printf("\t\t * HT protection: %s\n", protection[data[2] & 0x3]);
-	printf("\t\t * non-GF present: %d\n", (data[2] & 0x4) >> 2);
-	printf("\t\t * OBSS non-GF present: %d\n", (data[2] & 0x10) >> 4);
-	printf("\t\t * dual beacon: %d\n", (data[4] & 0x40) >> 6);
-	printf("\t\t * dual CTS protection: %d\n", (data[4] & 0x80) >> 7);
-	printf("\t\t * STBC beacon: %d\n", data[5] & 0x1);
-	printf("\t\t * L-SIG TXOP Prot: %d\n", (data[5] & 0x2) >> 1);
-	printf("\t\t * PCO active: %d\n", (data[5] & 0x4) >> 2);
-	printf("\t\t * PCO phase: %d\n", (data[5] & 0x8) >> 3);
+	iw_printf("Primary Channel", "%d", data[0]);
+	iw_printf("Secondary Channel Offset", "%s", ht_secondary_offset[data[1] & 0x3]);
+	iw_printf("STA Channel Width", "%s", sta_chan_width[(data[1] & 0x4)>>2]);
+	iw_printf("RIFS", "%d", (data[1] & 0x8)>>3);
+	iw_printf("HT Protection", "%s", protection[data[2] & 0x3]);
+	iw_printf("Non-GF Present", "%d", (data[2] & 0x4) >> 2);
+	iw_printf("OBSS Non-GF Present", "%d", (data[2] & 0x10) >> 4);
+	iw_printf("Dual Beacon", "%d", (data[4] & 0x40) >> 6);
+	iw_printf("Dual CTS Protection", "%d", (data[4] & 0x80) >> 7);
+	iw_printf("STBC Beacon", "%d", data[5] & 0x1);
+	iw_printf("L-SIG TXOP Protection", "%d", (data[5] & 0x2) >> 1);
+	iw_printf("PCO Active", "%d", (data[5] & 0x4) >> 2);
+	iw_printf("PCO Phase", "%d", (data[5] & 0x8) >> 3);
 }
 
 static void print_capabilities(const uint8_t type, uint8_t len,
@@ -1338,6 +1305,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 		ie += ie[1] + 2;
 	}
 
+	json_arr_open("Capabilities");
 	for (i = 0; i < len; i++) {
 		base = i * 8;
 
@@ -1345,15 +1313,13 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			if (!(data[i] & (1 << bit)))
 				continue;
 
-			printf("\n\t\t *");
-
-#define CAPA(bit, name)		case bit: printf(" " name); break
+#define CAPA(bit, name)		case bit: iw_printf(NULL, name); break
 
 /* if the capability 'cap' exists add 'val' to 'sum'
  * otherwise print 'Reserved' */
 #define ADD_BIT_VAL(bit, cap, sum, val)	case (bit): do {	\
 	if (!(cap)) {						\
-		printf(" Reserved");				\
+		iw_printf(NULL, "Reserved");				\
 		break;						\
 	}							\
 	sum += val;						\
@@ -1370,7 +1336,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 
 			case 6:
 				s_psmp_support = true;
-				printf(" S-PSMP Capability");
+				iw_printf(NULL, "S-PSMP Capability");
 				break;
 
 			CAPA(7, "Event");
@@ -1426,7 +1392,7 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(55, "QLoad Report");
 			CAPA(56, "Alternate EDCA");
 			CAPA(57, "Unprotected TXOP Negotiation");
-			CAPA(58, "Protected TXOP egotiation");
+			CAPA(58, "Protected TXOP Negotiation");
 			CAPA(59, "Reserved");
 			CAPA(60, "Protected QLoad Report");
 			CAPA(61, "TDLS Wider Bandwidth");
@@ -1450,62 +1416,50 @@ static void print_capabilities(const uint8_t type, uint8_t len,
 			CAPA(79, "OBSS Narrow Bandwith RU in UL OFDMA Tolerance Support");
 
 			default:
-				printf(" %d", bit);
+				iw_printf(NULL, "Bit: %d", bit);
 				break;
 			}
+
 #undef ADD_BIT_VAL
 #undef CAPA
-		}
-	}
+		} //inner for loop
+	} //outer for loop
+	json_arr_close();
+
 
 	if (s_psmp_support)
-		printf("\n\t\t * Service Interval Granularity is %d ms",
-		       (si_duration + 1) * 5);
+		iw_printf("Service Interval Granularity, ms", "%d", (si_duration + 1) * 5);
 
 	if (is_vht_cap) {
-		printf("\n\t\t * Max Number Of MSDUs In A-MSDU is ");
+		int max_amsdu_ = 0;
 		switch (max_amsdu) {
-		case 0:
-			printf("unlimited");
-			break;
-		case 1:
-			printf("32");
-			break;
-		case 2:
-			printf("16");
-			break;
-		case 3:
-			printf("8");
-			break;
-		default:
-			break;
+			case 0: max_amsdu_ = -1; break;
+			case 1: max_amsdu_ = 32; break;
+			case 2: max_amsdu_ = 16; break;
+			case 3: max_amsdu_ = 8; break;
+			default: break;
 		}
+		iw_printf("Max Number Of MSSDUs In A-MSDU", "%d", max_amsdu_);
 	}
-
-	printf("\n");
 }
 
 static void print_tim(const uint8_t type, uint8_t len, const uint8_t *data,
 		      const struct print_ies_data *ie_buffer)
 {
-	printf(" DTIM Count %u DTIM Period %u Bitmap Control 0x%x "
-	       "Bitmap[0] 0x%x",
-	       data[0], data[1], data[2], data[3]);
+	iw_printf("Value", "DTIM Count %u DTIM Period %u Bitmap Control 0x%x Bitmap[0] 0x%x", data[0], data[1], data[2], data[3]);
 	if (len - 4)
-		printf(" (+ %u octet%s)", len - 4, len - 4 == 1 ? "" : "s");
-	printf("\n");
+		iw_printf("Octets", "%u", len - 4);
 }
 
 static void print_ibssatim(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf(" %d TUs\n", (data[1] << 8) + data[0]);
+	iw_printf("TUs", "%d", (data[1] << 8) + data[0]);
 }
 
 static void print_vht_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_vht_info((__u32) data[0] | ((__u32)data[1] << 8) |
 		       ((__u32)data[2] << 16) | ((__u32)data[3] << 24),
 		       data + 4);
@@ -1521,12 +1475,12 @@ static void print_vht_oper(const uint8_t type, uint8_t len, const uint8_t *data,
 		[2] = "160 MHz",
 	};
 
-	printf("\n");
-	printf("\t\t * channel width: %d (%s)\n", data[0],
+	iw_printf("Channel Width", "%d (%s)", data[0],
 		data[0] < ARRAY_SIZE(chandwidths) ? chandwidths[data[0]] : "unknown");
-	printf("\t\t * center freq segment 1: %d\n", data[1]);
-	printf("\t\t * center freq segment 2: %d\n", data[2]);
-	printf("\t\t * VHT basic MCS set: 0x%.2x%.2x\n", data[4], data[3]);
+	iw_printf("Center Freq Segment 1", "%d", data[1]);
+	iw_printf("Center freq Segment 2", "%d", data[2]);
+	iw_printf("VHT Basic MCS Set", "0x%.2x%.2x", data[4], data[3]);
+
 }
 
 static void print_supp_op_classes(const uint8_t type, uint8_t len,
@@ -1538,8 +1492,8 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 	int zero_delimiter = 0;
 	int one_hundred_thirty_delimiter = 0;
 
-	printf("\n");
-	printf("\t\t * current operating class: %d\n", *p);
+	iw_printf("Current Operating Class", "%d", *p);
+	json_arr_open("Operating Class");
 	while (++p < next_data) {
 		if (*p == 130) {
 			one_hundred_thirty_delimiter = 1;
@@ -1549,18 +1503,28 @@ static void print_supp_op_classes(const uint8_t type, uint8_t len,
 			zero_delimiter = 0;
 			break;
 		}
-		printf("\t\t * operating class: %d\n", *p);
+		iw_printf(NULL, "%d", *p);
 	}
-	if (one_hundred_thirty_delimiter)
+	json_arr_close();
+
+	json_arr_open("Current Operating Class Extension");
+	if (one_hundred_thirty_delimiter){
 		while (++p < next_data) {
-			printf("\t\t * current operating class extension: %d\n", *p);
+			iw_printf(NULL, "%d", *p);
 		}
-	if (zero_delimiter)
+	}
+	json_arr_close();
+
+	json_arr_open("Operating Class Tuple");
+	if (zero_delimiter){
 		while (++p < next_data - 1) {
-			printf("\t\t * operating class tuple: %d %d\n", p[0], p[1]);
+			iw_printf(NULL, "%d %d", p[0], p[1]);
 			if (*p == 0)
 				break;
 		}
+	}
+	json_arr_close();
+
 }
 
 static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
@@ -1569,8 +1533,7 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 {
 	uint8_t *p, len_remaining;
 
-	printf("\n");
-	printf("\t\t * interval: %d TUs\n", data[0]);
+	iw_printf("Interval, TUs", "%d", data[0]);
 
 	if (len <= 1)
 		return;
@@ -1590,23 +1553,21 @@ static void print_measurement_pilot_tx(const uint8_t type, uint8_t len,
 
 		/* 802.11-2016 only allows vendor specific elements */
 		if (subelement_id != 221) {
-			printf("\t\t * <Invalid subelement ID %d>\n", subelement_id);
+			iw_printf("Invalid Subelement ID", "%d", subelement_id);
 			return;
 		}
 
 		if (len < 3 || len > len_remaining) {
-			printf(" <Parse error, element too short>\n");
+			iw_printf("Invalid Subelement ID", "%d", subelement_id);
 			return;
 		}
 
-		printf("\t\t * vendor specific: OUI %.2x:%.2x:%.2x, data:",
-			p[0], p[1], p[2]);
-		/* add only two here and use ++p in while loop */
-		p += 2;
+		json_arr_open("Vendor Specific OUI");
 
-		while (++p < end)
-			printf(" %.2x", *p);
-		printf("\n");
+		while (++p < end){
+			iw_printf(NULL, "0x%.2x", *p);
+		}
+		json_arr_close();
 
 		len_remaining -= len;
 	}
@@ -1616,15 +1577,13 @@ static void print_obss_scan_params(const uint8_t type, uint8_t len,
 				   const uint8_t *data,
 				   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
-	printf("\t\t * passive dwell: %d TUs\n", (data[1] << 8) | data[0]);
-	printf("\t\t * active dwell: %d TUs\n", (data[3] << 8) | data[2]);
-	printf("\t\t * channel width trigger scan interval: %d s\n", (data[5] << 8) | data[4]);
-	printf("\t\t * scan passive total per channel: %d TUs\n", (data[7] << 8) | data[6]);
-	printf("\t\t * scan active total per channel: %d TUs\n", (data[9] << 8) | data[8]);
-	printf("\t\t * BSS width channel transition delay factor: %d\n", (data[11] << 8) | data[10]);
-	printf("\t\t * OBSS Scan Activity Threshold: %d.%02d %%\n",
-		((data[13] << 8) | data[12]) / 100, ((data[13] << 8) | data[12]) % 100);
+	iw_printf("Passive dwell, TUs", "%d", (data[1] << 8) | data[0]);
+	iw_printf("Active dwell, TUs", "%d", (data[3] << 8) | data[2]);
+	iw_printf("Channel Width Trigger Scan Interval, s", "%d", (data[5] << 8) | data[4]);
+	iw_printf("Scan Passive Total Per Channel, TUs", "%d", (data[7] << 8) | data[6]);
+	iw_printf("Scan Active Total Per Channel, TUs", "%d", (data[9] << 8) | data[8]);
+	iw_printf("BSS Width Channel Transition Delay Factor", "%d", (data[11] << 8) | data[10]);
+	iw_printf("OBSS Scan Activity Threshold", "%d.%02d %%\n", ((data[13] << 8) | data[12]) / 100, ((data[13] << 8) | data[12]) % 100);
 }
 
 static void print_secchan_offs(const uint8_t type, uint8_t len,
@@ -1632,58 +1591,58 @@ static void print_secchan_offs(const uint8_t type, uint8_t len,
 			       const struct print_ies_data *ie_buffer)
 {
 	if (data[0] < ARRAY_SIZE(ht_secondary_offset))
-		printf(" %s (%d)\n", ht_secondary_offset[data[0]], data[0]);
+		iw_printf("Value", "%s (%d)", ht_secondary_offset[data[0]], data[0]);
 	else
-		printf(" %d\n", data[0]);
+		iw_printf("Value", "%d", data[0]);
 }
 
-static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *data,
+static void print_bss_load(const uint8_t type, uint8_t len, const uint8_t *_data,
 			   const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
-	printf("\t\t * station count: %d\n", (data[1] << 8) | data[0]);
-	printf("\t\t * channel utilisation: %d/255\n", data[2]);
-	printf("\t\t * available admission capacity: %d [*32us]\n", (data[4] << 8) | data[3]);
+	const int8_t *data = (int8_t *)_data;
+	iw_printf("Station Count", "%d", (data[1] << 8) | data[0]);
+	iw_printf("Channel Utilisation", "%d", data[2]);
+	iw_printf("Available Admission Capacity", "%d", (data[4] << 8) | data[3]);
 }
 
 static void print_mesh_conf(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
-	printf("\t\t * Active Path Selection Protocol ID: %d\n", data[0]);
-	printf("\t\t * Active Path Selection Metric ID: %d\n", data[1]);
-	printf("\t\t * Congestion Control Mode ID: %d\n", data[2]);
-	printf("\t\t * Synchronization Method ID: %d\n", data[3]);
-	printf("\t\t * Authentication Protocol ID: %d\n", data[4]);
-	printf("\t\t * Mesh Formation Info:\n");
-	printf("\t\t\t Number of Peerings: %d\n", (data[5] & 0x7E) >> 1);
+	iw_printf("Active Path Selection Protocol ID", "%d", data[0]);
+	iw_printf("Active Path Selection Metric ID", "%d", data[1]);
+	iw_printf("Congestion Control Mode ID", "%d", data[2]);
+	iw_printf("Synchronization Method ID", "%d", data[3]);
+	iw_printf("Authentication Protocol ID", "%d", data[4]);
+	json_arr_open("Mesh Formation Info");
+	iw_printf("Number of Peerings", "%d", (data[5] & 0x7E) >> 1);
 	if (data[5] & 0x01)
-		printf("\t\t\t Connected to Mesh Gate\n");
+		iw_printf(NULL, "Connected to Mesh Gate");
 	if (data[5] & 0x80)
-		printf("\t\t\t Connected to AS\n");
-	printf("\t\t * Mesh Capability\n");
+		iw_printf(NULL, "Connected to AS");
+	json_arr_close();
+	json_arr_open("Mesh Capability");
 	if (data[6] & 0x01)
-		printf("\t\t\t Accepting Additional Mesh Peerings\n");
+		iw_printf(NULL, "Accepting Additional Mesh Peerings");
 	if (data[6] & 0x02)
-		printf("\t\t\t MCCA Supported\n");
+		iw_printf(NULL, "MCCA Supported");
 	if (data[6] & 0x04)
-		printf("\t\t\t MCCA Enabled\n");
+		iw_printf(NULL, "MCCA Enabled");
 	if (data[6] & 0x08)
-		printf("\t\t\t Forwarding\n");
+		iw_printf(NULL, "Forwarding");
 	if (data[6] & 0x10)
-		printf("\t\t\t MBCA Supported\n");
+		iw_printf(NULL, "MBCA Supported");
 	if (data[6] & 0x20)
-		printf("\t\t\t TBTT Adjusting\n");
+		iw_printf(NULL, "TBTT Adjusting");
 	if (data[6] & 0x40)
-		printf("\t\t\t Mesh Power Save Level\n");
+		iw_printf(NULL, "Mesh Power Save Level");
+	json_arr_close();
 }
 
 static void print_s1g_capa(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_s1g_capability(data);
 }
 
@@ -1691,7 +1650,7 @@ static void print_short_beacon_int(const uint8_t type, uint8_t len,
 			    const uint8_t *data,
 			    const struct print_ies_data *ie_buffer)
 {
-	printf(" %d\n", (data[1] << 8) | data[0]);
+	iw_printf("Value", "%d", (data[1] << 8) | data[0]);
 }
 
 static void print_s1g_oper(const uint8_t type, uint8_t len,
@@ -1739,39 +1698,41 @@ static void print_s1g_oper(const uint8_t type, uint8_t len,
 		break;
 	}
 
-	printf("\n");
-	printf("\t\tChannel width:\n");
+	json_arr_open("Channel Width Info");
 	if (oper_ch_width == -1 || prim_ch_width == -1) {
-		printf("\t\t\tBSS primary channel width: invalid\n");
-		printf("\t\t\tBSS operating channel width: invalid\n");
+		iw_printf(NULL, "BSS primary channel width: invalid");
+		iw_printf(NULL, "BSS operating channel width: invalid");
 	} else {
-		printf("\t\t\tBSS primary channel width: %d MHz\n", prim_ch_width);
-		printf("\t\t\tBSS operating channel width: %d MHz\n", oper_ch_width);
+		iw_printf(NULL, "BSS primary channel width: %d MHz", prim_ch_width);
+		iw_printf(NULL, "BSS operating channel width: %d MHz", oper_ch_width);
 	}
 	if (data[0] & BIT(5))
-		printf("\t\t\t1 MHz primary channel located at the lower side of 2 MHz\n");
+		iw_printf(NULL, "1 MHz primary channel located at the lower side of 2 MHz");
 	else
-		printf("\t\t\t1 MHz primary channel located at the upper side of 2 MHz\n");
+		iw_printf(NULL, "1 MHz primary channel located at the upper side of 2 MHz");
 
 	if (data[0] & BIT(7))
-		printf("\t\t\tMCS 10 not recommended\n");
+		iw_printf(NULL, "MCS 10 not recommended");
+	json_arr_close();
 
-	printf("\t\t* operating class: %d\n", data[1]);
-	printf("\t\t* primary channel number: %d\n", data[2]);
+	iw_printf("Operating Class", "%d", data[1]);
+	iw_printf("Primary Channel Number", "%d", data[2]);
 
-	printf("\t\t* channel index: %d\n", data[3]);
+	iw_printf("channel index", "%d", data[3]);
 
-	printf("\t\tMax S1G MCS Map:\n");
-	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_max_support((data[4] >> 2) & 0x3));
-	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_max_support((data[4] >> 6) & 0x3));
-	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_max_support((data[5] >> 2) & 0x3));
-	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_max_support((data[5] >> 6) & 0x3));
+	json_obj_open("Max S1G MCS Map");
+	iw_printf("For 1 SS", "%s", s1g_ss_max_support((data[4] >> 2) & 0x3));
+	iw_printf("For 2 SS", "%s", s1g_ss_max_support((data[4] >> 6) & 0x3));
+	iw_printf("For 3 SS", "%s", s1g_ss_max_support((data[5] >> 2) & 0x3));
+	iw_printf("For 4 SS", "%s", s1g_ss_max_support((data[5] >> 6) & 0x3));
+	json_obj_close();
 
-	printf("\t\tMin S1G MCS Map:\n");
-	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_min_support(data[4] & 0x3));
-	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_min_support((data[4] >> 4) & 0x3));
-	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_min_support(data[5] & 0x3));
-	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_min_support((data[5] >> 4) & 0x3));
+	json_obj_open("Min S1G MCS Map");
+	iw_printf("For 1 SS", "%s", s1g_ss_min_support(data[4] & 0x3));
+	iw_printf("For 2 SS", "%s", s1g_ss_min_support((data[4] >> 4) & 0x3));
+	iw_printf("For 3 SS", "%s", s1g_ss_min_support(data[5] & 0x3));
+	iw_printf("For 4 SS", "%s", s1g_ss_min_support((data[5] >> 4) & 0x3));
+	json_obj_close();
 }
 
 struct ie_print {
@@ -1783,31 +1744,34 @@ struct ie_print {
 };
 
 static void print_ie(const struct ie_print *p, const uint8_t type, uint8_t len,
-		     const uint8_t *data,
-		     const struct print_ies_data *ie_buffer)
+                     const uint8_t *data,
+                     const struct print_ies_data *ie_buffer)
 {
-	int i;
+    int i;
 
-	if (!p->print)
-		return;
+    if (!p->print) return;
 
-	printf("\t%s:", p->name);
+	json_obj_open(p->name);
 	if (len < p->minlen || len > p->maxlen) {
+		iw_printf("Invalid Length", "%d", len);
 		if (len > 1) {
-			printf(" <invalid: %d bytes:", len);
+			json_arr_open("Invalid Data");
 			for (i = 0; i < len; i++)
-				printf(" %.02x", data[i]);
-			printf(">\n");
-		} else if (len)
-			printf(" <invalid: 1 byte: %.02x>\n", data[0]);
-		else
-			printf(" <invalid: no data>\n");
-		return;
+				iw_printf(NULL, "%.02x", data[i]);
+			json_arr_close();
+		} else if (len) {
+			iw_printf("1 byte", "%d", data[0]);
+		} else {
+			iw_printf("No data", "true");
+		}
+	} else {
+		// print callback
+		p->print(type, len, data, ie_buffer);
 	}
-
-	p->print(type, len, data, ie_buffer);
+	json_obj_close();
 }
 
+
 #define PRINT_IGN {		\
 	.name = "IGNORE",	\
 	.print = NULL,		\
@@ -1870,41 +1834,36 @@ static bool print_wifi_wmm_param(const uint8_t *data, uint8_t len)
 	int i;
 	static const char *aci_tbl[] = { "BE", "BK", "VI", "VO" };
 
-	if (len < 19)
-		goto invalid;
+	if (len < 19){
+		iw_printf("Invalid Length", "len < 19, len: %d", len);
+		return false;
+	}
+
+
+	iw_printf("Version", "%d", data[0]);
 
 	if (data[0] != 1) {
-		printf("Parameter: not version 1: ");
 		return false;
 	}
 
-	printf("\t * Parameter version 1");
-
 	data++;
 
-	if (data[0] & 0x80)
-		printf("\n\t\t * u-APSD");
-
+	if (data[0] & 0x80){
+		iw_printf("u-APSD", "%s", "true");
+	}
 	data += 2;
 
 	for (i = 0; i < 4; i++) {
-		printf("\n\t\t * %s:", aci_tbl[(data[0] >> 5) & 3]);
-		if (data[0] & 0x10)
-			printf(" acm");
-		printf(" CW %d-%d", (1 << (data[1] & 0xf)) - 1,
-				    (1 << (data[1] >> 4)) - 1);
-		printf(", AIFSN %d", data[0] & 0xf);
-		if (data[2] | data[3])
-			printf(", TXOP %d usec", (data[2] + (data[3] << 8)) * 32);
+		json_obj_open("%s", aci_tbl[(data[0] >> 5) & 3]);
+		if (data[0] & 0x10) iw_printf("acm", "%s", "true");
+		iw_printf("CW", "%d-%d", (1 << (data[1] & 0xf)) - 1, (1 << (data[1] >> 4)) - 1);
+		iw_printf("AIFSN", "%d", data[0] & 0xf);
+
+		if (data[2] | data[3]) iw_printf("TXOP_usec", "%d", (data[2] + (data[3] << 8)) * 32);
 		data += 4;
+		json_obj_close();
 	}
-
-	printf("\n");
 	return true;
-
- invalid:
- 	printf("invalid: ");
- 	return false;
 }
 
 static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
@@ -1914,20 +1873,22 @@ static void print_wifi_wmm(const uint8_t type, uint8_t len, const uint8_t *data,
 
 	switch (data[0]) {
 	case 0x00:
-		printf(" information:");
+		json_arr_open("Information");
 		break;
 	case 0x01:
 		if (print_wifi_wmm_param(data + 1, len - 1))
 			return;
 		break;
 	default:
-		printf(" type %d:", data[0]);
+		char buf[32];
+		snprintf(buf, sizeof(buf), "type %d", data[0]);
+		json_arr_open(buf);
 		break;
 	}
 
 	for(i = 1; i < len; i++)
-		printf(" %.02x", data[i]);
-	printf("\n");
+		iw_printf(NULL, "%.02x", data[i]);
+	json_arr_close();
 }
 
 static const char * wifi_wps_dev_passwd_id(uint16_t id)
@@ -1953,7 +1914,6 @@ static const char * wifi_wps_dev_passwd_id(uint16_t id)
 static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			   const struct print_ies_data *ie_buffer)
 {
-	bool first = true;
 	__u16 subtype, sublen;
 
 	while (len >= 4) {
@@ -1963,209 +1923,175 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 			break;
 
 		switch (subtype) {
-		case 0x104a:
-			tab_on_first(&first);
-			if (sublen < 1) {
-				printf("\t * Version: (invalid "
-				       "length %d)\n", sublen);
+			case 0x104a:
+				if (sublen < 1) {
+					iw_printf("Version invalid length", "%d", sublen);
+					break;
+				}
+				iw_printf("Version",  "%d.%d", data[4] >> 4, data[4] & 0xF);
 				break;
-			}
-			printf("\t * Version: %d.%d\n", data[4] >> 4, data[4] & 0xF);
-			break;
-		case 0x1011:
-			tab_on_first(&first);
-			printf("\t * Device name: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1012: {
-			uint16_t id;
-			tab_on_first(&first);
-			if (sublen != 2) {
-				printf("\t * Device Password ID: (invalid length %d)\n",
-				       sublen);
+			case 0x1011:
+				iw_printf("Device name", "%.*s", sublen, data + 4);
 				break;
-			}
-			id = data[4] << 8 | data[5];
-			printf("\t * Device Password ID: %u (%s)\n",
-			       id, wifi_wps_dev_passwd_id(id));
-			break;
-		}
-		case 0x1021:
-			tab_on_first(&first);
-			printf("\t * Manufacturer: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1023:
-			tab_on_first(&first);
-			printf("\t * Model: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1024:
-			tab_on_first(&first);
-			printf("\t * Model Number: %.*s\n", sublen, data + 4);
-			break;
-		case 0x103b: {
-			__u8 val;
-
-			if (sublen < 1) {
-				printf("\t * Response Type: (invalid length %d)\n",
-				       sublen);
+			case 0x1012: {
+				uint16_t id;
+				if (sublen != 2) {
+					iw_printf("Device password ID", "%d", sublen);
+					break;
+				}
+				id = data[4] << 8 | data[5];
+				iw_printf("Device Password ID",  "%u (%s)", id, wifi_wps_dev_passwd_id(id));
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * Response Type: %d%s\n",
-			       val, val == 3 ? " (AP)" : "");
-			break;
-		}
-		case 0x103c: {
-			__u8 val;
+			case 0x1021:
+				iw_printf("Manufacturer", "%.*s", sublen, data + 4);
+				break;
+			case 0x1023:
+				iw_printf("Model", "%.*s", sublen, data + 4);
+				break;
+			case 0x1024:
+				iw_printf("Model Number", "%.*s", sublen, data + 4);
+				break;
+			case 0x103b: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * RF Bands: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_printf("Response Type Invalid Length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("Response Type", "%d%s", val, val == 3 ? " (AP)" : "");
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * RF Bands: 0x%x\n", val);
-			break;
-		}
-		case 0x1041: {
-			__u8 val;
+			case 0x103c: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Selected Registrar: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_printf("RF Bands Invalid Length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("RF bands", "0x%x", val);
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * Selected Registrar: 0x%x\n", val);
-			break;
-		}
-		case 0x1042:
-			tab_on_first(&first);
-			printf("\t * Serial Number: %.*s\n", sublen, data + 4);
-			break;
-		case 0x1044: {
-			__u8 val;
+			case 0x1041: {
+				__u8 val;
 
-			if (sublen < 1) {
-				printf("\t * Wi-Fi Protected Setup State: (invalid length %d)\n",
-				       sublen);
+				if (sublen < 1) {
+					iw_printf("Selected Registrar Invalid Length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("Selected Registrar", "0x%x", val);
 				break;
 			}
-			val = data[4];
-			tab_on_first(&first);
-			printf("\t * Wi-Fi Protected Setup State: %d%s%s\n",
-			       val,
-			       val == 1 ? " (Unconfigured)" : "",
-			       val == 2 ? " (Configured)" : "");
-			break;
-		}
-		case 0x1047:
-			tab_on_first(&first);
-			printf("\t * UUID: ");
-			if (sublen != 16) {
-				printf("(invalid, length=%d)\n", sublen);
+			case 0x1042:
+				iw_printf("Serial Number", "%.*s", sublen, data + 4);
 				break;
+			case 0x1044: {
+				__u8 val;
+
+				if (sublen < 1) {
+					iw_printf("Wi-Fi Protected Setup State Invalid Length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("Wi-Fi Protected Setup State", "%d%s%s", val, val == 1 ? " (Unconfigured)" : "", val == 2 ? " (Configured)" : "");
+					break;
 			}
-			printf("%02x%02x%02x%02x-%02x%02x-%02x%02x-"
-				"%02x%02x-%02x%02x%02x%02x%02x%02x\n",
-				data[4], data[5], data[6], data[7],
-				data[8], data[9], data[10], data[11],
-				data[12], data[13], data[14], data[15],
-				data[16], data[17], data[18], data[19]);
-			break;
-		case 0x1049:
-			tab_on_first(&first);
-			if (sublen == 6 &&
-			    data[4] == 0x00 &&
-			    data[5] == 0x37 &&
-			    data[6] == 0x2a &&
-			    data[7] == 0x00 &&
-			    data[8] == 0x01) {
-				uint8_t v2 = data[9];
-				printf("\t * Version2: %d.%d\n", v2 >> 4, v2 & 0xf);
-			} else {
-				printf("\t * Unknown vendor extension. len=%u\n",
-				       sublen);
-			}
-			break;
-		case 0x1054: {
-			tab_on_first(&first);
-			if (sublen != 8) {
-				printf("\t * Primary Device Type: (invalid length %d)\n",
-				       sublen);
+			case 0x1047:
+				if (sublen != 16) {
+					iw_printf("UUID Invalid Length", "%d", sublen);
+					break;
+				}
+				iw_printf("UUID", "%02x%02x-%02x%02x%02x%02x%02x%02x",
+					"%02x%02x-%02x%02x%02x%02x%02x%02x",
+					data[4], data[5], data[6], data[7],
+					data[8], data[9], data[10], data[11],
+					data[12], data[13], data[14], data[15],
+					data[16], data[17], data[18], data[19]);
 				break;
-			}
-			printf("\t * Primary Device Type: "
-			       "%u-%02x%02x%02x%02x-%u\n",
-			       data[4] << 8 | data[5],
-			       data[6], data[7], data[8], data[9],
-			       data[10] << 8 | data[11]);
-			break;
-		}
-		case 0x1057: {
-			__u8 val;
-			tab_on_first(&first);
-			if (sublen < 1) {
-				printf("\t * AP setup locked: (invalid length %d)\n",
-				       sublen);
+			case 0x1049:
+				if (sublen == 6 &&
+					data[4] == 0x00 &&
+					data[5] == 0x37 &&
+					data[6] == 0x2a &&
+					data[7] == 0x00 &&
+					data[8] == 0x01) {
+					uint8_t v2 = data[9];
+					iw_printf("Version2", "%d.%d", v2 >> 4, v2 & 0xf);
+				} else {
+					iw_printf("Unknown Vendor Extension Length", "%u", sublen);
+				}
+				break;
+			case 0x1054: {
+				if (sublen != 8) {
+					iw_printf("Primary Device Type Invalid Length", "%d", sublen);
+					break;
+				}
+				iw_printf("Primary Device Type",
+					"%u-%02x%02x%02x%02x-%u",
+					data[4] << 8 | data[5],
+					data[6], data[7], data[8], data[9],
+					data[10] << 8 | data[11]);
 				break;
 			}
-			val = data[4];
-			printf("\t * AP setup locked: 0x%.2x\n", val);
-			break;
-		}
-		case 0x1008:
-		case 0x1053: {
-			__u16 meth;
-			bool comma;
-
-			if (sublen < 2) {
-				printf("\t * Config methods: (invalid length %d)\n",
-				       sublen);
+			case 0x1057: {
+				__u8 val;
+				if (sublen < 1) {
+					iw_printf("AP Setup Locked Invalid Length", "%d", sublen);
+					break;
+				}
+				val = data[4];
+				iw_printf("AP Setup Locked", "0x%.2x", val);
 				break;
 			}
-			meth = (data[4] << 8) + data[5];
-			comma = false;
-			tab_on_first(&first);
-			printf("\t * %sConfig methods:",
-			       subtype == 0x1053 ? "Selected Registrar ": "");
+			case 0x1008:
+			case 0x1053: {
+				__u16 meth;
+
+				if (sublen < 2) {
+					iw_printf("Config Methods Invalid Length", "%d", sublen);
+					break;
+				}
+				meth = (data[4] << 8) + data[5];
+				iw_printf("Config Methods Selected Registrar", "%s", "true");
+				json_arr_open("Config Methods");
+
 #define T(bit, name) do {		\
 	if (meth & (1<<bit)) {		\
-		if (comma)		\
-			printf(",");	\
-		comma = true;		\
-		printf(" " name);	\
-	} } while (0)
-			T(0, "USB");
-			T(1, "Ethernet");
-			T(2, "Label");
-			T(3, "Display");
-			T(4, "Ext. NFC");
-			T(5, "Int. NFC");
-			T(6, "NFC Intf.");
-			T(7, "PBC");
-			T(8, "Keypad");
-			printf("\n");
-			break;
-#undef T
-		}
-		default: {
-			const __u8 *subdata = data + 4;
-			__u16 tmplen = sublen;
+		iw_printf(NULL, name); \
+	} \
+} while (0)
 
-			tab_on_first(&first);
-			printf("\t * Unknown TLV (%#.4x, %d bytes):",
-			       subtype, tmplen);
-			while (tmplen) {
-				printf(" %.2x", *subdata);
-				subdata++;
-				tmplen--;
+				T(0, "USB");
+				T(1, "Ethernet");
+				T(2, "Label");
+				T(3, "Display");
+				T(4, "Ext. NFC");
+				T(5, "Int. NFC");
+				T(6, "NFC Intf.");
+				T(7, "PBC");
+				T(8, "Keypad");
+				json_arr_close();
+				break;
+#undef T
+			} //case 0x1053
+			default: {
+				const __u8 *subdata = data + 4;
+				__u16 tmplen = sublen;
+
+				iw_printf("Unknown TLV", "%#.4x, %d bytes", subtype, tmplen);
+				json_arr_open("Unknown TLV Data");
+
+				while (tmplen) {
+					iw_printf(NULL, "%.2x", *subdata);
+					subdata++;
+					tmplen--;
+				}
+				json_arr_close();
+				break;
 			}
-			printf("\n");
-			break;
-		}
 		}
 
 		data += sublen + 4;
@@ -2173,13 +2099,15 @@ static void print_wifi_wps(const uint8_t type, uint8_t len, const uint8_t *data,
 	}
 
 	if (len != 0) {
-		printf("\t\t * bogus tail data (%d):", len);
+		iw_printf("Bogus Tail Data Length", "%d", len);
+		json_arr_open("Bogus Tail Data");
+
 		while (len) {
-			printf(" %.2x", *data);
+			iw_printf(NULL, "%.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		json_arr_close();
 	}
 }
 
@@ -2193,7 +2121,6 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 			     const uint8_t *data,
 			     const struct print_ies_data *ie_buffer)
 {
-	bool first = true;
 	__u8 subtype;
 	__u16 sublen;
 
@@ -2206,17 +2133,16 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 
 		switch (subtype) {
 		case 0x02: /* capability */
-			tab_on_first(&first);
 			if (sublen < 2) {
-				printf("\t * malformed capability\n");
+				iw_printf("Malformed Capability", "true");
 				break;
 			}
-			printf("\t * Group capa: 0x%.2x, Device capa: 0x%.2x\n",
-				data[3], data[4]);
+			iw_printf("Group capa", "0x%.2x", data[3]);
+			iw_printf("Device capa", "0x%.2x", data[4]);
 			break;
 		case 0x0d: /* device info */
 			if (sublen < 6 + 2 + 8 + 1) {
-				printf("\t * malformed device info\n");
+				iw_printf("Malformed Device Info", "true");
 				break;
 			}
 			/* fall through */
@@ -2242,15 +2168,17 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 			const __u8 *subdata = data + 3;
 			__u16 tmplen = sublen;
 
-			tab_on_first(&first);
-			printf("\t * Unknown TLV (%#.2x, %d bytes):",
-			       subtype, tmplen);
+			json_obj_open("Unknown TLV");
+			iw_printf("Type", "%#.2x", subtype);
+			iw_printf("Length", "%d", tmplen);
+			json_arr_open("Data");
 			while (tmplen) {
-				printf(" %.2x", *subdata);
+				iw_printf(NULL, "%.2x", *subdata);
 				subdata++;
 				tmplen--;
 			}
-			printf("\n");
+			json_arr_close();
+			json_obj_close();
 			break;
 		}
 		}
@@ -2260,14 +2188,16 @@ static inline void print_p2p(const uint8_t type, uint8_t len,
 	}
 
 	if (len != 0) {
-		tab_on_first(&first);
-		printf("\t * bogus tail data (%d):", len);
+		json_obj_open("Bogus Tail Data");
+		iw_printf("Length", "%d", len);
+		json_arr_open("Data");
 		while (len) {
-			printf(" %.2x", *data);
+			iw_printf(NULL, "%.2x", *data);
 			data++;
 			len--;
 		}
-		printf("\n");
+		json_arr_close();
+		json_obj_close();
 	}
 }
 
@@ -2276,11 +2206,10 @@ static inline void print_hs20_ind(const uint8_t type, uint8_t len,
 				  const struct print_ies_data *ie_buffer)
 {
 	/* I can't find the spec for this...just going off what wireshark uses. */
-	printf("\n");
 	if (len > 0)
-		printf("\t\tDGAF: %i\n", (int)(data[0] & 0x1));
+		iw_printf("DGAF", "%i", (int)(data[0] & 0x1));
 	else
-		printf("\t\tUnexpected length: %i\n", len);
+		iw_printf("Unexpected Length", "%i", len);
 }
 
 static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
@@ -2290,24 +2219,21 @@ static void print_wifi_owe_tarns(const uint8_t type, uint8_t len,
 	char mac_addr[20];
 	int ssid_len;
 
-	printf("\n");
 	if (len < 7)
 		return;
 
 	mac_addr_n2a(mac_addr, data);
-	printf("\t\tBSSID: %s\n", mac_addr);
+	iw_printf("BSSID", "%s", mac_addr);
 
 	ssid_len = data[6];
 	if (ssid_len > len - 7)
 		return;
-	printf("\t\tSSID: ");
 	print_ssid_escaped(ssid_len, data + 7);
-	printf("\n");
 
 	/* optional elements */
 	if (len >= ssid_len + 9) {
-		printf("\t\tBand Info: %u\n", data[ssid_len + 7]);
-		printf("\t\tChannel Info: %u\n", data[ssid_len + 8]);
+		iw_printf("Band Info", "%u", data[ssid_len + 7]);
+		iw_printf("Channel Info", "%u", data[ssid_len + 8]);
 	}
 }
 
@@ -2322,30 +2248,32 @@ static void print_vendor(unsigned char len, unsigned char *data,
 			 bool unknown, enum print_ie_type ptype)
 {
 	int i;
-
 	if (len < 3) {
-		printf("\tVendor specific: <too short> data:");
-		for(i = 0; i < len; i++)
-			printf(" %.02x", data[i]);
-		printf("\n");
+		json_arr_open("vendor specific too short");
+		for(i = 0; i < len; i++){
+			iw_printf(NULL, "%.02x", data[i]);
+		}
+		json_arr_close();
 		return;
 	}
 
 	if (len >= 4 && memcmp(data, ms_oui, 3) == 0) {
 		if (data[3] < ARRAY_SIZE(wifiprinters) &&
-		    wifiprinters[data[3]].name &&
-		    wifiprinters[data[3]].flags & BIT(ptype)) {
+			wifiprinters[data[3]].name &&
+			wifiprinters[data[3]].flags & BIT(ptype)) {
 			print_ie(&wifiprinters[data[3]],
-				 data[3], len - 4, data + 4,
-				 NULL);
+				data[3], len - 4, data + 4,
+				NULL);
 			return;
 		}
-		if (!unknown)
-			return;
-		printf("\tMS/WiFi %#.2x, data:", data[3]);
-		for(i = 0; i < len - 4; i++)
-			printf(" %.02x", data[i + 4]);
-		printf("\n");
+		if (!unknown) return;
+
+		iw_printf("MS/WiFi", "%#.2x", data[3]);
+		json_arr_open("Data");
+		for(i = 0; i < len - 4; i++){
+			iw_printf(NULL, "%.02x", data[i + 4]);
+		}
+		json_arr_close();
 		return;
 	}
 
@@ -2360,27 +2288,31 @@ static void print_vendor(unsigned char len, unsigned char *data,
 		}
 		if (!unknown)
 			return;
-		printf("\tWFA %#.2x, data:", data[3]);
+		char buf[32];
+		snprintf(buf, sizeof(buf), "WFA %#.2x, data", data[3]);
+		json_arr_open(buf, NULL);
 		for(i = 0; i < len - 4; i++)
-			printf(" %.02x", data[i + 4]);
-		printf("\n");
+			iw_printf(NULL, "%.02x", data[i + 4]);
+		json_arr_close();
 		return;
 	}
 
 	if (!unknown)
 		return;
 
-	printf("\tVendor specific: OUI %.2x:%.2x:%.2x, data:",
-		data[0], data[1], data[2]);
+	json_obj_open("Vendor specific");
+	iw_printf("OUI", "%.2x:%.2x:%.2x", data[0], data[1], data[2]);
+
+	json_arr_open("Data");
 	for (i = 3; i < len; i++)
-		printf(" %.2x", data[i]);
-	printf("\n");
+		iw_printf(NULL, "%.2x", data[i]);
+	json_arr_close();
+	json_obj_close();
 }
 
 static void print_he_capa(const uint8_t type, uint8_t len, const uint8_t *data,
 			  const struct print_ies_data *ie_buffer)
 {
-	printf("\n");
 	print_he_capability(data, len);
 }
 
@@ -2394,7 +2326,7 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	unsigned char tag;
 
 	if (len < 1) {
-		printf("\tExtension IE: <empty>\n");
+		iw_printf("Extension IE empty", "true");
 		return;
 	}
 
@@ -2408,10 +2340,13 @@ static void print_extension(unsigned char len, unsigned char *ie,
 	if (unknown) {
 		int i;
 
-		printf("\tUnknown Extension ID (%d):", ie[0]);
+		json_obj_open("Unknown Extension ID");
+		iw_printf("ID", "%d", ie[0]);
+		json_arr_open("Data");
 		for (i = 1; i < len; i++)
-			printf(" %.2x", ie[i]);
-		printf("\n");
+			iw_printf(NULL, "%.2x", ie[i]);
+		json_arr_close();
+		json_obj_close();
 	}
 }
 
@@ -2439,10 +2374,13 @@ void print_ies(unsigned char *ie, int ielen, bool unknown,
 		} else if (unknown) {
 			int i;
 
-			printf("\tUnknown IE (%d):", ie[0]);
+			json_obj_open("Unknown IE");
+			iw_printf("IE", "%d", ie[0]);
+			json_arr_open("Data");
 			for (i=0; i<ie[1]; i++)
-				printf(" %.2x", ie[2+i]);
-			printf("\n");
+				iw_printf(NULL, "%.2x", ie[2+i]);
+			json_arr_close();
+			json_obj_close();
 		}
 		ielen -= ie[1] + 2;
 		ie += ie[1] + 2;
@@ -2453,64 +2391,64 @@ static void print_capa_dmg(__u16 capa)
 {
 	switch (capa & WLAN_CAPABILITY_DMG_TYPE_MASK) {
 	case WLAN_CAPABILITY_DMG_TYPE_AP:
-		printf(" DMG_ESS");
+		iw_printf(NULL, "DMG_ESS");
 		break;
 	case WLAN_CAPABILITY_DMG_TYPE_PBSS:
-		printf(" DMG_PCP");
+		iw_printf(NULL, "DMG_PCP");
 		break;
 	case WLAN_CAPABILITY_DMG_TYPE_IBSS:
-		printf(" DMG_IBSS");
+		iw_printf(NULL, "DMG_IBSS");
 		break;
 	}
 
 	if (capa & WLAN_CAPABILITY_DMG_CBAP_ONLY)
-		printf(" CBAP_Only");
+		iw_printf(NULL, "CBAP_Only");
 	if (capa & WLAN_CAPABILITY_DMG_CBAP_SOURCE)
-		printf(" CBAP_Src");
+		iw_printf(NULL, "CBAP_Src");
 	if (capa & WLAN_CAPABILITY_DMG_PRIVACY)
-		printf(" Privacy");
+		iw_printf(NULL, "Privacy");
 	if (capa & WLAN_CAPABILITY_DMG_ECPAC)
-		printf(" ECPAC");
+		iw_printf(NULL, "ECPAC");
 	if (capa & WLAN_CAPABILITY_DMG_SPECTRUM_MGMT)
-		printf(" SpectrumMgmt");
+		iw_printf(NULL, "SpectrumMgmt");
 	if (capa & WLAN_CAPABILITY_DMG_RADIO_MEASURE)
-		printf(" RadioMeasure");
+		iw_printf(NULL, "RadioMeasure");
 }
 
 static void print_capa_non_dmg(__u16 capa)
 {
 	if (capa & WLAN_CAPABILITY_ESS)
-		printf(" ESS");
+		iw_printf(NULL, "ESS");
 	if (capa & WLAN_CAPABILITY_IBSS)
-		printf(" IBSS");
+		iw_printf(NULL, "IBSS");
 	if (capa & WLAN_CAPABILITY_CF_POLLABLE)
-		printf(" CfPollable");
+		iw_printf(NULL, "CfPollable");
 	if (capa & WLAN_CAPABILITY_CF_POLL_REQUEST)
-		printf(" CfPollReq");
+		iw_printf(NULL, "CfPollReq");
 	if (capa & WLAN_CAPABILITY_PRIVACY)
-		printf(" Privacy");
+		iw_printf(NULL, "Privacy");
 	if (capa & WLAN_CAPABILITY_SHORT_PREAMBLE)
-		printf(" ShortPreamble");
+		iw_printf(NULL, "ShortPreamble");
 	if (capa & WLAN_CAPABILITY_PBCC)
-		printf(" PBCC");
+		iw_printf(NULL, "PBCC");
 	if (capa & WLAN_CAPABILITY_CHANNEL_AGILITY)
-		printf(" ChannelAgility");
+		iw_printf(NULL, "ChannelAgility");
 	if (capa & WLAN_CAPABILITY_SPECTRUM_MGMT)
-		printf(" SpectrumMgmt");
+		iw_printf(NULL, "SpectrumMgmt");
 	if (capa & WLAN_CAPABILITY_QOS)
-		printf(" QoS");
+		iw_printf(NULL, "QoS");
 	if (capa & WLAN_CAPABILITY_SHORT_SLOT_TIME)
-		printf(" ShortSlotTime");
+		iw_printf(NULL, "ShortSlotTime");
 	if (capa & WLAN_CAPABILITY_APSD)
-		printf(" APSD");
+		iw_printf(NULL, "APSD");
 	if (capa & WLAN_CAPABILITY_RADIO_MEASURE)
-		printf(" RadioMeasure");
+		iw_printf(NULL, "RadioMeasure");
 	if (capa & WLAN_CAPABILITY_DSSS_OFDM)
-		printf(" DSSS-OFDM");
+		iw_printf(NULL, "DSSS-OFDM");
 	if (capa & WLAN_CAPABILITY_DEL_BACK)
-		printf(" DelayedBACK");
+		iw_printf(NULL, "DelayedBACK");
 	if (capa & WLAN_CAPABILITY_IMM_BACK)
-		printf(" ImmediateBACK");
+		iw_printf(NULL, "ImmediateBACK");
 }
 
 static int print_bss_handler(struct nl_msg *msg, void *arg)
@@ -2537,16 +2475,15 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 	int show = params->show_both_ie_sets ? 2 : 1;
 	bool is_dmg = false;
 
-	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
-		  genlmsg_attrlen(gnlh, 0), NULL);
+	nla_parse(tb, NL80211_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0), NULL);
 
 	if (!tb[NL80211_ATTR_BSS]) {
 		fprintf(stderr, "bss info missing!\n");
 		return NL_SKIP;
 	}
 	if (nla_parse_nested(bss, NL80211_BSS_MAX,
-			     tb[NL80211_ATTR_BSS],
-			     bss_policy)) {
+				tb[NL80211_ATTR_BSS],
+				bss_policy)) {
 		fprintf(stderr, "failed to parse nested attributes!\n");
 		return NL_SKIP;
 	}
@@ -2555,78 +2492,85 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 		return NL_SKIP;
 
 	mac_addr_n2a(mac_addr, nla_data(bss[NL80211_BSS_BSSID]));
-	printf("BSS %s", mac_addr);
+	json_obj_open(mac_addr);
+
 	if (tb[NL80211_ATTR_IFINDEX]) {
 		if_indextoname(nla_get_u32(tb[NL80211_ATTR_IFINDEX]), dev);
-		printf("(on %s)", dev);
+		iw_printf("Ifname", "%s", dev);
 	}
 
+	char buf[32] = {0};
 	if (bss[NL80211_BSS_STATUS]) {
 		switch (nla_get_u32(bss[NL80211_BSS_STATUS])) {
 		case NL80211_BSS_STATUS_AUTHENTICATED:
-			printf(" -- authenticated");
+			snprintf(buf, sizeof(buf), "authenticated");
 			break;
 		case NL80211_BSS_STATUS_ASSOCIATED:
-			printf(" -- associated");
+			snprintf(buf, sizeof(buf), "associated");
 			break;
 		case NL80211_BSS_STATUS_IBSS_JOINED:
-			printf(" -- joined");
+			snprintf(buf, sizeof(buf), "joined");
 			break;
 		default:
-			printf(" -- unknown status: %d",
-				nla_get_u32(bss[NL80211_BSS_STATUS]));
+			snprintf(buf, sizeof(buf), "unknown status: %d", nla_get_u32(bss[NL80211_BSS_STATUS]));
 			break;
 		}
 	}
-	printf("\n");
+	iw_printf("Status", "%s", buf);
 
 	if (bss[NL80211_BSS_LAST_SEEN_BOOTTIME]) {
 		unsigned long long bt;
 		bt = (unsigned long long)nla_get_u64(bss[NL80211_BSS_LAST_SEEN_BOOTTIME]);
-		printf("\tlast seen: %llu.%.3llus [boottime]\n", bt/1000000000, (bt%1000000000)/1000000);
+		iw_printf("Last Seen", "%llu.%.3llus [boottime]", bt/1000000000, (bt%1000000000)/1000000);
 	}
 
 	if (bss[NL80211_BSS_TSF]) {
 		unsigned long long tsf;
 		tsf = (unsigned long long)nla_get_u64(bss[NL80211_BSS_TSF]);
-		printf("\tTSF: %llu usec (%llud, %.2lld:%.2llu:%.2llu)\n",
-			tsf, tsf/1000/1000/60/60/24, (tsf/1000/1000/60/60) % 24,
-			(tsf/1000/1000/60) % 60, (tsf/1000/1000) % 60);
+
+		json_obj_open("TSF");
+		iw_printf("usec", "%llu", tsf);
+		iw_printf("dd", "%llu", tsf/1000/1000/60/60/24);
+		iw_printf("hh", "%llu", (tsf/1000/1000/60/60) % 24);
+		iw_printf("mm", "%llu", (tsf/1000/1000/60) % 60);
+		iw_printf("ss", "%llu", (tsf/1000/1000) % 60);
+		json_obj_close();
 	}
 	if (bss[NL80211_BSS_FREQUENCY]) {
 		int freq = nla_get_u32(bss[NL80211_BSS_FREQUENCY]);
 		if (bss[NL80211_BSS_FREQUENCY_OFFSET])
-			printf("\tfreq: %d.%d\n", freq,
-			    nla_get_u32(bss[NL80211_BSS_FREQUENCY_OFFSET]));
+			iw_printf("Frequency, MHz", "%d.%d", freq, nla_get_u32(bss[NL80211_BSS_FREQUENCY_OFFSET]));
 		else
-			printf("\tfreq: %d\n", freq);
+			iw_printf("Frequency, MHz", "%d", freq);
 
 		if (freq > 45000)
 			is_dmg = true;
 	}
 	if (bss[NL80211_BSS_BEACON_INTERVAL])
-		printf("\tbeacon interval: %d TUs\n",
-			nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
+		iw_printf("Beacon Interval, TUs", "%d", nla_get_u16(bss[NL80211_BSS_BEACON_INTERVAL]));
 	if (bss[NL80211_BSS_CAPABILITY]) {
 		__u16 capa = nla_get_u16(bss[NL80211_BSS_CAPABILITY]);
-		printf("\tcapability:");
-		if (is_dmg)
+		json_arr_open("Capability");
+		if (is_dmg){
 			print_capa_dmg(capa);
-		else
+		}else{
 			print_capa_non_dmg(capa);
-		printf(" (0x%.4x)\n", capa);
+		}
+		json_arr_close();
+
+		iw_printf("Capability Raw Value", "0x%.4x", capa);
 	}
 	if (bss[NL80211_BSS_SIGNAL_MBM]) {
 		int s = nla_get_u32(bss[NL80211_BSS_SIGNAL_MBM]);
-		printf("\tsignal: %d.%.2d dBm\n", s/100, s%100);
+		iw_printf("Signal", "%d.%.2d dBm", s/100, s%100);
 	}
 	if (bss[NL80211_BSS_SIGNAL_UNSPEC]) {
 		unsigned char s = nla_get_u8(bss[NL80211_BSS_SIGNAL_UNSPEC]);
-		printf("\tsignal: %d/100\n", s);
+		iw_printf("Signal, Dbm", "%d/100", s);
 	}
 	if (bss[NL80211_BSS_SEEN_MS_AGO]) {
 		int age = nla_get_u32(bss[NL80211_BSS_SEEN_MS_AGO]);
-		printf("\tlast seen: %d ms ago\n", age);
+		iw_printf("Last Seen Ago, ms", "%d", age);
 	}
 
 	if (bss[NL80211_BSS_INFORMATION_ELEMENTS] && show--) {
@@ -2634,21 +2578,24 @@ static int print_bss_handler(struct nl_msg *msg, void *arg)
 		struct nlattr *bcnies = bss[NL80211_BSS_BEACON_IES];
 
 		if (bss[NL80211_BSS_PRESP_DATA] ||
-		    (bcnies && (nla_len(ies) != nla_len(bcnies) ||
+			(bcnies && (nla_len(ies) != nla_len(bcnies) ||
 				memcmp(nla_data(ies), nla_data(bcnies),
-				       nla_len(ies)))))
-			printf("\tInformation elements from Probe Response "
-			       "frame:\n");
-		print_ies(nla_data(ies), nla_len(ies),
-			  params->unknown, params->type);
+					nla_len(ies))))){
+			json_obj_open("BSS Probe Response Data Frame");
+			print_ies(nla_data(ies), nla_len(ies), params->unknown, params->type);
+			json_obj_close();
+		}
 	}
 	if (bss[NL80211_BSS_BEACON_IES] && show--) {
-		printf("\tInformation elements from Beacon frame:\n");
+		json_obj_open("BSS Beacon Frame");
 		print_ies(nla_data(bss[NL80211_BSS_BEACON_IES]),
-			  nla_len(bss[NL80211_BSS_BEACON_IES]),
-			  params->unknown, params->type);
+			nla_len(bss[NL80211_BSS_BEACON_IES]),
+			params->unknown, params->type);
+		json_obj_close();
 	}
 
+	json_obj_close();
+
 	return NL_SKIP;
 }
 
@@ -2744,7 +2691,7 @@ static int handle_scan_combined(struct nl80211_state *state,
 
 	if (listen_events(state, ARRAY_SIZE(cmds), cmds) ==
 					NL80211_CMD_SCAN_ABORTED) {
-		printf("scan aborted!\n");
+		iw_printf("scan aborted", "true");
 		return 0;
 	}
 
diff --git a/util.c b/util.c
index 2527650..c837f9c 100644
--- a/util.c
+++ b/util.c
@@ -5,6 +5,8 @@
 #include "iw.h"
 #include "nl80211.h"
 
+#include "json/iw_json_print.h"
+
 void mac_addr_n2a(char *mac_addr, const unsigned char *arg)
 {
 	int i, l;
@@ -222,19 +224,27 @@ int ieee80211_frequency_to_channel(int freq)
 		return 0;
 }
 
-void print_ssid_escaped(const uint8_t len, const uint8_t *data)
-{
-	int i;
+static char *ssid_escape(const uint8_t len, const uint8_t *data) {
+    static char buf[512]; // static buffer
+	int bufsize = (int)sizeof(buf);
+	int pos = 0;
 
-	for (i = 0; i < len; i++) {
-		if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\')
-			printf("%c", data[i]);
-		else if (data[i] == ' ' &&
-			 (i != 0 && i != len -1))
-			printf(" ");
-		else
-			printf("\\x%.2x", data[i]);
-	}
+    for (int i = 0; i < len && pos < bufsize - 5; i++) { // leave space for "\xXX" and terminator byte
+        if (isprint(data[i]) && data[i] != ' ' && data[i] != '\\') {
+            buf[pos++] = data[i];
+        } else if (data[i] == ' ' && (i != 0 && i != len - 1)) {
+            buf[pos++] = ' ';
+        } else {
+            pos += snprintf(buf + pos, bufsize - pos, "\\x%.2x", data[i]);
+        }
+    }
+    buf[pos] = '\0'; // set terminator byte
+    return buf;
+}
+
+void print_ssid_escaped(const uint8_t len, const uint8_t *data) {
+	char *escaped_ssid = ssid_escape(len, data);
+	iw_printf("SSID", "%s", escaped_ssid);
 }
 
 static int hex2num(char digit)
@@ -331,7 +341,7 @@ int parse_keys(struct nl_msg *msg, char **argv[], int *argc)
 		NLA_PUT_U32(msg, NL80211_ATTR_WPA_VERSIONS, NL80211_WPA_VERSION_2);
 
 		if (strlen(&arg[pos]) != (sizeof(psk_keybuf) * 2) || !hex2bin(&arg[pos], psk_keybuf)) {
-			printf("Bad PSK\n");
+			iw_printf("Bad PSK", "true");
 			return -EINVAL;
 		}
 
@@ -810,34 +820,52 @@ static void print_mcs_index(const __u8 *mcs)
 {
 	int mcs_bit, prev_bit = -2, prev_cont = 0;
 
+	char buf[8];
+	char *p = (char *)buf;
+	int bufleft = (int)sizeof(buf);
+	int written = 0;
+
 	for (mcs_bit = 0; mcs_bit <= 76; mcs_bit++) {
-		unsigned int mcs_octet = mcs_bit/8;
-		unsigned int MCS_RATE_BIT = 1 << mcs_bit % 8;
-		bool mcs_rate_idx_set;
+		unsigned int mcs_octet = mcs_bit / 8;
+		unsigned int MCS_RATE_BIT = 1 << (mcs_bit % 8);
+		bool mcs_rate_idx_set = (mcs[mcs_octet] & MCS_RATE_BIT) != 0;
 
-		mcs_rate_idx_set = !!(mcs[mcs_octet] & MCS_RATE_BIT);
+		if (!mcs_rate_idx_set) continue;
 
-		if (!mcs_rate_idx_set)
-			continue;
 
 		if (prev_bit != mcs_bit - 1) {
-			if (prev_bit != -2)
-				printf("%d, ", prev_bit);
-			else
-				printf(" ");
-			printf("%d", mcs_bit);
+			if (prev_bit != -2) {
+				//print single or range value
+				snprintf(p, bufleft, "%d", prev_bit);
+				iw_printf(NULL, "%s", buf);
+
+				//reset buffer
+				p = buf;
+				bufleft = sizeof(buf);
+
+			}
+
+			written = snprintf(p, bufleft, "%d", mcs_bit);
+			p += written;
+			bufleft -= written;
 			prev_cont = 0;
 		} else if (!prev_cont) {
-			printf("-");
+			written = snprintf(p, bufleft, "-");
+			p += written;
+			bufleft -= written;
 			prev_cont = 1;
 		}
 
 		prev_bit = mcs_bit;
 	}
 
-	if (prev_cont)
-		printf("%d", prev_bit);
-	printf("\n");
+	//if is range write last chunk
+	if (prev_cont) {
+		snprintf(p, bufleft, "%d", prev_bit);
+	}
+
+	//print last value
+	iw_printf(NULL, "%s", buf);
 }
 
 /*
@@ -880,18 +908,18 @@ void print_ampdu_length(__u8 exponent)
 	max_ampdu_length = compute_ampdu_length(exponent);
 
 	if (max_ampdu_length) {
-		printf("\t\tMaximum RX AMPDU length %d bytes (exponent: 0x0%02x)\n",
-		       max_ampdu_length, exponent);
+		iw_printf("max_ampdu_length", "%d", max_ampdu_length);
 	} else {
-		printf("\t\tMaximum RX AMPDU length: unrecognized bytes "
-		       "(exponent: %d)\n", exponent);
+		iw_printf("max_ampdu_length", "%d", -1);
 	}
+	iw_printf("max_ampdu_exponent", "0x0%02x", exponent);
+
 }
 
 void print_ampdu_spacing(__u8 spacing)
 {
-	printf("\t\tMinimum RX AMPDU time spacing: %s (0x%02x)\n",
-	       print_ampdu_space(spacing), spacing);
+	iw_printf("min_rx_ampdu_time_spacing", "%s", print_ampdu_space(spacing));
+	iw_printf("min_rx_ampdu_time_spacing_value", "0x0%02x", spacing);
 }
 
 void print_ht_capability(__u16 cap)
@@ -899,10 +927,11 @@ void print_ht_capability(__u16 cap)
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
 		if (_cond) \
-			printf("\t\t\t" _str "\n"); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
-	printf("\t\tCapabilities: 0x%02x\n", cap);
+	iw_printf("capabilities_value", "0x%02x", cap);
+	json_arr_open("capabilities");
 
 	PRINT_HT_CAP((cap & BIT(0)), "RX LDPC");
 	PRINT_HT_CAP((cap & BIT(1)), "HT20/HT40");
@@ -941,6 +970,8 @@ void print_ht_capability(__u16 cap)
 	PRINT_HT_CAP((cap & BIT(14)), "40 MHz Intolerant");
 
 	PRINT_HT_CAP((cap & BIT(15)), "L-SIG TXOP protection");
+
+	json_arr_close();
 #undef PRINT_HT_CAP
 }
 
@@ -956,32 +987,28 @@ void print_ht_mcs(const __u8 *mcs)
 	tx_max_num_spatial_streams = ((mcs[12] >> 2) & 3) + 1;
 	tx_unequal_modulation = !!(mcs[12] & (1 << 4));
 
-	if (max_rx_supp_data_rate)
-		printf("\t\tHT Max RX data rate: %d Mbps\n", max_rx_supp_data_rate);
+	if (max_rx_supp_data_rate){
+		iw_printf("ht_max_rx_data_rate_mbps", "%d", max_rx_supp_data_rate);
+	}
 	/* XXX: else see 9.6.0e.5.3 how to get this I think */
 
 	if (tx_mcs_set_defined) {
 		if (tx_mcs_set_equal) {
-			printf("\t\tHT TX/RX MCS rate indexes supported:");
+			json_arr_open("ht_tx_rx_mcs_idx_supported");
 			print_mcs_index(mcs);
+			json_arr_close();
 		} else {
-			printf("\t\tHT RX MCS rate indexes supported:");
+			json_arr_open("ht_rx_mcs_idx_supported");
 			print_mcs_index(mcs);
+			json_arr_close();
 
-			if (tx_unequal_modulation)
-				printf("\t\tTX unequal modulation supported\n");
-			else
-				printf("\t\tTX unequal modulation not supported\n");
-
-			printf("\t\tHT TX Max spatial streams: %d\n",
-				tx_max_num_spatial_streams);
-
-			printf("\t\tHT TX MCS rate indexes supported may differ\n");
+			iw_printf("tx_unequal_modulation", "%s", tx_unequal_modulation);
+			iw_printf("ht_tx_max_spatial_streams", "%d", tx_max_num_spatial_streams);
 		}
 	} else {
-		printf("\t\tHT RX MCS rate indexes supported:");
+		json_arr_open("ht_rx_mcs_idx_supported");
 		print_mcs_index(mcs);
-		printf("\t\tHT TX MCS rate indexes are undefined\n");
+		json_arr_close();
 	}
 }
 
@@ -1096,13 +1123,13 @@ static const struct vht_nss_ratio nss_ratio_tbl[3][4] = {
 	},
 };
 
-static void print_nss_ratio_value(int ratio)
+static const char *nss_ratio_value(int ratio)
 {
 	const char *rstr;
 
 	switch (ratio) {
 	case 4:
-		return;
+		return NULL;
 	case 3:
 		rstr = "3/4";
 		break;
@@ -1117,52 +1144,53 @@ static void print_nss_ratio_value(int ratio)
 		break;
 	}
 
-	printf("(%s NSS) ", rstr);
+	return rstr;
 }
 
 static void print_nss_ratio(const char *str, bool force_show, int ratio)
-{
+{ 	
 	if (!ratio)
 		return;
 	if (ratio == 4) {
 		if (force_show)
-			printf("%s ", str);
+			iw_printf("value", "%s", str);
 	} else {
-		printf("%s ", str);
-		print_nss_ratio_value(ratio);
+		iw_printf("value", "%s NSS", nss_ratio_value(ratio));
 	}
 }
 
 void print_vht_info(__u32 capa, const __u8 *mcs)
 {
+#define PRINT_VHT_CAPA(_bit, _str) \
+	do { \
+		if (capa & BIT(_bit)){ \
+			iw_printf(_str, "%s", "true"); \
+		} \
+	} while (0)
+
 	__u16 tmp;
 	__u32 supp_chan_width, ext_nss_bw;
 	const struct vht_nss_ratio *nss_tbl;
 	int i;
 
-	printf("\t\tVHT Capabilities (0x%.8x):\n", capa);
 
-#define PRINT_VHT_CAPA(_bit, _str) \
-	do { \
-		if (capa & BIT(_bit)) \
-			printf("\t\t\t" _str "\n"); \
-	} while (0)
-
-	printf("\t\t\tMax MPDU length: ");
+	json_obj_open("VHT Capabilities");
+	iw_printf("VHT Capabilities Raw Value", "0x%.8x", capa);
 	switch (capa & 3) {
-	case 0: printf("3895\n"); break;
-	case 1: printf("7991\n"); break;
-	case 2: printf("11454\n"); break;
-	case 3: printf("(reserved)\n");
+		case 0: iw_printf("Data", "3895"); break;
+		case 1: iw_printf("Data", "7991"); break;
+		case 2: iw_printf("Data", "11454"); break;
+		case 3: iw_printf("Data", "reserved");
 	}
+	json_obj_close();
+	json_obj_open("Supported Channel Width");
 
-	printf("\t\t\tSupported Channel Width: ");
 	supp_chan_width = (capa >> 2) & 3;
 	ext_nss_bw = (capa >> 30) & 3;
 	nss_tbl = &nss_ratio_tbl[supp_chan_width][ext_nss_bw];
 
 	if (!nss_tbl->valid)
-		printf("(reserved)\n");
+		iw_printf("reserved", "true");
 	else if (nss_tbl->bw_20 == 4 &&
 		 nss_tbl->bw_40 == 4 &&
 		 nss_tbl->bw_80 == 4 &&
@@ -1170,9 +1198,15 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 		 (!nss_tbl->bw_80_80 || nss_tbl->bw_80_80 == 4)) {
 		/* old style print format */
 		switch (supp_chan_width) {
-		case 0: printf("neither 160 nor 80+80\n"); break;
-		case 1: printf("160 MHz\n"); break;
-		case 2: printf("160 MHz, 80+80 MHz\n"); break;
+			case 0:
+				break;
+			case 1:
+				iw_printf("160", "true");
+				break;
+			case 2:
+				iw_printf("160", "true");
+				iw_printf("80+80", "true");
+				break;
 		}
 	} else {
 		print_nss_ratio("20Mhz", false, nss_tbl->bw_20);
@@ -1180,8 +1214,8 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 		print_nss_ratio("80Mhz", false, nss_tbl->bw_80);
 		print_nss_ratio("160Mhz", false, nss_tbl->bw_160);
 		print_nss_ratio("80+80Mhz", false, nss_tbl->bw_80_80);
-		printf("\n");
 	}
+	json_obj_close();
 
 	PRINT_VHT_CAPA(4, "RX LDPC");
 	PRINT_VHT_CAPA(5, "short GI (80 MHz)");
@@ -1201,36 +1235,42 @@ void print_vht_info(__u32 capa, const __u8 *mcs)
 	PRINT_VHT_CAPA(28, "RX antenna pattern consistency");
 	PRINT_VHT_CAPA(29, "TX antenna pattern consistency");
 
-	printf("\t\tVHT RX MCS set:\n");
+
+	json_obj_open("VHT RX MCS set");
 	tmp = mcs[0] | (mcs[1] << 8);
 	for (i = 1; i <= 8; i++) {
-		printf("\t\t\t%d streams: ", i);
+		char buf[16];
+		snprintf(buf, sizeof(buf), "%d streams", i);
 		switch ((tmp >> ((i-1)*2) ) & 3) {
-		case 0: printf("MCS 0-7\n"); break;
-		case 1: printf("MCS 0-8\n"); break;
-		case 2: printf("MCS 0-9\n"); break;
-		case 3: printf("not supported\n"); break;
+			case 0: iw_printf(buf, "MCS 0-7"); break;
+			case 1: iw_printf(buf, "MCS 0-8"); break;
+			case 2: iw_printf(buf, "MCS 0-9"); break;
+			case 3: iw_printf(buf, "not supported"); break;
 		}
 	}
+	json_obj_close();
 	tmp = mcs[2] | (mcs[3] << 8);
-	printf("\t\tVHT RX highest supported: %d Mbps\n", tmp & 0x1fff);
+	
+	iw_printf("VHT RX highest supported Mbps", "%d", tmp & 0x1fff);
 
-	printf("\t\tVHT TX MCS set:\n");
+	json_obj_open("VHT TX MCS set");
 	tmp = mcs[4] | (mcs[5] << 8);
 	for (i = 1; i <= 8; i++) {
-		printf("\t\t\t%d streams: ", i);
+		char buf[16];
+		snprintf(buf, sizeof(buf), "%d streams", i);
 		switch ((tmp >> ((i-1)*2) ) & 3) {
-		case 0: printf("MCS 0-7\n"); break;
-		case 1: printf("MCS 0-8\n"); break;
-		case 2: printf("MCS 0-9\n"); break;
-		case 3: printf("not supported\n"); break;
+			case 0: iw_printf(buf, "MCS 0-7"); break;
+			case 1: iw_printf(buf, "MCS 0-8"); break;
+			case 2: iw_printf(buf, "MCS 0-9"); break;
+			case 3: iw_printf(buf, "not supported"); break;
 		}
 	}
+	json_obj_close();
+
 	tmp = mcs[6] | (mcs[7] << 8);
-	printf("\t\tVHT TX highest supported: %d Mbps\n", tmp & 0x1fff);
+	iw_printf("VHT TX Highest Supported Mbps", "%d", tmp & 0x1fff);
 
-	printf("\t\tVHT extended NSS: %ssupported\n",
-	       (tmp & (1 << 13)) ? "" : "not ");
+	iw_printf("VHT extended NSS Supported", "%s", (tmp & (1 << 13)) ? true : false);
 }
 
 static void __print_he_capa(const __u16 *mac_cap,
@@ -1246,13 +1286,13 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_CAP(_var, _idx, _bit, _str) \
 	do { \
 		if (_var[_idx] & BIT(_bit)) \
-			printf("%s\t\t\t" _str "\n", pre); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
 	#define PRINT_HE_CAP_MASK(_var, _idx, _shift, _mask, _str) \
 	do { \
 		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+			iw_printf(NULL, "%s %d", _str, (_var[_idx] >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_HE_MAC_CAP(...) PRINT_HE_CAP(mac_cap, __VA_ARGS__)
@@ -1261,10 +1301,9 @@ static void __print_he_capa(const __u16 *mac_cap,
 	#define PRINT_HE_PHY_CAP0(_idx, _bit, ...) PRINT_HE_CAP(phy_cap, _idx, _bit + 8, __VA_ARGS__)
 	#define PRINT_HE_PHY_CAP_MASK(...) PRINT_HE_CAP_MASK(phy_cap, __VA_ARGS__)
 
-	printf("%s\t\tHE MAC Capabilities (0x", pre);
-	for (i = 0; i < 3; i++)
-		printf("%04x", mac_cap[i]);
-	printf("):\n");
+	iw_printf("HE MAC Capabilities Raw Value", "%s 0x%04x%04x%04x", pre, mac_cap[0], mac_cap[1], mac_cap[2]);
+
+	json_arr_open("HE MAC Capabilities");
 
 	PRINT_HE_MAC_CAP(0, 0, "+HTC HE Supported");
 	PRINT_HE_MAC_CAP(0, 1, "TWT Requester");
@@ -1301,10 +1340,21 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_MAC_CAP(2, 11, "UL 2x996-Tone RU");
 	PRINT_HE_MAC_CAP(2, 12, "OM Control UL MU Data Disable RX");
 
-	printf("%s\t\tHE PHY Capabilities: (0x", pre);
-	for (i = 0; i < 11; i++)
-		printf("%02x", ((__u8 *)phy_cap)[i + 1]);
-	printf("):\n");
+	{
+		char buf[64] = {0};
+		int bufleft = (int)sizeof(buf);
+		char *p = buf;
+		int written = 0;
+		for (i = 0; i < 11; i++){
+			written = snprintf(p, bufleft, "%02x", ((__u8 *)phy_cap)[i + 1]);
+			bufleft -= written;
+			p += written;
+		}
+
+		json_arr_close();
+		iw_printf("HE Phy Capabilities Raw Value", "%s 0x%s", pre, buf);
+		json_arr_open("HE Phy Capabilities");
+	}
 
 	PRINT_HE_PHY_CAP0(0, 1, "HE40/2.4GHz");
 	PRINT_HE_PHY_CAP0(0, 2, "HE40/HE80/5GHz");
@@ -1371,6 +1421,8 @@ static void __print_he_capa(const __u16 *mac_cap,
 	PRINT_HE_PHY_CAP(5, 4, "RX Full BW SU Using HE MU PPDU with Compression SIGB");
 	PRINT_HE_PHY_CAP(5, 5, "RX Full BW SU Using HE MU PPDU with Non-Compression SIGB");
 
+	json_arr_close();
+
 	mcs_used = 0;
 	for (i = 0; i < 3; i++) {
 		__u8 phy_cap_support[] = { BIT(1) | BIT(2), BIT(3), BIT(4) };
@@ -1386,19 +1438,26 @@ static void __print_he_capa(const __u16 *mac_cap,
 
 		for (j = 0; j < 2; j++) {
 			int k;
-			printf("%s\t\tHE %s MCS and NSS set %s MHz\n", pre, j ? "TX" : "RX", bw[i]);
+			char buf[128] = {0};
+			snprintf(buf, sizeof(buf), "%s_he_%s_mcs_and_nss_set", pre, j ? "tx" : "rx");
+			json_obj_open(buf);
+			iw_printf("Width, MHz", "%s", bw[i]);
+			json_obj_open("Streams");
 			for (k = 0; k < 8; k++) {
 				__u16 mcs = mcs_set[(i * 2) + j];
 				mcs >>= k * 2;
 				mcs &= 0x3;
-				printf("%s\t\t\t%d streams: ", pre, k + 1);
+				char keybuf[16];
+				snprintf(keybuf, sizeof(keybuf), "%s_%d_streams", pre, k + 1);
 				if (mcs == 3)
-					printf("not supported\n");
+					iw_printf(keybuf, "not supported");
 				else
-					printf("MCS 0-%d\n", 7 + (mcs * 2));
+					iw_printf(keybuf, "MCS 0-%d", 7 + (mcs * 2));
 			}
-
+			json_obj_close();
+			json_obj_close();
 		}
+
 		mcs_used += 2 * sizeof(mcs_set[0]);
 	}
 
@@ -1411,12 +1470,23 @@ static void __print_he_capa(const __u16 *mac_cap,
 			ppet_len = 0;
 	}
 
-	if (ppet_len && (phy_cap[3] & BIT(15))) {
-		printf("%s\t\tPPE Threshold ", pre);
-		for (i = 0; i < ppet_len; i++)
-			if (ppet[i])
-				printf("0x%02x ", ppet[i]);
-		printf("\n");
+	{
+		char buf[64];
+		char *p = buf;
+		int bufleft = (int)sizeof(buf);
+		int written = 0;
+
+		for (i = 0; i < ppet_len; i++){
+			if (ppet[i]){
+				written = snprintf(p, bufleft, "0x%02x ", ppet[i]);
+				bufleft -= written;
+				p += written;
+			}
+		}
+
+		if (ppet_len && (phy_cap[3] & BIT(15))) {
+			iw_printf("PPE Threshold", "%s", buf);
+		}
 	}
 }
 
@@ -1425,9 +1495,9 @@ void print_iftype_list(const char *name, const char *pfx, struct nlattr *attr)
 	struct nlattr *ift;
 	int rem;
 
-	printf("%s:\n", name);
-	nla_for_each_nested(ift, attr, rem)
-		printf("%s * %s\n", pfx, iftype_name(nla_type(ift)));
+	nla_for_each_nested(ift, attr, rem){
+		iw_printf(name, "%s * %s", pfx, iftype_name(nla_type(ift)));
+	}
 }
 
 void print_iftype_line(struct nlattr *attr)
@@ -1461,9 +1531,9 @@ void print_he_info(struct nlattr *nl_iftype)
 	if (!tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES])
 		return;
 
-	printf("\t\tHE Iftypes: ");
+	json_obj_open("HE Iftypes");
 	print_iftype_line(tb[NL80211_BAND_IFTYPE_ATTR_IFTYPES]);
-	printf("\n");
+	json_obj_close();
 
 	if (tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]) {
 		len = nla_len(tb[NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC]);
@@ -1517,39 +1587,43 @@ static void __print_eht_capa(int band,
 			     bool indent)
 {
 	unsigned int i;
-	const char *pre = indent ? "\t" : "";
 	const char *mcs[] = { "0-7", "8-9", "10-11", "12-13"};
 
 	#define PRINT_EHT_CAP(_var, _idx, _bit, _str) \
 	do { \
 		if (_var[_idx] & BIT(_bit)) \
-			printf("%s\t\t\t" _str "\n", pre); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
 	#define PRINT_EHT_CAP_MASK(_var, _idx, _shift, _mask, _str) \
 	do { \
 		if ((_var[_idx] >> _shift) & _mask) \
-			printf("%s\t\t\t" _str ": %d\n", pre, (_var[_idx] >> _shift) & _mask); \
+			iw_printf(NULL, "%s %d", _str, (_var[_idx] >> _shift) & _mask); \
 	} while (0)
 
 	#define PRINT_EHT_MAC_CAP(...) PRINT_EHT_CAP(mac_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP(...) PRINT_EHT_CAP(phy_cap, __VA_ARGS__)
 	#define PRINT_EHT_PHY_CAP_MASK(...) PRINT_EHT_CAP_MASK(phy_cap, __VA_ARGS__)
 
-	printf("%s\t\tEHT MAC Capabilities (0x", pre);
+	json_obj_open("EHT MAC Capabilities");
+	json_arr_open("Raw Data");
 	for (i = 0; i < 2; i++)
-		printf("%02x", mac_cap[i]);
-	printf("):\n");
+		iw_printf(NULL, "0x%02x", mac_cap[i]);
+	json_arr_close();
 
+	json_arr_open("Data");
 	PRINT_EHT_MAC_CAP(0, 0, "NSEP priority access Supported");
 	PRINT_EHT_MAC_CAP(0, 1, "EHT OM Control Supported");
 	PRINT_EHT_MAC_CAP(0, 2, "Triggered TXOP Sharing Supported");
 	PRINT_EHT_MAC_CAP(0, 3, "ARR Supported");
+	json_arr_close();
+	json_obj_close();
 
-	printf("%s\t\tEHT PHY Capabilities: (0x", pre);
+	json_obj_open("EHT PHY Capabilities");
+	json_arr_open("Raw Data");
 	for (i = 0; i < 8; i++)
-		printf("%02x", ((__u8 *)phy_cap)[i]);
-	printf("):\n");
+		iw_printf(NULL, "0x%02x", ((__u8 *)phy_cap)[i]);
+	json_arr_close();
 
 	PRINT_EHT_PHY_CAP(0, 1, "320MHz in 6GHz Supported");
 	PRINT_EHT_PHY_CAP(0, 2, "242-tone RU in BW wider than 20MHz Supported");
@@ -1593,22 +1667,26 @@ static void __print_eht_capa(int band,
 	PRINT_EHT_PHY_CAP(1, 28, "MU Beamformer (80MHz)");
 	PRINT_EHT_PHY_CAP(1, 29, "MU Beamformer (160MHz)");
 	PRINT_EHT_PHY_CAP(1, 30, "MU Beamformer (320MHz)");
+	json_arr_close();
 
-	printf("%s\t\tEHT MCS/NSS: (0x", pre);
+	json_arr_open("EHT MCS/NSS");
 	for (i = 0; i < mcs_len; i++)
-		printf("%02x", ((__u8 *)mcs_set)[i]);
-	printf("):\n");
+		iw_printf(NULL, "0x%02x", ((__u8 *)mcs_set)[i]);
+	json_arr_close();
+	json_obj_close();
 
+	json_obj_open("HE Phy Capabilities");
+	json_arr_open("Data");
 	if (!(he_phy_cap[0] & ((BIT(2) | BIT(3) | BIT(4)) << 8))){
 		for (i = 0; i < 4; i++)
-			printf("%s\t\tEHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i],
+			iw_printf(NULL, "EHT bw=20 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			       mcs[i],
 			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 	} else {
 		if (he_phy_cap[0] & (BIT(2) << 8)) {
 			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
+				iw_printf(NULL, "EHT bw <= 80 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+				       mcs[i + 1],
 				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 		}
 		mcs_set += 3;
@@ -1618,8 +1696,8 @@ static void __print_eht_capa(int band,
 	mcs_set += 3;
 	if (he_phy_cap[0] & (BIT(3) << 8)) {
 		for (i = 0; i < 3; i++)
-			printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i + 1],
+			iw_printf(NULL, "EHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			       mcs[i + 1],
 			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 
 	}
@@ -1627,32 +1705,35 @@ static void __print_eht_capa(int band,
 	mcs_set += 3;
 	if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
 		for (i = 0; i < 3; i++)
-			printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-			       pre, mcs[i + 1],
+			iw_printf(NULL, "EHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+			       mcs[i + 1],
 			       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 		if (he_phy_cap[0] & (BIT(3) << 8)) {
 			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
+				iw_printf(NULL, "EHT bw=160 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+				       mcs[i + 1],
 				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 		}
 
 		mcs_set += 3;
 		if (band == NL80211_BAND_6GHZ && (phy_cap[0] & BIT(1))) {
 			for (i = 0; i < 3; i++)
-				printf("%s\t\tEHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u\n",
-				       pre, mcs[i + 1],
+				iw_printf(NULL, "EHT bw=320 MHz, max NSS for MCS %s: Rx=%u, Tx=%u",
+				       mcs[i + 1],
 				       mcs_set[i] & 0xf, mcs_set[i] >> 4);
 		}
 	}
+	json_arr_close();
 
 	if (ppet && ppet_len && (phy_cap[1] & BIT(11))) {
-		printf("%s\t\tEHT PPE Thresholds ", pre);
+		json_arr_open("EHT PPE Thresholds");
 		for (i = 0; i < ppet_len; i++)
 			if (ppet[i])
-				printf("0x%02x ", ppet[i]);
-		printf("\n");
+				iw_printf(NULL, "0x%02x", ppet[i]);
+		json_arr_close();
 	}
+
+	json_obj_close();
 }
 
 void print_eht_info(struct nlattr *nl_iftype, int band)
@@ -1884,7 +1965,7 @@ void print_s1g_capability(const uint8_t *caps)
 #define PRINT_S1G_CAP(_cond, _str) \
 	do { \
 		if (_cond) \
-			printf("\t\t\t" _str "\n"); \
+			iw_printf(NULL, _str); \
 	} while (0)
 
 	static char buf[20];
@@ -1892,8 +1973,16 @@ void print_s1g_capability(const uint8_t *caps)
 	uint8_t cap = caps[0];
 
 	/* S1G Capabilities Information subfield */
-	if (cap)
-		printf("\t\tByte[0]: 0x%02x\n", cap);
+	iw_printf("S1G Capabilities Raw Value", "0x"
+		"%02x%02x%02x%02x"
+		"%02x%02x%02x%02x"
+		"%02x%02x%02x%02x", 
+		caps[0], caps[1], caps[2], caps[3],
+		caps[4], caps[5], caps[6], caps[7],
+		caps[8], caps[9], caps[10], caps[11]
+	);
+
+	json_arr_open("Capabilities");
 
 	PRINT_S1G_CAP((cap & BIT(0)), "S1G PHY: S1G_LONG PPDU Format");
 
@@ -1905,7 +1994,7 @@ void print_s1g_capability(const uint8_t *caps)
 		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x8) ? " 8" : "");
 		offset += sprintf(buf + offset, "%s", ((cap >> 1) & 0x10) ? " 16" : "");
 		offset += sprintf(buf + offset, " MHz");
-		printf("\t\t\t%s\n", buf);
+		iw_printf(NULL, buf);
 	}
 
 	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x0, "Channel width: 1, 2 MHz");
@@ -1915,22 +2004,18 @@ void print_s1g_capability(const uint8_t *caps)
 
 	cap = caps[1];
 
-	if (cap)
-		printf("\t\tByte[1]: 0x%02x\n", cap);
-
 	PRINT_S1G_CAP((cap & BIT(0)), "Rx LDPC");
 	PRINT_S1G_CAP((cap & BIT(1)), "Tx STBC");
 	PRINT_S1G_CAP((cap & BIT(2)), "Rx STBC");
 	PRINT_S1G_CAP((cap & BIT(3)), "SU Beamformer");
 	PRINT_S1G_CAP((cap & BIT(4)), "SU Beamformee");
 	if (cap & BIT(4))
-		printf("\t\t\tBeamformee STS: %d\n", (cap >> 5) + 1);
+		iw_printf(NULL, "Beamformee STS: %d", (cap >> 5) + 1);
 
 	cap = caps[2];
-	printf("\t\tByte[2]: 0x%02x\n", cap);
 
 	if (caps[1] & BIT(3))
-		printf("\t\t\tSounding dimensions: %d\n", (cap & 0x7) + 1);
+		iw_printf(NULL, "Sounding dimensions", "%d", (cap & 0x7) + 1);
 
 	PRINT_S1G_CAP((cap & BIT(3)), "MU Beamformer");
 	PRINT_S1G_CAP((cap & BIT(4)), "MU Beamformee");
@@ -1940,25 +2025,23 @@ void print_s1g_capability(const uint8_t *caps)
 	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x3, "Supports 1 and 2 STS Traveling Pilot");
 
 	cap = caps[3];
-	printf("\t\tByte[3]: 0x%02x\n", cap);
 	PRINT_S1G_CAP((cap & BIT(0)), "RD Responder");
 	/* BIT(1) in Byte 3 or BIT(25) in all capabilities is reserved */
 	PRINT_S1G_CAP(((cap & BIT(2)) == 0x0), "Max MPDU length: 3895 bytes");
 	PRINT_S1G_CAP((cap & BIT(2)), "Max MPDU length: 7991 bytes");
 
 	if (compute_ampdu_length((cap >> 2) & 0x3)) {
-		printf("\t\t\tMaximum AMPDU length: %d bytes (exponent: 0x0%02x)\n",
+		iw_printf(NULL, "Maximum AMPDU length: %d bytes (exponent: 0x0%02x)",
 		       compute_ampdu_length((cap >> 2) & 0x3), (cap >> 2) & 0x3);
 	} else {
-		printf("\t\t\tMaximum AMPDU length: unrecognized bytes (exponent: %d)\n",
+		iw_printf(NULL, "Maximum AMPDU length: unrecognized bytes (exponent: %d)",
 		       (cap >> 2) & 0x3);
 	}
 
-	printf("\t\t\tMinimum MPDU time spacing: %s (0x%02x)\n",
+	iw_printf(NULL, "Minimum MPDU time spacing: %s (0x%02x)",
 	       print_ampdu_space((cap >> 5) & 0x7), (cap >> 5) & 0x7);
 
 	cap = caps[4];
-	printf("\t\tByte[4]: 0x%02x\n", cap);
 	PRINT_S1G_CAP((cap & BIT(0)), "Uplink sync capable");
 	PRINT_S1G_CAP((cap & BIT(1)), "Dynamic AID");
 	PRINT_S1G_CAP((cap & BIT(2)), "BAT");
@@ -1970,7 +2053,6 @@ void print_s1g_capability(const uint8_t *caps)
 	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x2, "Only non-sensor STAs");
 
 	cap = caps[5];
-	printf("\t\tByte[5]: 0x%02x\n", cap);
 	PRINT_S1G_CAP((cap & BIT(0)), "Centralized authentication control");
 	PRINT_S1G_CAP((cap & BIT(1)), "Distributed authentication control");
 	PRINT_S1G_CAP((cap & BIT(2)), "A-MSDU supported");
@@ -1983,9 +2065,6 @@ void print_s1g_capability(const uint8_t *caps)
 	PRINT_S1G_CAP(((cap >> 6) & 0x3) == 0x3, "Group and TXOP-based sectorization operations");
 
 	cap = caps[6];
-	if (cap)
-		printf("\t\tByte[6]: 0x%02x\n", cap);
-
 	PRINT_S1G_CAP((cap & BIT(0)), "OBSS mitigation");
 	PRINT_S1G_CAP((cap & BIT(1)), "Fragment BA");
 	PRINT_S1G_CAP((cap & BIT(2)), "NDP PS-Poll");
@@ -2002,7 +2081,6 @@ void print_s1g_capability(const uint8_t *caps)
 	}
 
 	cap = caps[7];
-	printf("\t\tByte[7]: 0x%02x\n", cap);
 	PRINT_S1G_CAP((cap & BIT(0)), "TACK support as PS-Poll response");
 	PRINT_S1G_CAP((cap & BIT(1)), "Duplicate 1 MHz");
 	PRINT_S1G_CAP((cap & BIT(2)), "MCS negotiation");
@@ -2013,52 +2091,47 @@ void print_s1g_capability(const uint8_t *caps)
 	PRINT_S1G_CAP((cap & BIT(7)), "Temporary PS mode switch");
 
 	cap = caps[8];
-	if (cap)
-		printf("\t\tByte[8]: 0x%02x\n", cap);
-
 	PRINT_S1G_CAP((cap & BIT(0)), "TWT grouping");
 	PRINT_S1G_CAP((cap & BIT(1)), "BDT capable");
-	printf("\t\t\tColor: %u\n", (cap >> 2) & 0x7);
+	iw_printf(NULL, "Color: %u", (cap >> 2) & 0x7);
 	PRINT_S1G_CAP((cap & BIT(5)), "TWT requester");
 	PRINT_S1G_CAP((cap & BIT(6)), "TWT responder");
 	PRINT_S1G_CAP((cap & BIT(7)), "PV1 frame support");
 
 	cap = caps[9];
-	if (cap)
-		printf("\t\tByte[9]: 0x%02x\n", cap);
-
 	PRINT_S1G_CAP((cap & BIT(0)), "Link Adaptation without NDP CMAC PPDU capable");
 	/* Rest of byte 9 bits are reserved */
 
 	/* Supported S1G-MCS and NSS Set subfield */
 	/* Rx S1G-MCS Map */
 	cap = caps[10];
-	printf("\t\tMax Rx S1G MCS Map: 0x%02x\n", cap);
-	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_max_support(cap & 0x3));
-	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_max_support((cap >> 2) & 0x3));
-	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_max_support((cap >> 4) & 0x3));
-	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_max_support((cap >> 6) & 0x3));
+	iw_printf(NULL, "Max Rx S1G MCS Map: 0x%02x", cap);
+	iw_printf(NULL, "For 1 SS: %s", s1g_ss_max_support(cap & 0x3));
+	iw_printf(NULL, "For 2 SS: %s", s1g_ss_max_support((cap >> 2) & 0x3));
+	iw_printf(NULL, "For 3 SS: %s", s1g_ss_max_support((cap >> 4) & 0x3));
+	iw_printf(NULL, "For 4 SS: %s", s1g_ss_max_support((cap >> 6) & 0x3));
 
 	/* Rx Long GI data rate field comprises of 9 bits */
 	cap = caps[11];
 	if (cap || caps[12] & 0x1)
-		printf("\t\t\tRx Highest Long GI Data Rate: %u Mbps\n",
+		iw_printf(NULL, "Rx Highest Long GI Data Rate: %u Mbps",
 		       cap + ((caps[12] & 0x1) << 8));
 
 	/* Tx S1G-MCS Map */
 	cap = caps[12];
-	printf("\t\tMax Tx S1G MCS Map: 0x%02x\n", cap);
-	printf("\t\t\tFor 1 SS: %s\n", s1g_ss_max_support((cap >> 1) & 0x3));
-	printf("\t\t\tFor 2 SS: %s\n", s1g_ss_max_support((cap >> 3) & 0x3));
-	printf("\t\t\tFor 3 SS: %s\n", s1g_ss_max_support((cap >> 5) & 0x3));
-	printf("\t\t\tFor 4 SS: %s\n", s1g_ss_max_support(((cap >> 7) & 0x1) +
+	iw_printf(NULL, "Max Tx S1G MCS Map: 0x%02x", cap);
+	iw_printf(NULL, "For 1 SS: %s", s1g_ss_max_support((cap >> 1) & 0x3));
+	iw_printf(NULL, "For 2 SS: %s", s1g_ss_max_support((cap >> 3) & 0x3));
+	iw_printf(NULL, "For 3 SS: %s", s1g_ss_max_support((cap >> 5) & 0x3));
+	iw_printf(NULL, "For 4 SS: %s", s1g_ss_max_support(((cap >> 7) & 0x1) +
 	       ((caps[13] << 1) & 0x2)));
 
 	/* Tx Long GI data rate field comprises of 9 bits */
 	cap = caps[13];
 	if (((cap >> 7) & 0x7f) || (caps[14] & 0x3))
-		printf("\t\t\tTx Highest Long GI Data Rate: %u Mbps\n", ((cap >> 7) & 0x7f) +
+		iw_printf(NULL, "Tx Highest Long GI Data Rate: %u Mbps", ((cap >> 7) & 0x7f) +
 			((caps[14] & 0x3) << 7));
+	if(cap) json_arr_close();
 
 	/* Rx and Tx single spatial streams and S1G MCS Map for 1 MHz */
 	cap = (caps[15] >> 2) & 0xf;
@@ -2071,6 +2144,9 @@ void print_s1g_capability(const uint8_t *caps)
 	PRINT_S1G_CAP((cap & 0x3) == 0x1, "Tx single SS for 1 MHz: single SS and S1G-MCS 2");
 	PRINT_S1G_CAP((cap & 0x3) == 0x2, "Tx single SS for 1 MHz: single SS and S1G-MCS 7");
 	PRINT_S1G_CAP((cap & 0x3) == 0x3, "Tx single SS for 1 MHz: single SS and S1G-MCS 9");
+	
+	json_arr_close();
+
 	/* Last 2 bits are reserved */
 #undef PRINT_S1G_CAP
 }
-- 
2.42.0


