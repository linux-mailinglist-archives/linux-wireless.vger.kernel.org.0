Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579A8210B47
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2020 14:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgGAMsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 08:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbgGAMsk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 08:48:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927B120702;
        Wed,  1 Jul 2020 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593607719;
        bh=gWjezYEIrNhwS+ao6+ABxLzPKZFz2dqby/qKwjmavpo=;
        h=Date:From:To:Subject:From;
        b=pR+Jh9FtR9vx1LWMqiqmzPJk/mIYdzRhfYpNcAQMJWM6Boo5xnAp3eCJZwentbBNm
         Hiq9A7fO7Hw5hgPVGNGsHH3cpzrNi/uf9IRjGGx8GIioBpfIgw2W89zxMPxrp6/jZo
         SF2YigMZTlbVSgkdVSAAvOEvi0QuYvKg44wh0VYE=
Received: by pali.im (Postfix)
        id AA49E102D; Wed,  1 Jul 2020 14:48:37 +0200 (CEST)
Date:   Wed, 1 Jul 2020 14:48:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: mwifiex: mwifiex_cfg80211_change_station and AP mode
Message-ID: <20200701124837.3jss6u324f7kqeou@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

I'm looking at mwifiex_cfg80211_change_station() function which
basically implements NL80211_CMD_SET_STATION nl80211 API.

Currently this mwifiex implementation does not support AP mode, only
client STA mode.

The most common usage of NL80211_CMD_SET_STATION in AP mode is via
NL80211_ATTR_STA_VLAN to put clients into separate VLANs.

Is there any possibility how to implement NL80211_CMD_SET_STATION with
NL80211_ATTR_STA_VLAN in mwifiex (in mwifiex_cfg80211_change_station)?
It looks like it is needed some mwifiex firmware command which would do
it (put client into vlan).

Do you have any information / documentation for this feature?
