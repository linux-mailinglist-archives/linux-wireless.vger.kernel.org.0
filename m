Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5267BDDD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jan 2023 22:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbjAYVNt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Jan 2023 16:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjAYVNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Jan 2023 16:13:47 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222C5FCD
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jan 2023 13:13:39 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id l20so1166347vkm.11
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jan 2023 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ql6W9P064+i1Kp4d2i50MQ4p9bhZ+27+BNZNDpsu3cs=;
        b=2D7KonSKU1WRSXXozG8v6qaI1u/zgQmSrUJW21ciY8xH37i13HKTKeuABpwFXUftV1
         zCrXkQGPcoOJ+woBwPG4XJJYJc8CA7uLeOXLIIHnykSMLSAImmLGyzweAZdfvgstp80O
         AdDEj2BjY075G6zHWWeNizMUlWeyTbXaB02gZMP6lc+bKdt07ym5NNs5ISTewoodNaZl
         /CdWRxqiaMWv8Io2/O16MF2YSXWiCN+4GT25GpZyBHjXcR+brD4dQsmx6D84ivsHBKbt
         577xzUheHKmHpgeIBx2O+DMH5Q1md3xkQ4QGpb8vYk6MW+/uAeZTMeaYXTVzhCzZqvce
         tzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql6W9P064+i1Kp4d2i50MQ4p9bhZ+27+BNZNDpsu3cs=;
        b=lt1lfFRuHDUrWAgKasnjPaeuSBC2vtnkV0iyjGDhiEnppTSwoAA23+nQjlhjIbjNxy
         MuopdHR5YDUBQXwj+S7w61RRvFxe0EcWHIQUslsB65XWiIkdAAtTC7hCJIQpiP6Q91j9
         M/KWsIn2KAsdqR+zxLMib4/ZG3J/5ZmQSA9XIUuCDoL9E7vsU1v5DHl2SYaPAIQ5epnf
         PETSd/qPUNkN/9RYrBiCO0dj75Kn09GlQEZJvzoz5ll32tsrmzH2Zmo4rz1duTP48Da9
         1HfZejhGOS/fxdb/VWF7CJa7Ao+RAgMEcOCREXiyYAFle07Xa6jVg+XcxIhjNY88vzzQ
         aXmA==
X-Gm-Message-State: AFqh2kq/1Cq/0pnUWVDOVs9wJBfSWN8q4VOJv8g7VYkEdwkrLCGUXePY
        DdgrVh9XCfUEBN4lONW00XeIOOkTHcdndivcTws+Oqg2FdQh2kk2
X-Google-Smtp-Source: AMrXdXvp8w8GmXCF96ynxtzGA0eB/WTYxS1QP4GuhuugcA4J5QdxraURZ2uwWfkpkerMKa9z8b6wF1T6kWXFvRiNqcM=
X-Received: by 2002:a1f:a742:0:b0:3e1:f8b0:e35d with SMTP id
 q63-20020a1fa742000000b003e1f8b0e35dmr2838011vke.35.1674681218461; Wed, 25
 Jan 2023 13:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
In-Reply-To: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
Date:   Thu, 26 Jan 2023 10:13:27 +1300
Message-ID: <CAKHj3qRrppP9xDVdHyJuGAq9RaBs1_SQ59ykTx+bLCuw-qudXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] wifi: cfg80211: Add short_beacon_tail/head/period
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        quic_jjohnson@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 16, 2022 at 3:08 PM Gilad Itzkovitch
<gilad.itzkovitch@morsemicro.com> wrote:
>
> From: Kieran Frewen <kieran.frewen@morsemicro.com>
>
> Support variables to handle short beacon period and adding a
> separate tail/head for them.
>
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
> Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
> ---
>  include/net/cfg80211.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 11a370e64143..99f28ef2323f 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1179,8 +1179,13 @@ struct cfg80211_mbssid_elems {
>   *     or %NULL if not changed
>   * @tail: tail portion of beacon (after TIM IE)
>   *     or %NULL if not changed
> + * @short_head: head portion of short beacon or %NULL if not changed
> + * @short_tail: short tail portion of beacon (after TIM IE)
> +       or %NULL if not changed
>   * @head_len: length of @head
>   * @tail_len: length of @tail
> + * @short_head_len: length of @short_head
> + * @short_tail_len: length of @short_tail
>   * @beacon_ies: extra information element(s) to add into Beacon frames or %NULL
>   * @beacon_ies_len: length of beacon_ies in octets
>   * @proberesp_ies: extra information element(s) to add into Probe Response
> @@ -1208,6 +1213,7 @@ struct cfg80211_beacon_data {
>         unsigned int link_id;
>
>         const u8 *head, *tail;
> +       const u8 *short_head, *short_tail;
>         const u8 *beacon_ies;
>         const u8 *proberesp_ies;
>         const u8 *assocresp_ies;
> @@ -1218,6 +1224,7 @@ struct cfg80211_beacon_data {
>         s8 ftm_responder;
>
>         size_t head_len, tail_len;
> +       size_t short_head_len, short_tail_len;
>         size_t beacon_ies_len;
>         size_t proberesp_ies_len;
>         size_t assocresp_ies_len;
> @@ -1328,7 +1335,7 @@ struct cfg80211_ap_settings {
>
>         struct cfg80211_beacon_data beacon;
>
> -       int beacon_interval, dtim_period;
> +       int beacon_interval, dtim_period, short_beacon_period;
>         const u8 *ssid;
>         size_t ssid_len;
>         enum nl80211_hidden_ssid hidden_ssid;
>
> base-commit: 5c111ec204d15d1c7d00428b0afdda62ff118565
> --
> 2.34.1
>

Hi Johannes,

Just following up from our end to see what the status of this patchset
is? We were wondering if there was anything we can add in terms of
comments or further clarifications to help progress this.

Thanks and kind regards,
Kieran
