Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFEC5A593E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiH3CUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH3CUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:20:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59877E8E
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l3so9731294plb.10
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bPML7FE/fCZW/bRELH0G1Q/BW0KORFVovNbIiG6o5jc=;
        b=oDsWbiFfxH7/TPYYGO0H7oCeh1IZtKhvQFTODhsMrM0PXXn2JMeX2uyhDCzppwVA5O
         9Vx6DjgsfhMfqQR0HEl1x0VZrOgPRvlZUsNF4Uy7h+vldIk5/4nfgD6/gg+hK8bmOOaz
         EYL35OMJmkVw4aewnAA+EidWtRaud4X0hS42GvmO8vvcG6uAxvWMoaDG/U28qplkoKbn
         iOkZI2xqtE8Q/utmy7QxiFrooPzYf263MPYI3MIgVjCY/8TcqKy5CST/jl8xQj1/A1y4
         iK/Bq85aMIq7/yjPzAxrTjLBi83vRHhWAUw2crsPXyjMM1zJR+4ZgG8NU/Hu+1OD5j1G
         SnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bPML7FE/fCZW/bRELH0G1Q/BW0KORFVovNbIiG6o5jc=;
        b=Gr3opDfUMYkQ/OHH9ta3sDeHvyFgzv6fA053k0jdFd+Pa0pgqqqBSItmh6CrSOZ2Cj
         iEVp3bxw6nkIELuRuypRxvB+5vZ4ivWznAH+AfEt+PoFm6dQrVlCof7Xlro7VhpAIDCa
         O6H4LjwDvulUXmG6NNlpohOeQROcO/ekxVax6tVRFREC+ZXptXeS4J67/D1lFzDZb8T/
         qJ0sctJ5NHepPj7WWz1AgKUg9pLFU3AVenZ7FskVXbDn+yNurKHTJdeLlPxKyf8qz36Q
         1uEiPfy7SICP/O9W33aQTkgdBBm3u81DEoXNieexaHvzMVO6jMaoy37tEqp1PzG6+WdQ
         Ijdg==
X-Gm-Message-State: ACgBeo3F9zLVdssfF3+qQJYUbugBy1/MSrcmdhWY9avwpqP7IHX//LBC
        wLO536x2/V+43CmL5pQ5LlT3zA==
X-Google-Smtp-Source: AA6agR68jsbo0iAYT37zNkUG7i2vdibzk5QAg9T2EVm0FjQ57yVpfHrIWtPmTRxAHfRqyLKKuAz+FA==
X-Received: by 2002:a17:90b:33d1:b0:1f5:4fc5:3d72 with SMTP id lk17-20020a17090b33d100b001f54fc53d72mr21198769pjb.60.1661826037782;
        Mon, 29 Aug 2022 19:20:37 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:37 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 00/12] Additional Support for 802.11ah (S1G)
Date:   Tue, 30 Aug 2022 02:20:05 +0000
Message-Id: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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
	Implemented ieee80211_ie_build_s1g_cap fuction to build S1G 
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
 include/net/cfg80211.h                |  18 +-
 include/net/mac80211.h                |  33 +++-
 include/uapi/linux/nl80211.h          |  28 ++++
 net/mac80211/cfg.c                    |  43 +++--
 net/mac80211/ieee80211_i.h            |   2 +
 net/mac80211/rx.c                     |  32 +++-
 net/mac80211/sta_info.c               |   7 +
 net/mac80211/sta_info.h               |   7 +
 net/mac80211/tx.c                     |  27 ++-
 net/mac80211/util.c                   |  51 +++++-
 net/wireless/Makefile                 |   2 +-
 net/wireless/nl80211.c                |  37 ++++
 net/wireless/reg.c                    |  60 +++++--
 net/wireless/reg_s1g.c                | 232 ++++++++++++++++++++++++++
 net/wireless/reg_s1g.h                |  55 ++++++
 net/wireless/util.c                   | 148 +++++++++++++++-
 17 files changed, 767 insertions(+), 55 deletions(-)
 create mode 100755 net/wireless/reg_s1g.c
 create mode 100644 net/wireless/reg_s1g.h

-- 
2.25.1

