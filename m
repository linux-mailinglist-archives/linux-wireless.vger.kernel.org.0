Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE19249552
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHSGy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgHSGy7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 02:54:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F46C061389
        for <linux-wireless@vger.kernel.org>; Tue, 18 Aug 2020 23:54:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k8Hzr-006gqa-UK; Wed, 19 Aug 2020 08:54:56 +0200
Message-ID: <4abebda6ee90ce59b9dc5121b07d1954841351c7.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: send only vlan group traffics in 80211 xmit
 path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Seevalamuthu Mariappan <seevalam@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 19 Aug 2020 08:54:55 +0200
In-Reply-To: <1597819527-31887-1-git-send-email-seevalam@codeaurora.org>
References: <1597819527-31887-1-git-send-email-seevalam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-08-19 at 12:15 +0530, Seevalamuthu Mariappan wrote:
> AP-VLAN multicast/broadcast packets are expected to be encrypted
> in software. 

Err. Expected by whom?

> Those packets should follow 802.11 xmit path.

You should explain why ...

> -void __ieee80211_subif_start_xmit(struct sk_buff *skb,
> -				  struct net_device *dev,
> -				  u32 info_flags,
> -				  u32 ctrl_flags,
> -				  u64 *cookie)

There's no way I can review this if you move the whole function while
making a small change to it ...

johannes

