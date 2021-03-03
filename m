Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE232C120
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhCCVQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhCCMgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 07:36:18 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65776C061756;
        Wed,  3 Mar 2021 04:24:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d20so22703869qkc.2;
        Wed, 03 Mar 2021 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0LOUjXWU9XQMlC8ukkVjP6cbdNO347+RGN85W5m8N+0=;
        b=CWFi/YmIgLKQU3EsyxyA9z4dbgyph5EBnHmeINDqV77rqZogpKapQF/rcKR7XqYfUg
         vs0ms8ztdf+pD9KcZElRsxGN3jKdzXAQBwP5uqrSuMnAIAgTV1NmofdATzgps+aYwYwX
         Qrf+HllKPXiD9V69v1AcF+9SKQ1TvlLelwqkhHgLtttHToM6GMAET4H7EWFNU45JP457
         X82UeZjXoSLpFhzbHhSmJzlG898qbT4J4zUB/MQlSDILgs00fdhW3oL8TPvMheTU7ZJO
         hhcrgMbNLfxlFPUAIzeAcZBfbzwrwBd3dvKCxpxMuJSPKoIzPymGtOGLPfXFQMT+n0bP
         WFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0LOUjXWU9XQMlC8ukkVjP6cbdNO347+RGN85W5m8N+0=;
        b=nzYuD1ZztnNB68t6/Iy1owrdpRhJ72bYPairSRwS8r3G4AbTLO5YjE2iAUJyPX0ofX
         asutb1MpP6ivk1UQPVf+bWhIzSGKTwWImaf/Xsk8hJ5rBmQZHkdH2S9I6wEFAeDTASoR
         upJ0hjyEXePeCMhclNKPT5xOtzAsxS+LfOm2nOkVNsBYcbdXNVY74JkBKXfS+QPjfMT5
         tfFkTEqAC2j8alaUtulprm9cQZ6nnhHoKTGQ6RDZsNYzF1/f+BI50XE+K7l+f379M7L0
         VH9HsYqMcwibXKaSugM1S6ObMAqv2mKKZYCjDm6Lrjj5gmtnmh6qAOOX0mhARColsWED
         nk/g==
X-Gm-Message-State: AOAM530L74+Skv+DYccR/ZuL6m4wlkiUuJrVmKhh8czHU8yY1uhsuP7S
        pn8nfChQ1QnY2OKx1mlVld1UFwMfnHFiVdn/88Q=
X-Google-Smtp-Source: ABdhPJz/9pyKHVPVK6U3+bPhT6e3o+jREKifc5YPwXTt1DqPqYYa+FCw5Q8/glDbpMizEJtIKg4d3q43R8Y1y+DUbKA=
X-Received: by 2002:a05:620a:5bd:: with SMTP id q29mr17767569qkq.450.1614774240549;
 Wed, 03 Mar 2021 04:24:00 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Wed, 3 Mar 2021 20:23:49 +0800
Message-ID: <CANgQ54ckioG23b0AQvetnKvbowvgfV+UL9VKq6Wx4_GW2LyMgA@mail.gmail.com>
Subject: Questions of TX power get/set implementation for realtek WiFi driver
To:     pkshih@realtek.com, tehuang@realtek.com, Larry.Finger@lwfinger.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, kvalo@codeaurora.org,
        Reto Schneider <reto.schneider@husqvarnagroup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi guys,
    I'm planning to implement the get_txpower hook function of the
struct ieee80211_ops and handle the IEEE80211_CONF_CHANGE_POWER for
rtl8xxxu driver. So that users can get the information of the current
tx power limit and set a new limit value with iw commands.

    I found there's phy_txpwr_idx_to_dbm() of each driver in
realtek/rtlwifi to translate the tx power index parsed from efuse to
tx power level in dBm. Does the power level translated represent the
current tx power limit in dBm? In my RTL8188CUS module, the power
index of CCK/OFDM from efuse for each channel is basically 36/38, thus
the translated txpower level is 11dBm. Is this the expected value for
the default txpower limit value? Or do I need some other formula to
compute?

    And for the handler of IEEE80211_CONF_CHANGE_POWER, can I
translate the hw->conf.power_level with the phy_dbm_to_txpwr_idx
functions I found in some rtlwifi family drivers, then directly set
the txpower index with phy_set_txpower_index functions which write
power index to bbreg for different rates (CCK and OFDM)? Are there
some invalid values I should take care of because the TCP RX
performance seems to be extremely low when I write the power index
value translated from 20dBm to bbreg. Any suggestions for what I
should handle before writing the bbreg?

Chris
