Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030A0237B9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfETNDM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 09:03:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbfETNDM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 09:03:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 92B0B608D4; Mon, 20 May 2019 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558357391;
        bh=Im9cONrCw6xT+VTwujPXh75aFTBMK6QH99op6V0EHa0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fX5hi5qrZke+3Yt39/01PPIUtT+fjsdqSTPJz6aOS8BgY+Avm22q1bqpzkcmblgBS
         idmZ3LG7TQyMcv7H5xzuIZH//gguEYcp+qeX12RCB+owck50HJ3hCV9gpccnCWYpBY
         KiRm3h5Gce/x6dhaDYC1obKzbdICnJhOPBvFECfY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42D916076A;
        Mon, 20 May 2019 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558357391;
        bh=Im9cONrCw6xT+VTwujPXh75aFTBMK6QH99op6V0EHa0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fX5hi5qrZke+3Yt39/01PPIUtT+fjsdqSTPJz6aOS8BgY+Avm22q1bqpzkcmblgBS
         idmZ3LG7TQyMcv7H5xzuIZH//gguEYcp+qeX12RCB+owck50HJ3hCV9gpccnCWYpBY
         KiRm3h5Gce/x6dhaDYC1obKzbdICnJhOPBvFECfY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42D916076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH v2 1/2] nl80211: Add support for EDMG channels
References: <1557758554-18907-1-git-send-email-ailizaro@codeaurora.org>
        <1557758554-18907-2-git-send-email-ailizaro@codeaurora.org>
Date:   Mon, 20 May 2019 16:03:07 +0300
In-Reply-To: <1557758554-18907-2-git-send-email-ailizaro@codeaurora.org>
        (Alexei Avshalom Lazar's message of "Mon, 13 May 2019 17:42:33 +0300")
Message-ID: <87k1eluvlg.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexei Avshalom Lazar <ailizaro@codeaurora.org> writes:

> 802.11ay specification defines Enhanced Directional Multi-Gigabit
> (EDMG) STA and AP which allow channel bonding of 2 channels and more.
> Introduce NL80211_ATTR_WIPHY_EDMG_CHANNELS,
> NL80211_ATTR_WIPHY_EDMG_BW_CONFIG, NL80211_BAND_ATTR_EDMG_CHANNELS,
> NL80211_BAND_ATTR_EDMG_BW_CONFIG and RATE_INFO_FLAGS_EDMG
> that needed for enabling and configuring EDMG support.
> Driver is expected to report its EDMG capabilities: whether EDMG
> is supported and the supported EDMG channels.
> Bitrate calculation is enhanced to take into account EDMG support
> according to the 802.11ay specification.
> The kernel uses NL80211_BAND_ATTR_EDMG_CHANNELS and
> NL80211_BAND_ATTR_EDMG_BW_CONFIG attributes in order to publish
> the EDMG capabilities to the userspace.
> NL80211_BAND_ATTR_EDMG_CHANNELS is a bitmap field that indicates
> the 2.16 GHz channel(s) that are allowed to be used for transmissions
> in the BSS.
> If NL80211_BAND_ATTR_EDMG_CHANNELS is not set then EDMG not
> supported. NL80211_BAND_ATTR_EDMG_BW_CONFIG represent the allowed
> channel bandwidth configurations.
> NL80211_ATTR_WIPHY_EDMG_CHANNELS and NL80211_ATTR_WIPHY_EDMG_BW_CONFIG
> will be used by the userspace for AP configuration and connect command.
>
> Change-Id: I534f4a750354a4b0baad28c47dc29afb9cbc36ac

No Change-Id in upstream patches. And please read:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#signed-off-by_missing

-- 
Kalle Valo
