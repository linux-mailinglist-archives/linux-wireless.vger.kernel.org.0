Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02D61FF2F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 21:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKGUJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 15:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiKGUJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 15:09:38 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8910BE
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 12:09:38 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id v81so7472741vkv.5
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vOSjPF5ZdisjY+V3GmY+MDQ34ok+PPDsRNJuQbt9Los=;
        b=57nbm3pE7gC6OK8F9NmQj0zmENMTA8RUNn0cdxwCpI/yUc5swdB2uDSu8UdArfngyl
         TfL8fld1nCtrarSiL84r3RLzSRvi2w82/w404bJ47CdNC90QnX7iCUsruhpQq71ftjNr
         /dT3W9fHNqUfDWp8gsyBNzF6bMKcXvC6xzJqJkOLQTXUUkl2DTd7vFDq7xsPvE3quWgx
         MDOV5jcr7wTS03Y5xHcolLN3U6Ao9iBV80cciXYgGacaXgTRNbpDwfZ6tBT0n3O7VJUJ
         PcFFQPTsQgBm/pWZupjlBPAGcOJ5QBcxXnpmMNDWKgl2FG7OcWX6p0WjrQXxfk5jBZ2Z
         rpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOSjPF5ZdisjY+V3GmY+MDQ34ok+PPDsRNJuQbt9Los=;
        b=ECwkOWbJeSON9cNtIfNX0AMKToj02Pr7pjkzkFzUYDgIowHHZDbgt0C8Gw+zK/J4oh
         ahQG9o2f+QfKb2p3qEXJ9l0+DCj+AHn4KwXBctuACJIYhppy6OCwJTyUx3VW3opXl6Uz
         uV5aO1l2EHs44FgTXhqgFpuE3rGlqs6GZq5LtJypRMf3C7R6+jCjMcpGkEjlF2PAX9Vg
         Q9UJeCGBQ+6l9Zs18llMluiM/O2u+WYrUHhSKVE+DGT4seP5M7TgOIBaIzdziKow105g
         yUh/ybiWsUxdszMjxxeklkNZs3DzlNGgYc8UXSP2AR4eoiv5wl9oXTERh7vCSZPOb6IF
         GPIg==
X-Gm-Message-State: ACrzQf2cKdMUmYq3Jydi3mR0WZ3aVEzYduLzxeATbkwS9tFMP8j7OXhm
        FgTm0DX1SzglqgIgTad30sKGWn4fwZwUHVPUSfYdJChMGI7Z6g==
X-Google-Smtp-Source: AMsMyM6LcmhXXQ1RRFD0MlvbciAeg5BVlUW3BZ6OVpbUHahUNkMNEaQ19wCjb64KEhQs1kTJLFOAwPOk7b62c3H8eEQ=
X-Received: by 2002:a05:6122:200a:b0:3b6:b428:6036 with SMTP id
 l10-20020a056122200a00b003b6b4286036mr26207834vkd.9.1667851777214; Mon, 07
 Nov 2022 12:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Tue, 8 Nov 2022 09:09:26 +1300
