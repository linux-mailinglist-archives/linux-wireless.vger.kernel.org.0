Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CED1945BF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZRop (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 13:44:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35605 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZRop (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 13:44:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id t16so4788158lfl.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7XoiLWs2XoFacEsStR6FHno/JNyUlZJnqakWVyoyDc=;
        b=SIhtKem3WKctDwUJvIIHkVqRxFfpwnZFyKUFrx7OdsGGxSkUeJqtI+HFCPNrAYoG1M
         eTtZJXQSXAL7F3cAUXiDdsVn+GopgMxMKNmkPOGHbP9v/DUPvFkaTp9A0k91MbIfsnXF
         UppUeBnygELU4/+SD/jywgTeKeuW5pjXKH+pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7XoiLWs2XoFacEsStR6FHno/JNyUlZJnqakWVyoyDc=;
        b=ErawEoXaJqWkFSzYDidR8ATrRANEnuiGtk7S9jR7Ur6DWflXM7bYX3cIFslZLlQ5Uw
         5cphB+Wb2WuE7TFzkXBvZZjR83/W9ttO1Nxn9GAUw4NTl7kgzRTPJIZyFofSKxon8XXO
         AZc1wVLyHjNE31x5jk3ag/C+JubI04QJKiNIaKxoXDm3X7UorATFuD6L5hDP35MukF6c
         8+iKYZsfWeY3wKetDkSJI4m7cjSHQpxNlbPUJdsmeTHaF1ZXIpSHF1+powZY2L3DaaNM
         14ssIYL4BtBKHtNZsB4axBXkM+UAtA2sYuG6LG2IAibvy0uYUqBVo94R8FgrN6SHHS62
         1Jbw==
X-Gm-Message-State: ANhLgQ0ugSr4Cfpkt6zseOROjxpEbzi17M9d3wv/bJ3SD8I1FtviQuq6
        0eco4b0iaAcHa/vUi70hb56YRCybrmw=
X-Google-Smtp-Source: ADFU+vud+3Ov1SAE/m1YBK34UyXVdxH8yFg7sLKbzIs2f3yJzo0lEznyGhATBuK7ztg086BkOAnVeg==
X-Received: by 2002:ac2:5999:: with SMTP id w25mr5223567lfn.46.1585244672974;
        Thu, 26 Mar 2020 10:44:32 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id y3sm774440ljh.15.2020.03.26.10.44.32
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 10:44:32 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id e7so5624073lfq.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 10:44:32 -0700 (PDT)
X-Received: by 2002:a05:6512:203c:: with SMTP id s28mr6229169lfs.49.1585244671977;
 Thu, 26 Mar 2020 10:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200326020408.25218-1-yhchuang@realtek.com>
In-Reply-To: <20200326020408.25218-1-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 26 Mar 2020 10:44:20 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNQktYTa+hkH0Z2JH4TTZN6wdp5prNjH-f1XzJm_UFdaw@mail.gmail.com>
Message-ID: <CA+ASDXNQktYTa+hkH0Z2JH4TTZN6wdp5prNjH-f1XzJm_UFdaw@mail.gmail.com>
Subject: Re: [PATCH] rtw88: fix non-increase management packet sequence number
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 25, 2020 at 7:04 PM <yhchuang@realtek.com> wrote:
> In previous setting, management packets' sequence numbers will
> not increase and always stay at 0. Add hw sequence number support
> for mgmt packets.

I see that you're differentiating frames by mgmt/null-func/data in
your own TX handler, but shouldn't you be basing your sequence number
decisions based on IEEE80211_TX_CTL_ASSIGN_SEQ and
IEEE80211_TX_CTL_FIRST_FRAGMENT? Anyway, this patch seems to work as
expected:

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
