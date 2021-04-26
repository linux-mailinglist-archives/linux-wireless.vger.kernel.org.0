Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1936B994
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbhDZTDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:03:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31601 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbhDZTDW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:03:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619463761; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FeJLDSWEFP1EsMDjEkydK8up6lsrwVPB1RxB4Flwx88=;
 b=Y87DHINSg3hl4lsCdY6NSPdB+fdemGrX/ORufFeEGWxb5IZmj9AFoN86K1pQ+TFQApO6pmDg
 XUCFTzzzqDJC+9PDCGDtgsI4Rymo8xoAVTt9FZoFk517z5ao6p0eJBM76is0KjTuaoG+/gyi
 bMm49vjbIwlz7yIi803fUWGVvxs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60870e4f2cc44d3aeae54671 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Apr 2021 19:02:39
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AC39C433F1; Mon, 26 Apr 2021 19:02:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCDFEC433D3;
        Mon, 26 Apr 2021 19:02:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Apr 2021 12:02:37 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        alokad=codeaurora.org@codeaurora.org
Subject: Re: [PATCH 0/4] multiple bssid and EMA support in AP mode
In-Reply-To: <20210426185756.10924-1-alokad@codeaurora.org>
References: <20210426185756.10924-1-alokad@codeaurora.org>
Message-ID: <d98c791c2ab800a31942ad84bff5d815@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-26 11:57, Aloka Dixit wrote:
> This patchset adds support for multiple BSSID and
> enhanced multi-BSSID advertisements for AP mode.
> 
> HWSIM support will be added in a separate patchset.
> 
> John Crispin (4):
>   nl80211: multiple bssid and EMA support in AP mode
>   mac80211: multiple bssid support in interface handling
>   mac80211: MBSSID and EMA support in beacon handling
>   mac80211: CSA on non-transmitting interfaces
> 
>  include/net/cfg80211.h       |  51 +++++++
>  include/net/mac80211.h       | 123 ++++++++++++++-
>  include/uapi/linux/nl80211.h | 101 ++++++++++++-
>  net/mac80211/cfg.c           | 198 +++++++++++++++++++++++--
>  net/mac80211/debugfs.c       |   2 +
>  net/mac80211/ieee80211_i.h   |   2 +
>  net/mac80211/iface.c         |  12 ++
>  net/mac80211/tx.c            | 189 ++++++++++++++++++++---
>  net/wireless/nl80211.c       | 280 ++++++++++++++++++++++++++++++-----
>  9 files changed, 883 insertions(+), 75 deletions(-)
> 
> 
> base-commit: 5d869070569a23aa909c6e7e9d010fc438a492ef

Please ignore this one, forgot to add 'v0', sending new patchset :-)