Message-ID: <CAKHj3qROCR96qgAHP0FjKwCn8p7ZVWYScGsOA07DSGbUs+AvtQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Additional Support for 802.11ah (S1G)
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Sep 6, 2022 at 4:48 PM Kieran Frewen
<kieran.frewen@morsemicro.com> wrote:
>
> This patchset builds on the work down by Thomas Pedersen to add further
> support for 802.11ah in cfg80211 and mac80211. The ultimate goal is
> to enable the successful starting of an AP on 802.11ah using 802.11ah
> terms by implementing the various features that are required by the
> AP. The features are split into their own commits, please see those
> patches for more details.
> The patchset has been tested on both real hardware (Morse Micro MM610x)
> and mac80211_hwsim, in AP and STA modes. Basic regression testing was
> performed on 802.11n with mac80211_hwsim by starting an AP and having a
> STA interface connect to it.
> 802.11ah features/support missing:
>
> Rate control integration
> Regulatory database updates (only US regulatory information exists)
> Optional 802.11ah (S1G) features such as RAW, TWT and AID grouping
>
> Changelog
>
> v3:
> [PATCH 01/12]
>         Added prototype definition and description for
>         ieee80211_channel_to_freq_khz.
>         Fixed issue introduced in v1 where center_freq_khz
>         in handle_channel_custom() was uninitialised.
> [PATCH 10/12]
>         Fixed comment block style
>
> v2:
> [PATCH 01/12]
>         Added validation to assignment of s1g_oper_class and class_idx.
>         Changed align_to_end from u8 to bool.
>         Added clarification of usage requirements for country code in
>         s1g_oper_class struct.
>         Changed cc field in s1g_oper_class struct from char * to cc[3].
>         Moved initialised structs and arrays and from reg_s1g.h to reg_s1g.c.
>         Moved reg_s1g_get_oper_class from reg_s1g.h to reg_s1g.c
>         reg_s1g_get_oper_class now defaults to NULL if no natching
>         s1g_oper_class is found.
> [PATCH 04/12]
>         NL80211_ATTR_SHORT_BEACON_PERIOD changed to NLA_U16.
> [PATCH 07/12]
>         Implemented ieee80211_ie_build_s1g_cap function to build S1G
>         capability IE in place. Mimicing behaviour of
>         ieee80211_ie_build_ht_cap.
> [PATCH 08/12]
>         Capatilisation of MCS in description of RATE_INFO_FLAGS_S1G_MCS.
>         Re-ordered grouping of fields in rate_info struct to order by size.
> [PATCH 09/12]
>         Capatilisation of MCS in field naming of NL80211_RATE_INFO_S1G_MSS.
>         Reordering of info->bw cases in switch to numberical order.
>
> Kieran Frewen (12):
>   cfg80211: regulatory: extend regulatory support for S1G
>   mac80211: update TIM for S1G specification changes
>   mac80211: S1G beacon/short beacon support
>   nl80211: support setting S1G short beacon period
>   nl80211: support advertising S1G capabilities
>   mac80211: support ieee80211_ext format
>   mac80211: S1G capabilities information element in probe request
>   cfg80211: S1G rate flags
>   nl80211: support advertising S1G rate information
>   mac80211: support S1G rate encoding.
>   cfg80211: support for calculating S1G bitrates
>   mac80211_hwsim: support for S1G rate information
>
>  drivers/net/wireless/mac80211_hwsim.c |  40 +++--
>  include/net/cfg80211.h                |  26 ++-
>  include/net/mac80211.h                |  33 +++-
>  include/uapi/linux/nl80211.h          |  28 ++++
>  net/mac80211/cfg.c                    |  43 +++--
>  net/mac80211/ieee80211_i.h            |   2 +
>  net/mac80211/rx.c                     |  32 +++-
>  net/mac80211/sta_info.c               |   7 +
>  net/mac80211/sta_info.h               |   7 +
>  net/mac80211/tx.c                     |  27 ++-
>  net/mac80211/util.c                   |  50 +++++-
>  net/wireless/Makefile                 |   2 +-
>  net/wireless/nl80211.c                |  37 +++++
>  net/wireless/reg.c                    |  60 +++++--
>  net/wireless/reg_s1g.c                | 231 ++++++++++++++++++++++++++
>  net/wireless/reg_s1g.h                |  53 ++++++
>  net/wireless/util.c                   | 148 ++++++++++++++++-
>  17 files changed, 772 insertions(+), 54 deletions(-)
>  create mode 100644 net/wireless/reg_s1g.c
>  create mode 100644 net/wireless/reg_s1g.h
>
>
> base-commit: 7dad3e39fde1eef97bc1a0b92e5d0f3500c9ed56
> --
> 2.34.1
>

Quick update on this changeset, I have handed off some of the
continued development of this patchset. Additionally we decided it was
best to split up the patches in this changeset as much as possible to
individually addressable changes. You may have seen a new patch appear
as a result of this.

Thanks, Kieran
