Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294F73CC3B2
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhGQOAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Jul 2021 10:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232893AbhGQOAh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Jul 2021 10:00:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D504613C0;
        Sat, 17 Jul 2021 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626530261;
        bh=uT/+DTG39Evhwk4TJzOyhHJBomJDHu5EAcq2y/mItw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kU1byYFY0WqCAcXsPzKT/NkcKixg3ri0xW1Ci2KzW4a76AbQHSMX5kqiTpezk+Wgn
         mhPp5AYYLHED98P447DaEPI6OAswjxROVJvluFdTUSaJDI5EMMqbLZPbAfZBWwlbmE
         wq5QrDWzbVL1/AlCHcUZCgBLompIJ7a2HBkEKE4P1/43kAgEdiZWPiYeXHbB0wxE2j
         DVQWJRl6LUZcv7zAaPAIZ7ai38+P/HeNwQ1QAlQPY8Dx5xFEk5XbcHWNm5f7fGf3Ri
         fdp6qOMsZfFc43Mit1TVdawYNL1/usm3h36Kd4ZlKZG3rcRm8muzH14ZWDWfK/nF3i
         AQWRgixMDWhMQ==
Received: by pali.im (Postfix)
        id C89FB95D; Sat, 17 Jul 2021 15:57:38 +0200 (CEST)
Date:   Sat, 17 Jul 2021 15:57:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: mwifiex: mwifiex_cfg80211_change_station and AP mode
Message-ID: <20210717135738.isur3l2v4yyo54ad@pali>
References: <20200701124837.3jss6u324f7kqeou@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701124837.3jss6u324f7kqeou@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[+cc: Maximilian, Jonas and Sharvari]

Just to note that hostapd does not work in EAP mode (which is used e.g.
in WPA2-Enterprise) when kernel driver does not implement
NL80211_CMD_SET_STATION with NL80211_ATTR_STA_VLAN support.

So without it is mwifiex basically unusable for EAP mode.

On Wednesday 01 July 2020 14:48:37 Pali Rohár wrote:
> Hello!
> 
> I'm looking at mwifiex_cfg80211_change_station() function which
> basically implements NL80211_CMD_SET_STATION nl80211 API.
> 
> Currently this mwifiex implementation does not support AP mode, only
> client STA mode.
> 
> The most common usage of NL80211_CMD_SET_STATION in AP mode is via
> NL80211_ATTR_STA_VLAN to put clients into separate VLANs.
> 
> Is there any possibility how to implement NL80211_CMD_SET_STATION with
> NL80211_ATTR_STA_VLAN in mwifiex (in mwifiex_cfg80211_change_station)?
> It looks like it is needed some mwifiex firmware command which would do
> it (put client into vlan).
> 
> Do you have any information / documentation for this feature?
