Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E987A1B7231
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXKm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgDXKm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:42:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D824C09B045
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 03:42:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jRvmt-00FTKd-Gp; Fri, 24 Apr 2020 12:42:27 +0200
Message-ID: <39112803ea151a273845f37c45bd8dcef099616a.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Add support to configure TID specific Tx rate
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 12:42:25 +0200
In-Reply-To: <1587355657-11727-1-git-send-email-tamizhr@codeaurora.org>
References: <1587355657-11727-1-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-04-20 at 09:37 +0530, Tamizh Chelvam wrote:
> This patch adds support to configure per TID Tx Rate configuration
> through NL80211_TID_CONFIG_ATTR_TX_RATE* attributes. And it uses
> nl80211_parse_tx_bitrate_mask api to validate the Tx rate mask.

This is missing some kernel-doc updates, and for the new nl80211 enum
it's malformed. Please respin.

johannes

