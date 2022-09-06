Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6775ADE9A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiIFEsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiIFEst (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:48:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B295F981
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:48:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso13785387pjk.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QH1YXjqs0hV67ZNyp+3FhSgrzwh4xwxe93+YmRX935c=;
        b=ePHM8vHd8e/9BLmHpoPym43ezxg0PvdHxayZFQFNHMQXBpViZ5UsE0cDdjzERs0qP2
         wdstbWiCkkZ/mITIkMUt6kgNJK5S6Et2SU8nywCybsKLmSnrt22PiCW/QJK88nsHSBAl
         jI6VFcnNiEQNjJFps4N7jMOIKVOJ6oN/rXlvp9fBJ9FP3OKRHDb2iA7C2E+BXCPIk3pc
         MU8a8TV+SS1qLWpsp2D14c7lVA9mQ+UFR/PorIa6fMxAeDnOlQrNkVGHN8CsSvJKjeBL
         5y7aYWRJyW4s0AClK+z0sLKLwtJoSHx/FEDsNruyy7ofXMF1OTKPUmp6JYn+XxvMn3sP
         pSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QH1YXjqs0hV67ZNyp+3FhSgrzwh4xwxe93+YmRX935c=;
        b=3TFbkKo6+ViEWLGBsXvm5CwkI0maB69eWBpAqclRF0KkdOt6izvjqm+YbTLQbd4Oau
         vyJv6auZLck19l/G8f/WtH5lJl2coAQ3EeDNpAqzmUkiDPtzyOzzW4iXZ537bzuHf/1D
         WGU4YAf8oHTosPzuVMoDfzPVbEyt3K2hbaPEzVqTJaqVJ42vVDKQhz1hpSSKeV8rHTHA
         AhZ98aByRALldRLL/02guXYNX0lsdeIJqmFOa6qlqnUTReyYQFHwSjzEJgi0sN259RNA
         p0KbUBUzOdTt3vy0rSgEKAzfHcXH6qEKWR8GlVYXmVoXJ/P2IK8bqRBcudw5BD0KBlb5
         Txdg==
X-Gm-Message-State: ACgBeo1aWRBQrBJSk4ylpH1cgWRDCJFzSJINIqWkH3oFXVaXxWClHhR9
        FverVXcurWCB9B0JaulGVhnu4fwREAEs86+S
X-Google-Smtp-Source: AA6agR5j5uv18B9oPASmCe559oDXGqIlBr+YJicngG/JaXs2kR9BLzyFIk/ua9C5OIKj/L8YfQ4TDw==
X-Received: by 2002:a17:90a:318a:b0:1fa:c68c:aa03 with SMTP id j10-20020a17090a318a00b001fac68caa03mr22545306pjb.172.1662439723451;
        Mon, 05 Sep 2022 21:48:43 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:42 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 00/12] Additional Support for 802.11ah (S1G)
Date:   Tue,  6 Sep 2022 16:48:00 +1200
Message-Id: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset builds on the work down by Thomas Pedersen to add further
support for 802.11ah in cfg80211 and mac80211. The ultimate goal is
to enable the successful starting of an AP on 802.11ah using 802.11ah
terms by implementing the various features that are required by the
AP. The features are split into their own commits, please see those
patches for more details.
The patchset has been tested on both real hardware (Morse Micro MM610x)
and mac80211_hwsim, in AP and STA modes. Basic regression testing was
performed on 802.11n with mac80211_hwsim by starting an AP and having a
STA interface connect to it.
802.11ah features/support missing:

Rate control integration
Regulatory database updates (only US regulatory information exists)
Optional 802.11ah (S1G) features such as RAW, TWT and AID grouping

Changelog

v3:
[PATCH 01/12]
        Added prototype definition and description for
	ieee80211_channel_to_freq_khz.
	Fixed issue introduced in v1 where center_freq_khz
	in handle_channel_custom() was uninitialised.
[PATCH 10/12]
        Fixed comment block style

v2:
[PATCH 01/12]
	Added validation to assignment of s1g_oper_class and class_idx.
	Changed align_to_end from u8 to bool.
	Added clarification of usage requirements for country code in
	s1g_oper_class struct.
	Changed cc field in s1g_oper_class struct from char * to cc[3].
	Moved initialised structs and arrays and from reg_s1g.h to reg_s1g.c.
	Moved reg_s1g_get_oper_class from reg_s1g.h to reg_s1g.c
	reg_s1g_get_oper_class now defaults to NULL if no natching
	s1g_oper_class is found.
[PATCH 04/12]
	NL80211_ATTR_SHORT_BEACON_PERIOD changed to NLA_U16.
[PATCH 07/12]
	Implemented ieee80211_ie_build_s1g_cap function to build S1G
	capability IE in place. Mimicing behaviour of
	ieee80211_ie_build_ht_cap.
[PATCH 08/12]
	Capatilisation of MCS in description of RATE_INFO_FLAGS_S1G_MCS.
	Re-ordered grouping of fields in rate_info struct to order by size.
[PATCH 09/12]
	Capatilisation of MCS in field naming of NL80211_RATE_INFO_S1G_MSS.
	Reordering of info->bw cases in switch to numberical order.

Kieran Frewen (12):
  cfg80211: regulatory: extend regulatory support for S1G
  mac80211: update TIM for S1G specification changes
  mac80211: S1G beacon/short beacon support
  nl80211: support setting S1G short beacon period
  nl80211: support advertising S1G capabilities
  mac80211: support ieee80211_ext format
  mac80211: S1G capabilities information element in probe request
  cfg80211: S1G rate flags
  nl80211: support advertising S1G rate information
  mac80211: support S1G rate encoding.
  cfg80211: support for calculating S1G bitrates
  mac80211_hwsim: support for S1G rate information

 drivers/net/wireless/mac80211_hwsim.c |  40 +++--
 include/net/cfg80211.h                |  26 ++-
 include/net/mac80211.h                |  33 +++-
 include/uapi/linux/nl80211.h          |  28 ++++
 net/mac80211/cfg.c                    |  43 +++--
 net/mac80211/ieee80211_i.h            |   2 +
 net/mac80211/rx.c                     |  32 +++-
 net/mac80211/sta_info.c               |   7 +
 net/mac80211/sta_info.h               |   7 +
 net/mac80211/tx.c                     |  27 ++-
 net/mac80211/util.c                   |  50 +++++-
 net/wireless/Makefile                 |   2 +-
 net/wireless/nl80211.c                |  37 +++++
 net/wireless/reg.c                    |  60 +++++--
 net/wireless/reg_s1g.c                | 231 ++++++++++++++++++++++++++
 net/wireless/reg_s1g.h                |  53 ++++++
 net/wireless/util.c                   | 148 ++++++++++++++++-
 17 files changed, 772 insertions(+), 54 deletions(-)
 create mode 100644 net/wireless/reg_s1g.c
 create mode 100644 net/wireless/reg_s1g.h


base-commit: 7dad3e39fde1eef97bc1a0b92e5d0f3500c9ed56
-- 
2.34.1

