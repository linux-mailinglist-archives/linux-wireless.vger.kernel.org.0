Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A297D2312
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 14:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjJVMPR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 08:15:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED26DC
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 05:15:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso3490269a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697976914; x=1698581714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMzOne76+i1LcK53L01jfK0JhnQsu73wdWMrke7B3FU=;
        b=LLJ+Oli7ZHne/4LTDs0WW5gNUMBzpSTwFuznoCDiHV2Rs7xHkMdmavmQjXuSo/GvrG
         e5VepmDpYdnklmHXtEnybdIU2uD0vQdo/ygezf1G6nI5JxcvA3LOyg+bEk2IhINXMrkU
         KI0N8y4/M4iWnOwSTJBxa5h+7g9NnfzT7yZ2yGtC8m2xAHjwkuGDZgQ1F+4TigeC2uWD
         G/iOQFCI6PAbx8to6CmuvhMAGZRIl/jtyLgiapH64eAq0HNTN7LCKtwIqaNyPWD/boT6
         tOPPL/ddZBX3sMt3Fq/QqKNx81ani4TVwvzfjOEAACUO2D3T8f27BrJ/t+aOQzF9+ETl
         zW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697976914; x=1698581714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMzOne76+i1LcK53L01jfK0JhnQsu73wdWMrke7B3FU=;
        b=uXlIhyRLUq8EGz0MuJW9kLU6N5/8D9Q5A9kcfLPky+8It6QcZLAz/n+F0956NoL9Ce
         1fhiSK15OY4P6GLYrtyHyU/UMM/ZWpvcckycNEtoBkBrL7aeSN71yd6CL/Oc7TV1eNru
         nZsF2F759CcIiPcKVU+1gNk+7NM82shiFfveg3K2RF02iERH4c/yj8K/KIEZAlKX0exV
         wu5nW3SU5iMxO9XlCjFzpDjFBXgf0i6Vh2gXTsexQgP+CMDY59Q9/fGK2yed9Z5qoj7z
         6yqaqg8gRdLZYhcPWsmTZaZydZrNYXxEjITia4V4rGqRCTMPlR4ECiMeWSTfS4XaiF4S
         rSDA==
X-Gm-Message-State: AOJu0YzB80Ehfy+77XfHTqWa9EuLbova848O703FK9wRTQ5HMIFmuITZ
        IRN1h9wD194EzkZ/zJEh9CAi6Hi/nDVWkpVHNW8Lhvmp/BA=
X-Google-Smtp-Source: AGHT+IHzTuegw5Jq4+oIZRJ13AkTHxoTEdEGQwQvCtulCjrP05L2nquuC5RxubzUx912F355y6vZ3ZjrK6+AMvACU5k=
X-Received: by 2002:a17:907:6093:b0:9ba:2f20:3d7b with SMTP id
 ht19-20020a170907609300b009ba2f203d7bmr5404706ejc.71.1697976913806; Sun, 22
 Oct 2023 05:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231021154827.1142734-1-greearb@candelatech.com>
In-Reply-To: <20231021154827.1142734-1-greearb@candelatech.com>
From:   James Dutton <james.dutton@gmail.com>
Date:   Sun, 22 Oct 2023 13:14:37 +0100
Message-ID: <CAAMvbhHqbXXgF6FpPoWnqKbn=0A0br55wLN9T1xfnwRyiwvnuw@mail.gmail.com>
Subject: Re: [PATCH] wifi: wireless: Fix bad memory passed in inform_single_bss_data.
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 21 Oct 2023 at 16:52, <greearb@candelatech.com> wrote:
>
> From: Ben Greear <greearb@candelatech.com>
>
> The sins of similar variable names and passing void pointers
> are seen again in wireless-next tree.
>
> Wrong data was passed into the rdev_inform_bss method causing
> crashes.
>

Is there any good reason for the void pointers?
The patch you propose fixes the immediate problem, but if the void
pointers were replaced with struct pointers, the compiler could catch
this sort of problem.
I imagine there could be similar confusion with this struct and
function having the same name:
0 scan.c 1999 struct cfg80211_inform_single_bss_data {
1 scan.c 2023 cfg80211_inform_single_bss_data(struct wiphy *wiphy,

Maybe renaming the following:
struct cfg80211_inform_bss *drv_data = data->drv_data;
to
struct cfg80211_inform_bss *c_inform_bss1 = data->drv_data;
would reduce the confusion.
